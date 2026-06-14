#!/usr/bin/env python3
"""
PaddleOCR Book Page Text Extractor

This script processes book page images uploaded to Firebase Storage,
extracts text using PaddleOCR, and updates Firestore with the text content.

Features:
- High-quality Arabic OCR using PaddleOCR
- Batch processing
- Progress tracking
- Resume capability
- Automatic Firestore updates

Usage:
    python ocr_processor.py --book-id book_001
    python ocr_processor.py --book-id book_001 --start-page 10 --end-page 50
    python ocr_processor.py --all-pending
"""

import os
import sys
import argparse
import json
import tempfile
from pathlib import Path
from typing import List, Dict, Optional
import requests
from tqdm import tqdm

# Firebase Admin
import firebase_admin
from firebase_admin import credentials, firestore, storage

# PaddleOCR
from paddleocr import PaddleOCR

# Initialize Firebase Admin
if not firebase_admin._apps:
    # Use default credentials or service account
    cred = credentials.ApplicationDefault()
    firebase_admin.initialize_app(cred, {
        'storageBucket': 'your-project-id.appspot.com'  # Update this!
    })

db = firestore.client()
bucket = storage.bucket()

# Initialize PaddleOCR
print("Initializing PaddleOCR (Arabic)...")
ocr = PaddleOCR(
    lang='ar',  # Arabic language
    use_angle_cls=True,  # Enable angle classification
    use_gpu=False,  # Set to True if you have GPU
    show_log=False,  # Disable verbose logging
)
print("✓ PaddleOCR initialized\n")


class OCRProcessor:
    """Process book pages with OCR and update Firestore"""

    def __init__(self, book_id: str):
        self.book_id = book_id
        self.temp_dir = Path(tempfile.mkdtemp(prefix=f'ocr_{book_id}_'))

    def get_book_pages(self, start_page: Optional[int] = None,
                       end_page: Optional[int] = None) -> List[Dict]:
        """Fetch book pages from Firestore"""
        query = db.collection('book_pages').where('book_id', '==', self.book_id)

        if start_page:
            query = query.where('page_number', '>=', start_page)
        if end_page:
            query = query.where('page_number', '<=', end_page)

        query = query.order_by('page_number')

        docs = query.stream()
        return [{'id': doc.id, **doc.to_dict()} for doc in docs]

    def download_image(self, storage_path: str, local_path: Path) -> bool:
        """Download image from Firebase Storage"""
        try:
            blob = bucket.blob(storage_path)
            blob.download_to_filename(str(local_path))
            return True
        except Exception as e:
            print(f"Error downloading {storage_path}: {e}")
            return False

    def extract_text_from_image(self, image_path: Path) -> Optional[Dict]:
        """Extract text from image using PaddleOCR"""
        try:
            result = ocr.ocr(str(image_path), cls=True)

            if not result or not result[0]:
                return None

            # Extract text lines
            lines = []
            for line in result[0]:
                text = line[1][0]  # Extracted text
                confidence = line[1][1]  # Confidence score
                lines.append({
                    'text': text,
                    'confidence': confidence
                })

            # Combine all text
            full_text = '\n'.join([line['text'] for line in lines])
            avg_confidence = sum([line['confidence'] for line in lines]) / len(lines)

            return {
                'text': full_text,
                'lines': lines,
                'confidence': avg_confidence,
                'line_count': len(lines)
            }
        except Exception as e:
            print(f"Error extracting text: {e}")
            return None

    def update_firestore(self, page_id: str, ocr_result: Dict) -> bool:
        """Update Firestore with OCR results"""
        try:
            text_content = ocr_result['text']
            word_count = len(text_content.split())
            char_count = len(text_content)

            db.collection('book_pages').document(page_id).update({
                'text_content': text_content,
                'word_count': word_count,
                'character_count': char_count,
                'has_ocr': True,
                'ocr_confidence': ocr_result['confidence'],
                'ocr_line_count': ocr_result['line_count'],
                'ocr_processed_at': firestore.SERVER_TIMESTAMP,
            })
            return True
        except Exception as e:
            print(f"Error updating Firestore: {e}")
            return False

    def process_page(self, page: Dict) -> bool:
        """Process a single page"""
        page_id = page['id']
        page_number = page['page_number']
        storage_path = page['storage_path']

        # Check if already processed
        if page.get('has_ocr'):
            print(f"  ⊘ Page {page_number} already processed, skipping")
            return True

        # Download image
        image_path = self.temp_dir / f"page_{page_number}.png"
        if not self.download_image(storage_path, image_path):
            print(f"  ✗ Failed to download page {page_number}")
            return False

        # Extract text
        ocr_result = self.extract_text_from_image(image_path)
        if not ocr_result:
            print(f"  ✗ Failed to extract text from page {page_number}")
            return False

        # Update Firestore
        if not self.update_firestore(page_id, ocr_result):
            print(f"  ✗ Failed to update Firestore for page {page_number}")
            return False

        # Cleanup
        image_path.unlink()

        # Print summary
        word_count = len(ocr_result['text'].split())
        confidence = ocr_result['confidence'] * 100
        print(f"  ✓ Page {page_number}: {word_count} words, "
              f"{confidence:.1f}% confidence")

        return True

    def process_book(self, start_page: Optional[int] = None,
                     end_page: Optional[int] = None):
        """Process all pages in a book"""
        print(f"📖 Processing book: {self.book_id}")

        # Get pages
        pages = self.get_book_pages(start_page, end_page)
        if not pages:
            print("No pages found!")
            return

        print(f"Found {len(pages)} pages to process\n")

        # Process each page
        success_count = 0
        skip_count = 0
        error_count = 0

        with tqdm(total=len(pages), desc="Processing pages") as pbar:
            for page in pages:
                if page.get('has_ocr'):
                    skip_count += 1
                elif self.process_page(page):
                    success_count += 1
                else:
                    error_count += 1

                pbar.update(1)

        # Summary
        print("\n" + "="*60)
        print("📊 Processing Summary")
        print("="*60)
        print(f"✓ Successfully processed: {success_count} pages")
        print(f"⊘ Skipped (already done): {skip_count} pages")
        print(f"✗ Errors: {error_count} pages")
        print(f"📚 Total: {len(pages)} pages")
        print("="*60)

        # Cleanup temp directory
        self.temp_dir.rmdir()

        # Update book metadata
        self.update_book_metadata(success_count)

    def update_book_metadata(self, pages_processed: int):
        """Update book document with OCR status"""
        try:
            book_ref = db.collection('books').document(self.book_id)
            book_ref.update({
                'ocr_completed': True,
                'ocr_processed_pages': pages_processed,
                'ocr_completed_at': firestore.SERVER_TIMESTAMP,
            })
            print(f"\n✓ Updated book metadata")
        except Exception as e:
            print(f"\n✗ Error updating book metadata: {e}")


