#!/usr/bin/env python3
"""
Enhanced PDF extraction using multiple libraries
"""
import sys

def test_extraction_methods(pdf_path):
    """Test different extraction methods on a PDF"""

    print(f"\nTesting: {pdf_path}")
    print("="*80)

    # Method 1: PyMuPDF (fitz)
    try:
        import fitz
        doc = fitz.open(pdf_path)
        text = ""
        for page_num in range(min(3, len(doc))):
            text += doc[page_num].get_text()
        print(f"✓ PyMuPDF (fitz): {len(text)} chars from first 3 pages")
        if len(text) > 100:
            print(f"  Sample: {text[:200]}")
    except Exception as e:
        print(f"✗ PyMuPDF failed: {e}")

    # Method 2: pdfplumber
    try:
        import pdfplumber
        text = ""
        with pdfplumber.open(pdf_path) as pdf:
            for page in pdf.pages[:3]:
                page_text = page.extract_text()
                if page_text:
                    text += page_text
        print(f"✓ pdfplumber: {len(text)} chars from first 3 pages")
        if len(text) > 100:
            print(f"  Sample: {text[:200]}")
    except Exception as e:
        print(f"✗ pdfplumber failed: {e}")

    # Method 3: PyPDF2
    try:
        import PyPDF2
        text = ""
        with open(pdf_path, 'rb') as file:
            pdf = PyPDF2.PdfReader(file)
            for page_num in range(min(3, len(pdf.pages))):
                text += pdf.pages[page_num].extract_text()
        print(f"✓ PyPDF2: {len(text)} chars from first 3 pages")
        if len(text) > 100:
            print(f"  Sample: {text[:200]}")
    except Exception as e:
        print(f"✗ PyPDF2 failed: {e}")

if __name__ == "__main__":
    # Test a few PDFs
    test_pdfs = [
        "/home/user/Path_0f_Light/bookss/السيدة رقية بنت الحسين (ع), دراسة و تحليل - الشيخ نهاد الفيّاض.pdf",
        "/home/user/Path_0f_Light/bookss/فاطمة الزهراء (ع) ميزان المعرفة - الشيخ أحمد الحائري الأسدي.pdf",
        "/home/user/Path_0f_Light/bookss/أضواء على حياة الإمام علي (ع) - السيد مرتضى الحسيني الشيرازي.pdf",
    ]

    for pdf in test_pdfs:
        test_extraction_methods(pdf)
