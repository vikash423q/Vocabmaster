from typing import Dict, Optional, List
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_
from sqlalchemy.orm import selectinload
from app.models.user_word_progress import UserWordProgress, ProgressStatus
from app.models.quiz_sessions import QuizSession
from app.models.daily_word_stack import DailyWordStack


async def get_progress_overview(
    db: AsyncSession,
    user_id: int
) -> Dict:
    """Get overall progress statistics for a user."""
    # Total words in learning
    total_query = select(func.count(UserWordProgress.id)).where(
        UserWordProgress.user_id == user_id
    )
    total_result = await db.execute(total_query)
    total_words = total_result.scalar() or 0
    
    # Mastered words
    mastered_query = select(func.count(UserWordProgress.id)).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.status == ProgressStatus.MASTERED
        )
    )
    mastered_result = await db.execute(mastered_query)
    mastered_words = mastered_result.scalar() or 0
    
    # Words in learning
    learning_query = select(func.count(UserWordProgress.id)).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.status == ProgressStatus.LEARNING
        )
    )
    learning_result = await db.execute(learning_query)
    learning_words = learning_result.scalar() or 0
    
    # Words in review
    reviewing_query = select(func.count(UserWordProgress.id)).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.status == ProgressStatus.REVIEWING
        )
    )
    reviewing_result = await db.execute(reviewing_query)
    reviewing_words = reviewing_result.scalar() or 0
    
    # Total quiz attempts
    quiz_query = select(func.count(QuizSession.id)).where(
        QuizSession.user_id == user_id
    )
    quiz_result = await db.execute(quiz_query)
    total_quizzes = quiz_result.scalar() or 0
    
    # Correct answers
    correct_query = select(func.count(QuizSession.id)).where(
        and_(
            QuizSession.user_id == user_id,
            QuizSession.is_correct == True
        )
    )
    correct_result = await db.execute(correct_query)
    correct_answers = correct_result.scalar() or 0
    
    # Accuracy rate
    accuracy = (correct_answers / total_quizzes * 100) if total_quizzes > 0 else 0
    
    # Words due for review today
    from datetime import date
    today = date.today()
    due_query = select(func.count(DailyWordStack.id)).where(
        and_(
            DailyWordStack.user_id == user_id,
            DailyWordStack.scheduled_date == today,
            DailyWordStack.is_reviewed == False
        )
    )
    due_result = await db.execute(due_query)
    words_due_today = due_result.scalar() or 0
    
    return {
        "total_words": total_words,
        "mastered_words": mastered_words,
        "learning_words": learning_words,
        "reviewing_words": reviewing_words,
        "total_quizzes": total_quizzes,
        "correct_answers": correct_answers,
        "accuracy_rate": round(accuracy, 2),
        "words_due_today": words_due_today
    }


async def get_word_progress(
    db: AsyncSession,
    user_id: int,
    word_id: int
) -> Optional[Dict]:
    """Get progress details for a specific word."""
    from sqlalchemy.orm import selectinload
    
    query = select(UserWordProgress).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.word_id == word_id
        )
    ).options(selectinload(UserWordProgress.word))
    
    result = await db.execute(query)
    progress = result.scalar_one_or_none()
    
    if not progress:
        return None
    
    return {
        "word_id": progress.word_id,
        "word": progress.word.word if progress.word else None,
        "fibonacci_level": progress.fibonacci_level,
        "next_review_date": progress.next_review_date.isoformat() if progress.next_review_date else None,
        "correct_count": progress.correct_count,
        "incorrect_count": progress.incorrect_count,
        "last_reviewed_at": progress.last_reviewed_at.isoformat() if progress.last_reviewed_at else None,
        "status": progress.status.value,
        "added_at": progress.added_at.isoformat() if progress.added_at else None,
        "mastered_at": progress.mastered_at.isoformat() if progress.mastered_at else None
    }


