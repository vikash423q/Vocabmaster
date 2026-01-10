from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from app.database import get_db
from app.schemas.word import MediaSchema
from app.models.word_media import WordMedia, MediaType
from app.services.word_service import get_word_by_id
from app.api.dependencies import get_current_user
from app.models.user import User

router = APIRouter()


@router.get("/{word_id}/media", response_model=List[MediaSchema])
async def get_word_media(
    word_id: int,
    db: AsyncSession = Depends(get_db)
):
    """Get all media for a word."""
    word = await get_word_by_id(db, word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    return [
        MediaSchema(
            type=m.media_type.value,
            url=m.url,
            source=m.source,
            caption=m.caption,
            is_ai_generated=m.is_ai_generated
        )
        for m in word.media
    ]


@router.post("/{word_id}/media", response_model=MediaSchema, status_code=status.HTTP_201_CREATED)
async def add_word_media(
    word_id: int,
    media_type: str,
    url: str,
    source: str = None,
    caption: str = None,
    is_ai_generated: bool = False,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Add media to a word (admin/curator only)."""
    word = await get_word_by_id(db, word_id)
    if not word:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Word not found"
        )
    
    # In production, check if user is admin/curator
    # For now, allow any authenticated user
    
    media = WordMedia(
        word_id=word_id,
        media_type=MediaType(media_type),
        url=url,
        source=source,
        caption=caption,
        is_ai_generated=is_ai_generated
    )
    db.add(media)
    await db.commit()
    await db.refresh(media)
    
    return MediaSchema(
        type=media.media_type.value,
        url=media.url,
        source=media.source,
        caption=media.caption,
        is_ai_generated=media.is_ai_generated
    )
