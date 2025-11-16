#!/usr/bin/env python3
"""
Extract text from PDFs and convert to JSON format for bookss collection
"""
import json
import sys
import re
from pathlib import Path
import PyPDF2
from pdf2image import convert_from_path
from PIL import Image
import io
import base64
import requests
import time

def extract_text_from_pdf(pdf_path):
    """Extract text from PDF using PyPDF2"""
    text_by_page = []
    try:
        with open(pdf_path, 'rb') as file:
            pdf_reader = PyPDF2.PdfReader(file)
            total_pages = len(pdf_reader.pages)

            for i in range(total_pages):
                page = pdf_reader.pages[i]
                text = page.extract_text()
                text_by_page.append(text)

            return text_by_page, total_pages
    except Exception as e:
        print(f"Error extracting text: {e}")
        return [], 0

def ocr_image_with_ocrspace(image_bytes, api_key='K87899142188957'):
    """Use OCR.space free API for image OCR"""
    url = 'https://api.ocr.space/parse/image'

    payload = {
        'apikey': api_key,
        'language': 'ara',  # Arabic
        'isOverlayRequired': False,
        'detectOrientation': True,
        'scale': True,
        'OCREngine': 2,
    }

    files = {'file': ('image.png', image_bytes, 'image/png')}

    try:
        response = requests.post(url, files=files, data=payload, timeout=60)
        result = response.json()

        if result.get('ParsedResults'):
            return result['ParsedResults'][0].get('ParsedText', '')
        return ''
    except Exception as e:
        print(f"OCR error: {e}")
        return ''

def extract_text_from_image_pdf(pdf_path):
    """Extract text from image-based PDF using OCR"""
    text_by_page = []
    try:
        print(f"Converting PDF to images...")
        # Convert PDF to images (lower DPI for faster processing)
        images = convert_from_path(pdf_path, dpi=150, first_page=1, last_page=None)
        total_pages = len(images)

        print(f"Processing {total_pages} pages with OCR...")
        for i, image in enumerate(images):
            print(f"  OCR page {i+1}/{total_pages}...", end='', flush=True)

            # Convert PIL image to bytes
            img_byte_arr = io.BytesIO()
            image.save(img_byte_arr, format='PNG')
            img_byte_arr = img_byte_arr.getvalue()

            # OCR the image
            text = ocr_image_with_ocrspace(img_byte_arr)
            text_by_page.append(text)
            print(" ✓")

            # Rate limiting for free API
            if (i + 1) % 5 == 0:
                time.sleep(2)

        return text_by_page, total_pages
    except Exception as e:
        print(f"Error with image OCR: {e}")
        return [], 0

def split_into_paragraphs(text):
    """Split text into meaningful paragraphs"""
    # Split on double newlines or Arabic paragraph markers
    paragraphs = re.split(r'\n\n+|\r\n\r\n+', text)

    # Clean and filter paragraphs
    cleaned = []
    for p in paragraphs:
        p = p.strip()
        # Keep paragraphs with at least 20 characters
        if len(p) > 20:
            cleaned.append(p)

    return cleaned

def create_sections(text_by_page, chars_per_section=15000):
    """Create sections from pages"""
    sections = []
    current_section = []
    current_chars = 0
    section_num = 1

    for page_num, page_text in enumerate(text_by_page):
        current_section.append(page_text)
        current_chars += len(page_text)

        # Create new section when reaching character limit
        if current_chars >= chars_per_section:
            combined_text = '\n\n'.join(current_section)
            sections.append({
                'section_number': section_num,
                'text': combined_text,
                'start_page': page_num - len(current_section) + 1,
                'end_page': page_num
            })
            current_section = []
            current_chars = 0
            section_num += 1

    # Add remaining text as final section
    if current_section:
        combined_text = '\n\n'.join(current_section)
        sections.append({
            'section_number': section_num,
            'text': combined_text,
            'start_page': len(text_by_page) - len(current_section),
            'end_page': len(text_by_page) - 1
        })

    return sections

