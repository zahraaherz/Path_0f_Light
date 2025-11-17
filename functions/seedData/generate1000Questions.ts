/**
 * Generate 1000 questions from actual book JSON files
 * This script reads OCR-extracted book content and creates questions
 */

import * as fs from "fs";
import * as path from "path";

interface BookParagraph {
  paragraph_id: string;
  book_id: string;
  section_id: string;
  paragraph_number: number;
  content: {
    text_ar: string;
    word_count?: number;
    character_count?: number;
  };
  metadata?: {
    difficulty?: string;
    estimated_page?: number;
  };
}

interface BookData {
  book: {
    id: string;
    title_ar: string;
    title_en: string;
    author_ar: string;
    author_en: string;
  };
  paragraphs: BookParagraph[];
}

interface Question {
  id: string;
  category: string;
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  level_evaluation: "easy" | "medium" | "hard" | "very_hard";
  question_ar: string;
  question_en: string;
  options: {
    A: { text_ar: string; text_en: string };
    B: { text_ar: string; text_en: string };
    C: { text_ar: string; text_en: string };
    D: { text_ar: string; text_en: string };
  };
  correct_answer: "A" | "B" | "C" | "D";
  source: {
    paragraph_id: string;
    book_id: string;
    exact_quote_ar: string;
    page_number: number;
  };
  explanation_ar: string;
  explanation_en: string;
  points: number;
  verified: boolean;
  masoom_tags: string[];
  topic_tags: string[];
}

// Helper function to clean Arabic text
function cleanArabicText(text: string): string {
  return text
    .replace(/[\n\r]+/g, " ")
    .replace(/\s+/g, " ")
    .replace(/[\\|]/g, "")
    .trim();
}

// Helper function to extract first sentence
function extractFirstSentence(text: string): string {
  const cleaned = cleanArabicText(text);
  const match = cleaned.match(/^[^.؟!]+[.؟!]/);
  if (match) {
    return match[0].trim();
  }
  return cleaned.substring(0, Math.min(150, cleaned.length)).trim();
}

// Helper function to determine category from book content
function determineCategory(text: string, bookId: string): string {
  const lowerText = text.toLowerCase();

  if (bookId.includes("manaqib")) {
    if (text.includes("علي") || text.includes("أمير المؤمنين")) return "imam_ali";
    if (text.includes("الحسن")) return "imam_hasan";
    if (text.includes("الحسين")) return "imam_hussain";
    if (text.includes("فاطمة") || text.includes("الزهراء")) return "lady_fatimah";
    return "ahl_al_bayt";
  }

  if (bookId.includes("sira") || bookId.includes("prophet")) {
    if (text.includes("النبي") || text.includes("رسول الله") || text.includes("محمد")) {
      return "prophet_muhammad";
    }
  }

  if (text.includes("غزوة") || text.includes("معركة")) return "battles";
  if (text.includes("القرآن") || text.includes("آية")) return "quran";
  if (text.includes("الهجرة")) return "hijra";
  if (text.includes("مكة")) return "makkah";
  if (text.includes("المدينة")) return "madinah";

  return "islamic_history";
}

// Helper function to determine difficulty
function determineDifficulty(text: string): {
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  level_evaluation: "easy" | "medium" | "hard" | "very_hard";
  points: number;
} {
  const wordCount = text.split(/\s+/).length;

  if (wordCount < 30) {
    return { difficulty: "basic", level_evaluation: "easy", points: 10 };
  } else if (wordCount < 60) {
    return { difficulty: "intermediate", level_evaluation: "medium", points: 15 };
  } else if (wordCount < 100) {
    return { difficulty: "advanced", level_evaluation: "hard", points: 20 };
  } else {
    return { difficulty: "expert", level_evaluation: "very_hard", points: 25 };
  }
}

// Generate question from paragraph
function generateQuestionFromParagraph(
  paragraph: BookParagraph,
  bookData: BookData,
  questionNumber: number
): Question | null {
  const text = paragraph.content.text_ar;

  // Skip if text is too short or looks like formatting/headers
  if (text.length < 50 || text.includes("الطبَحة") || text.includes("ISBN")) {
    return null;
  }

  const cleanedText = cleanArabicText(text);
  const category = determineCategory(cleanedText, bookData.book.id);
  const { difficulty, level_evaluation, points } = determineDifficulty(cleanedText);
  const quote = extractFirstSentence(cleanedText);

  // Determine masoom tags
  const masoomTags: string[] = [];
  if (cleanedText.includes("النبي") || cleanedText.includes("رسول الله") || cleanedText.includes("محمد")) {
    masoomTags.push("prophet_muhammad");
  }
  if (cleanedText.includes("علي") || cleanedText.includes("أمير المؤمنين")) {
    masoomTags.push("imam_ali");
  }
  if (cleanedText.includes("فاطمة") || cleanedText.includes("الزهراء")) {
    masoomTags.push("lady_fatimah");
  }
  if (cleanedText.includes("الحسن")) masoomTags.push("imam_hasan");
  if (cleanedText.includes("الحسين")) masoomTags.push("imam_hussain");

  // Determine topic tags
  const topicTags: string[] = ["seerah", "history"];
  if (cleanedText.includes("غزوة") || cleanedText.includes("معركة")) topicTags.push("battles");
  if (cleanedText.includes("القرآن") || cleanedText.includes("آية")) topicTags.push("quran");
  if (cleanedText.includes("مسجد")) topicTags.push("mosque");
  if (cleanedText.includes("الهجرة")) topicTags.push("hijra");

  const questionId = `q_${String(questionNumber).padStart(4, "0")}`;

  // Create question based on content
  const question: Question = {
    id: questionId,
    category,
    difficulty,
    level_evaluation,
    question_ar: `ماذا ورد في ${bookData.book.title_ar} عن هذا الموضوع؟`,
    question_en: `What is mentioned in ${bookData.book.title_en} about this topic?`,
    options: {
      A: {
        text_ar: quote.substring(0, Math.min(80, quote.length)),
        text_en: "Content from the source (verify translation needed)"
      },
      B: {
        text_ar: "معلومة أخرى غير صحيحة",
        text_en: "Alternative incorrect information"
      },
      C: {
        text_ar: "معلومة أخرى غير صحيحة",
        text_en: "Alternative incorrect information"
      },
      D: {
        text_ar: "معلومة أخرى غير صحيحة",
        text_en: "Alternative incorrect information"
      }
    },
    correct_answer: "A",
    source: {
      paragraph_id: paragraph.paragraph_id,
      book_id: paragraph.book_id,
      exact_quote_ar: quote,
      page_number: paragraph.metadata?.estimated_page || 1
    },
    explanation_ar: `هذه المعلومة وردت في ${bookData.book.title_ar} للمؤلف ${bookData.book.author_ar}`,
    explanation_en: `This information is mentioned in ${bookData.book.title_en} by ${bookData.book.author_en}`,
    points,
    verified: false, // Needs manual review
    masoom_tags: masoomTags,
    topic_tags: topicTags
  };

  return question;
}

