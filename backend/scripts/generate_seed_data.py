"""
Generate seed data for words using AI agent service, Pixabay images, and MinIO
Run with: python -m scripts.generate_seed_data
"""
import asyncio
import sys
import json
import os
import tempfile
from pathlib import Path
from typing import Dict, List, Optional
import httpx
import requests
from minio import Minio
from minio.error import S3Error
from datetime import datetime
import traceback

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from app.config import settings

from seed_data import VOCAB_CATEGORIES

# Pixabay API
PIXABAY_API_KEY = "54142884-bb86c5904ca8713ac181347e8"
PIXABAY_API_URL = "https://pixabay.com/api/"

# File paths
GRE_FILE = Path(__file__).parent / "gre.txt"
WPME_FILE = Path(__file__).parent / "wpme.txt"
OUTPUT_FILE = Path(__file__).parent / "generated_seed_data.json"

# Progress tracking
PROGRESS_FILE = Path(__file__).parent / "generation_progress.json"


def load_words_from_file(file_path: Path) -> List[str]:
    """Load words from a text file (one word per line)."""
    if not file_path.exists():
        print(f"Warning: {file_path} not found")
        return []
    
    words = []
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            word = line.strip()
            if word and not word.startswith('#'):
                words.append(word)
    return words


def load_progress() -> Dict:
    """Load progress from previous run."""
    if PROGRESS_FILE.exists():
        with open(PROGRESS_FILE, 'r') as f:
            return json.load(f)
    return {
        "processed_words": [],
        "failed_words": [],
        "failed_details": {}  # word -> {error, step, retry_count}
    }


def save_progress(progress: Dict):
    """Save progress to file."""
    with open(PROGRESS_FILE, 'w') as f:
        json.dump(progress, f, indent=2)


def mark_word_failed(progress: Dict, word: str, error: str, step: str):
    """Mark a word as failed with error details."""
    if word not in progress["failed_words"]:
        progress["failed_words"].append(word)
    
    if word not in progress["failed_details"]:
        progress["failed_details"][word] = {
            "error": str(error),
            "step": step,
            "retry_count": 0,
            "last_attempt": datetime.now().isoformat()
        }
    else:
        progress["failed_details"][word]["retry_count"] += 1
        progress["failed_details"][word]["error"] = str(error)
        progress["failed_details"][word]["step"] = step
        progress["failed_details"][word]["last_attempt"] = datetime.now().isoformat()
    
    save_progress(progress)


def get_word_from_ai(word: str, ai_service_url: str) -> Optional[Dict]:
    """Get word details from AI agent service."""
    try:
        response = httpx.post(
            f"{ai_service_url}/generate-word-details",
            json={"word": word},
            timeout=60.0
        )
        response.raise_for_status()
        return response.json()
    except Exception as e:
        print(f"  ❌ AI service error for '{word}': {str(e)}")
        return None


def get_category_from_ai(word: str, definitions: List[str], ai_service_url: str) -> Optional[Dict[str, str]]:
    """Get category and sub-category suggestion from AI based on word and definitions.
    Returns dict with 'category' and optionally 'sub_category' keys.
    """
    try:
        definitions_text = ', '.join(definitions[:3]) if definitions else "No definitions available"
        
        # Build hierarchical category structure for the prompt
        categories_with_subs = []
        for parent, subs in VOCAB_CATEGORIES.items():
            sub_list = "\n    ".join([f"- {sub}" for sub in subs])
            categories_with_subs.append(f"{parent}:\n    {sub_list}")
        
        categories_text = "\n\n".join(categories_with_subs)
        
        prompt = f"""Given the word "{word}" with these definitions: {definitions_text}

Determine the most appropriate category and sub-category from this hierarchical structure:

{categories_text}

Instructions:
1. First, select the most appropriate PARENT category from the list above
2. Then, select the most appropriate SUB-CATEGORY from the sub-categories listed under that parent category
3. If no sub-category fits well, you can use null for sub_category

Return your answer in EXACTLY this JSON format (no other text, no markdown):
{{"category": "Parent Category Name", "sub_category": "Sub-category Name"}}

Example with sub-category:
{{"category": "Human Personality & Character", "sub_category": "Positive Traits"}}

Example without sub-category:
{{"category": "Human Personality & Character", "sub_category": null}}
"""
        response = httpx.post(
            f"{ai_service_url}/chat",
            json={
                "word": word,
                "definition": definitions[0] if definitions else "",
                "message": prompt
            },
            timeout=30.0
        )
        response.raise_for_status()
        result = response.json()
        response_text = result.get("response", "").strip()
        
        # Try to extract JSON from response
        import re
        json_match = re.search(r'\{[^}]+\}', response_text)
        if json_match:
            try:
                category_data = json.loads(json_match.group())
                category_name = category_data.get("category", "").strip()
                sub_category_name = category_data.get("sub_category")
                
                if category_name:
                    result_dict = {"category": category_name}
                    if sub_category_name:
                        result_dict["sub_category"] = sub_category_name.strip()
                    return result_dict
            except json.JSONDecodeError:
                pass
        
        # Fallback: try to parse "Category > Sub-category" format
        if ">" in response_text:
            parts = response_text.split(">")
            if len(parts) == 2:
                return {
                    "category": parts[0].strip().strip('"').strip("'"),
                    "sub_category": parts[1].strip().strip('"').strip("'")
                }
        
        # Last resort: just category
        category = response_text.strip().strip('"').strip("'")
        if category and any(cat in category for cat in VOCAB_CATEGORIES.keys()):
            return {"category": category}
        
        return None
    except Exception as e:
        print(f"  ⚠️  Category detection error for '{word}': {str(e)}")
        raise  # Re-raise to be caught by caller


