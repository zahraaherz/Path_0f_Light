#!/usr/bin/env python3
"""Test PyMuPDF extraction on various PDFs"""
import fitz
import os

test_pdfs = [
    ("bookss_016", "السيدة رقية بنت الحسين (ع), دراسة و تحليل - الشيخ نهاد الفيّاض.pdf"),
    ("bookss_024", "فاطمة الزهراء (ع) ميزان المعرفة - الشيخ أحمد الحائري الأسدي.pdf"),
    ("bookss_003", "أضواء على حياة الإمام علي (ع) - السيد مرتضى الحسيني الشيرازي.pdf"),
    ("bookss_009", "الإمام السـجّاد (ع) قدوة و أسوة - السيد محمد تقي المدرّسي.pdf"),
]

for book_id, filename in test_pdfs:
    pdf_path = f"/home/user/Path_0f_Light/bookss/{filename}"

    print(f"\n{'='*80}")
    print(f"{book_id}: {filename[:50]}...")
    print('='*80)

    try:
        doc = fitz.open(pdf_path)
        total_pages = len(doc)

        # Extract text from all pages
        total_text = ""
        for page_num in range(total_pages):
            page = doc[page_num]
            text = page.get_text()
            total_text += text

        print(f"Total pages: {total_pages}")
        print(f"Total characters: {len(total_text):,}")
        print(f"Total words: {len(total_text.split()):,}")

        if len(total_text) > 100:
            print(f"\n✓ SUCCESS - Has readable text!")
            print(f"Sample from page 1:")
            print(total_text[:300])
        else:
            print(f"\n✗ FAILED - Very little text extracted (likely image-based)")

    except Exception as e:
        print(f"Error: {e}")
