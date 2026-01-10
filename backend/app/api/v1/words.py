from fastapi import APIRouter, Depends, Query, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List, Optional
from app.database import get_db
from app.schemas.word import WordCreate, WordDetail, WordListItem, ReviewPageData, CategorySchema
from app.services.word_service import (
    get_words,
    get_word_by_id,
    get_word_for_review_page,
    get_categories,
    create_word
)
from app.api.dependencies import get_current_user
from app.models.user import User

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
        source=word.source.value
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
    word_data: WordCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Add a custom word."""
    word = await create_word(
        db=db,
        word=word_data.word,
        category_id=word_data.category_id,
        difficulty_level=word_data.difficulty_level,
        importance_score=word_data.importance_score,
        part_of_speech=word_data.part_of_speech,
        pronunciation=word_data.pronunciation,
        source=word_data.source
    )
    
    # Return word detail
    return await get_word(word.id, db)


@router.get("/categories/list", response_model=List[CategorySchema])
async def list_categories(
    db: AsyncSession = Depends(get_db)
):
    """List all categories with hierarchy."""
    categories = await get_categories(db)
    return categories
