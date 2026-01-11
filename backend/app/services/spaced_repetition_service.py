from datetime import date, timedelta
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.user_word_progress import UserWordProgress, ProgressStatus
from app.models.daily_word_stack import DailyWordStack

# Fibonacci sequence for spaced repetition
FIBONACCI_DAYS = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 180]
MAX_LEVEL = 10  # Level 10 = mastered


async def process_review(
    db: AsyncSession,
    user_word_progress: UserWordProgress,
    is_correct: bool
) -> UserWordProgress:
    """Process a review and update Fibonacci level."""
    current_level = user_word_progress.fibonacci_level
    
    if is_correct:
        user_word_progress.correct_count += 1
        new_level = min(current_level + 1, MAX_LEVEL)
        
        if new_level == MAX_LEVEL:
            # Word is mastered
            user_word_progress.status = ProgressStatus.MASTERED
            user_word_progress.mastered_at = date.today()
            user_word_progress.next_review_date = None
        else:
            user_word_progress.fibonacci_level = new_level
            days_to_add = FIBONACCI_DAYS[new_level] if new_level < len(FIBONACCI_DAYS) else 180
            user_word_progress.next_review_date = date.today() + timedelta(days=days_to_add)
            user_word_progress.status = ProgressStatus.REVIEWING
    else:
        user_word_progress.incorrect_count += 1
        new_level = max(current_level - 1, 0)
        user_word_progress.fibonacci_level = new_level
        
        if new_level == 0:
            user_word_progress.status = ProgressStatus.LEARNING
            days_to_add = FIBONACCI_DAYS[0]  # 1 day
        else:
            days_to_add = FIBONACCI_DAYS[new_level] if new_level < len(FIBONACCI_DAYS) else 180
        
        user_word_progress.next_review_date = date.today() + timedelta(days=days_to_add)
    
    user_word_progress.last_reviewed_at = date.today()
    
    # Update user's current_level based on review
    await update_user_level_from_review(db, user_word_progress.user_id, user_word_progress.word_id, is_correct)
    
    await db.commit()
    await db.refresh(user_word_progress)
    
    return user_word_progress


async def update_user_level_from_review(
    db: AsyncSession,
    user_id: int,
    word_id: int,
    is_correct: bool
):
    """Update user's current_level based on review performance.
    
    Formula: Use a weighted average where correct reviews gradually increase level
    towards the word's difficulty level.
    """
    from app.models.user import User
    from app.models.word import Word
    from sqlalchemy import func as sql_func
    from app.models.user_word_progress import UserWordProgress
    
    # Get user
    user_query = select(User).where(User.id == user_id)
    user_result = await db.execute(user_query)
    user = user_result.scalar_one_or_none()
    
    if not user or user.current_level is None:
        # Can't update level if user hasn't been assessed yet
        return
    
    # Get word difficulty
    word_query = select(Word).where(Word.id == word_id)
    word_result = await db.execute(word_query)
    word = word_result.scalar_one_or_none()
    
    if not word:
        return
    
    word_difficulty = float(word.difficulty_level)
    current_level = float(user.current_level)
    
    # Get total reviews count for this user
    review_count_query = select(sql_func.count(UserWordProgress.id)).where(
        UserWordProgress.user_id == user_id
    )
    review_count_result = await db.execute(review_count_query)
    total_reviews = review_count_result.scalar_one_or_none() or 1
    
    # Calculate increment/decrement
    # If correct: gradually increase towards word difficulty
    # If incorrect: slightly decrease
    if is_correct:
        # Weight: (1 / total_reviews) * 0.3 means each review has less impact as user reviews more
        # This ensures level stabilizes over time
        weight = min(0.3, 1.0 / max(1, total_reviews))
        increment = weight * (word_difficulty - current_level)
        # Cap increment to reasonable value
        increment = max(-0.5, min(0.5, increment))
        new_level = current_level + increment
    else:
        # On incorrect, slightly decrease (smaller impact)
        weight = min(0.1, 1.0 / max(1, total_reviews))
        decrement = weight * 0.5  # Small decrement
        new_level = current_level - decrement
    
    # Clamp between 1.0 and 10.0
    new_level = max(1.0, min(10.0, new_level))
    
    user.current_level = new_level


async def add_word_to_learning(
    db: AsyncSession,
    user_id: int,
    word_id: int
) -> UserWordProgress:
    """Add a word to user's learning stack."""
    # Check if already exists
    result = await db.execute(
        select(UserWordProgress).where(
            UserWordProgress.user_id == user_id,
            UserWordProgress.word_id == word_id
        )
    )
    existing = result.scalar_one_or_none()
    
    if existing:
        return existing
    
    # Create new progress entry
    progress = UserWordProgress(
        user_id=user_id,
        word_id=word_id,
        fibonacci_level=0,
        next_review_date=date.today() + timedelta(days=FIBONACCI_DAYS[0]),
        status=ProgressStatus.LEARNING
    )
    db.add(progress)
    await db.commit()
    await db.refresh(progress)
    
    # Add to today's daily stack
    await add_to_daily_stack(db, user_id, word_id, date.today())
    
    return progress


async def add_to_daily_stack(
    db: AsyncSession,
    user_id: int,
    word_id: int,
    scheduled_date: date
) -> DailyWordStack:
    """Add a word to daily stack for a specific date."""
    # Check if already exists
    result = await db.execute(
        select(DailyWordStack).where(
            DailyWordStack.user_id == user_id,
            DailyWordStack.word_id == word_id,
            DailyWordStack.scheduled_date == scheduled_date
        )
    )
    existing = result.scalar_one_or_none()
    
    if existing:
        return existing
    
    stack_entry = DailyWordStack(
        user_id=user_id,
        word_id=word_id,
        scheduled_date=scheduled_date,
        is_reviewed=False
    )
    db.add(stack_entry)
    await db.commit()
    await db.refresh(stack_entry)
    return stack_entry


async def get_user_progress_for_word(
    db: AsyncSession,
    user_id: int,
    word_id: int
) -> Optional[UserWordProgress]:
    """Get user's progress for a specific word."""
    result = await db.execute(
        select(UserWordProgress).where(
            UserWordProgress.user_id == user_id,
            UserWordProgress.word_id == word_id
        )
    )
    return result.scalar_one_or_none()
