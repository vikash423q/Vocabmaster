"""
Add difficulty scores to missing_words.csv
Run with: python -m scripts.add_difficulty_to_csv
"""
import csv
import sys
from pathlib import Path

# Add scripts directory to path for imports
scripts_dir = Path(__file__).parent
sys.path.insert(0, str(scripts_dir))

try:
    from word_difficulty import get_difficulty_score
except ImportError as e:
    print(f"❌ Import error: {e}")
    sys.exit(1)


def add_difficulty_scores(input_csv: Path, output_csv: Path):
    """Read CSV, calculate difficulty scores, and write to new CSV."""
    words_data = []
    
    # Read the input CSV
    print(f"📖 Reading {input_csv.name}...")
    with open(input_csv, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            word = row.get('word', '').strip()
            cefr_level = row.get('cefr_level', '').strip()
            
            # Skip if this looks like a header row
            if word.lower() == 'word' or cefr_level.lower() == 'cefr_level':
                continue
            
            if word and cefr_level:
                words_data.append({
                    'word': word,
                    'cefr_level': cefr_level
                })
    
    print(f"✓ Loaded {len(words_data)} words")
    
    # Calculate difficulty scores
    print(f"\n📊 Calculating difficulty scores...")
    words_with_scores = []
    for i, word_data in enumerate(words_data, 1):
        if i % 100 == 0:
            print(f"  Processed {i}/{len(words_data)} words...")
        
        word = word_data['word']
        cefr_level = word_data['cefr_level']
        
        try:
            difficulty_score = get_difficulty_score(word, cefr_level)
            # Convert to 1-10 scale (difficulty_score is 0-100, divide by 10)
            difficulty_level = round(difficulty_score / 10.0, 1)
        except Exception as e:
            print(f"⚠️  Error calculating difficulty for '{word}': {e}")
            difficulty_level = None
        
        words_with_scores.append({
            'word': word,
            'cefr_level': cefr_level,
            'difficulty_level': difficulty_level if difficulty_level is not None else ''
        })
    
    # Write to output CSV
    print(f"\n💾 Writing to {output_csv.name}...")
    with open(output_csv, 'w', newline='', encoding='utf-8') as f:
        fieldnames = ['word', 'cefr_level', 'difficulty_level']
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        
        writer.writeheader()
        for word_data in words_with_scores:
            writer.writerow(word_data)
    
    print(f"✓ Exported {len(words_with_scores)} words with difficulty scores to {output_csv.name}")


if __name__ == "__main__":
    scripts_dir = Path(__file__).parent
    input_csv = scripts_dir / "missing_words.csv"
    output_csv = scripts_dir / "missing_words.csv"  # Overwrite the same file
    
    print("=" * 60)
    print("📊 Adding Difficulty Scores to CSV")
    print("=" * 60)
    
    if not input_csv.exists():
        print(f"❌ File not found: {input_csv}")
        sys.exit(1)
    
    try:
        add_difficulty_scores(input_csv, output_csv)
        print("\n✅ Done!")
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
