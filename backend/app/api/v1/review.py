from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_, func
from sqlalchemy.orm import selectinload
from datetime import date
from typing import List, Optional, Dict, Any
import random
from app.database import get_db
from app.schemas.review import (
    DailyStackItem,
    ReviewSubmit,
    ReviewResponse,
    AddWordsRequest,
    WordProgressDetail,
    UpcomingReview,
    MCQQuestion,
    DailyStackQuestion
)
from app.services.daily_stack_service import get_daily_stack, mark_reviewed, populate_daily_stack_for_user
from app.services.spaced_repetition_service import (
    process_review,
    add_word_to_learning,
    get_user_progress_for_word
)
from app.services.progress_service import get_progress_overview, get_word_progress, get_upcoming_reviews, get_progress_words
from app.services.word_service import get_words_by_ids, get_word_by_id
from app.models.quiz_sessions import QuizSession, QuestionType
from app.models.user_word_progress import UserWordProgress
from app.models.daily_word_stack import DailyWordStack
from app.models.word import Word

from app.api.dependencies import get_current_user
from app.models.user import User

router = APIRouter()


@router.get("/daily-stack", response_model=List[DailyStackQuestion])
async def get_daily_stack_endpoint(
    target_date: Optional[str] = None,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get today's words to review with prepared MCQ questions and word details."""
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
    
    # Fetch all words with details in batch
    words = await get_words_by_ids(db, word_ids)
    words_dict = {word.id: word for word in words}
    
    # Build response with questions and word details
    result = []
    for item in stack_items:
        word = words_dict.get(item.word_id)
        if not word:
            continue  # Skip if word not found
        
        progress = progress_records.get(item.word_id)
        level = progress.fibonacci_level if progress else 0
        
        # Get primary definition
        primary_def = None
        for defn in word.definitions:
            if defn.is_primary:
                primary_def = defn
                break
        if not primary_def and word.definitions:
            primary_def = word.definitions[0]
        
        if not primary_def:
            continue  # Skip if no definition
        
        # Get random words for wrong options
        wrong_options = []
        used_word_ids = {word.id}
        difficulty = float(word.difficulty_level)
        category_id = word.category_id if word.category else None
        
        # Try to get words from same category first
        if category_id:
            try:
                category_query = select(Word).where(
                    and_(
                        Word.category_id == category_id,
                        Word.difficulty_level >= difficulty - 1.0,
                        Word.difficulty_level <= difficulty + 1.0,
                        ~Word.id.in_(used_word_ids)
                    )
                ).limit(20)
                category_result = await db.execute(category_query)
                category_words = list(category_result.scalars().all())
                
                for cat_word in category_words:
                    wrong_options.append(cat_word.word)
                    used_word_ids.add(cat_word.id)
                    if len(wrong_options) >= 3:
                        break
            except Exception:
                pass  # Continue to general search
        
        # If we don't have enough, get random words from similar difficulty
        if len(wrong_options) < 3:
            similar_query = select(Word).where(
                and_(
                    Word.difficulty_level >= difficulty - 1.5,
                    Word.difficulty_level <= difficulty + 1.5,
                    ~Word.id.in_(used_word_ids)
                )
            ).limit(30)
            similar_result = await db.execute(similar_query)
            similar_words = list(similar_result.scalars().all())
            
            for sim_word in similar_words:
                wrong_options.append(sim_word.word)
                used_word_ids.add(sim_word.id)
                if len(wrong_options) >= 3:
                    break
        
        # Shuffle and take 3 wrong options
        random.shuffle(wrong_options)
        selected_wrong_options = wrong_options[:3]
        
        # Create 4 options: correct answer + 3 wrong options
        all_options = [word.word] + selected_wrong_options
        random.shuffle(all_options)
        
        # Format word detail (same format as get_word endpoint)
        word_detail_dict = {
            "id": word.id,
            "word": word.word,
            "pronunciation": word.pronunciation,
            "parts_of_speech": word.part_of_speech or [],
            "definitions": [
                {
                    "text": d.definition,
                    "is_primary": d.is_primary,
                    "examples": [d.example_sentence] if d.example_sentence else []
                }
                for d in sorted(word.definitions, key=lambda x: (not x.is_primary, x.order_index))
            ],
            "etymology": {
                "origin_language": word.etymology.origin_language if word.etymology else None,
                "root_word": word.etymology.root_word if word.etymology else None,
                "evolution": word.etymology.evolution_story if word.etymology else None
            } if word.etymology else None,
            "media": [
                {
                    "type": m.media_type.value,
                    "url": m.url,
                    "source": m.source,
                    "caption": m.caption,
                    "is_ai_generated": m.is_ai_generated
                }
                for m in word.media
            ],
            "category": {
                "id": word.category.id,
                "name": word.category.name,
                "description": word.category.description,
                "parent_category_id": word.category.parent_category_id,
                "importance_weight": float(word.category.importance_weight)
            } if word.category else None,
            "difficulty_level": float(word.difficulty_level),
            "importance_score": word.importance_score,
            "source": word.source.value,
            "tone": word.tone.value.lower() if word.tone else "neutral",
            "cefr_level": word.cefr_level
        }
        
        # Create MCQ question
        mcq_question = MCQQuestion(
            word_id=word.id,
            word=word.word,
            definition=primary_def.definition,
            options=all_options,
            correct_answer=word.word,
            level=level
        )
        
        result.append(DailyStackQuestion(
            id=item.id,
            word_id=word.id,
            scheduled_date=item.scheduled_date.isoformat(),
            is_reviewed=item.is_reviewed,
            level=level,
            question=mcq_question,
            word_detail=word_detail_dict
        ))
    
    return result


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


@router.get("/review/history")
async def get_review_history_endpoint(
    days_back: int = 30,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get past review history grouped by date."""
    from datetime import date, timedelta
    from collections import defaultdict
    
    start_date = date.today() - timedelta(days=days_back)
    
    # Get reviewed items from daily stack
    query = select(DailyWordStack).where(
        and_(
            DailyWordStack.user_id == current_user.id,
            DailyWordStack.scheduled_date >= start_date,
            DailyWordStack.scheduled_date <= date.today(),
            DailyWordStack.is_reviewed == True
        )
    ).options(selectinload(DailyWordStack.word))
    
    result = await db.execute(query)
    reviewed_items = result.scalars().all()
    
    # Group by date
    history_by_date = defaultdict(int)
    for item in reviewed_items:
        date_str = item.scheduled_date.isoformat()
        history_by_date[date_str] += 1
    
    # Get upcoming reviews grouped by date
    upcoming_reviews = await get_upcoming_reviews(db, current_user.id, days_ahead=30)
    upcoming_by_date = defaultdict(int)
    for review in upcoming_reviews:
        if review.get('review_date'):
            upcoming_by_date[review['review_date']] += 1
    
    return {
        "past_reviews": dict(history_by_date),
        "upcoming_reviews": dict(upcoming_by_date)
    }


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


@router.get("/progress/words")
async def get_progress_words_endpoint(
    status: Optional[str] = "all",
    category_id: Optional[int] = Query(None),
    subcategory_id: Optional[int] = Query(None),
    search: Optional[str] = Query(None),
    limit: Optional[int] = None,
    offset: Optional[int] = None,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get progress words filtered by status, category, subcategory, and search."""
    # Validate status parameter
    valid_statuses = ["all", "mastered", "learning", "reviewing"]
    if status and status.lower() not in valid_statuses:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Invalid status. Must be one of: {', '.join(valid_statuses)}"
        )
    
    words = await get_progress_words(
        db=db,
        user_id=current_user.id,
        status_filter=status.lower() if status else "all",
        category_id=category_id,
        subcategory_id=subcategory_id,
        search=search,
        limit=limit,
        offset=offset
    )
    
    return {
        "words": words,
        "total": len(words),
        "status": status.lower() if status else "all"
    }
