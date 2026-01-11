"""
Service for user assessment and level calculation.
"""
from typing import List, Optional, Dict
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_, or_
from sqlalchemy.orm import selectinload
from app.models.user import User
from app.models.word import Word
from app.models.user_word_progress import UserWordProgress
from app.models.category import Category
import random


async def get_assessment_stack(
    db: AsyncSession,
    user_id: int
) -> Dict:
    """Get assessment stack for user.
    
    For new users (current_level is null): Returns 30 words (5 each of difficulty 4-9)
    For existing users: Returns words around their current_level ±1.0, weighted towards higher difficulty
    """
    user_result = await db.execute(select(User).where(User.id == user_id))
    user = user_result.scalar_one_or_none()
    
    if not user:
        raise ValueError("User not found")
    
    is_first_assessment = user.current_level is None
    
    if is_first_assessment:
        # First assessment: 30 words, 5 each of difficulty levels 4, 5, 6, 7, 8, 9
        words_by_difficulty = {}
        for difficulty in [4, 5, 6, 7, 8, 9]:
            query = select(Word).where(
                func.abs(Word.difficulty_level - difficulty) < 0.5  # Within 0.5 of target difficulty
            ).limit(10)  # Get more than needed for randomization
            
            result = await db.execute(query)
            available_words = list(result.scalars().all())
            
            if len(available_words) >= 5:
                words_by_difficulty[difficulty] = random.sample(available_words, 5)
            else:
                # If not enough words, take what's available
                words_by_difficulty[difficulty] = available_words
        
        # Flatten and randomize order
        all_words = []
        for difficulty_words in words_by_difficulty.values():
            all_words.extend(difficulty_words)
        
        random.shuffle(all_words)
        
    else:
        # Subsequent assessment: words around current_level
        current_level = float(user.current_level)
        target_min = max(1.0, current_level - 1.0)
        target_max = min(10.0, current_level + 1.5)  # Slightly higher to challenge
        
        # Exclude words user already knows (has progress on)
        progress_query = select(UserWordProgress.word_id).where(
            UserWordProgress.user_id == user_id
        )
        progress_result = await db.execute(progress_query)
        known_word_ids = {row[0] for row in progress_result.all()}
        
        query = select(Word).where(
            and_(
                Word.difficulty_level >= target_min,
                Word.difficulty_level <= target_max
            )
        )
        
        if known_word_ids:
            query = query.where(~Word.id.in_(known_word_ids))
        
        query = query.limit(30)
        result = await db.execute(query)
        all_words = list(result.scalars().all())
        
        # Shuffle
        random.shuffle(all_words)
    
    # Format response
    assessment_words = []
    for word in all_words:
        assessment_words.append({
            "id": word.id,
            "word": word.word,
            "pronunciation": word.pronunciation,
            "difficulty_level": float(word.difficulty_level),
            "cefr_level": word.cefr_level
        })
    
    return {
        "words": assessment_words,
        "total_words": len(assessment_words),
        "is_first_assessment": is_first_assessment
    }


async def submit_assessment(
    db: AsyncSession,
    user_id: int,
    responses: List[Dict]
) -> Dict:
    """Submit assessment responses and calculate user level.
    
    Scoring:
    - "don't_know": 4.0
    - "maybe": 5.0
    - "know": word's difficulty_level
    
    Calculate average as user's current_level.
    """
    user_result = await db.execute(select(User).where(User.id == user_id))
    user = user_result.scalar_one_or_none()
    
    if not user:
        raise ValueError("User not found")
    
    if not responses:
        raise ValueError("No responses provided")
    
    # Get word IDs and difficulty levels
    word_ids = [r["word_id"] for r in responses]
    words_query = select(Word).where(Word.id.in_(word_ids))
    words_result = await db.execute(words_query)
    words = {word.id: word for word in words_result.scalars().all()}
    
    # Calculate scores
    scores = []
    words_assessed = []
    
    for response in responses:
        word_id = response["word_id"]
        response_type = response["response"]
        
        if word_id not in words:
            continue
        
        word = words[word_id]
        words_assessed.append(word_id)
        
        if response_type == "don't_know":
            score = 4.0
        elif response_type == "maybe":
            score = 5.0
        elif response_type == "know":
            score = float(word.difficulty_level)
        else:
            # Default to maybe if invalid response
            score = 5.0
        
        scores.append(score)
    
    if not scores:
        raise ValueError("No valid responses")
    
    # Calculate average (user's current level)
    calculated_level = sum(scores) / len(scores)
    
    # Clamp between 1.0 and 10.0
    calculated_level = max(1.0, min(10.0, calculated_level))
    
    # Update user's current_level
    user.current_level = calculated_level
    await db.commit()
    await db.refresh(user)
    
    return {
        "calculated_level": calculated_level,
        "responses_count": len(responses),
        "words_assessed": len(words_assessed)
    }


