import json
import csv
from pathlib import Path
from bs4 import BeautifulSoup
import requests
import re
import time
from typing import Dict, List, Optional

def extract_next_data(html):
    soup = BeautifulSoup(html, "html.parser")
    script = soup.find("script", id="__NEXT_DATA__")
    if not script:
        raise RuntimeError("__NEXT_DATA__ not found")
    return json.loads(script.string)


def get_subcategories(category_url):
    """Get all subcategory URLs from a category page."""
    html = requests.get(category_url, timeout=20).text
    data = extract_next_data(html)
    
    subcats = []
    
    # Try to get subcategories from the page data
    try:
        category_data = (
            data.get("props", {})
            .get("pageProps", {})
            .get("category", {})
        )
        
        # Look for subcategories in various possible locations
        subcategories = category_data.get("subcategories", [])
        if subcategories:
            for subcat in subcategories:
                subcat_id = subcat.get("id")
                if subcat_id:
                    subcats.append(f"https://langeek.co/en/vocab/subcategory/{subcat_id}/learn")
    except Exception as e:
        print(f"  ⚠️  Could not extract from page data: {e}")
    
    # Fallback: extract from HTML using regex
    if not subcats:
        subcat_pattern = r'/en/vocab/subcategory/(\d+)/learn'
        matches = re.findall(subcat_pattern, html)
        for match in matches:
            subcats.append(f"https://langeek.co/en/vocab/subcategory/{match}/learn")
    
    # Remove duplicates
    subcats = list(set(subcats))
    
    if not subcats:
        raise ValueError(f"Subcategory links not found for {category_url}")
    
    return subcats

C2_URL = "https://langeek.co/en/vocab/category/251/c2-level"
C1_URL = "https://langeek.co/en/vocab/category/250/c1-level"


def get_words_from_subcategory(url):
    """Get all words from a subcategory page."""
    try:
        html = requests.get(url, timeout=20).text
        data = extract_next_data(html)

        words = []

        vocab_items = (
            data.get("props", {})
            .get("pageProps", {})
            .get("lesson", {})
            .get("vocabularies", [])
        )

        for v in vocab_items:
            word_text = v.get("word", "").strip().lower()
            if word_text:
                words.append({
                    "word": word_text,
                    "meaning": v.get("definition", ""),
                    "pos": v.get("partOfSpeech", ""),
                })
        
        return words
    except Exception as e:
        print(f"    ⚠️  Error fetching words from {url}: {e}")
        return []


def extract_level(level="C2"):
    """Extract all words for a CEFR level from langeek."""
    if level == "C2":
        url = C2_URL
    elif level == "C1":
        url = C1_URL
    else:
        raise ValueError("Only C1 or C2 supported")

    print(f"🔍 Getting subcategories for {level}...")
    try:
        subcats = get_subcategories(url)
        print(f"  ✓ Found {len(subcats)} subcategories")
    except Exception as e:
        print(f"  ❌ Error getting subcategories: {e}")
        return

    all_words = []
    seen_words = set()  # Track duplicates
    
    for idx, sc in enumerate(subcats, 1):
        print(f"  [{idx}/{len(subcats)}] Getting words from subcategory...")
        words = get_words_from_subcategory(sc)
        
        for w in words:
            word_text = w.get("word", "").strip().lower()
            if word_text and word_text not in seen_words:
                w["cefr"] = level
                all_words.append(w)
                seen_words.add(word_text)
        
        # Be polite to the server
        time.sleep(0.5)
    
    output_file = Path(__file__).parent / f"cefr_{level}.json"
    print(f"\n💾 Saving {len(all_words)} unique words to {output_file}")
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(all_words, f, indent=2, ensure_ascii=False)
    
    return all_words


def load_cefr_csv(csv_path: Path) -> Dict[str, str]:
    """Load CEFR levels from CSV file into a dictionary.
    Returns dict mapping word (lowercase) to CEFR level.
    """
    cefr_map = {}
    
    if not csv_path.exists():
        print(f"⚠️  CEFR CSV file not found: {csv_path}")
        return cefr_map
    
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            word = row.get("headword", "").strip().lower()
            cefr = row.get("CEFR", "").strip().upper()
            
            if word and cefr:
                # Handle multiple words (e.g., "a.m./A.M./am/AM")
                word_variants = [w.strip().lower() for w in word.split('/')]
                for variant in word_variants:
                    if variant:
                        # If word already exists, keep the higher level (C2 > C1 > B2 > B1 > A2 > A1)
                        if variant in cefr_map:
                            existing_level = cefr_map[variant]
                            level_order = {"A1": 1, "A2": 2, "B1": 3, "B2": 4, "C1": 5, "C2": 6}
                            if level_order.get(cefr, 0) > level_order.get(existing_level, 0):
                                cefr_map[variant] = cefr
                        else:
                            cefr_map[variant] = cefr
    
    print(f"✓ Loaded {len(cefr_map)} CEFR mappings from CSV")
    return cefr_map


def lookup_cefr_level(word: str, cefr_map: Dict[str, str]) -> Optional[str]:
    """Lookup CEFR level for a word."""
    word_lower = word.strip().lower()
    return cefr_map.get(word_lower)


if __name__ == "__main__":

    cefr_map = load_cefr_csv(Path(__file__).parent / "cefr_data.csv")
    # print("=" * 60)
    # print("🌐 Langeek CEFR Data Extractor")
    # print("=" * 60)
    
    # # Extract C1 and C2 levels
    # print("\n📖 Extracting C1 level words...")
    # c1_words = extract_level("C1")
    
    # print("\n📖 Extracting C2 level words...")
    # c2_words = extract_level("C2")
    
    # print("\n✅ Done!")

