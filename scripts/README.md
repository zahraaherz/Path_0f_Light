# Scripts Directory

Scripts for generating and uploading Quran data to Firestore.

---

## 📁 Files

### 1. `generate_quran_complete.py` (Python)
Fetches complete Quran from Quran.com API and formats for your app.

**Status:** Created but requires API access (use JS version instead)

### 2. `generate_quran_complete.js` (Node.js)
Fetches complete Quran from Al-Quran Cloud API.

**Status:** Created with complete metadata, but API may be unreachable

### 3. `transform_quran.js` (Node.js) ✅ **WORKING**
Transforms downloaded Quran JSON to your app format.

**Status:** ✅ Successfully generated all 6,236 verses!

### 4. `upload_quran_to_firestore.js` (Node.js)
Uploads complete Quran to Firestore database.

**Status:** Ready to use!

---

## 🚀 How to Upload Quran to Firestore

### Step 1: Install Dependencies

```bash
cd /home/user/Path_0f_Light
npm install firebase-admin
```

### Step 2: Get Firebase Service Account Key

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click the **gear icon** ⚙️ → **Project settings**
4. Go to **Service accounts** tab
5. Click **Generate new private key**
6. Save the JSON file as `serviceAccountKey.json` in the `scripts/` directory

```
Path_0f_Light/
└── scripts/
    ├── serviceAccountKey.json  ← Place here
    └── upload_quran_to_firestore.js
```

### Step 3: Run the Upload Script

```bash
cd /home/user/Path_0f_Light
node scripts/upload_quran_to_firestore.js
```

**This will upload:**
- ✅ 1 book (Quran metadata)
- ✅ 114 sections (all Surahs)
- ✅ 6,236 paragraphs (all verses)

**Upload time:** ~2-5 minutes depending on internet speed

---

## 📊 What Gets Uploaded

### Collection: `books`
**Document:** `quran_001`
```json
{
  "title_ar": "القرآن الكريم",
  "title_en": "The Holy Quran",
  "total_sections": 114,
  "total_paragraphs": 6236,
  "content_status": "published"
}
```

### Collection: `sections`
**114 documents** (one per Surah)
```json
{
  "id": "quran_001_surah_001",
  "title_ar": "الفاتحة",
  "title_en": "Al-Fatiha",
  "paragraph_count": 7,
  "revelation_place": "Makkah"
}
```

### Collection: `paragraphs`
**6,236 documents** (one per verse)
```json
{
  "id": "quran_para_001_001_001",
  "content": {
    "text_ar": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
    "text_en": "In the name of Allah, the Entirely Merciful..."
  },
  "search_data": {
    "keywords_ar": ["بسم", "الله", "الرحمن", "الرحيم"],
    "keywords_en": ["Allah", "Merciful", "name"]
  }
}
```

---

## ⚠️ Important Notes

### Firestore Security Rules

Before uploading, make sure your Firestore rules allow writes:

```javascript
// Firestore rules (temporary for upload)
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow admin writes for upload
    match /{document=**} {
      allow read: if true;
      allow write: if true; // Change this after upload!
    }
  }
}
```

**⚠️ After upload, update rules to secure your database!**

### Upload Monitoring

Watch the upload progress in Firebase Console:
1. Go to **Firestore Database**
2. You'll see collections being created:
   - `books` (1 document)
   - `sections` (114 documents)
   - `paragraphs` (6,236 documents)

### If Upload Fails

**Error: "Service account key not found"**
- Make sure `serviceAccountKey.json` exists in `scripts/` directory
- Verify the file is valid JSON

**Error: "Permission denied"**
- Check Firestore security rules
- Ensure service account has admin permissions

**Error: "Network timeout"**
- Check internet connection
- Try running again (script is idempotent)

---

## ✅ After Upload

Once uploaded successfully, your app will:

1. ✅ Show Quran in library automatically
2. ✅ Allow reading all 114 Surahs
3. ✅ Enable search across 6,236 verses
4. ✅ Support bookmarking verses
5. ✅ Track reading progress
6. ✅ Display table of contents
7. ✅ Allow comments on verses

**No app code changes needed!** Everything works automatically with the existing book reader.

---

## 🔧 Troubleshooting

### Check if data uploaded correctly

```javascript
// Test in Firebase Console > Firestore
// Or use this Node.js script:

const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

async function test() {
  const book = await db.collection('books').doc('quran_001').get();
  console.log('Quran book:', book.data());

  const sections = await db.collection('sections').where('book_id', '==', 'quran_001').limit(5).get();
  console.log(`Found ${sections.size} sections (first 5)`);

  const paragraphs = await db.collection('paragraphs').where('book_id', '==', 'quran_001').limit(5).get();
  console.log(`Found ${paragraphs.size} verses (first 5)`);
}

test();
```

### Delete uploaded data (if needed)

```bash
# Use Firebase Console:
# 1. Go to Firestore Database
# 2. Select collection (books/sections/paragraphs)
# 3. Click delete collection

# Or use firebase-tools CLI:
firebase firestore:delete --all-collections
```

---

## 📞 Need Help?

1. **Check the logs:** Upload script shows detailed progress
2. **Verify files exist:** Make sure JSON files are in `assets/quran/`
3. **Test connection:** Try reading from Firestore first
4. **Check quotas:** Firebase free tier has limits (check usage in console)

---

## 🎉 Success!

After successful upload, open your app and:

1. Navigate to **Library**
2. See **القرآن الكريم** (The Holy Quran)
3. Tap to start reading
4. Enjoy the beautiful reading experience!

**The complete Quran is now ready in your app!** 📖✨
