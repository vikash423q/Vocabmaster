"""
Populate synonyms for all words in the database using NLTK WordNet.
Run with: python -m scripts.populate_synonyms
"""
import asyncio
import sys
from pathlib import Path
from typing import List, Set
from urllib.parse import urlparse, urlunparse

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

# Add scripts directory to path for imports
scripts_dir = Path(__file__).parent
sys.path.insert(0, str(scripts_dir))

import nltk
from nltk.corpus import wordnet as wn
from nltk import pos_tag
from nltk.tokenize import word_tokenize

from sqlalchemy import select, delete
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.exc import OperationalError, ProgrammingError

from app.config import settings
from app.models.word import Word
from app.models.word_synonym import WordSynonym

# Download required NLTK data
try:
    nltk.data.find('corpora/wordnet')
except LookupError:
    print("Downloading WordNet corpus...")
    nltk.download('wordnet', quiet=True)

try:
    nltk.data.find('tokenizers/punkt')
except LookupError:
    print("Downloading punkt tokenizer...")
    nltk.download('punkt', quiet=True)

try:
    nltk.data.find('taggers/averaged_perceptron_tagger')
except LookupError:
    print("Downloading POS tagger...")
    nltk.download('averaged_perceptron_tagger', quiet=True)


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
        masked_netloc = f"{parsed.username}:***@{parsed.hostname}"
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
    pool_pre_ping=True,
)

# Create async session factory
AsyncSessionLocal = async_sessionmaker(
    engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autocommit=False,
    autoflush=False
)


def get_synonyms(word: str, min_synonyms: int = 3, max_synonyms: int = 10) -> List[str]:
    """Get synonyms for a word using WordNet.
    
    Args:
        word: The word to get synonyms for
        min_synonyms: Minimum number of synonyms to return
        max_synonyms: Maximum number of synonyms to return
    
    Returns:
        List of unique synonyms
    """
    synonyms = set()
    
    # Map NLTK POS tags to WordNet POS tags
    pos_map = {
        'N': wn.NOUN,
        'V': wn.VERB,
        'R': wn.ADV,
        'J': wn.ADJ
    }
    
    # Try to get POS tag for better results
    try:
        pos_tagged = pos_tag([word.lower()])
        word_pos = pos_tagged[0][1][0] if pos_tagged else None
        wn_pos = pos_map.get(word_pos)
    except:
        wn_pos = None
    
    # Get synsets with specific POS if available
    synsets = wn.synsets(word.lower(), pos=wn_pos) if wn_pos else wn.synsets(word.lower())
    
    # If no synsets found, try without POS filtering
    if not synsets:
        synsets = wn.synsets(word.lower())
    
    for synset in synsets:
        for lemma in synset.lemmas():
            synonym = lemma.name().replace('_', ' ').lower()
            # Exclude the original word and very short synonyms
            if synonym != word.lower() and len(synonym) > 2:
                synonyms.add(synonym)
    
    # Convert to list and limit results
    synonym_list = list(synonyms)[:max_synonyms]
    
    # If we don't have enough synonyms, try getting from related synsets
    if len(synonym_list) < min_synonyms:
        for synset in synsets[:3]:  # Check first 3 synsets
            # Get hypernyms (more general terms)
            for hypernym in synset.hypernyms()[:2]:
                for lemma in hypernym.lemmas()[:2]:
                    synonym = lemma.name().replace('_', ' ').lower()
                    if synonym != word.lower() and len(synonym) > 2:
                        synonyms.add(synonym)
            
            # Get hyponyms (more specific terms)
            for hyponym in synset.hyponyms()[:2]:
                for lemma in hyponym.lemmas()[:2]:
                    synonym = lemma.name().replace('_', ' ').lower()
                    if synonym != word.lower() and len(synonym) > 2:
                        synonyms.add(synonym)
        
        synonym_list = list(synonyms)[:max_synonyms]
    
    return synonym_list


async def populate_synonyms_for_word(session: AsyncSession, word: Word, min_synonyms: int = 3) -> int:
    """Populate synonyms for a single word.
    
    Returns:
        Number of synonyms added
    """
    # Check if synonyms already exist
    existing_query = select(WordSynonym).where(WordSynonym.word_id == word.id)
    existing_result = await session.execute(existing_query)
    existing_synonyms = existing_result.scalars().all()
    
    if len(existing_synonyms) >= min_synonyms:
        return 0  # Already has enough synonyms
    
    # Get synonyms
    synonyms = get_synonyms(word.word, min_synonyms=min_synonyms, max_synonyms=10)
    
    if not synonyms:
        return 0
    
    # Get existing synonym texts to avoid duplicates
    existing_texts = {syn.synonym.lower() for syn in existing_synonyms}
    
    # Add new synonyms
    added_count = 0
    for synonym_text in synonyms:
        if synonym_text.lower() not in existing_texts:
            new_synonym = WordSynonym(
                word_id=word.id,
                synonym=synonym_text
            )
            session.add(new_synonym)
            existing_texts.add(synonym_text.lower())
            added_count += 1
    
    return added_count


async def main():
    """Main function to populate synonyms for all words."""
    print("=" * 60)
    print("🔍 Populating Synonyms for All Words")
    print("=" * 60)
    
    # Display connection info (masked password)
    masked_url = mask_password_in_url(database_url)
    print(f"\n🔌 Connecting to database: {masked_url}")
    
    try:
        async with AsyncSessionLocal() as session:
            # Get all words
            words_query = select(Word)
            words_result = await session.execute(words_query)
            all_words = list(words_result.scalars().all())
            
            total_words = len(all_words)
            print(f"\n✓ Found {total_words} words in database")
            
            words_with_synonyms = 0
            words_without_synonyms = 0
            total_synonyms_added = 0
            
            print(f"\n📚 Processing words and fetching synonyms...")
            print("-" * 60)
            
            for i, word in enumerate(all_words, 1):
                if i % 100 == 0:
                    print(f"  Processed {i}/{total_words} words...")
                    await session.commit()  # Commit in batches
                
                try:
                    added_count = await populate_synonyms_for_word(session, word, min_synonyms=3)
                    
                    if added_count > 0:
                        words_with_synonyms += 1
                        total_synonyms_added += added_count
                    else:
                        # Check if it already has synonyms
                        existing_query = select(WordSynonym).where(WordSynonym.word_id == word.id)
                        existing_result = await session.execute(existing_query)
                        existing_count = len(list(existing_result.scalars().all()))
                        
                        if existing_count >= 3:
                            words_with_synonyms += 1
                        else:
                            words_without_synonyms += 1
                except Exception as e:
                    print(f"  ⚠️  Error processing word '{word.word}': {e}")
                    words_without_synonyms += 1
                    continue
            
            # Final commit
            await session.commit()
            
            print("\n" + "=" * 60)
            print("📊 Summary:")
            print("-" * 60)
            print(f"Total words processed: {total_words}")
            print(f"Words with synonyms (≥3): {words_with_synonyms}")
            print(f"Words without enough synonyms: {words_without_synonyms}")
            print(f"Total synonyms added: {total_synonyms_added}")
            print("\n✅ Done!")
            
    except OperationalError as e:
        print(f"\n❌ Database connection error: {e}")
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
