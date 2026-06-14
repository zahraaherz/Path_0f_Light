
# Book Upload System with Image Storage

This guide explains how to upload books with **page images** (not just text) to your app.

## 🎯 What This System Does

When you upload a book PDF:
1. ✅ Extracts each page as a **high-quality image**
2. ✅ Uploads images to Firebase Storage
3. ✅ Stores image URLs in Firestore for each page
4. ✅ Optionally extracts text via OCR
5. ✅ Creates beautiful image-based reading experience

## 📋 Prerequisites

### 1. Install System Dependencies

On your server (where Cloud Functions run), install:

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install poppler-utils

# macOS
brew install poppler

# The poppler-utils package includes pdftoppm which converts PDFs to images
```

### 2. Add Firebase Functions Dependencies

```bash
cd functions
npm install @google-cloud/storage
```

### 3. Add Flutter Dependencies

Add to your `pubspec.yaml`:

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

### 4. Run Build Runner

Generate the Freezed code for the new BookPage model:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🚀 How to Use

### Option 1: Admin Upload UI (Recommended)

1. **Navigate to the upload screen** in your app:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const BookUploadScreen(),
  ),
);
```

2. **Fill in the book details**:
   - Title (Arabic & English)
   - Author (Arabic & English)
   - Description
   - Topics
   - Volume number & series

3. **Select files**:
   - Click "Select File" to choose the PDF
   - Optionally add a cover image

4. **Upload**:
   - Click "Upload Book"
   - Wait for processing (shows progress bar)

5. **Automatic Processing**:
   - Cloud Function automatically triggers
   - Extracts all pages as images
   - Uploads to Storage: `book_pages/{bookId}/page_0001.png`, `page_0002.png`, etc.
   - Creates Firestore documents in `book_pages` collection

### Option 2: Manual Upload via Firebase Console

1. **Upload PDF to Storage**:
   - Go to Firebase Console → Storage
   - Upload PDF to `islamic_books/` folder

2. **Create book metadata**:
   - Go to Firestore → `books` collection
   - Add document with fields:
     ```json
     {
       "id": "unique_book_id",
       "title_ar": "العنوان",
       "title_en": "Title",
       "author_ar": "المؤلف",
       "author_en": "Author",
       "original_filename": "book.pdf",
       "storage_path": "islamic_books/book.pdf",
       "processing_status": "pending"
     }
     ```

3. **Processing happens automatically** via Cloud Function

### Option 3: Script Upload

Use the existing script and then process images:

```bash
# 1. Run the import script
node import_books_to_firebase.js

# 2. Upload PDFs to Storage
firebase storage:upload path/to/book.pdf islamic_books/book.pdf

# 3. Images are automatically extracted by Cloud Function
```

## 📊 Database Structure

### Books Collection (`books`)

```typescript
{
  id: "book_001",
  title_ar: "السيرة النبوية",
  title_en: "The Prophet's Biography",
  author_ar: "المؤلف",
  author_en: "Author",
  
  // Files
  pdf_url: "https://...",
  cover_image_url: "https://...",
  storage_path: "islamic_books/book_001.pdf",
  
  // Processing
  processing_status: "completed",  // pending | extracting_images | completed | error
  has_page_images: true,
  total_pages: 250,
  
  // Content
  total_sections: 15,
  total_paragraphs: 500,
  
  // Metadata
  language: "ar",
  topics: ["Seerah", "History"],
  volume_number: 1,
  series: "sira_nabawiya"
}
```

### Book Pages Collection (`book_pages`)

```typescript
{
  page_id: "book_001_page_0001",
  book_id: "book_001",
  page_number: 1,
  
  // Image
  image_url: "https://storage.googleapis.com/.../page_0001.png",
  storage_path: "book_pages/book_001/page_0001.png",
  
  // Optional OCR text
  text_content: "Extracted text from this page...",
  word_count: 250,
  character_count: 1500,
  has_ocr: true,
  
  created_at: Timestamp
}
```

## 🖼️ Storage Structure

```
Firebase Storage:
├── islamic_books/
│   ├── book_001.pdf
│   ├── book_002.pdf
│   └── book_003.pdf
│
├── book_covers/
│   ├── book_001.jpg
│   ├── book_002.jpg
│   └── book_003.jpg
│
└── book_pages/
    ├── book_001/
    │   ├── page_0001.png  (200 DPI)
    │   ├── page_0002.png
    │   ├── page_0003.png
    │   └── ...
    │
    └── book_002/
        ├── page_0001.png
        └── ...
```

## 📖 Displaying Book Pages in Your App

### Example 1: Simple Page Viewer

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/library/book_page.dart';
import '../repositories/book_pages_repository.dart';
import '../widgets/reading/image_page_viewer.dart';

class BookImageReaderScreen extends ConsumerWidget {
  final String bookId;

  const BookImageReaderScreen({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<BookPage>>(
      future: BookPagesRepository().getBookPages(bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final pages = snapshot.data ?? [];

        if (pages.isEmpty) {
          return const Center(child: Text('No pages available'));
        }

        return ImagePageViewer(
          pages: pages,
          initialPage: 0,
          showPageNumber: true,
          showText: true, // Show OCR text if available
        );
      },
    );
  }
}
```

### Example 2: With Reading Progress

```dart
class BookReaderWithProgress extends ConsumerStatefulWidget {
  final String bookId;
  
  const BookReaderWithProgress({super.key, required this.bookId});
  
