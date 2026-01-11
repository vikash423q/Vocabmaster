"""
Data seeding script for VocabMaster
Run with: python -m scripts.seed_data
"""
import asyncio
import sys
import json
from pathlib import Path
from typing import List, Dict, Optional

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy import select
from app.database import Base
from app.config import settings
from app.models.category import Category
from app.models.word import Word, WordSource, Tone
from app.models.word_definition import WordDefinition
from app.models.word_etymology import WordEtymology
from app.models.word_media import WordMedia, MediaType

# Vocabulary Categories with nested sub-categories
VOCAB_CATEGORIES = {
    "Human Personality & Character": [
        "Positive Traits",
        "Negative Traits",
        "Moral & Ethical Traits",
        "Intellectual Traits",
        "Emotional Disposition",
        "Social Traits",
        "Courage & Cowardice"
    ],

    "Emotions, Feelings & Psychological States": [
        "Happiness & Pleasure",
        "Sadness & Despair",
        "Anger & Hostility",
        "Fear & Anxiety",
        "Confidence & Doubt",
        "Mental Stability & Instability"
    ],

    "Intelligence, Knowledge & Thinking": [
        "Intelligence & Wisdom",
        "Ignorance & Foolishness",
        "Learning & Education",
        "Thinking & Reasoning",
        "Memory & Forgetfulness"
    ],

    "Communication, Speech & Language": [
        "Talkative vs Silent",
        "Honest vs Deceptive Speech",
        "Persuasion & Rhetoric",
        "Criticism & Praise",
        "Writing Style & Expression"
    ],

    "Social Behavior & Human Interaction": [
        "Cooperation & Harmony",
        "Conflict & Opposition",
        "Leadership & Authority",
        "Obedience & Submission",
        "Rebellion & Independence"
    ],

    "Power, Control & Politics": [
        "Power & Authority",
        "Tyranny & Oppression",
        "Democracy & Freedom",
        "Law & Governance"
    ],

    "Morality, Ethics & Values": [
        "Good vs Evil",
        "Justice & Fairness",
        "Integrity & Corruption",
        "Responsibility & Neglect"
    ],

    "Work, Effort & Productivity": [
        "Hard Work & Diligence",
        "Laziness & Neglect",
        "Skill & Competence",
        "Planning & Execution"
    ],

    "Success, Failure & Achievement": [
        "Success & Triumph",
        "Failure & Defeat",
        "Progress & Improvement",
        "Decline & Deterioration"
    ],

    "Change, Growth & Transformation": [
        "Beginning & Creation",
        "Change & Mutation",
        "Growth & Expansion",
        "Decline & End"
    ],

    "Order, Structure & Organization": [
        "Order & System",
        "Disorder & Chaos",
        "Simplicity & Complexity"
    ],

    "Quantity, Degree & Measurement": [
        "Large Amounts",
        "Small Amounts",
        "Excess & Deficiency",
        "Intensity & Strength"
    ],

    "Time & Temporality": [
        "Speed & Slowness",
        "Permanence & Transience",
        "Frequency & Repetition"
    ],

    "Nature, Environment & Physical World": [
        "Natural Phenomena",
        "Climate & Geography",
        "Animals & Biology"
    ],

    "Science, Logic & Analysis": [
        "Cause & Effect",
        "Evidence & Proof",
        "Theory & Hypothesis"
    ],

    "Art, Culture & Aesthetics": [
        "Beauty & Ugliness",
        "Creativity & Originality",
        "Tradition & Convention"
    ],

    "Economics, Trade & Resources": [
        "Wealth & Poverty",
        "Trade & Commerce",
        "Resources & Scarcity"
    ],

    "Religion, Philosophy & Belief": [
        "Belief & Faith",
        "Skepticism & Doubt",
        "Fate & Destiny"
    ],

    "Health, Body & Medicine": [
        "Health & Vitality",
        "Disease & Weakness",
        "Mental Health"
    ],

    "Miscellaneous / High-Frequency GRE Words": [
        "Abstract High-Frequency Words",
        "Context-Dependent Words",
        "Hard-to-Classify Words"
    ]
}

