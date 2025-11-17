#!/usr/bin/env python3
"""
Enhanced extraction using PyMuPDF - extracts actual text from PDFs
"""
import json
import os
import sys
import re
import fitz  # PyMuPDF
from pathlib import Path

def split_into_paragraphs(text):
    """Split text into meaningful paragraphs"""
    # Split on multiple newlines
    paragraphs = re.split(r'\n\s*\n+', text)

    # Clean and filter paragraphs
    cleaned = []
    for p in paragraphs:
        # Remove page numbers and extra whitespace
        p = re.sub(r'^\s*-\s*\d+\s*-\s*$', '', p, flags=re.MULTILINE)
        p = p.strip()

        # Keep paragraphs with at least 20 characters of actual content
        if len(p) > 20 and not p.replace('-', '').replace(' ', '').isdigit():
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

def extract_with_pymupdf(pdf_path, metadata, book_id, output_path):
    """Extract PDF using PyMuPDF"""
    print(f"\n{'='*80}")
    print(f"Processing: {metadata['title_ar']}")
    print(f"{'='*80}")

    try:
        # Open PDF with PyMuPDF
        doc = fitz.open(pdf_path)
        total_pages = len(doc)

        print(f"Extracting text from {total_pages} pages using PyMuPDF...")

        # Extract text from all pages
        text_by_page = []
        for page_num in range(total_pages):
            page = doc[page_num]
            text = page.get_text("text")  # Get plain text
            text_by_page.append(text)

            if (page_num + 1) % 50 == 0:
                print(f"  Processed {page_num + 1}/{total_pages} pages...")

        doc.close()

        # Combine all text
        full_text = '\n\n'.join(text_by_page)
        total_chars = len(full_text)

        # Check if we got meaningful text
        if total_chars < 500:
            print(f"⚠ Warning: Only {total_chars} characters extracted - PDF may be image-based")
            # Still create the JSON with what we have
            extraction_method = "pymupdf_low_content"
        else:
            print(f"✓ Extracted {total_chars:,} characters")
            extraction_method = "pymupdf_text_extraction"

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

        return True

    except Exception as e:
        print(f"✗ Error: {e}")
        return False

def process_all_books():
    """Process all books with PyMuPDF"""
    metadata_path = '/home/user/Path_0f_Light/bookss_metadata.json'
    bookss_dir = '/home/user/Path_0f_Light/bookss'
    output_dir = '/home/user/Path_0f_Light'

    # Load metadata
    with open(metadata_path, 'r', encoding='utf-8') as f:
        all_metadata = json.load(f)

    # Get list of PDFs sorted by size
    pdf_files = []
    for book_id, metadata in all_metadata.items():
        pdf_filename = metadata['original_filename']
        pdf_path = os.path.join(bookss_dir, pdf_filename)

        if os.path.exists(pdf_path):
            size = os.path.getsize(pdf_path)
            pdf_files.append({
                'book_id': book_id,
                'pdf_path': pdf_path,
                'size': size,
                'metadata': metadata
            })

    # Sort by size
    pdf_files.sort(key=lambda x: x['size'])

    print(f"\nProcessing {len(pdf_files)} books with PyMuPDF")
    print("="*80)

    success_count = 0
    for i, file_info in enumerate(pdf_files, 1):
        output_path = os.path.join(output_dir, f"{file_info['book_id']}_ocr.json")

        print(f"\n[{i}/{len(pdf_files)}] {file_info['book_id']}")

        if extract_with_pymupdf(
            file_info['pdf_path'],
            file_info['metadata'],
            file_info['book_id'],
            output_path
        ):
            success_count += 1

    print(f"\n{'='*80}")
    print(f"PROCESSING COMPLETE")
    print(f"{'='*80}")
    print(f"Successfully processed: {success_count}/{len(pdf_files)}")

if __name__ == "__main__":
    process_all_books()