def get_pixabay_images(word: str, count: int = 4) -> List[Dict]:
    """Get images from Pixabay for a word."""
    try:
        response = requests.get(
            PIXABAY_API_URL,
            params={
                "key": PIXABAY_API_KEY,
                "q": word,
                "image_type": "photo",
                "per_page": count,
                "safesearch": "true"
            },
            timeout=10.0
        )
        response.raise_for_status()
        data = response.json()
        
        images = []
        for hit in data.get("hits", [])[:count]:
            images.append({
                "url": hit.get("webformatURL", ""),
                "preview_url": hit.get("previewURL", ""),
                "tags": hit.get("tags", ""),
                "id": hit.get("id", 0)
            })
        
        return images
    except Exception as e:
        print(f"  ⚠️  Pixabay error for '{word}': {str(e)}")
        return []


def download_image(url: str, temp_dir: Path, word: str, index: int) -> Optional[Path]:
    """Download an image from URL to temp directory."""
    try:
        response = requests.get(url, timeout=10.0)
        response.raise_for_status()
        
        # Determine file extension
        content_type = response.headers.get('content-type', '')
        if 'jpeg' in content_type or 'jpg' in content_type:
            ext = '.jpg'
        elif 'png' in content_type:
            ext = '.png'
        elif 'webp' in content_type:
            ext = '.webp'
        else:
            ext = '.jpg'  # default
        
        file_path = temp_dir / f"{word}_{index}{ext}"
        with open(file_path, 'wb') as f:
            f.write(response.content)
        
        return file_path
    except Exception as e:
        print(f"    ⚠️  Download error: {str(e)}")
        return None


def upload_to_minio(file_path: Path, word: str, index: int, minio_client: Minio) -> Optional[str]:
    """Upload image to MinIO and return the URL."""
    try:
        # Ensure bucket exists
        if not minio_client.bucket_exists(settings.minio_bucket_name):
            minio_client.make_bucket(settings.minio_bucket_name)
        
        # Upload file
        object_name = f"words/{word}/{word}_{index}{file_path.suffix}"
        
        minio_client.fput_object(
            settings.minio_bucket_name,
            object_name,
            str(file_path)
        )
        
        # Generate URL
        if settings.minio_use_ssl:
            protocol = "https"
        else:
            protocol = "http"
        
        url = f"{protocol}://{settings.minio_endpoint}/{settings.minio_bucket_name}/{object_name}"
        return url
    except S3Error as e:
        print(f"    ❌ MinIO upload error: {str(e)}")
        return None
    except Exception as e:
        print(f"    ❌ Upload error: {str(e)}")
        return None
    