# Sample data (legacy categories - kept for backward compatibility)
CATEGORIES = [
    {"name": "GRE", "description": "GRE vocabulary words", "importance_weight": 9.0},
    {"name": "Word Power Made Easy", "description": "Words from Word Power Made Easy", "importance_weight": 8.0},
    {"name": "Academic", "description": "Academic vocabulary", "importance_weight": 7.0},
    {"name": "Business", "description": "Business vocabulary", "importance_weight": 6.0},
]

# Path to generated seed data JSON file
GENERATED_SEED_DATA_FILE = Path(__file__).parent / "generated_seed_data.json"

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


async def seed_vocab_categories(session: AsyncSession):
    """Seed vocabulary categories with nested sub-categories."""
    category_map = {}
    
    # First, create all parent categories
    for parent_name, subcategories in VOCAB_CATEGORIES.items():
        result = await session.execute(
            select(Category).where(Category.name == parent_name)
        )
        existing = result.scalar_one_or_none()
        
        if not existing:
            parent_category = Category(
                name=parent_name,
                description=f"Vocabulary category: {parent_name}",
                importance_weight=7.0,
                parent_category_id=None
            )
            session.add(parent_category)
            await session.flush()
            category_map[parent_name] = parent_category.id
            print(f"Created parent category: {parent_name}")
        else:
            category_map[parent_name] = existing.id
            print(f"Parent category already exists: {parent_name}")
    
    await session.flush()
    
    # Then, create all sub-categories
    for parent_name, subcategories in VOCAB_CATEGORIES.items():
        parent_id = category_map[parent_name]
        
        for subcat_name in subcategories:
            result = await session.execute(
                select(Category).where(Category.name == subcat_name)
            )
            existing = result.scalar_one_or_none()
            
            if not existing:
                sub_category = Category(
                    name=subcat_name,
                    description=f"Sub-category of {parent_name}: {subcat_name}",
                    importance_weight=6.0,
                    parent_category_id=parent_id
                )
                session.add(sub_category)
                await session.flush()
                category_map[subcat_name] = sub_category.id
                print(f"  Created sub-category: {subcat_name} (under {parent_name})")
            else:
                # Update parent if it's different
                if existing.parent_category_id != parent_id:
                    existing.parent_category_id = parent_id
                    await session.flush()
                    print(f"  Updated sub-category: {subcat_name} (set parent to {parent_name})")
                else:
                    print(f"  Sub-category already exists: {subcat_name}")
    
    await session.commit()
    print(f"\nSeeded {len(VOCAB_CATEGORIES)} parent categories with {sum(len(subs) for subs in VOCAB_CATEGORIES.values())} sub-categories")
    return category_map


def load_generated_words() -> List[Dict]:
    """Load words from generated seed data JSON file."""
    if not GENERATED_SEED_DATA_FILE.exists():
        print(f"Generated seed data file not found: {GENERATED_SEED_DATA_FILE}")
        return []
    
    import json
    with open(GENERATED_SEED_DATA_FILE, 'r') as f:
        return json.load(f)


async def find_category_by_name(session: AsyncSession, category_name: str) -> Optional[int]:
    """Find category ID by name (supports parent > sub-category format)."""
    if ">" in category_name:
        parts = category_name.split(">")
        parent_name = parts[0].strip()
        sub_name = parts[1].strip()
        
        # Find parent
        parent_result = await session.execute(
            select(Category).where(Category.name == parent_name)
        )
        parent = parent_result.scalar_one_or_none()
        if not parent:
            return None
        
        # Find sub-category
        sub_result = await session.execute(
            select(Category).where(
                Category.name == sub_name,
                Category.parent_category_id == parent.id
            )
        )
        sub = sub_result.scalar_one_or_none()
        return sub.id if sub else parent.id
    else:
        # Just parent category
        result = await session.execute(
            select(Category).where(Category.name == category_name)
        )
        cat = result.scalar_one_or_none()
        return cat.id if cat else None


