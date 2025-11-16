# Quran JSON Files for Firestore

This directory contains the Quran structured according to your app's book format (Book → Sections → Paragraphs).

## 📁 Files Created

### 1. `quran_book.json`
- **Collection**: `books`
- **Document ID**: `quran_001`
- Contains Quran metadata (title, author, totals, etc.)

### 2. `quran_sections.json` (Sample)
- **Collection**: `sections`
- Contains metadata for all 114 Surahs
- Each Surah is a section with:
  - Surah name (Arabic & English)
  - Verse count
  - Revelation place (Makkah/Madinah)
  - Topics
  - Page range

### 3. `quran_paragraphs_sample.json` (Complete Surah Al-Fatiha + Surah Al-Ikhlas)
- **Collection**: `paragraphs`
- Each verse is a paragraph
- Includes:
  - Arabic text
  - English translation
  - Keywords for search
  - Metadata (difficulty, reading time, etc.)

---

## 📖 Data Structure

```
books/quran_001
  ├─ title_ar: "القرآن الكريم"
  ├─ title_en: "The Holy Quran"
  ├─ total_sections: 114
  └─ total_paragraphs: 6236

sections/quran_001_surah_001
  ├─ title_ar: "الفاتحة"
  ├─ title_en: "Al-Fatiha"
  ├─ paragraph_count: 7
  └─ revelation_place: "Makkah"

paragraphs/quran_para_001_001_001
  ├─ content.text_ar: "بِسْمِ اللَّهِ..."
  ├─ content.text_en: "In the name of Allah..."
  ├─ section_title_ar: "الفاتحة"
  └─ metadata: {...}
```

---

## 🔗 Get Complete Quran Data

To get all 6,236 verses, use one of these verified sources:

### **Option 1: Quran.com API** (Recommended)
```bash
# Get all verses with translations
https://api.quran.com/api/v4/verses/by_chapter/1?language=en&words=false&translations=131

# Chapter info
https://api.quran.com/api/v4/chapters

# Verse by verse
https://api.quran.com/api/v4/quran/verses/uthmani
```

### **Option 2: tanzil.net**
- Download complete Quran XML/JSON
- URL: http://tanzil.net/download/
- Choose "Simple Enhanced" or "Simple Clean"
- Includes Arabic text without tashkeel

### **Option 3: GitHub Repositories**
```bash
# Complete Quran JSON
https://github.com/risan/quran-json

# Quran with translations
https://github.com/spa5k/quran-api

# Al-Quran Cloud
https://github.com/islamic-network/alquran-api
```

---

## 📤 Upload to Firestore

### **Step 1: Install Firebase CLI**
```bash
npm install -g firebase-tools
firebase login
```

### **Step 2: Create Upload Script**

Create `scripts/upload_quran.js`:

```javascript
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// Upload book
async function uploadBook() {
  const book = require('../assets/quran/quran_book.json');
  await db.collection('books').doc(book.id).set(book);
  console.log('✅ Book uploaded');
}

// Upload sections
async function uploadSections() {
  const sections = require('../assets/quran/quran_sections.json');
  const batch = db.batch();

  sections.forEach(section => {
    const ref = db.collection('sections').doc(section.id);
    batch.set(ref, section);
  });

  await batch.commit();
  console.log('✅ Sections uploaded');
}

// Upload paragraphs (verses)
async function uploadParagraphs() {
  const paragraphs = require('../assets/quran/quran_paragraphs_complete.json');

  // Batch in chunks of 500
  const chunks = [];
  for (let i = 0; i < paragraphs.length; i += 500) {
    chunks.push(paragraphs.slice(i, i + 500));
  }

  for (const chunk of chunks) {
    const batch = db.batch();
    chunk.forEach(para => {
      const ref = db.collection('paragraphs').doc(para.id);
      batch.set(ref, para);
    });
    await batch.commit();
    console.log(`✅ Uploaded ${chunk.length} verses`);
  }
}

// Run all
async function uploadAll() {
  await uploadBook();
  await uploadSections();
  await uploadParagraphs();
  console.log('🎉 Quran upload complete!');
}

uploadAll();
```

### **Step 3: Run Upload**
```bash
node scripts/upload_quran.js
```

---

## 🔍 Using in the App

Once uploaded, the Quran will work automatically with:

✅ **Book Library** - Shows in library list
✅ **Book Reader** - Full reading experience with Arabic typography
✅ **Search** - Search verses by keyword (Arabic/English)
✅ **Bookmarks** - Save favorite verses
✅ **Reading Progress** - Track what you've read
✅ **Comments** - Comment on verses
✅ **Quiz Integration** - Link questions to verses

---

## 📝 Complete Surah List Needed

You need to complete `quran_sections.json` with all 114 Surahs. Here's the format:

```json
{
  "id": "quran_001_surah_XXX",
  "book_id": "quran_001",
  "section_number": XXX,
  "title_ar": "السورة",
  "title_en": "Surah Name",
  "paragraph_count": YYY,
  "page_range": "XX-YY",
  "revelation_place": "Makkah" or "Madinah",
  "difficulty_level": "basic" / "intermediate" / "advanced"
}
```

I've included samples for Surahs 1-7, 112-114. You need to add 8-111.

---

## 📊 Surah Statistics

| Surah # | Name | Verses | Pages |
|---------|------|--------|-------|
| 1 | Al-Fatiha | 7 | 1 |
| 2 | Al-Baqarah | 286 | 48 |
| 3 | Ali 'Imran | 200 | 27 |
| ... | ... | ... | ... |
| 114 | An-Nas | 6 | 1 |

**Total: 6,236 verses across 604 pages**

---

## 🎯 Next Steps

1. ✅ Book metadata created
2. ⏳ Complete all 114 sections (use API or dataset)
3. ⏳ Generate all 6,236 paragraphs (use API or dataset)
4. ⏳ Upload to Firestore
5. ✅ App will automatically display Quran in library!

---

## 🔐 Translation Sources

For English translations, consider:
- **Sahih International** (Clear, modern English)
- **Yusuf Ali** (Classic, poetic)
- **Pickthall** (Traditional)
- **Shakir** (Scholarly)

For Shia-specific translations:
- **Mir Ahmed Ali** (with Shia commentary)
- **S.V. Mir Ahmed Ali** (Shia perspective)

---

## 📞 Need Help?

When ready to populate complete data:
1. Choose a source (Quran.com API recommended)
2. Write a script to fetch and format
3. Upload to Firestore
4. Test in the app

The structure is ready - just need to fill in all verses! 📖✨
