/**
 * Script to generate quiz questions from exported book data
 * This ensures all questions come from actual Firestore content
 *
 * Usage:
 * 1. First run: ts-node exportBooksData.ts
 * 2. Then run: ts-node generateQuestionsFromBooks.ts
 */

import * as fs from "fs";
import * as path from "path";

interface Paragraph {
  id: string;
  book_id: string;
  section_id: string;
  section_title_ar: string;
  paragraph_number: number;
  page_number: number;
  content: {
    text_ar: string;
    text_en?: string;
  };
  entities?: {
    people?: string[];
    places?: string[];
    events?: string[];
    dates?: string[];
  };
  metadata?: {
    difficulty?: string;
  };
}

interface Book {
  id: string;
  title_ar: string;
  title_en: string;
  author_ar: string;
  author_en: string;
}

interface QuestionTemplate {
  paragraph: Paragraph;
  book: Book;
  suggestedQuestion: string;
  suggestedOptions: string[];
  detectedFacts: string[];
}

function loadExportedData(): {
  books: Book[];
  paragraphs: Paragraph[];
} {
  try {
    const booksPath = path.join(__dirname, "exported_books.json");
    const paragraphsPath = path.join(__dirname, "exported_paragraphs.json");

    if (!fs.existsSync(booksPath) || !fs.existsSync(paragraphsPath)) {
      throw new Error(
        "Exported data not found. Please run exportBooksData.ts first."
      );
    }

    const booksData = JSON.parse(fs.readFileSync(booksPath, "utf8"));
    const paragraphsData = JSON.parse(
      fs.readFileSync(paragraphsPath, "utf8")
    );

    return {
      books: booksData.books,
      paragraphs: paragraphsData.paragraphs,
    };
  } catch (error) {
    console.error("❌ Error loading exported data:", error);
    throw error;
  }
}

function analyzeFactsInParagraph(paragraph: Paragraph): string[] {
  const facts: string[] = [];
  const content = paragraph.content.text_ar;

  // Check for entities that can become questions
  if (paragraph.entities) {
    if (paragraph.entities.people && paragraph.entities.people.length > 0) {
      facts.push(`People mentioned: ${paragraph.entities.people.join(", ")}`);
    }
    if (paragraph.entities.places && paragraph.entities.places.length > 0) {
      facts.push(`Places mentioned: ${paragraph.entities.places.join(", ")}`);
    }
    if (paragraph.entities.events && paragraph.entities.events.length > 0) {
      facts.push(`Events mentioned: ${paragraph.entities.events.join(", ")}`);
    }
    if (paragraph.entities.dates && paragraph.entities.dates.length > 0) {
      facts.push(`Dates mentioned: ${paragraph.entities.dates.length(", ")}`);
    }
  }

  // Check for common question indicators in Arabic text
  const indicators = [
    /ولد في/,
    /توفي في/,
    /كان في/,
    /حدث في/,
    /قال/,
    /روى/,
    /من أهم/,
    /الأول/,
    /الثاني/,
    /عدد/,
  ];

  indicators.forEach((pattern) => {
    if (pattern.test(content)) {
      facts.push(`Pattern detected: ${pattern.source}`);
    }
  });

  return facts;
}

function generateQuestionTemplate(
  paragraph: Paragraph,
  book: Book
): QuestionTemplate | null {
  const facts = analyzeFactsInParagraph(paragraph);

  if (facts.length === 0) {
    return null; // Not enough information to create a question
  }

  // Create a template that needs to be filled in manually
  const template: QuestionTemplate = {
    paragraph,
    book,
    detectedFacts: facts,
    suggestedQuestion:
      `[FILL IN] Create a question based on: ${paragraph.content.text_ar.substring(0, 100)}...`,
    suggestedOptions: [
      "[FILL IN] Correct answer based on paragraph",
      "[FILL IN] Plausible wrong answer 1",
      "[FILL IN] Plausible wrong answer 2",
      "[FILL IN] Plausible wrong answer 3",
    ],
  };

  return template;
}

function generateQuestions() {
  console.log("🚀 Starting question generation from book data...\n");

  const {books, paragraphs} = loadExportedData();

  console.log(`📚 Loaded ${books.length} books`);
  console.log(`📄 Loaded ${paragraphs.length} paragraphs\n`);

  if (paragraphs.length === 0) {
    console.log(
      "⚠️  No paragraphs found. Please ensure books are processed in Firestore."
    );
    return;
  }

  // Create a map of books for easy lookup
  const booksMap = new Map(books.map((book) => [book.id, book]));

  // Generate templates for each paragraph
  const templates: QuestionTemplate[] = [];

  paragraphs.forEach((paragraph, index) => {
    const book = booksMap.get(paragraph.book_id);
    if (!book) {
      console.log(
        `⚠️  Book not found for paragraph ${paragraph.id}`
      );
      return;
    }

    const template = generateQuestionTemplate(paragraph, book);
    if (template) {
      templates.push(template);
      console.log(
        `✅ Generated template ${templates.length} from paragraph ${paragraph.id}`
      );
    }
  });

  console.log(`\n📊 Generated ${templates.length} question templates\n`);

  // Save templates to file
  const outputPath = path.join(__dirname, "question_templates.json");
  fs.writeFileSync(
    outputPath,
    JSON.stringify({generated_at: new Date().toISOString(), templates}, null, 2),
    "utf8"
  );

  console.log(`💾 Saved templates to: question_templates.json\n`);

  // Show some examples
  console.log("📝 Sample Templates:\n");
  templates.slice(0, 3).forEach((template, index) => {
    console.log(`Template ${index + 1}:`);
    console.log(`  Book: ${template.book.title_ar}`);
    console.log(`  Paragraph ID: ${template.paragraph.id}`);
    console.log(`  Page: ${template.paragraph.page_number}`);
    console.log(`  Facts detected: ${template.detectedFacts.length}`);
    console.log(
      `  Content preview: ${template.paragraph.content.text_ar.substring(0, 80)}...`
    );
    console.log();
  });

  console.log("\n⚠️  IMPORTANT NEXT STEPS:");
  console.log(
    "1. Review each template in question_templates.json"
  );
  console.log(
    "2. Manually create questions based on the actual paragraph content"
  );
  console.log("3. Ensure questions are accurate and verified");
  console.log(
    "4. Add questions to questions.json with proper format"
  );
  console.log("5. Have questions reviewed by a scholar");
  console.log("6. Upload to Firestore using uploadQuestions.ts\n");
}

// Run the generation
try {
  generateQuestions();
  console.log("✨ Question template generation completed!");
} catch (error) {
  console.error("💥 Generation failed:", error);
  console.log("\n📝 Note: You need to run exportBooksData.ts first!");
  process.exit(1);
}
