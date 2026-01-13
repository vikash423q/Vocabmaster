"""
Check for words from CEFR CSV that are missing in the database
Run with: python -m scripts.check_missing_c1
"""
import asyncio
import csv
import json
import sys
from pathlib import Path
from typing import List, Dict, Set, Any
from urllib.parse import urlparse, urlunparse

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

# Add scripts directory to path for imports
scripts_dir = Path(__file__).parent
sys.path.insert(0, str(scripts_dir))

from sqlalchemy import select, func, text
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.exc import OperationalError, ProgrammingError

from app.config import settings
from app.models.word import Word
from word_difficulty import get_difficulty_score


def get_database_url() -> str:
    """Get the database URL and convert to asyncpg format."""
    db_url = settings.database_url
    if db_url.startswith("postgresql://"):
        db_url = db_url.replace("postgresql://", "postgresql+asyncpg://")
    return db_url


def mask_password_in_url(url: str) -> str:
    """Mask password in database URL for display."""
    parsed = urlparse(url)
    if parsed.password:
        # Replace password with ***
        masked_netloc = f"{parsed.username}:{settings.db_password}@{parsed.hostname}"
        if parsed.port:
            masked_netloc += f":{parsed.port}"
        parsed = parsed._replace(netloc=masked_netloc)
    return urlunparse(parsed)


# Create async engine
database_url = get_database_url()
engine = create_async_engine(
    database_url,
    echo=False,
    future=True,
    pool_pre_ping=True,  # Verify connections before using
)

# Create async session factory
AsyncSessionLocal = async_sessionmaker(
    engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autocommit=False,
    autoflush=False
)


async def get_all_db_words(session: AsyncSession) -> Set[str]:
    """Get all words from database as a set (lowercase for comparison)."""
    result = await session.execute(select(Word.word))
    words = {word.strip().lower() for word in result.scalars().all()}
    return words


def load_definitions_from_seed_data(seed_data_path: Path) -> Dict[str, str]:
    """Load definitions from generated_seed_data.json file."""
    definitions = {}
    
    if not seed_data_path.exists():
        print(f"⚠️  Seed data file not found: {seed_data_path}")
        return definitions
    
    try:
        with open(seed_data_path, 'r', encoding='utf-8') as f:
            seed_data = json.load(f)
            
        for word_data in seed_data:
            word = word_data.get('word', '').strip().lower()
            if word:
                # Get first definition if available
                definitions_list = word_data.get('definitions', [])
                if definitions_list and len(definitions_list) > 0:
                    definitions[word] = definitions_list[0].get('definition', '')
    except Exception as e:
        print(f"⚠️  Error loading seed data: {e}")
    
    return definitions


async def get_cefr_statistics(session: AsyncSession) -> dict:
    """Get statistics about CEFR levels in the database."""
    # Count words by CEFR level
    result = await session.execute(
        select(
            Word.cefr_level,
            func.count(Word.id).label('count')
        ).group_by(Word.cefr_level)
    )
    
    stats = {}
    for row in result.all():
        level = row.cefr_level or "NULL"
        stats[level] = row.count
    
    return stats


async def test_connection(session: AsyncSession) -> bool:
    """Test database connection."""
    try:
        await session.execute(text("SELECT 1"))
        await session.commit()
        return True
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        return False


def load_cefr_csv_with_details(csv_path: Path) -> List[Dict[str, str]]:
    """Load CEFR CSV file and return list of word entries with details."""
    words_list = []
    
    if not csv_path.exists():
        print(f"⚠️  CEFR CSV file not found: {csv_path}")
        return words_list
    
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            word = row.get("word", "").strip()
            cefr = row.get("cefr_level", "").strip().upper()
            
            if word and cefr:
                # Handle multiple words (e.g., "a.m./A.M./am/AM")
                word_variants = [w.strip() for w in word.split('/')]
                for variant in word_variants:
                    if variant:
                        words_list.append({
                            'word': variant,
                            'word_lower': variant.lower(),
                            'cefr_level': cefr,
                            'original_headword': word
                        })
    
    return words_list


