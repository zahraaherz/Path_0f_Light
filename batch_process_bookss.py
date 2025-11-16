#!/usr/bin/env python3
"""
Batch process all bookss PDFs to JSON format
"""
import json
import os
import sys
from pathlib import Path
import subprocess

def get_file_size(filepath):
    """Get file size in bytes"""
    return os.path.getsize(filepath)

def process_all_books(metadata_path, bookss_dir, output_dir):
    """Process all books from metadata"""

    # Load metadata
    with open(metadata_path, 'r', encoding='utf-8') as f:
        all_metadata = json.load(f)

    # Get list of PDFs with their sizes
    pdf_files = []
    for book_id, metadata in all_metadata.items():
        pdf_filename = metadata['original_filename']
        pdf_path = os.path.join(bookss_dir, pdf_filename)

        if os.path.exists(pdf_path):
            size = get_file_size(pdf_path)
            pdf_files.append({
                'book_id': book_id,
                'pdf_path': pdf_path,
                'size': size,
                'metadata': metadata,
                'title': metadata['title_ar']
            })
        else:
            print(f"Warning: PDF not found: {pdf_path}")

    # Sort by size (smallest first)
    pdf_files.sort(key=lambda x: x['size'])

    print(f"\nFound {len(pdf_files)} PDFs to process")
    print(f"Total size: {sum(f['size'] for f in pdf_files) / 1024 / 1024:.1f} MB")
    print("\nProcessing order (smallest to largest):")
    for i, f in enumerate(pdf_files, 1):
        size_mb = f['size'] / 1024 / 1024
        print(f"  {i:2d}. {f['book_id']:15s} - {size_mb:6.2f} MB - {f['title']}")

    # Process each PDF
    print("\n" + "="*60)
    print("Starting batch processing...")
    print("="*60)

    results = []
    for i, file_info in enumerate(pdf_files, 1):
        output_path = os.path.join(output_dir, f"{file_info['book_id']}_ocr.json")

        # Skip if already exists
        if os.path.exists(output_path):
            print(f"\n[{i}/{len(pdf_files)}] Skipping {file_info['book_id']} (already exists)")
            results.append({'book_id': file_info['book_id'], 'status': 'skipped'})
            continue

        print(f"\n[{i}/{len(pdf_files)}] Processing {file_info['book_id']}...")
        print(f"Size: {file_info['size'] / 1024 / 1024:.2f} MB")

        try:
            # Call the extraction script
            cmd = [
                'python3',
                '/home/user/Path_0f_Light/extract_pdf_to_json.py',
                file_info['pdf_path'],
                file_info['book_id'],
                json.dumps(file_info['metadata']),
                output_path
            ]

            result = subprocess.run(cmd, capture_output=True, text=True, timeout=600)

            if result.returncode == 0:
                print(f"✓ Success: {output_path}")
                results.append({'book_id': file_info['book_id'], 'status': 'success'})
            else:
                print(f"✗ Failed: {result.stderr}")
                results.append({'book_id': file_info['book_id'], 'status': 'failed', 'error': result.stderr})

        except subprocess.TimeoutExpired:
            print(f"✗ Timeout after 10 minutes")
            results.append({'book_id': file_info['book_id'], 'status': 'timeout'})
        except Exception as e:
            print(f"✗ Error: {e}")
            results.append({'book_id': file_info['book_id'], 'status': 'error', 'error': str(e)})

        # Save progress after each book
        progress_file = os.path.join(output_dir, 'batch_progress.json')
        with open(progress_file, 'w', encoding='utf-8') as f:
            json.dump({
                'processed': i,
                'total': len(pdf_files),
                'results': results
            }, f, ensure_ascii=False, indent=2)

    # Final summary
    print("\n" + "="*60)
    print("BATCH PROCESSING COMPLETE")
    print("="*60)
    success = sum(1 for r in results if r['status'] == 'success')
    skipped = sum(1 for r in results if r['status'] == 'skipped')
    failed = sum(1 for r in results if r['status'] in ['failed', 'error', 'timeout'])

    print(f"Total: {len(results)}")
    print(f"Success: {success}")
    print(f"Skipped: {skipped}")
    print(f"Failed: {failed}")

    if failed > 0:
        print("\nFailed books:")
        for r in results:
            if r['status'] in ['failed', 'error', 'timeout']:
                print(f"  - {r['book_id']}: {r.get('error', r['status'])}")

if __name__ == "__main__":
    metadata_path = '/home/user/Path_0f_Light/bookss_metadata.json'
    bookss_dir = '/home/user/Path_0f_Light/bookss'
    output_dir = '/home/user/Path_0f_Light'

    process_all_books(metadata_path, bookss_dir, output_dir)
