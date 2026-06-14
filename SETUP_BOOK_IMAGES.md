# Quick Setup Guide - Book Image Upload System

## ✅ What I Created For You

### 1. **Admin Upload UI** (`lib/screens/admin/book_upload_screen.dart`)
   - Beautiful Flutter interface to upload books
   - Upload PDF + cover image
   - Fill in metadata (title, author, description, topics)
   - Progress tracking during upload

### 2. **Cloud Functions** (`functions/src/bookImageProcessing.ts`)
   - Automatically extracts each page as an image (PNG, 200 DPI)
   - Uploads images to Firebase Storage
   - Creates Firestore documents for each page
   - Processes books in the background

### 3. **Data Models** 
   - `lib/models/library/book_page.dart` - Page model with image URL
   - `lib/repositories/book_pages_repository.dart` - Query pages from Firestore

### 4. **Image Viewer** (`lib/widgets/reading/image_page_viewer.dart`)
   - Pinch to zoom
   - Swipe to change pages
   - Page navigator with grid
   - Beautiful reading experience

### 5. **Documentation**
   - `BOOK_IMAGE_UPLOAD_GUIDE.md` - Complete usage guide
   - `SETUP_BOOK_IMAGES.md` - This file!

## 🚀 Setup Steps (5 minutes)

### Step 1: Add Flutter Dependencies

Open `pubspec.yaml` and add:

```yaml
dependencies:
  cached_network_image: ^3.3.0
  photo_view: ^0.14.0
  file_picker: ^6.1.1
```

Then run:
```bash
flutter pub get
```

### Step 2: Generate Freezed Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates the code for the `BookPage` model.

### Step 3: Install Server Dependencies

On your Cloud Functions server (or local for testing):

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install poppler-utils

# macOS
brew install poppler
```

### Step 4: Install Node Dependencies

```bash
cd functions
npm install @google-cloud/storage
```

### Step 5: Deploy Cloud Functions

```bash
cd functions
npm run build
firebase deploy --only functions:processBookWithImages,functions:processBookImagesManually
```

### Step 6: Update Firestore Rules

Add to your `firestore.rules`:

```javascript
match /book_pages/{pageId} {
  allow read: if request.auth != null;
  allow write: if isAdmin();
}
```

Deploy:
```bash
firebase deploy --only firestore:rules
```

### Step 7: Update Storage Rules

Add to your `storage.rules`:

```javascript
match /book_pages/{bookId}/{pageImage} {
  allow read: if request.auth != null;
  allow write: if isAdmin();
}

match /book_covers/{coverImage} {
  allow read: if request.auth != null;
  allow write: if isAdmin();
}
```

Deploy:
```bash
firebase deploy --only storage:rules
```

## 📱 How to Use

### In Your App

1. **Navigate to upload screen**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const BookUploadScreen(),
  ),
);
```

2. **Upload a book** through the UI

3. **Read the book with images**:
```dart
// Get pages
final pages = await BookPagesRepository().getBookPages(bookId);

// Display with image viewer
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ImagePageViewer(
      pages: pages,
      initialPage: 0,
      showPageNumber: true,
      showText: false, // Set true if you add OCR later
    ),
  ),
);
```

## 📊 What Happens When You Upload

```
1. User selects PDF & fills form
         ↓
2. Upload to Firebase Storage: islamic_books/book.pdf
         ↓
3. Cloud Function triggers automatically
         ↓
4. Extract pages: page_0001.png, page_0002.png, ...
         ↓
5. Upload images: book_pages/{bookId}/page_XXXX.png
         ↓
6. Create Firestore docs: book_pages collection
         ↓
7. User can now read with beautiful image viewer!
```

## 📁 Database Structure

### Firestore Collections

```
books/
  ├── book_001
  │   ├── title_ar: "العنوان"
  │   ├── title_en: "Title"
  │   ├── pdf_url: "..."
  │   ├── cover_image_url: "..."
  │   ├── total_pages: 250
  │   └── has_page_images: true
  │
book_pages/
  ├── book_001_page_0001
  │   ├── book_id: "book_001"
  │   ├── page_number: 1
  │   ├── image_url: "https://..."
  │   └── storage_path: "book_pages/book_001/page_0001.png"
  │
  ├── book_001_page_0002
  │   └── ...
```

### Firebase Storage

```
islamic_books/
  └── book_001.pdf

book_covers/
  └── book_001.jpg

book_pages/
  └── book_001/
      ├── page_0001.png
      ├── page_0002.png
      ├── page_0003.png
      └── ...
```

## 🎯 Features You Get

✅ **Upload PDFs** with beautiful admin UI  
✅ **Auto-extract pages** as high-quality images  
✅ **Store images** in Firebase Storage  
✅ **Zoom & Pan** image viewing  
✅ **Page Navigator** with grid view  
✅ **Progress Tracking** (can add later)  
✅ **Offline Caching** with cached_network_image  
✅ **OCR Ready** (can extract text later)  

## 🔍 Testing

### Test Upload

1. Open the `BookUploadScreen`
2. Select a small PDF (2-3 pages for testing)
3. Fill in details and upload
4. Check Firebase Console:
   - Storage → `book_pages/` folder should have images
   - Firestore → `book_pages` collection should have documents

### Test Viewing

```dart
// In your app
final testBookId = 'your_book_id';
final pages = await BookPagesRepository().getBookPages(testBookId);

if (pages.isNotEmpty) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ImagePageViewer(pages: pages),
    ),
  );
}
```

## 💡 Tips

### Image Quality vs Size

Default: 200 DPI (good balance)

**Higher quality** (300 DPI):
```typescript
// In bookImageProcessing.ts
const command = `pdftoppm -png -r 300 "${pdfPath}" "${outputPrefix}"`;
```

**Smaller files** (150 DPI):
```typescript
const command = `pdftoppm -png -r 150 "${pdfPath}" "${outputPrefix}"`;
```

### Performance

- Images are cached automatically
- Use lazy loading for large books
- Preload adjacent pages for smooth experience

## 🆘 Troubleshooting

### "poppler-utils not found"
Install poppler on your server (see Step 3)

### Images not extracting
Check Cloud Function logs:
```bash
firebase functions:log --only processBookWithImages
```

### Timeout errors
- Reduce image resolution (150 DPI)
- Increase function timeout
- Process smaller books first

### Images not loading
- Check Storage permissions
- Verify image URLs in Firestore
- Check user authentication

## 🎓 Next Steps

1. ✅ Complete setup steps above
2. ✅ Test with a small PDF
3. ✅ Upload your books
4. ✅ Enjoy beautiful image-based reading!

**Optional enhancements**:
- Add OCR for text search
- Add reading progress tracking
- Add bookmarks
- Add annotations on images

---

**Questions?** Check `BOOK_IMAGE_UPLOAD_GUIDE.md` for detailed documentation!