def find_missing_words(cefr_words: List[Dict[str, str]], db_words: Set[str]) -> List[Dict[str, str]]:
    """Find words from CEFR CSV that are not in the database."""
    missing = []
    
    for cefr_word in cefr_words:
        word_lower = cefr_word['word_lower']
        # Check if word exists in database
        if word_lower not in db_words:
            # Also try without special characters
            word_clean = word_lower.replace("'", "").replace("-", "").replace(" ", "")
            if word_clean not in db_words:
                missing.append(cefr_word)
    
    return missing


def sort_by_cefr_level(words: List[Dict[str, str]]) -> List[Dict[str, str]]:
    """Sort words by CEFR level (A1, A2, B1, B2, C1, C2) and then alphabetically by word."""
    level_order = {"A1": 1, "A2": 2, "B1": 3, "B2": 4, "C1": 5, "C2": 6}
    
    def sort_key(word_data):
        level = word_data['cefr_level']
        level_priority = level_order.get(level, 99)  # Unknown levels go to end
        word_lower = word_data['word'].lower()
        return (level_priority, word_lower)
    
    return sorted(words, key=sort_key)


def calculate_difficulty_and_lookup_definition(word_data: Dict[str, str], definitions_map: Dict[str, str]) -> Dict[str, Any]:
    """Calculate difficulty level and look up definition for a word."""
    word = word_data['word']
    cefr_level = word_data['cefr_level']
    
    # Calculate difficulty level using get_difficulty_score
    try:
        difficulty_score = get_difficulty_score(word, cefr_level)
        # Convert to 1-10 scale (difficulty_score is 0-100, divide by 10)
        difficulty_level = round(difficulty_score / 10.0, 1)
    except Exception as e:
        print(f"⚠️  Error calculating difficulty for '{word}': {e}")
        difficulty_level = None
    
    # Look up definition
    word_lower = word.lower()
    definition = definitions_map.get(word_lower, '')
    
    return {
        'difficulty_level': difficulty_level,
        'definition': definition
    }


