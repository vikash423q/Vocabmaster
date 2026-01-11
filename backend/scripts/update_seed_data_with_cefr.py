"""
Update generated_seed_data.json with CEFR levels and difficulty scores
Run with: python -m scripts.update_seed_data_with_cefr
"""
import json
import sys
from pathlib import Path
from typing import Dict, List

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

# Add scripts directory to path for imports
scripts_dir = Path(__file__).parent
sys.path.insert(0, str(scripts_dir))

from cfr_data import load_cefr_csv, lookup_cefr_level
from word_difficulty import get_difficulty_score, zipf_frequency, zipf_score

# File paths
GENERATED_SEED_DATA_FILE = Path(__file__).parent / "generated_seed_data.json"
CEFR_CSV_FILE = Path(__file__).parent / "ENGLISH_CERF_WORDS.csv"  # Note: filename has typo "CERF" instead of "CEFR"
BACKUP_FILE = Path(__file__).parent / "generated_seed_data.json.backup"


def update_word_with_cefr(word_data: Dict, cefr_map: Dict[str, str]) -> Dict:
    """Update a word entry with CEFR level and calculated difficulty."""
    word_text = word_data.get("word", "").strip()
    if not word_text:
        return word_data
    
    # Lookup CEFR level
    cefr_level = lookup_cefr_level(word_text, cefr_map)
    if not cefr_level:
        # Try without special characters or try variations
        word_clean = word_text.replace("'", "").replace("-", "").replace(" ", "")
        cefr_level = lookup_cefr_level(word_clean, cefr_map)
    
    # If still not found, assume C2 (advanced vocabulary)
    if not cefr_level:
        cefr_level = "C1" if zipf_score(zipf_frequency(word_text, 'en')) <= 57 else "C2"
    
    # Calculate difficulty level using get_difficulty_score
    # get_difficulty_score returns 0-100, we'll store it as 1-10 scale in JSON
    try:
        difficulty_score = get_difficulty_score(word_text, cefr_level)
        # Convert to 1-10 scale for consistency with database
        difficulty_level = difficulty_score / 10.0
    except Exception as e:
        print(f"  ⚠️  Error calculating difficulty for '{word_text}': {e}")
        # Fallback to existing difficulty_level or default
        difficulty_level = float(word_data.get("difficulty_level", 5.0))
        if difficulty_level > 10:
            difficulty_level = difficulty_level / 10.0
        elif difficulty_level < 1:
            difficulty_level = 5.0
    
    # Update word data
    updated_data = word_data.copy()
    updated_data["cefr_level"] = cefr_level  # Always set CEFR (either found or C2 default)
    updated_data["difficulty_level"] = round(difficulty_level, 1)
    
    return updated_data


def main():
    """Main function to update seed data with CEFR levels and difficulty scores."""
    print("=" * 60)
    print("🔄 Updating Generated Seed Data with CEFR Levels")
    print("=" * 60)
    
    # Check if generated seed data file exists
    if not GENERATED_SEED_DATA_FILE.exists():
        print(f"❌ Generated seed data file not found: {GENERATED_SEED_DATA_FILE}")
        return
    
    # Load CEFR mapping
    print(f"\n📚 Loading CEFR mappings from CSV...")
    if not CEFR_CSV_FILE.exists():
        print(f"❌ CEFR CSV file not found: {CEFR_CSV_FILE}")
        print(f"   Please ensure the file exists before running this script")
        return
    
    cefr_map = load_cefr_csv(CEFR_CSV_FILE)
    
    if not cefr_map:
        print("❌ Failed to load CEFR mappings from CSV")
        return
    
    # Create backup
    print(f"\n💾 Creating backup...")
    import shutil
    shutil.copy2(GENERATED_SEED_DATA_FILE, BACKUP_FILE)
    print(f"  ✓ Backup created: {BACKUP_FILE}")
    
    # Load generated seed data
    print(f"\n📖 Loading generated seed data...")
    with open(GENERATED_SEED_DATA_FILE, 'r', encoding='utf-8') as f:
        words_data = json.load(f)
    
    print(f"  ✓ Loaded {len(words_data)} words")
    
    # Update words with CEFR and difficulty
    print(f"\n🔄 Updating words with CEFR levels and difficulty scores...")
    print(f"   (Words not found in CSV will default to C2)")
    updated_count = 0
    cefr_found_count = 0
    cefr_defaulted_count = 0
    
    for idx, word_data in enumerate(words_data, 1):
        word_text = word_data.get("word", "")
        
        # Check if CEFR was found in CSV (before defaulting in update_word_with_cefr)
        original_cefr = lookup_cefr_level(word_text, cefr_map)
        if not original_cefr:
            word_clean = word_text.replace("'", "").replace("-", "").replace(" ", "")
            original_cefr = lookup_cefr_level(word_clean, cefr_map)
        
        updated_word = update_word_with_cefr(word_data, cefr_map)
        
        # Track statistics based on whether it was found in CSV
        if original_cefr:
            cefr_found_count += 1
        else:
            cefr_defaulted_count += 1
        
        words_data[idx - 1] = updated_word
        updated_count += 1
        
        # Progress indicator
        if idx % 100 == 0:
            print(f"  Progress: {idx}/{len(words_data)} words processed...")
        
        # Save incrementally every 500 words
        if idx % 500 == 0:
            with open(GENERATED_SEED_DATA_FILE, 'w', encoding='utf-8') as f:
                json.dump(words_data, f, indent=2, ensure_ascii=False)
            print(f"  💾 Saved progress at {idx} words...")
    
    # Final save
    print(f"\n💾 Saving updated data...")
    with open(GENERATED_SEED_DATA_FILE, 'w', encoding='utf-8') as f:
        json.dump(words_data, f, indent=2, ensure_ascii=False)
    
    # Statistics
    print(f"\n{'=' * 60}")
    print("✅ Update Complete!")
    print(f"{'=' * 60}")
    print(f"📊 Statistics:")
    print(f"  - Total words processed: {updated_count}")
    print(f"  - Words with CEFR found in CSV: {cefr_found_count}")
    print(f"  - Words defaulted to C2: {cefr_defaulted_count}")
    print(f"  - CEFR coverage from CSV: {(cefr_found_count / updated_count * 100):.1f}%")
    print(f"  - All words now have CEFR level (found or C2 default)")
    print(f"\n📁 Files:")
    print(f"  - Updated file: {GENERATED_SEED_DATA_FILE}")
    print(f"  - Backup file: {BACKUP_FILE}")
    print(f"\n💡 Next step: Run seed_data.py to seed the database")


if __name__ == "__main__":
    main()
