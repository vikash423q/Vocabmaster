from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_
from datetime import date
from typing import List, Optional
from app.database import get_db
from app.schemas.review import (
    DailyStackItem,
    ReviewSubmit,
    ReviewResponse,
    AddWordsRequest,
    WordProgressDetail,
    UpcomingReview
)
from app.services.daily_stack_service import get_daily_stack, mark_reviewed, populate_daily_stack_for_user
from app.services.spaced_repetition_service import (
    process_review,
    add_word_to_learning,
    get_user_progress_for_word
)
from app.services.progress_service import get_progress_overview, get_word_progress, get_upcoming_reviews
from app.models.quiz_sessions import QuizSession, QuestionType
from app.models.user_word_progress import UserWordProgress

from app.api.dependencies import get_current_user
from app.models.user import User

router = APIRouter()


@router.get("/daily-stack", response_model=List[DailyStackItem])
async def get_daily_stack_endpoint(
    target_date: Optional[str] = None,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get today's words to review."""
    review_date = date.fromisoformat(target_date) if target_date else date.today()
    
    # Populate daily stack if needed
    await populate_daily_stack_for_user(db, current_user.id, review_date)
    
    # Get daily stack
    stack_items = await get_daily_stack(db, current_user.id, review_date)
    
    if not stack_items:
        return []
    
    # Get progress for all words in one query to include the level
    word_ids = [item.word_id for item in stack_items]
    progress_query = select(UserWordProgress).where(
        and_(
            UserWordProgress.user_id == current_user.id,
            UserWordProgress.word_id.in_(word_ids)
        )
    )
    progress_result = await db.execute(progress_query)
    progress_records = {p.word_id: p for p in progress_result.scalars().all()}
    
    # Build response with progress levels
    return [
        DailyStackItem(
            id=item.id,
            word_id=item.word_id,
            word=item.word.word if item.word else "",
            scheduled_date=item.scheduled_date.isoformat(),
            is_reviewed=item.is_reviewed,
            level=progress_records[item.word_id].fibonacci_level if item.word_id in progress_records else 0
        )
        for item in stack_items
    ]


@router.post("/daily-stack/add-words", status_code=status.HTTP_201_CREATED)
async def add_words_to_stack(
    request: AddWordsRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Add words to learning stack."""
    added_count = 0
    for word_id in request.word_ids:
        try:
            await add_word_to_learning(db, current_user.id, word_id)
            added_count += 1
        except Exception:
            continue
    
    return {
        "message": f"Added {added_count} word(s) to learning stack",
        "added_count": added_count
    }


@router.post("/review/submit", response_model=ReviewResponse)
async def submit_review(
    review_data: ReviewSubmit,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Submit quiz answer and update Fibonacci level."""
    # Get user progress for this word
    progress = await get_user_progress_for_word(db, current_user.id, review_data.word_id)
    
    if not progress:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found in learning stack"
        )
    
    # Process review
    updated_progress = await process_review(db, progress, review_data.is_correct)
    
    # Mark as reviewed in daily stack
    await mark_reviewed(db, current_user.id, review_data.word_id, date.today())
    
    # Save quiz session
    quiz_session = QuizSession(
        user_id=current_user.id,
        word_id=review_data.word_id,
        question_type=QuestionType(review_data.question_type),
        options_presented=review_data.options_presented,
        user_answer=review_data.user_answer,
        correct_answer=review_data.correct_answer,
        is_correct=review_data.is_correct,
        time_taken_seconds=review_data.time_taken_seconds
    )
    db.add(quiz_session)
    await db.commit()
    
    return ReviewResponse(
        success=True,
        new_level=updated_progress.fibonacci_level,
        next_review_date=updated_progress.next_review_date.isoformat() if updated_progress.next_review_date else None,
        status=updated_progress.status.value,
        message="Review submitted successfully"
    )


@router.get("/review/upcoming", response_model=List[UpcomingReview])
async def get_upcoming_reviews_endpoint(
    days_ahead: int = 7,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get upcoming review schedule."""
    reviews = await get_upcoming_reviews(db, current_user.id, days_ahead)
    return [UpcomingReview(**r) for r in reviews]


@router.get("/progress/overview")
async def get_progress_overview_endpoint(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get user's overall progress."""
    stats = await get_progress_overview(db, current_user.id)
    return stats


@router.get("/progress/word/{word_id}", response_model=WordProgressDetail)
async def get_word_progress_endpoint(
    word_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get progress for specific word."""
    progress = await get_word_progress(db, current_user.id, word_id)
    if not progress:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word progress not found"
        )
    return WordProgressDetail(**progress)