async def get_upcoming_reviews(
    db: AsyncSession,
    user_id: int,
    days_ahead: int = 7
) -> List[Dict]:
    """Get upcoming review schedule."""
    from datetime import date, timedelta
    
    end_date = date.today() + timedelta(days=days_ahead)
    
    query = select(UserWordProgress).where(
        and_(
            UserWordProgress.user_id == user_id,
            UserWordProgress.next_review_date >= date.today(),
            UserWordProgress.next_review_date <= end_date,
            UserWordProgress.status != ProgressStatus.MASTERED
        )
    ).order_by(UserWordProgress.next_review_date).options(
        selectinload(UserWordProgress.word)
    )
    
    result = await db.execute(query)
    progress_entries = list(result.scalars().all())
    
    return [
        {
            "word_id": p.word_id,
            "word": p.word.word if p.word else None,
            "review_date": p.next_review_date.isoformat() if p.next_review_date else None,
            "level": p.fibonacci_level
        }
        for p in progress_entries
    ]


async def get_progress_words(
    db: AsyncSession,
    user_id: int,
    status_filter: Optional[str] = "all",
    category_id: Optional[int] = None,
    subcategory_id: Optional[int] = None,
    search: Optional[str] = None,
    limit: Optional[int] = None,
    offset: Optional[int] = None
) -> List[Dict]:
    """Get progress words filtered by status, category, subcategory, and search."""
    from app.models.word import Word, Tone
    from app.models.category import Category
    from sqlalchemy import or_
    
    # Build query with status filter
    conditions = [UserWordProgress.user_id == user_id]
    
    if status_filter and status_filter != "all":
        try:
            status_enum = ProgressStatus(status_filter.lower())
            conditions.append(UserWordProgress.status == status_enum)
        except ValueError:
            # Invalid status, return empty list
            return []
    
    query = select(UserWordProgress).where(
        and_(*conditions)
    ).options(
        selectinload(UserWordProgress.word).selectinload(Word.category)
    )
    
    # Apply category/subcategory filter
    if subcategory_id:
        # Filter by specific subcategory
        query = query.join(Word).where(Word.category_id == subcategory_id)
    elif category_id:
        # Filter by parent category including all its subcategories
        # Get all subcategory IDs for this parent category
        subcategories_query = select(Category.id).where(Category.parent_category_id == category_id)
        subcategories_result = await db.execute(subcategories_query)
        subcategory_ids = [row[0] for row in subcategories_result.all()]
        
        # Filter by parent category OR any of its subcategories
        category_conditions = [Word.category_id == category_id]
        if subcategory_ids:
            category_conditions.append(Word.category_id.in_(subcategory_ids))
        
        query = query.join(Word).where(or_(*category_conditions))
    else:
        # Always join Word for search filter or for accessing word fields
        query = query.join(Word)
    
    # Apply search filter
    if search:
        query = query.where(Word.word.ilike(f"%{search}%"))
    
    query = query.order_by(UserWordProgress.added_at.desc())
    
    # Apply pagination
    if offset:
        query = query.offset(offset)
    if limit:
        query = query.limit(limit)
    
    result = await db.execute(query)
    progress_entries = list(result.scalars().all())
    
    return [
        {
            "id": p.word_id,
            "word": p.word.word if p.word else None,
            "pronunciation": p.word.pronunciation if p.word else None,
            "category_id": p.word.category_id if p.word else None,
            "category_name": p.word.category.name if p.word and p.word.category else None,
            "difficulty_level": float(p.word.difficulty_level) if p.word and p.word.difficulty_level else 5.0,
            "importance_score": p.word.importance_score if p.word else 50,
            "status": p.status.value,
            "fibonacci_level": p.fibonacci_level,
            "next_review_date": p.next_review_date.isoformat() if p.next_review_date else None,
            "correct_count": p.correct_count,
            "incorrect_count": p.incorrect_count,
            "last_reviewed_at": p.last_reviewed_at.isoformat() if p.last_reviewed_at else None,
            "added_at": p.added_at.isoformat() if p.added_at else None,
            "mastered_at": p.mastered_at.isoformat() if p.mastered_at else None,
            "tone": p.word.tone.value if p.word and p.word.tone else None,
            "cefr_level": p.word.cefr_level if p.word else None,
        }
        for p in progress_entries
    ]