async def seed_data():
    """Seed the database with initial data."""
    engine = create_async_engine(
        settings.database_url.replace("postgresql://", "postgresql+asyncpg://"),
        echo=False
    )
    
    async_session = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    
    async with async_session() as session:
        # Seed vocabulary categories first
        await seed_vocab_categories(session)
        
        # Load generated words if available
        generated_words = load_generated_words()
        if generated_words:
            print(f"\n📦 Loading {len(generated_words)} words from generated seed data...")
            await seed_generated_words(session, generated_words)
        
        # Create legacy categories
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


async def seed_generated_words(session: AsyncSession, generated_words: List[Dict]):
    """Seed words from generated seed data JSON."""
    
    for word_data in generated_words:
        word_text = word_data.get("word")
        if not word_text:
            continue
        
        # Check if word exists
        result = await session.execute(
            select(Word).where(Word.word == word_text)
        )
        existing_word = result.scalar_one_or_none()
        
        if existing_word:
            print(f"  - Word already exists: {word_text}")
            continue
        
        # Find or use default category
        category_id = None
        # Try new format first (category and sub_category separate)
        category_name = word_data.get("category")
        sub_category_name = word_data.get("sub_category")
        
        if category_name:
            if sub_category_name:
                # Try to find sub-category
                category_id = await find_category_by_name(session, f"{category_name} > {sub_category_name}")
            if not category_id:
                # Fall back to parent category
                category_id = await find_category_by_name(session, category_name)
        
        # Fallback to old format
        if not category_id:
            category_suggestion = word_data.get("category_suggestion")
            if category_suggestion:
                category_id = await find_category_by_name(session, category_suggestion)
        
        if not category_id:
            # Use default "General" category
            general_result = await session.execute(
                select(Category).where(Category.name.ilike("General")).limit(1)
            )
            general = general_result.scalar_one_or_none()
            if general:
                category_id = general.id
            else:
                print(f"  ⚠️  No category found for '{word_text}', skipping")
                continue
        
        # Parse tone
        tone_str = word_data.get("tone", "neutral").upper()
        try:
            tone = Tone(tone_str)
        except ValueError:
            tone = Tone.NEUTRAL
        
        # Create word
        word = Word(
            word=word_text,
            category_id=category_id,
            difficulty_level=float(word_data.get("difficulty_level", 5.0)),
            importance_score=int(word_data.get("importance_score", 50)),
            part_of_speech=word_data.get("parts_of_speech", []),
            pronunciation=word_data.get("pronunciation"),
            source=WordSource(word_data.get("source", "Curated")),
            tone=tone
        )
        session.add(word)
        await session.flush()
        
        # Create definitions
        for idx, def_data in enumerate(word_data.get("definitions", [])):
            definition = WordDefinition(
                word_id=word.id,
                definition=def_data.get("text", ""),
                example_sentence=def_data.get("example"),
                is_primary=def_data.get("is_primary", idx == 0),
                order_index=idx
            )
            session.add(definition)
        
        # Create etymology
        etymology_data = word_data.get("etymology", {})
        if etymology_data and (etymology_data.get("origin_language") or etymology_data.get("root_word") or etymology_data.get("evolution")):
            etymology = WordEtymology(
                word_id=word.id,
                origin_language=etymology_data.get("origin_language"),
                root_word=etymology_data.get("root_word"),
                evolution_story=etymology_data.get("evolution")
            )
            session.add(etymology)
        
        # Create media
        for media_data in word_data.get("media", []):
            media_type_str = media_data.get("type", "image").lower()
            try:
                if media_type_str == "image":
                    media_type = MediaType.IMAGE
                elif media_type_str == "quote":
                    media_type = MediaType.QUOTE
                elif media_type_str == "video_clip":
                    media_type = MediaType.VIDEO_CLIP
                else:
                    media_type = MediaType.IMAGE
            except:
                media_type = MediaType.IMAGE
            
            word_media = WordMedia(
                word_id=word.id,
                media_type=media_type,
                url=media_data.get("url", ""),
                source=media_data.get("source"),
                caption=media_data.get("caption"),
                is_ai_generated=media_data.get("is_ai_generated", False)
            )
            session.add(word_media)
        
        print(f"  ✅ Created word: {word_text}")
    
    await session.commit()
    print(f"\n✅ Seeded {len(generated_words)} words from generated data")


if __name__ == "__main__":
    asyncio.run(seed_data())
