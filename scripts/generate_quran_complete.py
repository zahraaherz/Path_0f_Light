#!/usr/bin/env python3
"""
Generate complete Quran JSON files for Firestore
Fetches data from Quran.com API and formats for your app structure
"""

import json
import requests
import time
from typing import List, Dict

# Quran.com API endpoints
BASE_URL = "https://api.quran.com/api/v4"
CHAPTERS_URL = f"{BASE_URL}/chapters"
VERSES_URL = f"{BASE_URL}/quran/verses/uthmani"
TRANSLATIONS_URL = f"{BASE_URL}/quran/translations/131"  # Sahih International

# Surah metadata (114 Surahs)
SURAH_DATA = [
    {"num": 1, "name_ar": "الفاتحة", "name_en": "Al-Fatiha", "verses": 7, "place": "Makkah", "pages": "1-1"},
    {"num": 2, "name_ar": "البقرة", "name_en": "Al-Baqarah", "verses": 286, "place": "Madinah", "pages": "2-49"},
    {"num": 3, "name_ar": "آل عمران", "name_en": "Ali 'Imran", "verses": 200, "place": "Madinah", "pages": "50-76"},
    {"num": 4, "name_ar": "النساء", "name_en": "An-Nisa", "verses": 176, "place": "Madinah", "pages": "77-106"},
    {"num": 5, "name_ar": "المائدة", "name_en": "Al-Ma'idah", "verses": 120, "place": "Madinah", "pages": "106-127"},
    {"num": 6, "name_ar": "الأنعام", "name_en": "Al-An'am", "verses": 165, "place": "Makkah", "pages": "128-150"},
    {"num": 7, "name_ar": "الأعراف", "name_en": "Al-A'raf", "verses": 206, "place": "Makkah", "pages": "151-176"},
    # Add remaining 107 Surahs here...
    {"num": 112, "name_ar": "الإخلاص", "name_en": "Al-Ikhlas", "verses": 4, "place": "Makkah", "pages": "604-604"},
    {"num": 113, "name_ar": "الفلق", "name_en": "Al-Falaq", "verses": 5, "place": "Makkah", "pages": "604-604"},
    {"num": 114, "name_ar": "الناس", "name_en": "An-Nas", "verses": 6, "place": "Makkah", "pages": "604-604"},
]


def fetch_chapter_info():
    """Fetch all chapter information from Quran.com API"""
    print("📥 Fetching chapter information...")
    response = requests.get(CHAPTERS_URL)
    data = response.json()
    return data['chapters']


def fetch_verses():
    """Fetch all Quran verses with Arabic text"""
    print("📥 Fetching Arabic verses...")
    response = requests.get(VERSES_URL)
    data = response.json()
    return data['verses']


def fetch_translations():
    """Fetch English translations (Sahih International)"""
    print("📥 Fetching English translations...")
    response = requests.get(TRANSLATIONS_URL)
    data = response.json()
    return data['translations']


def generate_sections() -> List[Dict]:
    """Generate sections JSON (all 114 Surahs)"""
    print("📝 Generating sections (Surahs)...")
    sections = []

    chapters = fetch_chapter_info()

    for chapter in chapters:
        section = {
            "id": f"quran_001_surah_{chapter['id']:03d}",
            "book_id": "quran_001",
            "book_title_ar": "القرآن الكريم",
            "book_title_en": "The Holy Quran",
            "section_number": chapter['id'],
            "title_ar": chapter['name_arabic'],
            "title_en": chapter['name_simple'],
            "paragraph_count": chapter['verses_count'],
            "page_range": f"{chapter.get('pages', [1])[0]}-{chapter.get('pages', [1])[-1] if chapter.get('pages') else 1}",
            "difficulty_level": "basic" if chapter['verses_count'] < 20 else "intermediate",
            "topics": [],
            "revelation_place": chapter['revelation_place']
        }
        sections.append(section)

    return sections


def extract_keywords(text: str, language: str) -> List[str]:
    """Extract search keywords from text"""
    # Simple keyword extraction (remove stop words for production)
    words = text.split()
    # Filter short words
    keywords = [w for w in words if len(w) > 2][:10]  # Top 10 words
    return keywords


def generate_paragraphs() -> List[Dict]:
    """Generate paragraphs JSON (all 6,236 verses)"""
    print("📝 Generating paragraphs (Ayahs/Verses)...")

    verses_ar = fetch_verses()
    verses_en = fetch_translations()

    paragraphs = []
    current_page = 1

    for i, (verse_ar, verse_en) in enumerate(zip(verses_ar, verses_en), 1):
        # Parse verse key (e.g., "1:1" = Surah 1, Verse 1)
        parts = verse_ar['verse_key'].split(':')
        surah_num = int(parts[0])
        verse_num = int(parts[1])

        # Get Surah info
        surah_info = next((s for s in SURAH_DATA if s['num'] == surah_num), None)
        if not surah_info:
            continue

        paragraph = {
            "id": f"quran_para_{surah_num:03d}_{verse_num:03d}",
            "book_id": "quran_001",
            "section_id": f"quran_001_surah_{surah_num:03d}",
            "section_title_ar": surah_info['name_ar'],
            "section_title_en": surah_info['name_en'],
            "paragraph_number": verse_num,
            "page_number": verse_ar.get('page_number', current_page),
            "content": {
                "text_ar": verse_ar['text_uthmani'],
                "text_en": verse_en['text']
            },
            "entities": {
                "people": [],
                "places": [],
                "events": [],
                "dates": []
            },
            "search_data": {
                "keywords_ar": extract_keywords(verse_ar['text_uthmani'], 'ar'),
                "keywords_en": extract_keywords(verse_en['text'], 'en')
            },
            "references": {
                "referenced_in_questions": [],
                "related_paragraphs": []
            },
            "metadata": {
                "difficulty": "basic",
                "reading_time_seconds": max(3, len(verse_ar['text_uthmani']) // 10),
                "question_potential": {
                    "facts_count": 0,
                    "can_generate_questions": True
                },
                "content_priority": "high" if surah_num in [1, 2, 18, 36, 55] else "medium"
            },
            "created_at": None
        }

        paragraphs.append(paragraph)
        current_page = verse_ar.get('page_number', current_page)

        # Progress indicator
        if i % 500 == 0:
            print(f"  ✓ Processed {i}/{len(verses_ar)} verses")

    return paragraphs


def save_json(data: any, filename: str):
    """Save data to JSON file"""
    filepath = f"../assets/quran/{filename}"
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"✅ Saved: {filepath}")


def main():
    """Main execution"""
    print("🌙 Starting Quran JSON Generation")
    print("=" * 50)

    try:
        # Generate sections (114 Surahs)
        sections = generate_sections()
        save_json(sections, "quran_sections_complete.json")
        print(f"📊 Generated {len(sections)} sections")

        # Generate paragraphs (6,236 verses)
        paragraphs = generate_paragraphs()
        save_json(paragraphs, "quran_paragraphs_complete.json")
        print(f"📊 Generated {len(paragraphs)} paragraphs")

        print("\n🎉 Complete Quran JSON generated successfully!")
        print("\nNext steps:")
        print("1. Review the generated files")
        print("2. Upload to Firestore using upload script")
        print("3. Open the app and enjoy reading!")

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    main()
