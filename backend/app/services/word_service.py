from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, or_, and_, delete
from sqlalchemy.orm import selectinload
from app.models.word import Word, Tone
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
        } if word.category else None,
        "tone": word.tone.value.lower() if word.tone else "neutral",
        "cefr_level": word.cefr_level
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
    source: str = "User",
    tone: Tone = Tone.NEUTRAL,
    cefr_level: Optional[str] = None
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
        source=WordSource(source),
        tone=tone,
        cefr_level=cefr_level
    )
    db.add(new_word)
    await db.commit()
    await db.refresh(new_word)
    return new_word


async def create_word_with_ai(
    db: AsyncSession,
    word: str,
    ai_details: dict
) -> Word:
    """Create a new word with AI-generated details."""
    from app.models.word import WordSource
    from app.models.word_definition import WordDefinition
    from app.models.word_etymology import WordEtymology
    
    # Get or create a default "General" category
    category_query = select(Category).where(Category.name.ilike("General")).limit(1)
    category_result = await db.execute(category_query)
    category = category_result.scalar_one_or_none()
    
    if not category:
        # Create a default "General" category if it doesn't exist
        category = Category(
            name="General",
            description="General vocabulary words",
            importance_weight=5.0
        )
        db.add(category)
        await db.flush()
    
    # Parse tone from AI details, default to NEUTRAL
    # AI returns lowercase, but database enum uses uppercase
    tone_str = ai_details.get("tone", "neutral").upper()
    try:
        tone = Tone(tone_str)
    except ValueError:
        tone = Tone.NEUTRAL
    
    # Get CEFR level from AI details (should be pre-calculated in JSON)
    cefr_level = ai_details.get("cefr_level")
    
    # Create the word
    new_word = Word(
        word=word,
        category_id=category.id,
        difficulty_level=float(ai_details.get("difficulty_level", 5.0)),
        importance_score=int(ai_details.get("importance_score", 50)),
        part_of_speech=ai_details.get("parts_of_speech", []),
        pronunciation=ai_details.get("pronunciation"),
        source=WordSource.USER,
        tone=tone,
        cefr_level=cefr_level
    )
    db.add(new_word)
    await db.flush()  # Flush to get the word ID
    
    # Create definitions
    definitions = ai_details.get("definitions", [])
    for idx, def_data in enumerate(definitions):
        definition = WordDefinition(
            word_id=new_word.id,
            definition=def_data.get("text", ""),
            example_sentence=def_data.get("example"),
            is_primary=def_data.get("is_primary", idx == 0),
            order_index=idx
        )
        db.add(definition)
    
    # Create etymology if available
    etymology_data = ai_details.get("etymology", {})
    if etymology_data and (etymology_data.get("origin_language") or etymology_data.get("root_word") or etymology_data.get("evolution")):
        etymology = WordEtymology(
            word_id=new_word.id,
            origin_language=etymology_data.get("origin_language"),
            root_word=etymology_data.get("root_word"),
            evolution_story=etymology_data.get("evolution")
        )
        db.add(etymology)
    
    await db.commit()
    await db.refresh(new_word)
    
    # Reload with relationships
    return await get_word_by_id(db, new_word.id)


async def delete_word(
    db: AsyncSession,
    word_id: int
) -> bool:
    """Delete a word. Only allows deletion of user-generated words."""
    from app.models.word import WordSource
    from sqlalchemy import delete as sql_delete
    
    # Load word to check source
    word = await get_word_by_id(db, word_id)
    if not word:
        raise ValueError("Word not found")
    
    # Only allow deletion of user-generated words
    if word.source != WordSource.USER:
        raise ValueError("Only user-generated words can be deleted")
    
    # Manually delete related records first to avoid foreign key constraint issues
    # Delete in order: child tables first, then parent
    from app.models.word_definition import WordDefinition
    from app.models.word_etymology import WordEtymology
    from app.models.word_media import WordMedia
    from app.models.user_word_progress import UserWordProgress
    from app.models.daily_word_stack import DailyWordStack
    from app.models.quiz_sessions import QuizSession
    
    # Delete all related records
    await db.execute(sql_delete(WordDefinition).where(WordDefinition.word_id == word_id))
    await db.execute(sql_delete(WordEtymology).where(WordEtymology.word_id == word_id))
    await db.execute(sql_delete(WordMedia).where(WordMedia.word_id == word_id))
    await db.execute(sql_delete(UserWordProgress).where(UserWordProgress.word_id == word_id))
    await db.execute(sql_delete(DailyWordStack).where(DailyWordStack.word_id == word_id))
    await db.execute(sql_delete(QuizSession).where(QuizSession.word_id == word_id))
    
    # Now delete the word itself
    await db.execute(sql_delete(Word).where(Word.id == word_id))
    await db.commit()
    return True
