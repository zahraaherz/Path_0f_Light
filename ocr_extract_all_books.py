#!/usr/bin/env python3
"""
Full OCR extraction using pdf2image + Tesseract OCR
"""
import json
import os
import sys
import re
import fitz  # PyMuPDF
from pdf2image import convert_from_path
import pytesseract
from PIL import Image
import time

def split_into_paragraphs(text):
    """Split text into meaningful paragraphs"""
    # Split on multiple newlines
    paragraphs = re.split(r'\n\s*\n+', text)

    # Clean and filter paragraphs
    cleaned = []
    for p in paragraphs:
        # Remove page numbers and extra whitespace
        p = re.sub(r'^\s*[-–—]\s*\d+\s*[-–—]\s*$', '', p, flags=re.MULTILINE)
        p = p.strip()

        # Keep paragraphs with at least 30 characters of actual Arabic content
        if len(p) > 30 and not p.replace('-', '').replace(' ', '').replace('\n', '').isdigit():
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

def ocr_pdf_with_tesseract(pdf_path, metadata, book_id, output_path):
    """Extract PDF using Tesseract OCR"""
    print(f"\n{'='*80}")
    print(f"Processing: {metadata['title_ar']}")
    print(f"Book ID: {book_id}")
    print(f"{'='*80}")

    try:
        # First check if PDF has embedded text
        doc = fitz.open(pdf_path)
        total_pages = len(doc)

        # Quick check for embedded text
        sample_text = ''
        for i in range(min(3, total_pages)):
            sample_text += doc[i].get_text()
        doc.close()

        # If has embedded text, use PyMuPDF
        if len(sample_text.strip()) > 1000:
            print(f"✓ PDF has embedded text, using PyMuPDF extraction...")
            return extract_with_pymupdf(pdf_path, metadata, book_id, output_path)

        # Otherwise, use OCR
        print(f"PDF is image-based, using Tesseract OCR...")
        print(f"Converting {total_pages} pages to images (this may take a while)...")

        # Convert PDF to images (200 DPI for faster processing while maintaining quality)
        images = convert_from_path(pdf_path, dpi=200, thread_count=4)

        print(f"Running OCR on {len(images)} pages...")
        text_by_page = []

        for i, image in enumerate(images):
            # OCR with Tesseract (Arabic + English)
            text = pytesseract.image_to_string(image, lang='ara+eng', config='--psm 6')
            text_by_page.append(text)

            # Progress indicator
            if (i + 1) % 10 == 0:
                print(f"  Processed {i + 1}/{len(images)} pages...")

        # Combine all text
        full_text = '\n\n'.join(text_by_page)
        total_chars = len(full_text)

        print(f"✓ OCR complete! Extracted {total_chars:,} characters")

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
                    'page_number': section['start_page'] + 1
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
                'extraction_method': 'tesseract_ocr_arabic'
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

        return True

    except Exception as e:
        print(f"✗ Error: {e}")
        import traceback
        traceback.print_exc()
        return False

def extract_with_pymupdf(pdf_path, metadata, book_id, output_path):
    """Fallback to PyMuPDF for text-based PDFs"""
    print("Using PyMuPDF text extraction...")

    doc = fitz.open(pdf_path)
    total_pages = len(doc)

    text_by_page = []
    for page_num in range(total_pages):
        text = doc[page_num].get_text("text")
        text_by_page.append(text)
    doc.close()

    full_text = '\n\n'.join(text_by_page)
    total_chars = len(full_text)

    sections_data = create_sections(text_by_page)

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
                'page_number': section['start_page'] + 1
            })
            paragraph_id += 1

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

    total_words = len(full_text.split())

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
            'extraction_method': 'pymupdf_text_extraction'
        },
        'sections': sections_meta,
        'paragraphs': all_paragraphs
    }

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(json_data, f, ensure_ascii=False, indent=2)

    print(f"✓ Complete! {total_pages} pages, {len(all_paragraphs)} paragraphs, {total_chars:,} chars")
    return True

def process_single_book(book_id):
    """Process a single book by ID"""
    metadata_path = '/home/user/Path_0f_Light/bookss_metadata.json'
    bookss_dir = '/home/user/Path_0f_Light/bookss'
    output_dir = '/home/user/Path_0f_Light'

    with open(metadata_path, 'r', encoding='utf-8') as f:
        all_metadata = json.load(f)

    if book_id not in all_metadata:
        print(f"Error: Book ID '{book_id}' not found in metadata")
        return False

    metadata = all_metadata[book_id]
    pdf_path = os.path.join(bookss_dir, metadata['original_filename'])
    output_path = os.path.join(output_dir, f"{book_id}_ocr.json")

    if not os.path.exists(pdf_path):
        print(f"Error: PDF not found at {pdf_path}")
        return False

    return ocr_pdf_with_tesseract(pdf_path, metadata, book_id, output_path)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        # Process single book
        book_id = sys.argv[1]
        success = process_single_book(book_id)
        sys.exit(0 if success else 1)
    else:
        print("Usage: python3 ocr_extract_all_books.py <book_id>")
        print("Example: python3 ocr_extract_all_books.py bookss_024")
        sys.exit(1)
