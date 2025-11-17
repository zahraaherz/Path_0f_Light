#!/usr/bin/env python3
"""
Fast parallel OCR processing - process 3 books simultaneously
"""
import json
import os
import subprocess
from multiprocessing import Pool
import time

def get_books_to_process():
    """Get list of books that need OCR"""
    metadata_path = '/home/user/Path_0f_Light/bookss_metadata.json'
    bookss_dir = '/home/user/Path_0f_Light/bookss'
    output_dir = '/home/user/Path_0f_Light'

    with open(metadata_path, 'r') as f:
        all_metadata = json.load(f)

    books = []
    for book_id, metadata in all_metadata.items():
        pdf_path = os.path.join(bookss_dir, metadata['original_filename'])
        output_path = os.path.join(output_dir, f"{book_id}_ocr.json")

        if not os.path.exists(pdf_path):
            continue

        # Check if needs processing
        needs_processing = True
        if os.path.exists(output_path):
            try:
                with open(output_path, 'r') as f:
                    data = json.load(f)
                    if data['book']['total_paragraphs'] > 50:
                        needs_processing = False
            except:
                pass

        if needs_processing:
            size = os.path.getsize(pdf_path)
            books.append((book_id, size))

    books.sort(key=lambda x: x[1])  # Sort by size
    return [b[0] for b in books]

def process_book(book_id):
    """Process a single book"""
    try:
        print(f"[{book_id}] Starting OCR...")
        cmd = ['python3', '/home/user/Path_0f_Light/ocr_extract_all_books.py', book_id]
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=1800)

        if result.returncode == 0:
            print(f"[{book_id}] ✓ Complete!")
            return (book_id, 'success')
        else:
            print(f"[{book_id}] ✗ Failed")
            return (book_id, 'failed')
    except Exception as e:
        print(f"[{book_id}] ✗ Error: {e}")
        return (book_id, 'error')

def main():
    books = get_books_to_process()

    if not books:
        print("All books already processed!")
        return

    print(f"Processing {len(books)} books in parallel (3 at a time)...")
    print("="*80)

    # Process 3 books at a time
    with Pool(processes=3) as pool:
        results = pool.map(process_book, books)

    # Summary
    success = sum(1 for _, status in results if status == 'success')
    print(f"\n{'='*80}")
    print(f"Completed: {success}/{len(books)} books")
    print(f"{'='*80}")

if __name__ == "__main__":
    main()
