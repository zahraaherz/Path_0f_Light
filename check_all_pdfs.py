#!/usr/bin/env python3
import PyPDF2
import json
import os

# Load metadata
with open('bookss_metadata.json', 'r', encoding='utf-8') as f:
    metadata = json.load(f)

text_based = []
image_based = []

for book_id, meta in sorted(metadata.items()):
    pdf_path = os.path.join('bookss', meta['original_filename'])

    if not os.path.exists(pdf_path):
        continue

    try:
        with open(pdf_path, 'rb') as file:
            pdf_reader = PyPDF2.PdfReader(file)
            total_pages = len(pdf_reader.pages)

            # Check first 3 pages
            text = ""
            for i in range(min(3, total_pages)):
                text += pdf_reader.pages[i].extract_text()

            size_mb = os.path.getsize(pdf_path) / 1024 / 1024

            if len(text.strip()) > 200:
                text_based.append((book_id, meta['title_ar'], total_pages, size_mb))
            else:
                image_based.append((book_id, meta['title_ar'], total_pages, size_mb))
    except Exception as e:
        print(f"Error with {book_id}: {e}")

print(f"\n{'='*80}")
print("TEXT-BASED PDFs (can extract directly):")
print(f"{'='*80}")
for book_id, title, pages, size in text_based:
    print(f"{book_id:15} {pages:4} pages {size:6.2f} MB - {title}")
print(f"\nTotal text-based: {len(text_based)}\n")

print(f"{'='*80}")
print("IMAGE-BASED PDFs (need OCR):")
print(f"{'='*80}")
for book_id, title, pages, size in image_based:
    print(f"{book_id:15} {pages:4} pages {size:6.2f} MB - {title}")
print(f"\nTotal image-based: {len(image_based)}")