def populate_media(word: str, minio_client: Minio) -> List[Dict]:
    """Populate media URLs for a word by downloading from Pixabay and uploading to MinIO."""
    print(f"  🖼️  Getting images from Pixabay...")
    pixabay_images = []
    try:
        pixabay_images = get_pixabay_images(word, count=4)
        print(f"    ✓ Found {len(pixabay_images)} images")
    except Exception as e:
        error_msg = f"Pixabay error: {str(e)}"
        print(f"  ⚠️  {error_msg}")
        # Don't fail the word if Pixabay fails, just continue without images
    
    # Step 4: Download and upload images
    media_urls = []
    if pixabay_images:
        try:
            with tempfile.TemporaryDirectory() as temp_dir:
                temp_path = Path(temp_dir)
                for idx, img_data in enumerate(pixabay_images):
                    try:
                        print(f"    Downloading image {idx + 1}/{len(pixabay_images)}...")
                        downloaded_file = download_image(
                            img_data["url"],
                            temp_path,
                            word,
                            idx
                        )
                        
                        if downloaded_file:
                            try:
                                print(f"    Uploading to MinIO...")
                                minio_url = upload_to_minio(
                                    downloaded_file,
                                    word,
                                    idx,
                                    minio_client
                                )
                                if minio_url:
                                    media_urls.append({
                                        "type": "image",
                                        "url": minio_url,
                                        "source": f"Pixabay: {img_data.get('tags', '')}",
                                        "caption": f"Image related to '{word}'",
                                        "is_ai_generated": False
                                    })
                                    print(f"    ✓ Image {idx + 1} uploaded successfully")
                                else:
                                    print(f"    ⚠️  Failed to upload image {idx + 1} to MinIO")
                            except Exception as e:
                                print(f"    ⚠️  MinIO upload error for image {idx + 1}: {str(e)}")
                        else:
                            print(f"    ⚠️  Failed to download image {idx + 1}")
                    except Exception as e:
                        print(f"    ⚠️  Error processing image {idx + 1}: {str(e)}")
                        # Continue with next image
        except Exception as e:
            error_msg = f"Image processing error: {str(e)}"
            print(f"  ⚠️  {error_msg}")
            # Don't fail the word if image processing fails


def process_word(
    word: str,
    source: str,
    ai_service_url: str,
    minio_client: Minio,
    progress: Dict
) -> Optional[Dict]:
    """Process a single word: get AI details, images, and upload to MinIO.
    Returns word data dict on success, None on failure.
    Tracks failures with detailed error information for retry.
    """
    print(f"\n📝 Processing: {word} ({source})")
    
    # Skip if already processed
    if word in progress["processed_words"]:
        print(f"  ⏭️  Already processed, skipping")
        return None
    
    try:
        # Step 1: Get word details from AI
        print(f"  🤖 Getting word details from AI...")
        try:
            ai_details = get_word_from_ai(word, ai_service_url)
            if not ai_details:
                error_msg = "Failed to get word details from AI service"
                mark_word_failed(progress, word, error_msg, "ai_word_details")
                print(f"  ❌ {error_msg}")
                return None
        except Exception as e:
            error_msg = f"AI word details error: {str(e)}"
            mark_word_failed(progress, word, error_msg, "ai_word_details")
            print(f"  ❌ {error_msg}")
            print(f"  Traceback: {traceback.format_exc()}")
            return None
        
        # Step 2: Get category and sub-category suggestion
        print(f"  🏷️  Determining category and sub-category...")
        category_data = None
        try:
            definitions = [d.get("text", "") for d in ai_details.get("definitions", [])]
            category_data = get_category_from_ai(word, definitions, ai_service_url)
            if category_data:
                if category_data.get("sub_category"):
                    print(f"    ✓ Category: {category_data['category']} > {category_data['sub_category']}")
                else:
                    print(f"    ✓ Category: {category_data['category']}")
            else:
                print(f"    ⚠️  Could not determine category")
        except Exception as e:
            error_msg = f"Category detection error: {str(e)}"
            print(f"  ⚠️  {error_msg}")
            # Don't fail the word if category detection fails, just log it
        
        # Step 3: Get images from Pixabay and upload to MinIO
        print(f"  ☁️  Populating media...")
        populate_media(word, minio_client)
        
        # Step 5: Build word data structure
        try:
            # Format category suggestion
            category_suggestion = None
            if category_data:
                if category_data.get("sub_category"):
                    category_suggestion = f"{category_data['category']} > {category_data['sub_category']}"
                else:
                    category_suggestion = category_data['category']
            
            word_data = {
                "word": word,
                "source": source,
                "category": category_data.get("category") if category_data else None,
                "sub_category": category_data.get("sub_category") if category_data else None,
                "category_suggestion": category_suggestion,  # Keep for backward compatibility
                "difficulty_level": ai_details.get("difficulty_level", 5.0),
                "importance_score": ai_details.get("importance_score", 50),
                "pronunciation": ai_details.get("pronunciation"),
                "parts_of_speech": ai_details.get("parts_of_speech", []),
                "tone": ai_details.get("tone", "neutral"),
                "definitions": [
                    {
                        "text": d.get("text", ""),
                        "is_primary": d.get("is_primary", False),
                        "example": d.get("example", "")
                    }
                    for d in ai_details.get("definitions", [])
                ],
                "etymology": ai_details.get("etymology", {}),
                "media": media_urls
            }
            
            # Mark as processed
            progress["processed_words"].append(word)
            # Remove from failed list if it was there
            if word in progress["failed_words"]:
                progress["failed_words"].remove(word)
            if word in progress.get("failed_details", {}):
                del progress["failed_details"][word]
            save_progress(progress)
            
            print(f"  ✅ Completed: {word}")
            return word_data
            
        except Exception as e:
            error_msg = f"Data structure building error: {str(e)}"
            mark_word_failed(progress, word, error_msg, "data_structure")
            print(f"  ❌ {error_msg}")
            print(f"  Traceback: {traceback.format_exc()}")
            return None
            
    except Exception as e:
        # Catch-all for any unexpected errors
        error_msg = f"Unexpected error processing word: {str(e)}"
        mark_word_failed(progress, word, error_msg, "unexpected")
        print(f"  ❌ {error_msg}")
        print(f"  Traceback: {traceback.format_exc()}")
        return None


