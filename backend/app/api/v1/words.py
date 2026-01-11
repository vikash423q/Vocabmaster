from fastapi import APIRouter, Depends, Query, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from typing import List, Optional
import httpx
from app.database import get_db
from app.schemas.word import WordCreate, WordCreateSimple, WordDetail, WordListItem, ReviewPageData, CategorySchema
from app.services.word_service import (
    get_words,
    get_word_by_id,
    get_word_for_review_page,
    get_categories,
    create_word,
    create_word_with_ai,
    delete_word
)
from app.api.dependencies import get_current_user
from app.models.user import User
from app.models.word import Word
from app.config import settings

router = APIRouter()


@router.get("", response_model=List[WordListItem])
async def list_words(
    category_id: Optional[int] = Query(None),
    difficulty_min: Optional[float] = Query(None),
    difficulty_max: Optional[float] = Query(None),
    search: Optional[str] = Query(None),
    limit: int = Query(100, le=500),
    offset: int = Query(0, ge=0),
    db: AsyncSession = Depends(get_db)
):
    """List words with optional filters."""
    words = await get_words(
        db=db,
        category_id=category_id,
        difficulty_min=difficulty_min,
        difficulty_max=difficulty_max,
        search=search,
        limit=limit,
        offset=offset
    )
    return words


@router.get("/{word_id}", response_model=WordDetail)
async def get_word(
    word_id: int,
    db: AsyncSession = Depends(get_db)
):
    """Get comprehensive word details."""
    word = await get_word_by_id(db, word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    # Format response
    primary_def = None
    for defn in word.definitions:
        if defn.is_primary:
            primary_def = defn
            break
    
    return WordDetail(
        id=word.id,
        word=word.word,
        pronunciation=word.pronunciation,
        parts_of_speech=word.part_of_speech or [],
        definitions=[
            {
                "text": d.definition,
                "is_primary": d.is_primary,
                "examples": [d.example_sentence] if d.example_sentence else []
            }
            for d in sorted(word.definitions, key=lambda x: (not x.is_primary, x.order_index))
        ],
        etymology={
            "origin_language": word.etymology.origin_language if word.etymology else None,
            "root_word": word.etymology.root_word if word.etymology else None,
            "evolution": word.etymology.evolution_story if word.etymology else None
        } if word.etymology else None,
        media=[
            {
                "type": m.media_type.value,
                "url": m.url,
                "source": m.source,
                "caption": m.caption,
                "is_ai_generated": m.is_ai_generated
            }
            for m in word.media
        ],
        category={
            "id": word.category.id,
            "name": word.category.name,
            "description": word.category.description,
            "parent_category_id": word.category.parent_category_id,
            "importance_weight": float(word.category.importance_weight)
        } if word.category else None,
        difficulty_level=float(word.difficulty_level),
        importance_score=word.importance_score,
        source=word.source.value,
        tone=word.tone.value.lower() if word.tone else "neutral",
        cefr_level=word.cefr_level
    )


@router.get("/{word_id}/review-page", response_model=ReviewPageData)
async def get_review_page(
    word_id: int,
    db: AsyncSession = Depends(get_db)
):
    """Get comprehensive review page data."""
    data = await get_word_for_review_page(db, word_id)
    if not data:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    return ReviewPageData(**data)


@router.post("", response_model=WordDetail, status_code=status.HTTP_201_CREATED)
async def create_word_endpoint(
    word_data: WordCreateSimple,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Add a custom word. AI will generate definitions, etymology, pronunciation, and other details."""
    # Check if word already exists
    existing_query = select(Word).where(Word.word.ilike(word_data.word))
    existing_result = await db.execute(existing_query)
    existing = existing_result.scalar_one_or_none()
    
    if existing:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Word '{word_data.word}' already exists"
        )
    
    # Call AI service to generate word details
    try:
        async with httpx.AsyncClient() as client:
            ai_response = await client.post(
                f"{settings.ai_agent_service_url}/generate-word-details",
                json={"word": word_data.word},
                timeout=60.0
            )
            ai_response.raise_for_status()
            ai_details = ai_response.json()
    except httpx.HTTPError as e:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"AI service error: {str(e)}"
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error generating word details: {str(e)}"
        )
    
    # Create word with AI-generated details
    try:
        word = await create_word_with_ai(db, word_data.word, ai_details)
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error creating word: {str(e)}"
        )
    
    # Format and return word detail (same format as get_word endpoint)
    return WordDetail(
        id=word.id,
        word=word.word,
        pronunciation=word.pronunciation,
        parts_of_speech=word.part_of_speech or [],
        definitions=[
            {
                "text": d.definition,
                "is_primary": d.is_primary,
                "examples": [d.example_sentence] if d.example_sentence else []
            }
            for d in sorted(word.definitions, key=lambda x: (not x.is_primary, x.order_index))
        ],
        etymology={
            "origin_language": word.etymology.origin_language if word.etymology else None,
            "root_word": word.etymology.root_word if word.etymology else None,
            "evolution": word.etymology.evolution_story if word.etymology else None
        } if word.etymology else None,
        media=[
            {
                "type": m.media_type.value,
                "url": m.url,
                "source": m.source,
                "caption": m.caption,
                "is_ai_generated": m.is_ai_generated
            }
            for m in word.media
        ],
        category={
            "id": word.category.id,
            "name": word.category.name,
            "description": word.category.description,
            "parent_category_id": word.category.parent_category_id,
            "importance_weight": float(word.category.importance_weight)
        } if word.category else None,
        difficulty_level=float(word.difficulty_level),
        importance_score=word.importance_score,
        source=word.source.value,
        tone=word.tone.value.lower() if word.tone else "neutral",
        cefr_level=word.cefr_level
    )


@router.delete("/{word_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_word_endpoint(
    word_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Delete a user-generated word. Only user-generated words can be deleted."""
    # Check if word exists
    word = await get_word_by_id(db, word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    # Try to delete (will raise ValueError if not user-generated)
    try:
        await delete_word(db, word_id)
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error deleting word: {str(e)}"
        )
    
    return {"message": "Word deleted successfully"}


@router.get("/categories/list", response_model=List[CategorySchema])
async def list_categories(
    db: AsyncSession = Depends(get_db)
):
    """List all categories with hierarchy."""
    categories = await get_categories(db)
    return categories
