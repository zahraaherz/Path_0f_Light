# Books Import Guide for Path of Light

This guide explains how to import Islamic books metadata into Firebase Firestore for the Path of Light application.

## 📚 Overview

The project includes 20 Islamic books in PDF format located in the `PathOfLightBooks/` directory:
- **السيرة النبوية** (Prophet's Biography) - Various volumes
- **مناقب آل أبي طالب** (Virtues of the Family of Abu Talib) - Various volumes

## 📁 Files Created

1. **firebase_books_import.json** - Contains metadata for all 20 books in Firebase-ready JSON format
2. **import_books_to_firebase.js** - Node.js script to import the data into Firestore
3. **BOOKS_IMPORT_GUIDE.md** - This guide

## 🚀 Quick Start

### Option 1: Using the Import Script (Recommended)

1. **Install dependencies** (if not already installed):
   ```bash
   cd functions
   npm install
   ```

2. **Set up Firebase credentials**:
   - If running locally, make sure you have Firebase Admin SDK credentials
   - Download your service account key from Firebase Console → Project Settings → Service Accounts
   - Set the environment variable:
     ```bash
     export GOOGLE_APPLICATION_CREDENTIALS="path/to/serviceAccountKey.json"
     ```

3. **Run the import script**:
   ```bash
   node import_books_to_firebase.js
   ```

4. **Verify the import**:
   - Open Firebase Console
   - Navigate to Firestore Database
   - Check the `books` collection

### Option 2: Manual Import via Firebase Console

1. Open Firebase Console
2. Go to Firestore Database
3. Click "Import"
4. Select `firebase_books_import.json`
5. Choose the `books` collection as the target

### Option 3: Using Firebase CLI

```bash
# Install Firebase CLI if needed
npm install -g firebase-tools

# Login to Firebase
firebase login

# Import the data
firebase firestore:import firebase_books_import.json
```

## 📖 JSON Data Structure

Each book entry contains:

```json
{
  "id": "unique_book_id",
  "title_ar": "العنوان بالعربية",
  "title_en": "Title in English",
  "author_ar": "المؤلف بالعربية",
  "author_en": "Author in English",
  "total_sections": 0,
  "total_paragraphs": 0,
  "language": "ar",
  "pdf_url": "",
  "original_filename": "file.pdf",
  "storage_path": "islamic_books/file.pdf",
  "version": "1.0",
  "content_status": "draft",
  "description": "وصف الكتاب",
  "topics": ["topic1", "topic2"],
  "processing_status": "pending",
  "volume_number": 1,
  "series": "series_name"
}
```

## 📤 Uploading PDF Files

After importing the metadata, you need to upload the PDF files:

### Using Firebase Console:

1. Go to Firebase Console → Storage
2. Create folder: `islamic_books/`
3. Upload all PDF files from `PathOfLightBooks/` directory
4. The files should match the `original_filename` in the JSON

### Using Firebase CLI:

```bash
# Upload all books at once
cd PathOfLightBooks
for file in *.pdf; do
  firebase storage:upload "$file" "islamic_books/$file"
done
```

### Using gsutil (Google Cloud SDK):

```bash
# Copy all PDFs to Firebase Storage
gsutil -m cp PathOfLightBooks/*.pdf gs://YOUR_PROJECT_ID.appspot.com/islamic_books/
```

## 🔄 Automatic Processing

Once PDFs are uploaded, the Cloud Function `processUploadedBook` will automatically:

1. Detect new PDF uploads in `islamic_books/` folder
2. Extract text from the PDF
3. Split content into sections and paragraphs
4. Update book metadata with:
   - Total pages
   - Total sections
   - Total paragraphs
   - Word count
   - Character count
5. Store processed content in Firestore

## ✅ Verification Steps

After import and upload:

1. **Check Firestore**:
   ```javascript
   // In Firebase Console or using the Admin SDK
   db.collection('books').get()
   ```

2. **Verify PDF URLs**:
   - Each book should have a `pdf_url` field populated after upload

3. **Check Processing Status**:
   - Books should have `processing_status: "completed"` after processing
   - Check `total_sections` and `total_paragraphs` are populated

4. **Test in App**:
   - Open the Path of Light app
   - Navigate to Library section
   - Verify books are displayed correctly

## 📊 Book Collections Included

### Series 1: السيرة النبوية برواية أئمة أهل البيت
**Author**: الشيخ علي دعموش العاملي (Sheikh Ali Damoush)
- Volumes: 2, 3, 4, 5, 6, 7, 8, 9, 10
- Series ID: `sira_nabawiya_damoush`

### Series 2: مناقب آل أبي طالب
**Author**: محمد بن علي إبن شهرآشوب المازندراني (Ibn Shahrashub)
- Volumes: 1, 2, 3, 4, 6, 8, 9, 11, 12
- Series ID: `manaqib_aal_abi_talib`

### Individual Books:
- alsera_alnabaweya.pdf
- prophet_muhammad_1.pdf

## 🛠️ Troubleshooting

### Issue: Import Script Fails

**Solution**: Check Firebase credentials
```bash
# Verify authentication
firebase projects:list
```

### Issue: PDF Processing Fails

**Solution**: Check Cloud Function logs
```bash
firebase functions:log --only processUploadedBook
```

### Issue: Books Not Showing in App

**Possible causes**:
1. Firestore security rules blocking read access
2. Book `content_status` is not "published"
3. App not refreshing data

**Solution**: Update book status
```javascript
db.collection('books').doc('book_id').update({
  content_status: 'published'
});
```

## 🔐 Security Considerations

Before deploying to production:

1. **Update Firestore Rules**:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /books/{bookId} {
         allow read: if request.auth != null;
         allow write: if request.auth != null &&
                         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
       }
     }
   }
   ```

2. **Storage Rules**:
   ```javascript
   rules_version = '2';
   service firebase.storage {
     match /b/{bucket}/o {
       match /islamic_books/{filename} {
         allow read: if request.auth != null;
         allow write: if request.auth != null &&
                         request.auth.token.role == 'admin';
       }
     }
   }
   ```

## 📝 Next Steps

1. ✅ Import book metadata → `node import_books_to_firebase.js`
2. ✅ Upload PDF files to Storage
3. ✅ Wait for automatic processing
4. ✅ Update security rules
5. ✅ Test in the application
6. ✅ Publish books by updating `content_status` to "published"

## 🤝 Support

For issues or questions:
- Check Firebase Console logs
- Review Cloud Function logs
- Verify Firestore data structure matches the Book model in `lib/models/library/book.dart`

---

**Created for Path of Light - Islamic Learning Application**
