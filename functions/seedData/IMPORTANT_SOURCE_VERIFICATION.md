# IMPORTANT: Source Verification Required

## Current Status

The existing questions in `questions.json` were created as **templates** and **examples**. They reference book sources but these sources need to be **verified against actual book content** exported from Firestore.

## Why This Matters

Islamic knowledge requires authentic sources. Every question must:
1. Come from an actual paragraph in the database
2. Have a verified `paragraph_id` that exists in Firestore
3. Include the exact quote from the source
4. Be reviewed by a scholar for accuracy

## Workflow for Creating Authentic Questions

### Step 1: Export Book Data from Firestore

First, you need to export the actual book data that has been processed and stored in Firestore:

```bash
cd functions/seedData
ts-node exportBooksData.ts
```

This will create:
- `exported_books.json` - List of all books in the database
- `exported_paragraphs.json` - Sample paragraphs with actual content

### Step 2: Review Exported Content

After exporting, you'll have real paragraph content like:

```json
{
  "paragraphs": [
    {
      "id": "book_001_para_0001",
      "book_id": "alsera_alnabaweya",
      "section_id": "section_01",
      "paragraph_number": 1,
      "page_number": 15,
      "content": {
        "text_ar": "وُلد محمد بن عبد الله بن عبد المطلب في مكة المكرمة في عام الفيل...",
        "text_en": "Muhammad son of Abdullah was born in Makkah..."
      },
      "entities": {
        "people": ["محمد", "عبد الله"],
        "places": ["مكة المكرمة"],
        "events": ["عام الفيل"]
      }
    }
  ]
}
```

### Step 3: Generate Questions from Real Content

Use the `generateQuestionsFromBooks.ts` script (to be created) to:
1. Read exported paragraph data
2. Identify key facts and information
3. Generate question templates
4. Map questions to specific paragraph IDs

### Step 4: Scholar Review

**CRITICAL**: All questions must be reviewed by a knowledgeable person to ensure:
- Theological accuracy
- Proper understanding of context
- Correct answers
- Appropriate difficulty levels

### Step 5: Mark as Verified

Only after review, set `verified: true` in the question data.

## Current Questions Status

⚠️ **The existing 20 questions in `questions.json` are TEMPLATES**

They should be considered:
- ✅ Good examples of question format and structure
- ✅ Correct bilingual format (Arabic/English)
- ✅ Proper difficulty distribution
- ⚠️ Need to be mapped to real paragraph_ids from Firestore
- ⚠️ Need source quotes to be verified
- ⚠️ Need scholarly review

## Books Available in Repository

The following PDF books are in the `PathOfLightBooks/` directory:

1. **alsera_alnabaweya.pdf** - السيرة النبوية
2. **prophet_muhammad_1.pdf** - Prophet Muhammad biography
3. **السيرة النبوية برواية أئمة أهل البيت (ع)** - Volumes 02-10
4. **مناقب آل أبي طالب (ع)** - Volumes 01-12

These books need to be:
1. Uploaded to Firebase Storage
2. Processed by the `processUploadedBook` function
3. Extracted into paragraphs in Firestore
4. Exported to JSON for question generation

## Action Required

To create MORE questions with VERIFIED sources:

1. **Upload Books** (if not already done):
   ```bash
   # Upload PDFs to Firebase Storage under islamic_books/
   # They will be automatically processed
   ```

2. **Export Data**:
   ```bash
   cd functions/seedData
   ts-node exportBooksData.ts
   ```

3. **Generate Questions**:
   ```bash
   ts-node generateQuestionsFromBooks.ts
   ```

4. **Review Questions**:
   - Manually review each generated question
   - Verify answers against source text
   - Ensure proper Arabic/English translation
   - Check difficulty levels

5. **Upload to Firestore**:
   ```bash
   ts-node uploadQuestions.ts
   ```

## Never Do This

❌ Don't create questions from memory or general knowledge
❌ Don't make up source references
❌ Don't skip the verification step
❌ Don't set `verified: true` without scholarly review

## Always Do This

✅ Create questions from actual paragraph content in Firestore
✅ Include exact paragraph_id references
✅ Provide exact quotes from source
✅ Get scholarly review before marking as verified
✅ Test questions for clarity and correctness

## For Developers

When adding questions to the system:

1. First check if book data exists:
   ```typescript
   const bookDoc = await db.collection('books').doc(bookId).get();
   const paragraphDoc = await db.collection('paragraphs').doc(paragraphId).get();
   ```

2. Verify the paragraph contains the information:
   ```typescript
   const text = paragraphDoc.data().content.text_ar;
   // Verify the text actually contains the fact in the question
   ```

3. Only then create the question with proper source attribution

## Summary

**Bottom Line**: All questions must come from actual book content stored in Firestore. The current questions are good templates but need to be connected to real sources before being considered authoritative.