def process_all_pending_books():
    """Process all books that have images but no OCR"""
    print("🔍 Finding books with pending OCR...\n")

    # Find books with images but no OCR
    books = db.collection('books')\
        .where('has_page_images', '==', True)\
        .where('ocr_completed', '==', False)\
        .stream()

    book_list = [{'id': doc.id, **doc.to_dict()} for doc in books]

    if not book_list:
        print("No pending books found!")
        return

    print(f"Found {len(book_list)} books to process:\n")
    for book in book_list:
        print(f"  - {book.get('title_en', book['id'])} ({book['total_pages']} pages)")

    print("\n" + "="*60)
    confirm = input("Process all these books? (yes/no): ")
    if confirm.lower() != 'yes':
        print("Cancelled.")
        return

    # Process each book
    for i, book in enumerate(book_list, 1):
        print(f"\n{'='*60}")
        print(f"Processing book {i}/{len(book_list)}")
        print(f"{'='*60}\n")

        processor = OCRProcessor(book['id'])
        processor.process_book()


def main():
    parser = argparse.ArgumentParser(
        description='Extract text from book page images using PaddleOCR'
    )

    # Arguments
    parser.add_argument('--book-id', help='Book ID to process')
    parser.add_argument('--start-page', type=int, help='Start from this page')
    parser.add_argument('--end-page', type=int, help='End at this page')
    parser.add_argument('--all-pending', action='store_true',
                       help='Process all books with pending OCR')

    args = parser.parse_args()

    # Process
    if args.all_pending:
        process_all_pending_books()
    elif args.book_id:
        processor = OCRProcessor(args.book_id)
        processor.process_book(args.start_page, args.end_page)
    else:
        parser.print_help()
        sys.exit(1)


if __name__ == '__main__':
    main()
