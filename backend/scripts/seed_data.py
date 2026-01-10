"""
Data seeding script for VocabMaster
Run with: python -m scripts.seed_data
"""
import asyncio
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy import select
from app.database import Base
from app.config import settings
from app.models.category import Category
from app.models.word import Word, WordSource
from app.models.word_definition import WordDefinition
from app.models.word_etymology import WordEtymology

# Sample data
CATEGORIES = [
    {"name": "GRE", "description": "GRE vocabulary words", "importance_weight": 9.0},
    {"name": "Word Power Made Easy", "description": "Words from Word Power Made Easy", "importance_weight": 8.0},
    {"name": "Academic", "description": "Academic vocabulary", "importance_weight": 7.0},
    {"name": "Business", "description": "Business vocabulary", "importance_weight": 6.0},
]

WORDS = [
    {
        "word": "ephemeral",
        "category": "GRE",
        "difficulty_level": 7.0,
        "importance_score": 85,
        "part_of_speech": ["adjective"],
        "pronunciation": "ih-FEM-er-uhl",
        "source": "GRE",
        "definitions": [
            {
                "definition": "Lasting for a very short time",
                "example_sentence": "The beauty of cherry blossoms is ephemeral.",
                "is_primary": True,
                "order_index": 0
            }
        ],
        "etymology": {
            "origin_language": "Greek",
            "root_word": "ephemeros (lasting only a day)",
            "evolution_story": "Greek → Latin → French → English"
        }
    },
    {
        "word": "ubiquitous",
        "category": "GRE",
        "difficulty_level": 6.0,
        "importance_score": 80,
        "part_of_speech": ["adjective"],
        "pronunciation": "yoo-BIK-wit-uhs",
        "source": "GRE",
        "definitions": [
            {
                "definition": "Present, appearing, or found everywhere",
                "example_sentence": "Smartphones have become ubiquitous in modern society.",
                "is_primary": True,
                "order_index": 0
            }
        ],
        "etymology": {
            "origin_language": "Latin",
            "root_word": "ubique (everywhere)",
            "evolution_story": "Latin → English"
        }
    },
    {
        "word": "meticulous",
        "category": "Word Power Made Easy",
        "difficulty_level": 5.0,
        "importance_score": 75,
        "part_of_speech": ["adjective"],
        "pronunciation": "muh-TIK-yuh-luhs",
        "source": "WordPower",
        "definitions": [
            {
                "definition": "Showing great attention to detail; very careful and precise",
                "example_sentence": "She was meticulous in her research, checking every source twice.",
                "is_primary": True,
                "order_index": 0
            }
        ],
        "etymology": {
            "origin_language": "Latin",
            "root_word": "metus (fear)",
            "evolution_story": "Latin → English"
        }
    },
    {
        "word": "paradigm",
        "category": "Academic",
        "difficulty_level": 7.0,
        "importance_score": 82,
        "part_of_speech": ["noun"],
        "pronunciation": "PAIR-uh-dime",
        "source": "Curated",
        "definitions": [
            {
                "definition": "A typical example or pattern of something; a model",
                "example_sentence": "The new research represents a paradigm shift in our understanding.",
                "is_primary": True,
                "order_index": 0
            }
        ],
        "etymology": {
            "origin_language": "Greek",
            "root_word": "paradeigma (pattern, example)",
            "evolution_story": "Greek → Latin → English"
        }
    },
    {
        "word": "leverage",
        "category": "Business",
        "difficulty_level": 5.0,
        "importance_score": 70,
        "part_of_speech": ["noun", "verb"],
        "pronunciation": "LEV-er-ij",
        "source": "Curated",
        "definitions": [
            {
                "definition": "The exertion of force by means of a lever; strategic advantage",
                "example_sentence": "The company used its market position as leverage in negotiations.",
                "is_primary": True,
                "order_index": 0
            },
            {
                "definition": "To use something to maximum advantage",
                "example_sentence": "We need to leverage our existing relationships.",
                "is_primary": False,
                "order_index": 1
            }
        ],
        "etymology": {
            "origin_language": "French",
            "root_word": "levier (lever)",
            "evolution_story": "French → English"
        }
    }
]


async def seed_data():
    """Seed the database with initial data."""
    engine = create_async_engine(
        settings.database_url.replace("postgresql://", "postgresql+asyncpg://"),
        echo=False
    )
    
    async_session = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    
    async with async_session() as session:
        # Create categories
        category_map = {}
        for cat_data in CATEGORIES:
            result = await session.execute(
                select(Category).where(Category.name == cat_data["name"])
            )
            existing = result.scalar_one_or_none()
            
            if not existing:
                category = Category(**cat_data)
                session.add(category)
                await session.flush()
                category_map[cat_data["name"]] = category.id
                print(f"Created category: {cat_data['name']}")
            else:
                category_map[cat_data["name"]] = existing.id
                print(f"Category already exists: {cat_data['name']}")
        
        await session.commit()
        
        # Create words
        for word_data in WORDS:
            # Check if word exists
            result = await session.execute(
                select(Word).where(Word.word == word_data["word"])
            )
            existing_word = result.scalar_one_or_none()
            
            if existing_word:
                print(f"Word already exists: {word_data['word']}")
                continue
            
            # Get category ID
            category_id = category_map.get(word_data["category"])
            if not category_id:
                print(f"Category not found: {word_data['category']}")
                continue
            
            # Create word
            word = Word(
                word=word_data["word"],
                category_id=category_id,
                difficulty_level=word_data["difficulty_level"],
                importance_score=word_data["importance_score"],
                part_of_speech=word_data["part_of_speech"],
                pronunciation=word_data.get("pronunciation"),
                source=WordSource(word_data["source"])
            )
            session.add(word)
            await session.flush()
            
            # Create definitions
            for def_data in word_data.get("definitions", []):
                definition = WordDefinition(
                    word_id=word.id,
                    definition=def_data["definition"],
                    example_sentence=def_data.get("example_sentence"),
                    is_primary=def_data.get("is_primary", False),
                    order_index=def_data.get("order_index", 0)
                )
                session.add(definition)
            
            # Create etymology
            if "etymology" in word_data:
                etym_data = word_data["etymology"]
                etymology = WordEtymology(
                    word_id=word.id,
                    origin_language=etym_data.get("origin_language"),
                    root_word=etym_data.get("root_word"),
                    evolution_story=etym_data.get("evolution_story")
                )
                session.add(etymology)
            
            print(f"Created word: {word_data['word']}")
        
        await session.commit()
        print("\nSeeding completed successfully!")


if __name__ == "__main__":
    asyncio.run(seed_data())
