# Questions Seed Data

⚠️ **IMPORTANT**: Read `IMPORTANT_SOURCE_VERIFICATION.md` for critical information about question authenticity and source verification.

This directory contains seed data for the quiz questions system in the Path of Light app.

## 🔴 Source Verification Requirement

**All questions MUST come from actual book content stored in Firestore.**

Before adding questions:
1. Export book data: `ts-node exportBooksData.ts`
2. Generate templates: `ts-node generateQuestionsFromBooks.ts`
3. Create questions from real paragraph content
4. Get scholarly verification
5. Upload: `ts-node uploadQuestions.ts`

See the [Workflow for Creating Authentic Questions](#workflow-for-creating-authentic-questions) section below.

## Overview

The questions are stored in Firestore and cover various Islamic topics including:
- Prophet Muhammad (pbuh) and his life
- The 14 Masoomeen (Infallibles)
- Islamic history and battles
- Quran and its teachings
- Fiqh and Islamic jurisprudence

## Question Structure

Each question follows this comprehensive structure:

```json
{
  "id": "q_001",
  "category": "prophet_muhammad",
  "difficulty": "basic",
  "level_evaluation": "easy",
  "question_ar": "Arabic question text",
  "question_en": "English question text",
  "options": {
    "A": {
      "text_ar": "Arabic option A",
      "text_en": "English option A"
    },
    "B": {
      "text_ar": "Arabic option B",
      "text_en": "English option B"
    },
    "C": {
      "text_ar": "Arabic option C",
      "text_en": "English option C"
    },
    "D": {
      "text_ar": "Arabic option D",
      "text_en": "English option D"
    }
  },
  "correct_answer": "A",
  "source": {
    "paragraph_id": "para_001",
    "book_id": "book_001",
    "exact_quote_ar": "Exact Arabic quote from the source",
    "page_number": 15
  },
  "explanation_ar": "Arabic explanation of the answer",
  "explanation_en": "English explanation of the answer",
  "points": 10,
  "verified": true,
  "masoom_tags": ["prophet_muhammad"],
  "topic_tags": ["seerah", "history"]
}
```

## Difficulty Levels

Questions are categorized by difficulty with corresponding points:

- **Basic** (easy): 10 points - Simple questions about well-known facts
- **Intermediate** (medium): 15 points - Requires moderate knowledge
- **Advanced** (hard): 20 points - Requires detailed knowledge
- **Expert** (very_hard): 25 points - Requires deep scholarly knowledge

## Categories

Questions are organized into the following categories:

- `prophet_muhammad` - Life and teachings of Prophet Muhammad (pbuh)
- `imam_ali` - First Imam, Ali ibn Abi Talib (as)
- `imam_hasan` - Second Imam, Hasan al-Mujtaba (as)
- `imam_hussain` - Third Imam, Hussain ibn Ali (as)
- `imam_sajjad` - Fourth Imam, Ali Zayn al-Abidin (as)
- `imam_sadiq` - Sixth Imam, Ja'far al-Sadiq (as)
- `imam_kadhim` - Seventh Imam, Musa al-Kadhim (as)
- `imam_mahdi` - Twelfth Imam, Muhammad al-Mahdi (aj)
- `lady_fatimah` - Lady Fatimah al-Zahra (as)
- `lady_khadijah` - Lady Khadijah (as)
- `islamic_history` - General Islamic history
- `quran` - Quranic knowledge
- `ghadir` - Event of Ghadir Khumm
- `battles` - Islamic battles and conquests
- `hajj` - Pilgrimage and related topics

## Topic Tags

Questions can have multiple topic tags for better organization:

- `seerah` - Biography of the Prophet (pbuh)
- `history` - Historical events
- `masoomeen` - Related to the 14 Infallibles
- `family` - Family relationships
- `hadith` - Prophetic traditions
- `quran` - Quranic verses and interpretation
- `battles` - Military expeditions
- `wilayah` - Succession and leadership
- `beliefs` - Islamic beliefs and theology
- `ahl_al_bayt` - Family of the Prophet
- `karbala` - Event of Karbala
- `ashura` - Day of Ashura
- `ghadir` - Event of Ghadir
- `literature` - Islamic literature
- `nahjul_balagha` - Nahj al-Balagha
- `knowledge` - Islamic knowledge and sciences
- `supplications` - Du'as and prayers
- `martyrdom` - Shahadat and martyrs
- `oppression` - Historical oppression
- `early_islam` - Early Islamic period
- `basics` - Basic Islamic knowledge
- `fiqh` - Islamic jurisprudence

## Level Evaluation

The `level_evaluation` field provides an additional assessment of difficulty:

- `easy` - Simple questions suitable for beginners
- `medium` - Moderate difficulty
- `hard` - Challenging questions
- `very_hard` - Expert-level questions

This complements the `difficulty` field and can be used for additional filtering.

## Masoom Tags

Questions can be tagged with one or more Masoomeen they relate to:

- `prophet_muhammad`
- `imam_ali`
- `imam_hasan`
- `imam_hussain`
- `imam_sajjad`
- `imam_baqir`
- `imam_sadiq`
- `imam_kadhim`
- `imam_ridha`
- `imam_taqi`
- `imam_naqi`
- `imam_askari`
- `imam_mahdi`
- `lady_fatimah`
- `lady_khadijah`

## Source Attribution

Every question includes source information linking back to the books:

- `book_id`: The ID of the source book
- `paragraph_id`: The specific paragraph in the book
- `exact_quote_ar`: The exact Arabic quote from the source
- `page_number`: Page number in the source book

This ensures all questions are verifiable and traced back to authentic sources.

## Bilingual Support

All questions, options, and explanations are provided in both Arabic and English:

- Questions: `question_ar` and `question_en`
- Options: Each option has `text_ar` and `text_en`
- Explanations: `explanation_ar` and `explanation_en`
- Sources: Currently Arabic quotes (`exact_quote_ar`)

## Workflow for Creating Authentic Questions

### Step 1: Ensure Books are Processed

Make sure the PDF books in `PathOfLightBooks/` directory have been:
1. Uploaded to Firebase Storage under `islamic_books/`
2. Automatically processed by the `processUploadedBook` Cloud Function
3. Extracted into paragraphs in Firestore

Check Firestore collections:
- `books` - Should contain book metadata
- `sections` - Should contain book sections
- `paragraphs` - Should contain extracted paragraphs

### Step 2: Export Book Data

Export the processed book data from Firestore to JSON files:

```bash
cd functions/seedData
ts-node exportBooksData.ts
```

This creates:
- `exported_books.json` - All books with metadata
- `exported_paragraphs.json` - Sample paragraphs (max 200)

### Step 3: Generate Question Templates

Generate templates from actual paragraph content:

```bash
ts-node generateQuestionsFromBooks.ts
```

This analyzes paragraphs and creates:
- `question_templates.json` - Templates with detected facts and suggestions

### Step 4: Create Questions Manually

Open `question_templates.json` and for each template:

1. Read the actual paragraph content
2. Identify a clear fact or concept
3. Create a question testing that knowledge
4. Generate 4 options (1 correct, 3 plausible incorrect)
5. Write explanations in Arabic and English
6. Extract the exact quote supporting the answer

Example workflow:
```typescript
// Template shows:
{
  "paragraph": {
    "id": "alsera_001_para_0015",
    "book_id": "alsera_alnabaweya",
    "page_number": 15,
    "content": {
      "text_ar": "وُلد محمد بن عبد الله في مكة المكرمة في عام الفيل..."
    }
  },
  "detectedFacts": ["People: محمد، عبد الله", "Places: مكة", "Events: عام الفيل"]
}

// You create:
{
  "id": "q_021",
  "category": "prophet_muhammad",
  "difficulty": "basic",
  "level_evaluation": "easy",
  "question_ar": "في أي عام وُلد النبي محمد (ص)؟",
  "question_en": "In which year was Prophet Muhammad (pbuh) born?",
  "options": {...},
  "correct_answer": "A",
  "source": {
    "paragraph_id": "alsera_001_para_0015",
    "book_id": "alsera_alnabaweya",
    "exact_quote_ar": "وُلد محمد بن عبد الله في مكة المكرمة في عام الفيل",
    "page_number": 15
  },
  ...
}
```

### Step 5: Validate Questions

Before uploading, validate each question:

1. ✅ Paragraph ID exists in Firestore
2. ✅ Exact quote matches paragraph content
3. ✅ Page number is correct
4. ✅ Arabic and English translations are accurate
5. ✅ Correct answer is actually correct
6. ✅ Wrong options are plausible but incorrect
7. ✅ Difficulty level is appropriate

### Step 6: Scholarly Review

**CRITICAL**: Have questions reviewed by someone knowledgeable in:
- Islamic history and theology
- Arabic language
- The specific subject matter

Only set `verified: true` after review.

### Step 7: Add to questions.json

Add your new questions to `questions.json`, following the existing format.

### Step 8: Upload to Firestore

```bash
ts-node uploadQuestions.ts
```

## Uploading Questions to Firestore

### Prerequisites

1. Firebase Admin SDK configured
2. Service account credentials (if not using default)
3. Node.js installed

### Upload Steps

#### Option 1: Using JavaScript

```bash
cd functions/seedData
node uploadQuestions.js
```

#### Option 2: Using TypeScript

```bash
cd functions/seedData
ts-node uploadQuestions.ts
```

### What the Upload Script Does

1. Reads all questions from `questions.json`
2. Uploads each question to the `questions` collection in Firestore
3. Adds `created_at` and `updated_at` timestamps
4. Provides statistics about uploaded questions

### Expected Output

```
🚀 Starting questions upload...
📚 Found 20 questions to upload
✅ Uploaded question 1/20: q_001
✅ Uploaded question 2/20: q_002
...
✅ Successfully uploaded 20 questions!

📊 Upload Statistics:
   Total Questions: 20

   By Difficulty:
   - Basic: 5
   - Intermediate: 6
   - Advanced: 5
   - Expert: 4

   By Category:
   - prophet_muhammad: 5
   - imam_ali: 3
   - imam_hussain: 1
   ...

✨ Upload completed successfully!
🎉 All done!
```

## Adding New Questions

To add new questions:

1. Open `questions.json`
2. Add a new question object with a unique ID (e.g., `q_021`)
3. Follow the structure outlined above
4. Ensure all required fields are present:
   - Bilingual question and options
   - Correct answer (A, B, C, or D)
   - Source information
   - Bilingual explanations
   - Appropriate category and difficulty
   - Verification status
   - Points (based on difficulty)
5. Run the upload script to sync with Firestore

## Question Types

While the current implementation uses multiple-choice questions (A, B, C, D), the structure supports:

- **Multiple Choice**: Single correct answer from 4 options
- **Source-Based**: Questions with citations to specific books and pages
- **Tagged Questions**: Questions tagged by Masoom and topics for filtered quizzes

Future question types could include:
- True/False
- Fill in the blank
- Matching
- Ordering

## Verification

All questions should have `verified: true` only after:

1. Content accuracy is confirmed
2. Source citations are verified
3. Arabic and English translations are correct
4. Answers are validated by scholars

## Best Practices

1. **Accuracy**: Ensure all information is accurate and from authentic sources
2. **Sources**: Always provide source attribution with exact quotes
3. **Balance**: Maintain a good distribution across difficulty levels
4. **Variety**: Cover diverse topics and categories
5. **Quality**: Focus on educational value and clarity
6. **Bilingual**: Always provide both Arabic and English versions
7. **Verification**: Have questions reviewed by knowledgeable individuals
8. **Tags**: Use appropriate masoom_tags and topic_tags for better organization

## Current Statistics

- Total Questions: 20
- Categories: 13 unique categories
- Difficulty Distribution:
  - Basic: 5 questions (25%)
  - Intermediate: 6 questions (30%)
  - Advanced: 5 questions (25%)
  - Expert: 4 questions (20%)

## Integration with App

These questions integrate with:

- `lib/models/quiz/quiz_models.dart` - Quiz data models
- `lib/repositories/quiz_repository.dart` - Quiz repository
- `functions/src/quizManagement.ts` - Backend quiz functions

## Future Enhancements

1. Add more questions from the books in `PathOfLightBooks/`
2. Create questions for each of the 14 Masoomeen
3. Add questions about Fiqh and Islamic jurisprudence
4. Include questions about Quranic interpretation
5. Create difficulty-progressive question sets
6. Add image-based questions
7. Create category-specific quizzes
8. Implement adaptive difficulty based on user performance

## Contributing

When contributing new questions:

1. Ensure the question is educational and beneficial
2. Provide authentic source references
3. Include both Arabic and English versions
4. Set appropriate difficulty and category
5. Add relevant tags for filtering
6. Test the question format before uploading

## Support

For questions or issues with the question system:

1. Check the Firebase console for question data
2. Review the quiz management functions
3. Test questions using the app's quiz interface
4. Verify source book availability in `PathOfLightBooks/`
