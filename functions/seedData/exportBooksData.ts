/**
 * Script to export books, sections, and paragraphs from Firestore to JSON
 * This allows us to create questions from actual book content
 *
 * Usage:
 * ts-node exportBooksData.ts
 */

import * as admin from "firebase-admin";
import * as fs from "fs";
import * as path from "path";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
  });
}

const db = admin.firestore();

interface Book {
  id: string;
  title_ar: string;
  title_en: string;
  author_ar: string;
  author_en: string;
  total_sections?: number;
  total_paragraphs?: number;
  language: string;
}

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

async function exportBooksData() {
  try {
    console.log("🚀 Starting books data export...");

    // Export Books
    console.log("\n📚 Fetching books...");
    const booksSnapshot = await db.collection("books").get();
    const books: Book[] = [];

    booksSnapshot.forEach((doc) => {
      books.push({
        id: doc.id,
        ...doc.data(),
      } as Book);
    });

    console.log(`✅ Found ${books.length} books`);

    // Export Paragraphs (with a limit to avoid huge files)
    console.log("\n📄 Fetching paragraphs (max 200)...");
    const paragraphsSnapshot = await db
      .collection("paragraphs")
      .limit(200)
      .get();

    const paragraphs: Paragraph[] = [];

    paragraphsSnapshot.forEach((doc) => {
      paragraphs.push({
        id: doc.id,
        ...doc.data(),
      } as Paragraph);
    });

    console.log(`✅ Found ${paragraphs.length} paragraphs`);

    // Save to JSON files
    const outputDir = path.join(__dirname);

    const booksData = {
      exported_at: new Date().toISOString(),
      total_books: books.length,
      books: books,
    };

    const paragraphsData = {
      exported_at: new Date().toISOString(),
      total_paragraphs: paragraphs.length,
      paragraphs: paragraphs,
    };

    fs.writeFileSync(
      path.join(outputDir, "exported_books.json"),
      JSON.stringify(booksData, null, 2),
      "utf8"
    );

    fs.writeFileSync(
      path.join(outputDir, "exported_paragraphs.json"),
      JSON.stringify(paragraphsData, null, 2),
      "utf8"
    );

    console.log("\n✨ Export completed successfully!");
    console.log(`   Books saved to: exported_books.json`);
    console.log(`   Paragraphs saved to: exported_paragraphs.json`);

    // Show statistics
    console.log("\n📊 Export Statistics:");
    console.log(`   Total Books: ${books.length}`);
    console.log(`   Total Paragraphs: ${paragraphs.length}`);

    if (books.length > 0) {
      console.log("\n📚 Books exported:");
      books.forEach((book) => {
        console.log(`   - ${book.title_ar} (${book.title_en})`);
        console.log(`     Author: ${book.author_ar}`);
        console.log(
          `     Paragraphs: ${book.total_paragraphs || 0}`
        );
      });
    }

    if (paragraphs.length > 0) {
      console.log("\n📄 Sample paragraphs:");
      paragraphs.slice(0, 3).forEach((para) => {
        console.log(`   - ${para.content.text_ar.substring(0, 100)}...`);
        console.log(`     (Page ${para.page_number})`);
      });
    }

    return {books, paragraphs};
  } catch (error) {
    console.error("❌ Error exporting books data:", error);
    throw error;
  }
}

// Run the export
exportBooksData()
  .then(() => {
    console.log("\n🎉 Export completed!");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Export failed:", error);
    process.exit(1);
  });
