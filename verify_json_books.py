#!/usr/bin/env python3
"""Generate statistics for all converted books"""
import json
import os
from pathlib import Path

def analyze_books():
    json_files = sorted([f for f in os.listdir('.') if f.startswith('bookss_') and f.endswith('_ocr.json')])

    print(f"\n{'='*80}")
    print(f"BOOKSS CONVERSION SUMMARY")
    print(f"{'='*80}\n")

    total_pages = 0
    total_sections = 0
    total_paragraphs = 0
    total_chars = 0
    total_words = 0

    print(f"{'Book ID':<18} {'Pages':>6} {'Sections':>8} {'Paras':>6} {'Chars':>10} {'Words':>8} {'Method':<25} {'Title'}")
    print("-" * 160)

    for json_file in json_files:
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
            book = data['book']

            total_pages += book['total_pages']
            total_sections += book['total_sections']
            total_paragraphs += book['total_paragraphs']
            total_chars += book['total_characters']
            total_words += book['total_words']

            title = book['title_ar']
            if len(title) > 50:
                title = title[:47] + "..."

            print(f"{book['id']:<18} {book['total_pages']:>6} {book['total_sections']:>8} "
                  f"{book['total_paragraphs']:>6} {book['total_characters']:>10,} {book['total_words']:>8,} "
                  f"{book['extraction_method']:<25} {title}")

    print("-" * 160)
    print(f"{'TOTAL:':<18} {total_pages:>6} {total_sections:>8} {total_paragraphs:>6} {total_chars:>10,} {total_words:>8,}")
    print(f"\n{'='*80}")
    print(f"Total Books Converted: {len(json_files)}")
    print(f"{'='*80}\n")

if __name__ == "__main__":
    analyze_books()