async def get_stack_recommendations(
    db: AsyncSession,
    user_id: int,
    limit: int = 20
) -> Dict:
    """Get recommended words for user's stack.
    
    Criteria:
    - Difficulty level: user's current_level + 30% more challenging (up to 10.0)
    - Exclude words user already knows
    """
    user_result = await db.execute(select(User).where(User.id == user_id))
    user = user_result.scalar_one_or_none()
    
    if not user:
        raise ValueError("User not found")
    
    if user.current_level is None:
        raise ValueError("User must complete assessment first")
    
    current_level = float(user.current_level)
    
    # Target difficulty: current_level * 1.3, capped at 10.0
    target_difficulty = min(10.0, current_level * 1.3)
    
    # Range around target (allow some variance)
    difficulty_min = max(1.0, target_difficulty - 1.0)
    difficulty_max = min(10.0, target_difficulty + 1.0)
    
    # Get words user already knows (has progress on)
    progress_query = select(UserWordProgress.word_id).where(
        UserWordProgress.user_id == user_id
    )
    progress_result = await db.execute(progress_query)
    known_word_ids = {row[0] for row in progress_result.all()}
    
    # Build query for recommended words (eagerly load category for response)
    base_query = select(Word).options(selectinload(Word.category)).where(
        and_(
            Word.difficulty_level >= difficulty_min,
            Word.difficulty_level <= difficulty_max
        )
    )
    
    # Exclude known words
    if known_word_ids:
        base_query = base_query.where(~Word.id.in_(known_word_ids))
    
    # Get more than limit to allow for randomization
    result = await db.execute(base_query.limit(limit * 3))
    all_words = list(result.scalars().all())
    
    # Shuffle for variety and take up to limit
    random.shuffle(all_words)
    selected_words = all_words[:limit]
    
    # Format response
    recommended_words = []
    for word in selected_words:
        category_name = None
        if word.category:
            category_name = word.category.name
        
        recommended_words.append({
            "id": word.id,
            "word": word.word,
            "pronunciation": word.pronunciation,
            "difficulty_level": float(word.difficulty_level),
            "cefr_level": word.cefr_level,
            "category_id": word.category_id,
            "category_name": category_name,
            "importance_score": word.importance_score
        })
    
    return {
        "words": recommended_words,
        "recommended_level": target_difficulty,
        "user_current_level": current_level,
        "total_recommended": len(recommended_words)
    }


async def mark_word_as_known(
    db: AsyncSession,
    user_id: int,
    word_id: int
) -> Dict:
    """Toggle word mastered status.
    
    If word is mastered, unmark it (set to learning).
    If word is not mastered or has no progress, mark it as mastered.
    This allows users to toggle words they already know.
    """
    from datetime import date, timedelta
    from app.models.user_word_progress import UserWordProgress, ProgressStatus
    from app.services.spaced_repetition_service import FIBONACCI_DAYS
    
    # Check if word exists
    word_result = await db.execute(select(Word).where(Word.id == word_id))
    word = word_result.scalar_one_or_none()
    
    if not word:
        raise ValueError("Word not found")
    
    # Check if progress already exists
    progress_query = select(UserWordProgress).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.word_id == word_id
        )
    )
    progress_result = await db.execute(progress_query)
    existing_progress = progress_result.scalar_one_or_none()
    
    if existing_progress:
        if existing_progress.status == ProgressStatus.MASTERED:
            # Unmark - set back to learning
            existing_progress.status = ProgressStatus.LEARNING
            existing_progress.fibonacci_level = 0
            existing_progress.mastered_at = None
            existing_progress.next_review_date = date.today() + timedelta(days=FIBONACCI_DAYS[0])
            await db.commit()
            await db.refresh(existing_progress)
            return {"message": "Word unmarked as mastered", "word_id": word_id, "is_mastered": False}
        else:
            # Mark as mastered
            existing_progress.status = ProgressStatus.MASTERED
            existing_progress.fibonacci_level = 10  # Max level
            existing_progress.mastered_at = date.today()
            existing_progress.next_review_date = None
            await db.commit()
            await db.refresh(existing_progress)
            return {"message": "Word marked as mastered", "word_id": word_id, "is_mastered": True}
    
    # Create new progress entry as mastered
    new_progress = UserWordProgress(
        user_id=user_id,
        word_id=word_id,
        fibonacci_level=10,  # Mastered
        status=ProgressStatus.MASTERED,
        mastered_at=date.today(),
        correct_count=1,  # Start with one correct since they know it
        next_review_date=None  # No need to review mastered words
    )
    
    db.add(new_progress)
    await db.commit()
    await db.refresh(new_progress)
    
    return {"message": "Word marked as mastered", "word_id": word_id, "is_mastered": True}
