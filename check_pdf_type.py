#!/usr/bin/env python3
import sys
import PyPDF2

def check_pdf_text(pdf_path):
    """Check if PDF has embedded text"""
    try:
        with open(pdf_path, 'rb') as file:
            pdf_reader = PyPDF2.PdfReader(file)
            total_pages = len(pdf_reader.pages)

            # Check first 5 pages for text
            text_found = False
            for i in range(min(5, total_pages)):
                page = pdf_reader.pages[i]
                text = page.extract_text()
                if text and len(text.strip()) > 50:
                    text_found = True
                    break

            if text_found:
                print(f"✓ PDF has embedded text ({total_pages} pages)")
                return True
            else:
                print(f"✗ PDF is image-based ({total_pages} pages)")
                return False
    except Exception as e:
        print(f"Error: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) > 1:
        check_pdf_text(sys.argv[1])
    else:
        print("Usage: python3 check_pdf_type.py <pdf_file>")
