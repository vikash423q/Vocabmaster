"""
Standalone script to seed vocabulary categories
Run with: python -m scripts.seed_categories
"""
import asyncio
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy import select
from app.config import settings
from app.models.category import Category

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


async def seed_vocab_categories():
    """Seed vocabulary categories with nested sub-categories."""
    engine = create_async_engine(
        settings.database_url.replace("postgresql://", "postgresql+asyncpg://"),
        echo=False
    )
    
    async_session = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    
    async with async_session() as session:
        category_map = {}
        
        # First, create all parent categories
        print("Creating parent categories...")
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
                print(f"  ✓ Created parent category: {parent_name}")
            else:
                category_map[parent_name] = existing.id
                print(f"  - Parent category already exists: {parent_name}")
        
        await session.flush()
        
        # Then, create all sub-categories
        print("\nCreating sub-categories...")
        total_subcats = 0
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
                    total_subcats += 1
                    print(f"  ✓ Created sub-category: {subcat_name} (under {parent_name})")
                else:
                    # Update parent if it's different
                    if existing.parent_category_id != parent_id:
                        existing.parent_category_id = parent_id
                        await session.flush()
                        print(f"  ↻ Updated sub-category: {subcat_name} (set parent to {parent_name})")
                    else:
                        print(f"  - Sub-category already exists: {subcat_name}")
        
        await session.commit()
        print(f"\n{'='*60}")
        print(f"Seeding completed!")
        print(f"  - {len(VOCAB_CATEGORIES)} parent categories")
        print(f"  - {sum(len(subs) for subs in VOCAB_CATEGORIES.values())} sub-categories")
        print(f"  - {total_subcats} new sub-categories created")
        print(f"{'='*60}")


if __name__ == "__main__":
    asyncio.run(seed_vocab_categories())