def convert_pdf_to_json(pdf_path, metadata, book_id, output_path):
    """Convert a PDF to JSON format"""
    print(f"\n{'='*60}")
    print(f"Processing: {metadata['title_ar']}")
    print(f"{'='*60}")

    # Check if PDF has embedded text first
    print("Checking PDF type...")
    text_by_page, total_pages = extract_text_from_pdf(pdf_path)

    # Check if we got meaningful text
    total_text = ''.join(text_by_page)
    has_text = len(total_text.strip()) > 500

    if not has_text:
        print("PDF is image-based, using OCR...")
        text_by_page, total_pages = extract_text_from_image_pdf(pdf_path)
        extraction_method = "ocr_space_api"
    else:
        print(f"PDF has embedded text ({total_pages} pages)")
        extraction_method = "pypdf2_text_extraction"

    # Combine all text
    full_text = '\n\n'.join(text_by_page)

    # Create sections
    print("Creating sections...")
    sections_data = create_sections(text_by_page)

    # Create paragraphs
    print("Extracting paragraphs...")
    all_paragraphs = []
    paragraph_id = 1

    for section in sections_data:
        section_paragraphs = split_into_paragraphs(section['text'])

        for para_text in section_paragraphs:
            all_paragraphs.append({
                'paragraph_id': f"{book_id}_paragraph_{paragraph_id:04d}",
                'book_id': book_id,
                'section_id': f"{book_id}_section_{section['section_number']:03d}",
                'paragraph_number': paragraph_id,
                'text_ar': para_text,
                'page_number': section['start_page'] + 1  # Estimate
            })
            paragraph_id += 1

    # Create sections metadata
    sections_meta = []
    position = 0
    for section in sections_data:
        section_text = section['text']
        sections_meta.append({
            'section_id': f"{book_id}_section_{section['section_number']:03d}",
            'book_id': book_id,
            'section_number': section['section_number'],
            'title_ar': f"القسم {section['section_number']}",
            'title_en': f"Part {section['section_number']}",
            'startPosition': position,
            'endPosition': position + len(section_text),
            'estimated_page': section['start_page']
        })
        position += len(section_text)

    # Calculate statistics
    total_chars = len(full_text)
    total_words = len(full_text.split())

    # Create final JSON structure
    json_data = {
        'book': {
            'id': book_id,
            'title_ar': metadata['title_ar'],
            'title_en': metadata['title_en'],
            'author_ar': metadata['author_ar'],
            'author_en': metadata['author_en'],
            'total_sections': len(sections_meta),
            'total_paragraphs': len(all_paragraphs),
            'language': metadata['language'],
            'pdf_url': metadata.get('pdf_url', ''),
            'original_filename': metadata['original_filename'],
            'storage_path': metadata['storage_path'],
            'version': metadata['version'],
            'content_status': metadata['content_status'],
            'description': metadata['description'],
            'topics': metadata['topics'],
            'category': metadata['category'],
            'processing_status': 'completed',
            'total_pages': total_pages,
            'total_characters': total_chars,
            'total_words': total_words,
            'extraction_method': extraction_method
        },
        'sections': sections_meta,
        'paragraphs': all_paragraphs
    }

    # Write to file
    print(f"Writing JSON to {output_path}...")
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(json_data, f, ensure_ascii=False, indent=2)

    print(f"✓ Complete!")
    print(f"  - Pages: {total_pages}")
    print(f"  - Sections: {len(sections_meta)}")
    print(f"  - Paragraphs: {len(all_paragraphs)}")
    print(f"  - Characters: {total_chars:,}")
    print(f"  - Words: {total_words:,}")

    return json_data

if __name__ == "__main__":
    if len(sys.argv) != 5:
        print("Usage: python3 extract_pdf_to_json.py <pdf_path> <book_id> <metadata_json> <output_path>")
        sys.exit(1)

    pdf_path = sys.argv[1]
    book_id = sys.argv[2]
    metadata = json.loads(sys.argv[3])
    output_path = sys.argv[4]

    convert_pdf_to_json(pdf_path, metadata, book_id, output_path)