// Main function
async function generate1000Questions() {
  console.log("🚀 Generating 1000 questions from book JSON files...\n");

  const bookFiles = [
    "../../book_sira_nabawiya_damoush_vol2_003_ocr.json",
    "../../book_sira_nabawiya_damoush_vol3_004_ocr.json",
    "../../book_manaqib_vol1_012_ocr.json"
  ];

  const allQuestions: Record<string, Question> = {};
  let questionCount = 1;

  for (const bookFile of bookFiles) {
    try {
      const bookPath = path.join(__dirname, bookFile);
      console.log(`📚 Reading: ${bookFile}`);

      if (!fs.existsSync(bookPath)) {
        console.log(`⚠️  File not found: ${bookPath}`);
        continue;
      }

      const fileContent = fs.readFileSync(bookPath, "utf8");
      const bookData: BookData = JSON.parse(fileContent);

      console.log(`   Book: ${bookData.book.title_ar}`);
      console.log(`   Paragraphs: ${bookData.paragraphs?.length || 0}`);

      if (!bookData.paragraphs) {
        console.log(`   ⚠️ No paragraphs found`);
        continue;
      }

      // Generate questions from paragraphs
      for (const paragraph of bookData.paragraphs) {
        if (questionCount > 1000) break;

        const question = generateQuestionFromParagraph(
          paragraph,
          bookData,
          questionCount
        );

        if (question) {
          allQuestions[question.id] = question;
          questionCount++;

          if (questionCount % 100 === 0) {
            console.log(`   ✅ Generated ${questionCount - 1} questions...`);
          }
        }
      }

      console.log(`   ✅ Total generated: ${questionCount - 1}\n`);

      if (questionCount > 1000) break;
    } catch (error) {
      console.error(`❌ Error reading ${bookFile}:`, error);
    }
  }

  // Save to questions.json
  const outputPath = path.join(__dirname, "questions.json");
  const questionsData = {
    questions: allQuestions
  };

  fs.writeFileSync(
    outputPath,
    JSON.stringify(questionsData, null, 2),
    "utf8"
  );

  console.log(`\n✨ Successfully generated ${questionCount - 1} questions!`);
  console.log(`   Saved to: questions.json`);

  // Statistics
  const stats = {
    total: questionCount - 1,
    byDifficulty: {
      basic: 0,
      intermediate: 0,
      advanced: 0,
      expert: 0
    },
    byCategory: {} as Record<string, number>
  };

  Object.values(allQuestions).forEach((q) => {
    stats.byDifficulty[q.difficulty]++;
    stats.byCategory[q.category] = (stats.byCategory[q.category] || 0) + 1;
  });

  console.log("\n📊 Statistics:");
  console.log(`   Total: ${stats.total}`);
  console.log("\n   By Difficulty:");
  console.log(`   - Basic: ${stats.byDifficulty.basic}`);
  console.log(`   - Intermediate: ${stats.byDifficulty.intermediate}`);
  console.log(`   - Advanced: ${stats.byDifficulty.advanced}`);
  console.log(`   - Expert: ${stats.byDifficulty.expert}`);
  console.log("\n   By Category:");
  Object.entries(stats.byCategory).forEach(([cat, count]) => {
    console.log(`   - ${cat}: ${count}`);
  });

  console.log("\n⚠️  IMPORTANT:");
  console.log("   These questions are AUTO-GENERATED and need:");
  console.log("   1. Manual review of question quality");
  console.log("   2. Proper English translations");
  console.log("   3. Creation of plausible wrong options");
  console.log("   4. Scholarly verification");
  console.log("   5. Setting verified=true after review");
}

// Run
generate1000Questions()
  .then(() => {
    console.log("\n🎉 Done!");
    process.exit(0);
  })
  .catch((error) => {
    console.error("\n💥 Error:", error);
    process.exit(1);
  });
