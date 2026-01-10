from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, or_, and_
from sqlalchemy.orm import selectinload
from app.models.word import Word
from app.models.category import Category
from app.models.word_definition import WordDefinition
from app.models.word_etymology import WordEtymology
from app.models.word_media import WordMedia


async def get_words(
    db: AsyncSession,
    category_id: Optional[int] = None,
    difficulty_min: Optional[float] = None,
    difficulty_max: Optional[float] = None,
    search: Optional[str] = None,
    limit: int = 100,
    offset: int = 0
) -> List[Word]:
    """Get words with optional filters."""
    query = select(Word)
    
    if category_id:
        query = query.where(Word.category_id == category_id)
    
    if difficulty_min is not None:
        query = query.where(Word.difficulty_level >= difficulty_min)
    
    if difficulty_max is not None:
        query = query.where(Word.difficulty_level <= difficulty_max)
    
    if search:
        query = query.where(Word.word.ilike(f"%{search}%"))
    
    query = query.limit(limit).offset(offset)
    result = await db.execute(query)
    return list(result.scalars().all())


async def get_word_by_id(db: AsyncSession, word_id: int) -> Optional[Word]:
    """Get a word by ID with all related data."""
    query = select(Word).where(Word.id == word_id).options(
        selectinload(Word.definitions),
        selectinload(Word.etymology),
        selectinload(Word.media),
        selectinload(Word.category)
    )
    result = await db.execute(query)
    return result.scalar_one_or_none()


async def get_word_for_review_page(db: AsyncSession, word_id: int) -> Optional[dict]:
    """Get comprehensive word data for review page."""
    word = await get_word_by_id(db, word_id)
    if not word:
        return None
    
    # Get primary definition
    primary_def = None
    for defn in word.definitions:
        if defn.is_primary:
            primary_def = defn
            break
    
    if not primary_def and word.definitions:
        primary_def = word.definitions[0]
    
    return {
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
            "name": word.category.name
        } if word.category else None
    }


async def get_categories(db: AsyncSession) -> List[Category]:
    """Get all categories with hierarchy."""
    result = await db.execute(select(Category).order_by(Category.name))
    return list(result.scalars().all())


async def create_word(
    db: AsyncSession,
    word: str,
    category_id: int,
    difficulty_level: float = 5.0,
    importance_score: int = 50,
    part_of_speech: List[str] = None,
    pronunciation: Optional[str] = None,
    source: str = "User"
) -> Word:
    """Create a new word."""
    from app.models.word import WordSource
    
    new_word = Word(
        word=word,
        category_id=category_id,
        difficulty_level=difficulty_level,
        importance_score=importance_score,
        part_of_speech=part_of_speech or [],
        pronunciation=pronunciation,
        source=WordSource(source)
    )
    db.add(new_word)
    await db.commit()
    await db.refresh(new_word)
    return new_word
