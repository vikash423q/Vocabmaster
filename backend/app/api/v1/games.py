"""
Game API endpoints for vocabulary learning games.
"""
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_
from sqlalchemy.orm import selectinload
import random
from typing import List, Dict, Optional, Tuple

from app.database import get_db
from app.api.dependencies import get_current_user
from app.models.user import User
from app.models.word import Word
from app.models.word_synonym import WordSynonym

router = APIRouter()


def calculate_difficulty_range(level: int) -> Tuple[float, float]:
    """
    Calculate difficulty range based on level.
    Level 1: 5.0-5.5
    Level 2: 5.0-6.0
    Level 3: 5.0-6.5
    etc. (increases by 0.5 per level)
    """
    min_difficulty = 5.0
    max_difficulty = 5.0 + (level * 0.5)
    return (min_difficulty, max_difficulty)


def calculate_timer_seconds(level: int) -> int:
    """
    Calculate timer seconds based on level.
    Level 1: 72 seconds (12 seconds per pair * 6 pairs)
    Each level decreases by 12 seconds, capped at 12 seconds minimum.
    """
    base_time = 72  # Level 1
    time_decrease = (level - 1) * 12
    timer = base_time - time_decrease
    return max(12, timer)  # Cap at 12 seconds minimum


@router.get("/")
async def games_root():
    """Games API root endpoint."""
    return {"message": "Games API", "available_games": ["iceburst"]}


@router.get("/iceburst/start")
async def start_iceburst_game(
    level: int = Query(1, ge=1, description="Game level (1+)"),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """
    Start an Iceburst game session.
    
    Args:
        level: Game level (default: 1). Higher levels have wider difficulty ranges and less time.
            - Level 1: difficulty 5.0-5.5, 72 seconds
            - Level 2: difficulty 5.0-6.0, 60 seconds
            - Level 3: difficulty 5.0-6.5, 48 seconds
            - And so on...
    
    Returns 6 words with 1 synonym each, randomly selected from the difficulty range.
    The game is a 4x3 grid matching game where users match words with their synonyms.
    """
    # Calculate difficulty range for this level
    min_difficulty, max_difficulty = calculate_difficulty_range(level)
    
    # Calculate timer for this level
    timer_seconds = calculate_timer_seconds(level)
    
    # Get words within difficulty range that have at least 1 synonym
    words_query = (
        select(Word)
        .join(WordSynonym)
        .where(
            and_(
                Word.difficulty_level >= min_difficulty,
                Word.difficulty_level <= max_difficulty
            )
        )
        .group_by(Word.id)
        .having(func.count(WordSynonym.id) >= 1)
        .options(selectinload(Word.synonyms))
    )
    
    result = await db.execute(words_query)
    all_words = list(result.scalars().all())
    
    if len(all_words) < 6:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Not enough words with synonyms available in difficulty range {min_difficulty}-{max_difficulty}. "
                   f"Found {len(all_words)} words, need at least 6."
        )
    
    # Randomly select 6 words
    selected_words = random.sample(all_words, 6)
    
    # Build game data with word and one random synonym each
    game_words = []
    for word in selected_words:
        # Get all synonyms for this word
        synonyms = [syn.synonym for syn in word.synonyms]
        
        if not synonyms:
            continue
        
        # Randomly select one synonym
        selected_synonym = random.choice(synonyms)
        
        game_words.append({
            "word": word.word,
            "word_id": word.id,
            "synonym": selected_synonym,
            "difficulty_level": float(word.difficulty_level),
        })
    
    if len(game_words) < 6:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Could not generate enough word-synonym pairs for the game."
        )
    
    # Create a shuffled list of all items (words + synonyms) for the grid
    grid_items = []
    for item in game_words:
        grid_items.append({
            "id": f"word_{item['word_id']}",
            "text": item["word"],
            "type": "word",
            "pair_id": item["word_id"],
        })
        grid_items.append({
            "id": f"syn_{item['word_id']}",
            "text": item["synonym"],
            "type": "synonym",
            "pair_id": item["word_id"],
        })
    
    # Shuffle the grid items
    random.shuffle(grid_items)
    
    return {
        "game_type": "iceburst",
        "level": level,
        "difficulty_range": {
            "min": min_difficulty,
            "max": max_difficulty
        },
        "words": game_words,  # The correct pairs for validation
        "grid": grid_items,  # Shuffled items for the 4x3 grid
        "grid_size": {"rows": 4, "cols": 3},
        "timer_seconds": timer_seconds,
    }
