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
            # Calculate days between current and next review day
            # FIBONACCI_DAYS represents the days at which we review, so we need the difference
            if new_level < len(FIBONACCI_DAYS):
                if new_level == 0:
                    days_to_add = FIBONACCI_DAYS[0]  # First review on day 1 (1 day from today)
                else:
                    days_to_add = FIBONACCI_DAYS[new_level] - FIBONACCI_DAYS[new_level - 1]
            else:
                # Beyond the sequence, use difference from last value to 180
                days_to_add = 180 - FIBONACCI_DAYS[-1]  # 180 - 89 = 91 days
            user_word_progress.next_review_date = date.today() + timedelta(days=days_to_add)
            user_word_progress.status = ProgressStatus.REVIEWING
    else:
        user_word_progress.incorrect_count += 1
        new_level = max(current_level - 1, 0)
        user_word_progress.fibonacci_level = new_level
        
        if new_level == 0:
            user_word_progress.status = ProgressStatus.LEARNING
            days_to_add = FIBONACCI_DAYS[0]  # First review on day 1
        else:
            # Calculate days between current and next review day
            days_to_add = FIBONACCI_DAYS[new_level] - FIBONACCI_DAYS[new_level - 1]
        
        user_word_progress.next_review_date = date.today() + timedelta(days=days_to_add)
    
    user_word_progress.last_reviewed_at = date.today()
    
    # Note: User's current_level is only updated via assessments, not individual reviews
    
    await db.commit()
    await db.refresh(user_word_progress)
    
    return user_word_progress


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