def main():
    """Main function to generate seed data."""
    print("=" * 60)
    print("🚀 VocabMaster Seed Data Generator")
    print("=" * 60)
    
    # Load words
    print("\n📚 Loading words from files...")
    gre_words = load_words_from_file(GRE_FILE)
    wpme_words = load_words_from_file(WPME_FILE)
    
    print(f"  - GRE words: {len(gre_words)}")
    print(f"  - WPME words: {len(wpme_words)}")
    print(f"  - Total: {len(gre_words) + len(wpme_words)}")
    
    # Load progress
    progress = load_progress()
    print(f"\n📊 Progress: {len(progress['processed_words'])} processed, {len(progress['failed_words'])} failed")
    
    # Initialize MinIO client
    print("\n☁️  Initializing MinIO client...")
    minio_client = Minio(
        settings.minio_endpoint,
        access_key=settings.minio_access_key,
        secret_key=settings.minio_secret_key,
        secure=settings.minio_use_ssl
    )
    
    # Ensure bucket exists
    try:
        if not minio_client.bucket_exists(settings.minio_bucket_name):
            minio_client.make_bucket(settings.minio_bucket_name)
            print(f"  ✅ Created bucket: {settings.minio_bucket_name}")
        else:
            print(f"  ✅ Bucket exists: {settings.minio_bucket_name}")
    except Exception as e:
        print(f"  ❌ MinIO error: {str(e)}")
        return
    
    # AI service URL
    ai_service_url = settings.ai_agent_service_url
    print(f"\n🤖 AI Service URL: {ai_service_url}")
    
    # Process words
    with open(OUTPUT_FILE, 'r') as f:
        try:
            all_word_data = json.load(f)
        except Exception:
            all_word_data = []
    
    # Process GRE words
    print(f"\n{'=' * 60}")
    print("📖 Processing GRE words...")
    print(f"{'=' * 60}")
    for word in gre_words:
        populate_media(word, minio_client)
        # word_data = process_word(word, "GRE", ai_service_url, minio_client, progress)
        # if word_data:
        #     all_word_data.append(word_data)
        #     # Save incrementally
        #     with open(OUTPUT_FILE, 'w') as f:
        #         json.dump(all_word_data, f, indent=2)
    
    # Process WPME words
    print(f"\n{'=' * 60}")
    print("📖 Processing WPME words...")
    print(f"{'=' * 60}")
    for word in wpme_words:
        populate_media(word, minio_client)
        # word_data = process_word(word, "WordPower", ai_service_url, minio_client, progress)
        # if word_data:
        #     all_word_data.append(word_data)
        #     # Save incrementally
        #     with open(OUTPUT_FILE, 'w') as f:
        #         json.dump(all_word_data, f, indent=2)
    
    # Final save
    # print(f"\n💾 Saving final data...")
    # with open(OUTPUT_FILE, 'w') as f:
    #     json.dump(all_word_data, f, indent=2)
    
    print(f"\n{'=' * 60}")
    print("✅ Generation Complete!")
    print(f"{'=' * 60}")
    print(f"📊 Statistics:")
    print(f"  - Total words processed: {len(all_word_data)}")
    print(f"  - Failed words: {len(progress['failed_words'])}")
    print(f"  - Output file: {OUTPUT_FILE}")
    print(f"  - Progress file: {PROGRESS_FILE}")
    print(f"\n💡 Next step: Use the generated JSON file in seed_data.py")


if __name__ == "__main__":
    main()
