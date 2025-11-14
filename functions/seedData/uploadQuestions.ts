/**
 * Script to upload questions from questions.json to Firestore
 *
 * Usage:
 * 1. Make sure you have Firebase Admin SDK initialized
 * 2. Run: ts-node uploadQuestions.ts
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

interface Question {
  id: string;
  category: string;
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  level_evaluation: string;
  question_ar: string;
  question_en: string;
  options: {
    A: { text_ar: string; text_en: string };
    B: { text_ar: string; text_en: string };
    C: { text_ar: string; text_en: string };
    D: { text_ar: string; text_en: string };
  };
  correct_answer: string;
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
  masoom_tags?: string[];
  topic_tags?: string[];
}

async function uploadQuestions() {
  try {
    console.log("🚀 Starting questions upload...");

    // Read questions file
    const questionsPath = path.join(__dirname, "questions.json");
    const questionsData = JSON.parse(fs.readFileSync(questionsPath, "utf8"));

    const questions = questionsData.questions;
    const questionIds = Object.keys(questions);

    console.log(`📚 Found ${questionIds.length} questions to upload`);

    // Upload each question
    const batch = db.batch();
    let count = 0;

    for (const questionId of questionIds) {
      const question = questions[questionId] as Question;
      const questionRef = db.collection("questions").doc(questionId);

      // Add timestamp
      const questionWithTimestamp = {
        ...question,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      };

      batch.set(questionRef, questionWithTimestamp);
      count++;

      // Firestore batch limit is 500 operations
      if (count % 500 === 0) {
        await batch.commit();
        console.log(`✅ Uploaded ${count} questions...`);
      }
    }

    // Commit remaining operations
    if (count % 500 !== 0) {
      await batch.commit();
    }

    console.log(`✅ Successfully uploaded ${count} questions!`);

    // Generate statistics
    const stats = {
      total: count,
      byDifficulty: {
        basic: 0,
        intermediate: 0,
        advanced: 0,
        expert: 0,
      },
      byCategory: {} as Record<string, number>,
    };

    questionIds.forEach((id) => {
      const q = questions[id] as Question;
      stats.byDifficulty[q.difficulty]++;
      stats.byCategory[q.category] = (stats.byCategory[q.category] || 0) + 1;
    });

    console.log("\n📊 Upload Statistics:");
    console.log(`   Total Questions: ${stats.total}`);
    console.log("\n   By Difficulty:");
    console.log(`   - Basic: ${stats.byDifficulty.basic}`);
    console.log(`   - Intermediate: ${stats.byDifficulty.intermediate}`);
    console.log(`   - Advanced: ${stats.byDifficulty.advanced}`);
    console.log(`   - Expert: ${stats.byDifficulty.expert}`);
    console.log("\n   By Category:");
    Object.entries(stats.byCategory).forEach(([category, count]) => {
      console.log(`   - ${category}: ${count}`);
    });

    console.log("\n✨ Upload completed successfully!");
  } catch (error) {
    console.error("❌ Error uploading questions:", error);
    throw error;
  }
}

// Run the upload
uploadQuestions()
  .then(() => {
    console.log("🎉 All done!");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Upload failed:", error);
    process.exit(1);
  });
