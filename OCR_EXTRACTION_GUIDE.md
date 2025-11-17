# OCR Extraction Guide for Image-Based PDFs

This guide explains how to extract text from image-based (scanned) PDF files using OCR (Optical Character Recognition).

## Overview

19 out of 20 books in the PathOfLightBooks directory are image-based PDFs that require OCR for text extraction. I've created an OCR-enabled extraction script that uses Tesseract.js for Arabic text recognition.

## Quick Start

### 1. Install Dependencies

```bash
npm install tesseract.js pdf-poppler
```

**Note**: `pdf-poppler` requires the Poppler PDF utilities to be installed on your system:

**On Ubuntu/Debian**:
```bash
sudo apt-get install poppler-utils
```

**On macOS**:
```bash
brew install poppler
```

**On Windows**:
- Download from: https://github.com/oschwartz10612/poppler-windows/releases
- Add to PATH

### 2. Run OCR Extraction

```bash
# Process all books (WARNING: This will take several hours!)
node extract_pdf_with_ocr.js

# Or process specific books by modifying the script
```

## Performance Expectations

**OCR is SLOW**. Here's what to expect:

- **Per Page**: 5-15 seconds (depending on image quality and text density)
- **Per Book** (avg 400 pages): 30-90 minutes
- **All 20 Books**: 10-30 hours total

### Processing Time Estimates

| Book | Pages | Estimated Time |
|------|-------|----------------|
| alsera_alnabaweya.pdf | 410 | Already extracted (text-based) |
| prophet_muhammad_1.pdf | 529 | ~45-90 min |
| السيرة النبوية ج02 | 440 | ~35-75 min |
| ... (others) | ~300-500 | ~25-85 min each |

## Optimization Strategies

### Option 1: Process One Book at a Time

Modify `extract_pdf_with_ocr.js` to process specific books:

```javascript
// At line ~355, filter the books array:
const booksToProcess = books.filter(book =>
  book.id === 'prophet_muhammad_vol1_002' // Process only this book
);

for (const book of booksToProcess) {
  // ... rest of code
}
```

### Option 2: Process in Batches

Process books in smaller batches (e.g., 3-5 books at a time) and run overnight or during off-hours.

### Option 3: Use Cloud OCR Services (Faster & More Accurate)

Cloud services are significantly faster and more accurate for Arabic:

#### Google Cloud Vision API

1. Install:
```bash
npm install @google-cloud/vision
```

2. Set up credentials:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account-key.json"
```

3. Use the API:
```javascript
const vision = require('@google-cloud/vision');
const client = new vision.ImageAnnotatorClient();

async function ocrWithGoogle(imagePath) {
  const [result] = await client.documentTextDetection(imagePath);
  return result.fullTextAnnotation?.text || '';
}
```

**Advantages**:
- Much faster (2-5 seconds per page)
- Better Arabic recognition
- Handles complex layouts

**Cost**: ~$1.50 per 1000 pages

#### AWS Textract

Similar benefits to Google Cloud Vision, with different pricing and API.

## Alternative Solutions

### 1. Use Pre-OCR'd PDFs

Many Islamic libraries provide searchable (text-based) PDFs:

- **Shia Online Library**: https://shiaonlinelibrary.com
- **Al-Islam.org**: https://www.al-islam.org
- **Waqfeya**: https://waqfeya.net
- **Noor Library**: https://www.noor-book.com

Check if these books are available in searchable format.

### 2. Adobe Acrobat Pro

If you have access to Adobe Acrobat Pro:

1. Open PDF in Acrobat Pro
2. Tools → Scan & OCR → Recognize Text
3. Choose Arabic language
4. Save the searchable PDF
5. Re-run `extract_pdf_content.js` on the new PDF

This is often faster than Tesseract for batch processing.

### 3. ABBYY FineReader

Professional OCR software with excellent Arabic support:
- Batch process all PDFs
- Export as searchable PDFs
- Re-run extraction script

## Current Extraction Status

### Successfully Extracted (Text-based)
- ✅ `alsera_alnabaweya.pdf` - 574,080 characters, 114,143 words

### Needs OCR (Image-based)
All other 19 books - currently only 2 words extracted per book

## Using the OCR Script

### Basic Usage

```bash
# Install dependencies
npm install tesseract.js pdf-poppler

# Run extraction (all books)
node extract_pdf_with_ocr.js
```

### Output Files

The OCR script generates:
- `firebase_complete_import_ocr.json` - Complete dataset
- `firebase_books_ocr.json` - Book metadata
- `firebase_sections_ocr.json` - Extracted sections
- `firebase_paragraphs_ocr_part*.json` - Paragraph content

### Monitoring Progress

The script provides detailed progress output:

```
📖 Processing with OCR: Prophet Muhammad (PBUH) - Volume 1
   File: prophet_muhammad_1.pdf
   Size: 23.15 MB
   Converting PDF to images...
   ✓ Generated 529 images
   Initializing OCR engine (Arabic)...
   Performing OCR on pages...
      OCR: prophet_muhammad_1-1.png
      OCR: prophet_muhammad_1-2.png
      Progress: 10/529 pages
      Progress: 20/529 pages
      ...
   ✓ OCR completed: 529 pages processed
   ✓ 1,250,000 characters extracted
   ✓ 185,000 words extracted
```

## Troubleshooting

### Error: "poppler-utils not found"

Install Poppler (see installation instructions above).

### Error: "Tesseract language data not found"

Tesseract.js downloads language data automatically on first run. Ensure internet connection.

### OCR Produces Gibberish

- Check that Arabic language pack is being used (`'ara'`)
- Verify PDF image quality (low-quality scans produce poor OCR)
- Consider using cloud OCR services for better accuracy

### Script Crashes or Hangs

- Process fewer books at a time
- Increase Node.js memory: `node --max-old-space-size=4096 extract_pdf_with_ocr.js`
- Check disk space for temp images

## Recommendations

For the Path of Light project, I recommend:

1. **Short-term**: Use the existing extracted data (book metadata and the one successfully extracted book) to build and test the app

2. **Medium-term**: Process 2-3 high-priority books with OCR to populate the library

3. **Long-term**: Either:
   - Source text-based PDFs from Islamic libraries
   - Use Google Cloud Vision API for batch OCR
   - Partner with organizations that already have digitized versions

## Cost Analysis

### Free (Tesseract.js)
- **Cost**: $0
- **Time**: 10-30 hours for all books
- **Accuracy**: 70-85% for Arabic
- **Effort**: Run script and wait

### Cloud OCR (Google/AWS)
- **Cost**: ~$30-60 for all books
- **Time**: 2-4 hours for all books
- **Accuracy**: 90-95% for Arabic
- **Effort**: Set up API + run script

### Professional Software (Adobe/ABBYY)
- **Cost**: Software license ($15-30/month)
- **Time**: 4-8 hours for all books
- **Accuracy**: 95%+
- **Effort**: Manual batch processing

---

**Need Help?**

The OCR extraction script is ready to use, but due to the time required, I recommend starting with a test on just 1-2 books to verify the quality before processing all 20 books.
