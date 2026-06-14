# OCR Processing Guide

Extract text from book page images using **PaddleOCR** (free & open-source).

## 🎯 What This Does

After you upload a book and images are extracted:
1. Downloads page images from Firebase Storage
2. Runs PaddleOCR to extract Arabic text
3. Updates Firestore with:
   - `text_content` - Full extracted text
   - `word_count` - Number of words
   - `character_count` - Number of characters
   - `has_ocr` - OCR status
   - `ocr_confidence` - Accuracy score

## 📋 Setup (One Time)

### 1. Install Python Dependencies

```bash
cd scripts
pip install -r requirements.txt
```

**Note**: PaddleOCR will download language models (~200MB) on first run.

### 2. Setup Firebase Credentials

Download your service account key from Firebase Console:
- Firebase Console → Project Settings → Service Accounts
- Click "Generate New Private Key"
- Save as `serviceAccountKey.json`

Set environment variable:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="path/to/serviceAccountKey.json"
```

### 3. Update Storage Bucket

Edit `ocr_processor.py` line 46:
```python
'storageBucket': 'your-project-id.appspot.com'  # Change this!
```

## 🚀 Usage

### Process a Single Book

```bash
python ocr_processor.py --book-id book_001
```

### Process Specific Page Range

```bash
# Process pages 10-50
python ocr_processor.py --book-id book_001 --start-page 10 --end-page 50
```

### Process All Pending Books

```bash
python ocr_processor.py --all-pending
```

This will:
1. Find all books with `has_page_images=true` and `ocr_completed=false`
2. Show you the list
3. Ask for confirmation
4. Process all books automatically

## 📊 Example Output

```
📖 Processing book: sira_nabawiya_vol1
Found 250 pages to process

Processing pages: 100%|████████████| 250/250 [12:30<00:00, 3.00s/page]

  ✓ Page 1: 245 words, 94.2% confidence
  ✓ Page 2: 198 words, 96.1% confidence
  ✓ Page 3: 312 words, 93.8% confidence
  ...

============================================================
📊 Processing Summary
============================================================
✓ Successfully processed: 250 pages
⊘ Skipped (already done): 0 pages
✗ Errors: 0 pages
📚 Total: 250 pages
============================================================

✓ Updated book metadata
```

## ⚙️ Configuration

### OCR Language

To process English books:
```python
ocr = PaddleOCR(
    lang='en',  # Change to 'en'
    use_angle_cls=True,
)
```

Supported languages: ar, en, fr, de, zh, ja, ko, and 80+ more!

### GPU Acceleration (Optional)

If you have NVIDIA GPU:

1. Install GPU version:
```bash
pip uninstall paddlepaddle
pip install paddlepaddle-gpu
```

2. Enable in script:
```python
ocr = PaddleOCR(
    lang='ar',
    use_gpu=True,  # Change to True
)
```

**Speed improvement**: ~10x faster!

### Batch Size

Process multiple books in sequence:
```bash
# Create a batch script
for book_id in book_001 book_002 book_003
do
  python ocr_processor.py --book-id $book_id
done
```

## 📈 Performance

### Processing Speed

| Hardware | Pages/Minute | 400-Page Book |
|----------|--------------|---------------|
| CPU      | 4-6 pages    | ~60-90 min    |
| GPU      | 30-50 pages  | ~8-13 min     |

### Accuracy

| Language | Accuracy |
|----------|----------|
| Arabic   | 90-95%   |
| English  | 95-98%   |
| Mixed    | 85-92%   |

## 🔍 Verify Results

### Check a Page in Firestore

```python
from firebase_admin import firestore

db = firestore.client()
page = db.collection('book_pages').document('book_001_page_0001').get()
data = page.to_dict()

print(f"Text: {data['text_content'][:100]}...")
print(f"Words: {data['word_count']}")
print(f"Confidence: {data['ocr_confidence']*100:.1f}%")
```

### Test in Your App

```dart
final page = await BookPagesRepository().getPage('book_001_page_0001');
print('Has text: ${page?.hasText}');
print('Text: ${page?.textContent}');
```

## 🐛 Troubleshooting

### "No module named 'paddleocr'"

Install dependencies:
```bash
pip install -r requirements.txt
```

### "Could not find language pack"

PaddleOCR downloads language models automatically. Make sure you have:
- Internet connection
- ~500MB free disk space
- Write permissions in home directory

### "Failed to download image"

Check:
- Firebase credentials are correct
- Storage bucket name is correct
- Page has `storage_path` field in Firestore

### Low Accuracy

For better results:
- Use higher DPI images (300 instead of 200)
- Ensure images are clear and not rotated
- Check image quality in original PDF

### Out of Memory

For large books:
- Process in batches (--start-page --end-page)
- Close other applications
- Use GPU if available

## 💡 Tips

### Resume Processing

If processing stops, just run again - it automatically skips pages with `has_ocr=true`.

### Parallel Processing

Process multiple books at once:
```bash
# Terminal 1
python ocr_processor.py --book-id book_001

# Terminal 2
python ocr_processor.py --book-id book_002

# Terminal 3
python ocr_processor.py --book-id book_003
```

### Quality Check

After processing, spot-check some pages:
```bash
python -c "
from firebase_admin import firestore, credentials, initialize_app
initialize_app(credentials.ApplicationDefault())
db = firestore.client()

pages = db.collection('book_pages')\
  .where('book_id', '==', 'book_001')\
  .where('ocr_confidence', '<', 0.85)\
  .limit(10).stream()

print('Low confidence pages:')
for p in pages:
    data = p.to_dict()
    print(f\"  Page {data['page_number']}: {data['ocr_confidence']*100:.1f}%\")
"
```

## 🔄 Workflow

Complete book upload + OCR workflow:

```bash
# 1. Upload book through app UI
# (Images are automatically extracted by Cloud Function)

# 2. Wait for image extraction to complete
# (Check Firebase Console - Storage should have book_pages/book_id/*)

# 3. Run OCR
python ocr_processor.py --book-id book_001

# 4. Verify in app
# Open book in app - images + text should be available

# 5. Users can now:
# - View beautiful page images
# - Search text
# - Copy text
# - Use screen readers
```

## 📚 Next Steps

After OCR is complete, you can:
- Enable text search in your app
- Add text-to-speech
- Create book highlights
- Generate summaries
- Build study guides
- Create flashcards from content

---

**Need help?** Check the main `BOOK_IMAGE_UPLOAD_GUIDE.md` or create an issue!
