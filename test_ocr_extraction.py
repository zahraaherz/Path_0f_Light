#!/usr/bin/env python3
"""
OCR extraction using PyMuPDF image extraction + OCR.space free API
"""
import fitz  # PyMuPDF
import requests
import json
import time
import io
from PIL import Image

def ocr_image_with_ocrspace(image_bytes, api_key='helloworld'):
    """Use OCR.space free API"""
    url = 'https://api.ocr.space/parse/image'

    payload = {
        'apikey': api_key,
        'language': 'ara',
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
        elif result.get('ErrorMessage'):
            print(f"    OCR Error: {result['ErrorMessage']}")
            return ''
        return ''
    except Exception as e:
        print(f"    Request error: {e}")
        return ''

def extract_page_as_image(page):
    """Extract PDF page as image using PyMuPDF"""
    try:
        # Render page to image at 300 DPI for better OCR
        mat = fitz.Matrix(300/72, 300/72)
        pix = page.get_pixmap(matrix=mat)

        # Convert to PIL Image
        img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)

        # Convert to PNG bytes
        img_byte_arr = io.BytesIO()
        img.save(img_byte_arr, format='PNG', optimize=True)
        img_byte_arr = img_byte_arr.getvalue()

        return img_byte_arr
    except Exception as e:
        print(f"    Image extraction error: {e}")
        return None

def ocr_pdf_page(page, page_num):
    """OCR a single PDF page"""
    print(f"  Page {page_num + 1}...", end='', flush=True)

    # Extract page as image
    img_bytes = extract_page_as_image(page)
    if not img_bytes:
        print(" ✗ Image extraction failed")
        return ""

    # OCR the image
    text = ocr_image_with_ocrspace(img_bytes)

    if text and len(text) > 20:
        print(f" ✓ ({len(text)} chars)")
    else:
        print(" ✗ No text")

    return text

def test_ocr_extraction(pdf_path, max_pages=3):
    """Test OCR extraction on a PDF"""
    print(f"\nTesting OCR on: {pdf_path}")
    print("="*80)

    doc = fitz.open(pdf_path)
    total_pages = len(doc)
    pages_to_test = min(max_pages, total_pages)

    print(f"Testing first {pages_to_test} of {total_pages} pages...")

    all_text = []
    for page_num in range(pages_to_test):
        page = doc[page_num]
        text = ocr_pdf_page(page, page_num)
        all_text.append(text)

        # Rate limiting
        time.sleep(2)

    doc.close()

    combined_text = '\n\n'.join(all_text)
    print(f"\nTotal extracted: {len(combined_text)} characters")

    if len(combined_text) > 100:
        print("\n✓ SUCCESS! Sample:")
        print(combined_text[:500])
        return True
    else:
        print("\n✗ FAILED - Very little text extracted")
        return False

if __name__ == "__main__":
    # Test on smallest book
    test_pdf = "/home/user/Path_0f_Light/bookss/فاطمة الزهراء (ع) ميزان المعرفة - الشيخ أحمد الحائري الأسدي.pdf"
    test_ocr_extraction(test_pdf, max_pages=2)
