#!/usr/bin/env python3
"""
Batch OCR processing for all bookss PDF files
"""
import json
import os
import subprocess
import time
from datetime import datetime

def get_books_to_process():
    """Get list of books that need OCR, sorted by size"""
    metadata_path = '/home/user/Path_0f_Light/bookss_metadata.json'
    bookss_dir = '/home/user/Path_0f_Light/bookss'
    output_dir = '/home/user/Path_0f_Light'

    with open(metadata_path, 'r', encoding='utf-8') as f:
        all_metadata = json.load(f)

    books = []
    for book_id, metadata in all_metadata.items():
        pdf_path = os.path.join(bookss_dir, metadata['original_filename'])
        output_path = os.path.join(output_dir, f"{book_id}_ocr.json")

        if not os.path.exists(pdf_path):
            continue

        # Check if already processed with good content
        needs_processing = True
        if os.path.exists(output_path):
            try:
                with open(output_path, 'r') as f:
                    data = json.load(f)
                    # If has many paragraphs, skip
                    if data['book']['total_paragraphs'] > 50:
                        needs_processing = False
            except:
                pass

        if needs_processing:
            size = os.path.getsize(pdf_path)
            books.append({
                'book_id': book_id,
                'title': metadata['title_ar'],
                'size': size,
                'pdf_path': pdf_path
            })

    # Sort by size (smallest first)
    books.sort(key=lambda x: x['size'])
    return books

def process_all_books():
    """Process all books that need OCR"""
    books = get_books_to_process()

    print(f"\n{'='*80}")
    print(f"BATCH OCR PROCESSING")
    print(f"{'='*80}")
    print(f"Found {len(books)} books to process")
    print(f"\nProcessing order (smallest to largest):")

    for i, book in enumerate(books, 1):
        size_mb = book['size'] / 1024 / 1024
        print(f"  {i:2d}. {book['book_id']:15s} - {size_mb:6.2f} MB - {book['title'][:50]}")

    print(f"\n{'='*80}")
    print("Starting batch OCR processing...")
    print(f"{'='*80}\n")

    start_time = time.time()
    results = []

    for i, book in enumerate(books, 1):
        book_start = time.time()

        print(f"\n[{i}/{len(books)}] Processing {book['book_id']}...")
        print(f"Size: {book['size'] / 1024 / 1024:.2f} MB")
        print(f"Started: {datetime.now().strftime('%H:%M:%S')}")

        try:
            cmd = [
                'python3',
                '/home/user/Path_0f_Light/ocr_extract_all_books.py',
                book['book_id']
            ]

            result = subprocess.run(cmd, capture_output=True, text=True, timeout=3600)

            book_time = time.time() - book_start

            if result.returncode == 0:
                print(f"✓ Success in {book_time/60:.1f} minutes")
                results.append({'book_id': book['book_id'], 'status': 'success', 'time': book_time})
            else:
                print(f"✗ Failed:")
                print(result.stderr[-500:] if len(result.stderr) > 500 else result.stderr)
                results.append({'book_id': book['book_id'], 'status': 'failed', 'error': result.stderr[:200]})

        except subprocess.TimeoutExpired:
            print(f"✗ Timeout after 1 hour")
            results.append({'book_id': book['book_id'], 'status': 'timeout'})
        except Exception as e:
            print(f"✗ Error: {e}")
            results.append({'book_id': book['book_id'], 'status': 'error', 'error': str(e)})

        # Save progress
        progress_file = '/home/user/Path_0f_Light/ocr_batch_progress.json'
        with open(progress_file, 'w', encoding='utf-8') as f:
            json.dump({
                'processed': i,
                'total': len(books),
                'results': results,
                'elapsed_time': time.time() - start_time
            }, f, ensure_ascii=False, indent=2)

        # Print progress
        elapsed = time.time() - start_time
        avg_time = elapsed / i
        remaining = (len(books) - i) * avg_time
        print(f"Progress: {i}/{len(books)} ({i*100//len(books)}%)")
        print(f"Elapsed: {elapsed/60:.1f}min | Est. remaining: {remaining/60:.1f}min")

    # Final summary
    total_time = time.time() - start_time
    print(f"\n{'='*80}")
    print("BATCH OCR PROCESSING COMPLETE!")
    print(f"{'='*80}")

    success = sum(1 for r in results if r['status'] == 'success')
    failed = sum(1 for r in results if r['status'] in ['failed', 'error', 'timeout'])

    print(f"Total books: {len(results)}")
    print(f"Success: {success}")
    print(f"Failed: {failed}")
    print(f"Total time: {total_time/3600:.2f} hours")

    if failed > 0:
        print(f"\nFailed books:")
        for r in results:
            if r['status'] in ['failed', 'error', 'timeout']:
                print(f"  - {r['book_id']}: {r.get('error', r['status'])}")

if __name__ == "__main__":
    process_all_books()