  @override
  ConsumerState<BookReaderWithProgress> createState() => 
      _BookReaderWithProgressState();
}

class _BookReaderWithProgressState 
    extends ConsumerState<BookReaderWithProgress> {
  
  int _currentPage = 0;
  
  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    
    // Save reading progress to Firestore
    FirebaseFirestore.instance
        .collection('reading_progress')
        .doc('${widget.bookId}_${userId}')
        .set({
      'book_id': widget.bookId,
      'current_page': page,
      'last_read': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookPage>>(
      future: BookPagesRepository().getBookPages(widget.bookId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        
        return ImagePageViewer(
          pages: snapshot.data!,
          initialPage: _currentPage,
          onPageChanged: _onPageChanged,
        );
      },
    );
  }
}
```

## ⚙️ Cloud Function Configuration

The Cloud Functions are configured in `functions/src/bookImageProcessing.ts`.

### Key Settings:

```typescript
setGlobalOptions({
  maxInstances: 5,          // Max parallel processing
  timeoutSeconds: 540,      // 9 minutes (max for Cloud Functions)
  memory: '4GiB',           // High memory for image processing
  region: 'us-central1',    // Your region
});
```

### Image Quality Settings:

In the `extractPageImages()` function:

```typescript
// Current: 200 DPI (good balance of quality/size)
const command = `pdftoppm -png -r 200 "${pdfPath}" "${outputPrefix}"`;

// For higher quality (larger files):
// const command = `pdftoppm -png -r 300 "${pdfPath}" "${outputPrefix}"`;

// For smaller files (lower quality):
// const command = `pdftoppm -png -r 150 "${pdfPath}" "${outputPrefix}"`;
```

## 🔧 Deployment

### Deploy Cloud Functions

```bash
cd functions
npm run build
firebase deploy --only functions
```

### Deploy Firestore Security Rules

Update your `firestore.rules`:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Books
    match /books/{bookId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
    
    // Book Pages
    match /book_pages/{pageId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
    
    function isAdmin() {
      return request.auth != null && 
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

### Deploy Storage Rules

Update your `storage.rules`:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    
    // Book PDFs
    match /islamic_books/{filename} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
    
    // Book page images
    match /book_pages/{bookId}/{pageImage} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
    
    // Book covers
    match /book_covers/{coverImage} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
    
    function isAdmin() {
      return request.auth != null && 
             firestore.get(/databases/(default)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

## 💰 Cost Considerations

### Storage Costs

- **PDF storage**: ~10-50 MB per book
- **Page images** (200 DPI PNG): ~300-500 KB per page
- **Example**: 400-page book = ~150 MB of images

### Processing Costs

- **Cloud Functions**: ~$0.40 per GB-second
- **Processing time**: ~30-60 seconds per 100 pages
- **Example**: 400-page book ≈ 2-3 minutes ≈ $0.05-0.10

### Storage Pricing (Firebase)

- First 5 GB: Free
- After: $0.026/GB/month
- **Example**: 20 books (400 pages each) ≈ 3 GB ≈ **FREE**

## 🚀 Performance Tips

### 1. Lazy Loading

Don't load all pages at once:

```dart
// Load pages in chunks
Future<List<BookPage>> loadPageChunk(int startPage, int endPage) {
  return BookPagesRepository().getPageRange(bookId, startPage, endPage);
}
```

### 2. Caching

Use `cached_network_image` (already included):

```dart
CachedNetworkImage(
  imageUrl: page.imageUrl,
  cacheKey: 'page_${page.pageId}',
  maxHeightDiskCache: 2000,
)
```

### 3. Preloading

Preload adjacent pages:

```dart
void preloadAdjacentPages(int currentPage) {
  final nextPage = pages[currentPage + 1];
  final prevPage = pages[currentPage - 1];
  
  precacheImage(CachedNetworkImageProvider(nextPage.imageUrl), context);
  precacheImage(CachedNetworkImageProvider(prevPage.imageUrl), context);
}
```

## 🐛 Troubleshooting

### Images Not Extracting

**Check Cloud Function logs:**
```bash
firebase functions:log --only processBookWithImages
```

**Common issues:**
- `pdftoppm not found`: Install poppler-utils on the server
- `Timeout`: Increase function timeout or reduce image resolution
- `Out of memory`: Increase function memory allocation

### Images Not Loading

**Check:**
1. Storage URLs are public or user has read permission
2. Image URLs in Firestore are correct
3. Network connectivity

### Slow Performance

**Solutions:**
- Reduce image DPI (150 instead of 200)
- Enable image caching
- Use CDN (Firebase Storage uses Google CDN automatically)
- Lazy load pages

## 📚 Complete Workflow Example

```dart
// 1. Admin uploads book
await Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => BookUploadScreen()),
);

// 2. Cloud Function processes automatically
// - Extracts pages as images
// - Uploads to Storage
// - Creates Firestore documents

// 3. User reads book with images
final pages = await BookPagesRepository().getBookPages(bookId);

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ImagePageViewer(
      pages: pages,
      initialPage: 0,
    ),
  ),
);

// 4. Beautiful reading experience with:
// - Pinch to zoom
// - Swipe to change pages
// - Page grid navigator
// - Reading progress tracking
```

## ✨ What You Get

✅ **Page Images**: Original book pages as high-quality images  
✅ **Zoom & Pan**: Smooth image viewing with gestures  
✅ **Fast Loading**: Cached images for instant access  
✅ **Page Navigator**: Quick jump to any page  
✅ **Reading Progress**: Track where users left off  
✅ **OCR Ready**: Can add text extraction later  
✅ **Offline Support**: Images cached on device  

---

**Need help?** Check the Cloud Function logs or open an issue!