def export_to_csv(missing_words: List[Dict[str, str]], definitions_map: Dict[str, str], output_path: Path):
    """Export missing words to CSV file, sorted by CEFR level, with difficulty_level and definition."""
    if not missing_words:
        print("No words to export.")
        return
    
    # Sort by CEFR level and then alphabetically
    sorted_words = sort_by_cefr_level(missing_words)
    
    print(f"📊 Calculating difficulty levels and looking up definitions...")
    words_with_details = []
    for i, word_data in enumerate(sorted_words, 1):
        if i % 100 == 0:
            print(f"  Processed {i}/{len(sorted_words)} words...")
        
        details = calculate_difficulty_and_lookup_definition(word_data, definitions_map)
        words_with_details.append({
            **word_data,
            **details
        })
    
    with open(output_path, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['word', 'cefr_level', 'difficulty_level', 'definition', 'original_headword']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        writer.writeheader()
        for word_data in words_with_details:
            writer.writerow({
                'word': word_data['word'],
                'cefr_level': word_data['cefr_level'],
                'difficulty_level': word_data['difficulty_level'] if word_data['difficulty_level'] is not None else '',
                'definition': word_data['definition'],
                'original_headword': word_data['original_headword'],
            })
    
    print(f"✓ Exported {len(words_with_details)} words to {output_path} (sorted by CEFR level)")


async def main():
    """Main function to check for missing C1 data."""
    print("=" * 60)
    print("🔍 Checking for Words from CEFR CSV Missing in Database")
    print("=" * 60)
    
    # Load CEFR CSV
    cefr_csv_path = Path(__file__).parent / "missing_words.csv"
    print(f"\n📚 Loading CEFR data from {cefr_csv_path.name}...")
    cefr_words = load_cefr_csv_with_details(cefr_csv_path)
    
    if not cefr_words:
        print("❌ No words found in CEFR CSV file")
        return
    
    print(f"✓ Loaded {len(cefr_words)} words from CEFR CSV")
    
    # Load definitions from seed data
    seed_data_path = Path(__file__).parent / "generated_seed_data.json"
    print(f"\n📚 Loading definitions from {seed_data_path.name}...")
    definitions_map = load_definitions_from_seed_data(seed_data_path)
    print(f"✓ Loaded {len(definitions_map)} definitions from seed data")
    
    # Display connection info (masked password)
    masked_url = mask_password_in_url(database_url)
    print(f"\n🔌 Connecting to database: {masked_url}")
    
    try:
        async with AsyncSessionLocal() as session:
            # Test connection
            print("🔐 Testing database connection...")
            if not await test_connection(session):
                print("\n❌ Failed to connect to database. Please check:")
                print("   1. Database is running")
                print("   2. Database credentials are correct")
                print("   3. Database URL in .env or environment variables")
                return
            
            print("✓ Database connection successful!\n")
            
            # Get all words from database
            print("📖 Loading words from database...")
            db_words = await get_all_db_words(session)
            print(f"✓ Found {len(db_words)} words in database\n")
            
            # Find missing words
            print("🔍 Comparing CEFR CSV with database...")
            missing_words = find_missing_words(cefr_words, db_words)
            
            # Get statistics
            print("\n📊 CEFR Level Statistics:")
            print("-" * 60)
            stats = await get_cefr_statistics(session)
            total_words = sum(stats.values())
            
            print(f"Total words in database: {total_words}")
            print(f"Total words in CEFR CSV: {len(cefr_words)}")
            print(f"Words from CEFR CSV missing in database: {len(missing_words)}")
            print("\nBreakdown by level in database:")
            for level in sorted(stats.keys()):
                count = stats[level]
                percentage = (count / total_words * 100) if total_words > 0 else 0
                print(f"  {level:>6}: {count:>5} ({percentage:>5.1f}%)")
            
            # Show missing words by CEFR level
            if missing_words:
                print("\n" + "=" * 60)
                print("📝 Missing Words by CEFR Level:")
                print("-" * 60)
                missing_by_level = {}
                for word_data in missing_words:
                    level = word_data['cefr_level']
                    missing_by_level[level] = missing_by_level.get(level, 0) + 1
                
                for level in sorted(missing_by_level.keys()):
                    count = missing_by_level[level]
                    print(f"  {level:>6}: {count:>5} words")
                
                # Show sample missing words
                print("\n" + "=" * 60)
                print("📝 Sample Missing Words (first 20):")
                print("-" * 60)
                for i, word_data in enumerate(missing_words[:20], 1):
                    print(f"{i:>4}. Word: {word_data['word']:>30} | CEFR: {word_data['cefr_level']:>4}")
                
                if len(missing_words) > 20:
                    print(f"\n... and {len(missing_words) - 20} more missing words")
                
                # Export to CSV
                output_path = Path(__file__).parent / "missing_words_from_cefr.csv"
                print(f"\n💾 Exporting {len(missing_words)} missing words to CSV...")
                export_to_csv(missing_words, definitions_map, output_path)
            else:
                print("\n✓ All words from CEFR CSV are present in the database!")
            
            # Summary
            print("\n" + "=" * 60)
            print("📋 Summary:")
            print("-" * 60)
            print(f"Words in CEFR CSV: {len(cefr_words)}")
            print(f"Words in database: {total_words}")
            print(f"Words from CEFR CSV missing in database: {len(missing_words)}")
            
            if missing_words:
                print(f"\n⚠️  Action needed: {len(missing_words)} words from CEFR CSV are missing in database")
                print(f"   Exported to: missing_words_from_cefr.csv")
            else:
                print("\n✓ All CEFR words are present in the database!")
    
    except OperationalError as e:
        print(f"\n❌ Database connection error: {e}")
        print("\nPlease check:")
        print("   1. Database server is running")
        print("   2. Database credentials are correct")
        print("   3. Network connectivity to database")
        sys.exit(1)
    except ProgrammingError as e:
        print(f"\n❌ Database authentication error: {e}")
        print("\nPlease check:")
        print("   1. Database username and password are correct")
        print("   2. User has proper permissions")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Unexpected error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
    finally:
        await engine.dispose()


if __name__ == "__main__":
    asyncio.run(main())
