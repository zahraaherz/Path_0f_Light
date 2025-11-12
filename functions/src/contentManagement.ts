import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Content Management Functions
 * For inserting and managing books, sections, paragraphs, and questions
 */

/**
 * Interface for book data
 */
interface BookData {
  title_ar: string;
  title_en: string;
  author_ar: string;
  author_en: string;
  total_sections?: number;
  total_paragraphs?: number;
  language: string;
  pdf_url?: string;
  version: string;
  verified_by?: string;
  content_status: "draft" | "verified" | "published";
  created_at: admin.firestore.Timestamp;
  updated_at: admin.firestore.Timestamp;
}

/**
 * Interface for section data
 */
interface SectionData {
  book_id: string;
  book_title_ar: string;
  book_title_en?: string;
  section_number: number;
  title_ar: string;
  title_en: string;
  paragraph_count?: number;
  page_range?: string;
  difficulty_level: "basic" | "intermediate" | "advanced" | "expert";
  topics: string[];
  created_at: admin.firestore.Timestamp;
}

/**
 * Interface for paragraph data
 */
interface ParagraphData {
  book_id: string;
  section_id: string;
  section_title_ar: string;
  section_title_en?: string;
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
  search_data?: {
    keywords_ar: string[];
    keywords_en?: string[];
  };
  references?: {
    referenced_in_questions?: string[];
    related_paragraphs?: string[];
  };
  metadata?: {
    difficulty: "basic" | "intermediate" | "advanced" | "expert";
    reading_time_seconds?: number;
    question_potential?: {
      facts_count: number;
      can_generate_questions: boolean;
    };
    content_priority?: "high" | "medium" | "low";
  };
  created_at: admin.firestore.Timestamp;
}

/**
 * Interface for question data
 */
interface QuestionData {
  category: string;
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  question_ar: string;
  question_en: string;
  options: {
    A: {text_ar: string; text_en: string};
    B: {text_ar: string; text_en: string};
    C: {text_ar: string; text_en: string};
    D: {text_ar: string; text_en: string};
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
  created_at: admin.firestore.Timestamp;
}

/**
 * HTTP function to insert a new book
 * Requires admin authentication
 */
export const insertBook = functions.https.onCall(async (data, context) => {
  // Check authentication
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  // TODO: Add admin role check
  // if (!context.auth.token.admin) {
  //   throw new functions.https.HttpsError(
  //     "permission-denied",
  //     "Only admins can insert books"
  //   );
  // }

  const {
    title_ar,
    title_en,
    author_ar,
    author_en,
    language,
    pdf_url,
    version = "1.0",
  } = data;

  // Validate required fields
  if (!title_ar || !title_en || !author_ar || !author_en || !language) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: title_ar, title_en, author_ar, author_en, language"
    );
  }

  try {
    const now = admin.firestore.Timestamp.now();

    const bookData: BookData = {
      title_ar,
      title_en,
      author_ar,
      author_en,
      language,
      pdf_url: pdf_url || null,
      version,
      content_status: "draft",
      total_sections: 0,
      total_paragraphs: 0,
      verified_by: context.auth.uid,
      created_at: now,
      updated_at: now,
    };

    const bookRef = await db.collection("books").add(bookData);

    return {
      success: true,
      bookId: bookRef.id,
      message: "Book inserted successfully",
      book: bookData,
    };
  } catch (error) {
    console.error("Error in insertBook:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to insert book"
    );
  }
});

/**
 * HTTP function to insert a section
 */
export const insertSection = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {
    book_id,
    section_number,
    title_ar,
    title_en,
    page_range,
    difficulty_level = "basic",
    topics = [],
  } = data;

  // Validate required fields
  if (!book_id || !section_number || !title_ar || !title_en) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: book_id, section_number, title_ar, title_en"
    );
  }

  try {
    // Verify book exists
    const bookDoc = await db.collection("books").doc(book_id).get();

    if (!bookDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Book not found");
    }

    const bookData = bookDoc.data() as BookData;
    const now = admin.firestore.Timestamp.now();

    const sectionData: SectionData = {
      book_id,
      book_title_ar: bookData.title_ar,
      book_title_en: bookData.title_en,
      section_number,
      title_ar,
      title_en,
      page_range,
      difficulty_level,
      topics,
      paragraph_count: 0,
      created_at: now,
    };

    const sectionRef = await db.collection("sections").add(sectionData);

    // Update book section count
    await db.collection("books").doc(book_id).update({
      total_sections: admin.firestore.FieldValue.increment(1),
      updated_at: now,
    });

    return {
      success: true,
      sectionId: sectionRef.id,
      message: "Section inserted successfully",
      section: sectionData,
    };
  } catch (error) {
    console.error("Error in insertSection:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to insert section"
    );
  }
});

/**
 * HTTP function to insert a paragraph
 */
export const insertParagraph = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {
      book_id,
      section_id,
      paragraph_number,
      page_number,
      text_ar,
      text_en,
      entities,
      keywords_ar,
      keywords_en,
      difficulty = "basic",
      content_priority = "medium",
    } = data;

    // Validate required fields
    if (
      !book_id ||
      !section_id ||
      !paragraph_number ||
      !page_number ||
      !text_ar
    ) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing required fields"
      );
    }

    try {
      // Verify section exists
      const sectionDoc = await db.collection("sections").doc(section_id).get();

      if (!sectionDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Section not found");
      }

      const sectionData = sectionDoc.data() as SectionData;
      const now = admin.firestore.Timestamp.now();

      const paragraphData: ParagraphData = {
        book_id,
        section_id,
        section_title_ar: sectionData.title_ar,
        section_title_en: sectionData.title_en,
        paragraph_number,
        page_number,
        content: {
          text_ar,
          text_en: text_en || null,
        },
        entities: entities || {
          people: [],
          places: [],
          events: [],
          dates: [],
        },
        search_data: {
          keywords_ar: keywords_ar || [],
          keywords_en: keywords_en || [],
        },
        references: {
          referenced_in_questions: [],
          related_paragraphs: [],
        },
        metadata: {
          difficulty,
          reading_time_seconds: Math.ceil(text_ar.split(" ").length / 3),
          question_potential: {
            facts_count: 0,
            can_generate_questions: false,
          },
          content_priority,
        },
        created_at: now,
      };

      const paragraphRef = await db
        .collection("paragraphs")
        .add(paragraphData);

      // Update counts
      const batch = db.batch();
      batch.update(db.collection("sections").doc(section_id), {
        paragraph_count: admin.firestore.FieldValue.increment(1),
      });
      batch.update(db.collection("books").doc(book_id), {
        total_paragraphs: admin.firestore.FieldValue.increment(1),
        updated_at: now,
      });
      await batch.commit();

      return {
        success: true,
        paragraphId: paragraphRef.id,
        message: "Paragraph inserted successfully",
      };
    } catch (error) {
      console.error("Error in insertParagraph:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to insert paragraph"
      );
    }
  }
);

/**
 * HTTP function to bulk insert paragraphs
 * More efficient for large book uploads
 */
export const bulkInsertParagraphs = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {book_id, section_id, paragraphs} = data;

    if (!book_id || !section_id || !paragraphs || !Array.isArray(paragraphs)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "book_id, section_id, and paragraphs array are required"
      );
    }

    try {
      // Verify section exists
      const sectionDoc = await db.collection("sections").doc(section_id).get();

      if (!sectionDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Section not found");
      }

      const sectionData = sectionDoc.data() as SectionData;
      const now = admin.firestore.Timestamp.now();
      const batch = db.batch();
      let count = 0;

      for (const para of paragraphs) {
        const paragraphData: ParagraphData = {
          book_id,
          section_id,
          section_title_ar: sectionData.title_ar,
          section_title_en: sectionData.title_en,
          paragraph_number: para.paragraph_number,
          page_number: para.page_number,
          content: {
            text_ar: para.text_ar,
            text_en: para.text_en || null,
          },
          entities: para.entities || {},
          search_data: para.search_data || {},
          references: {
            referenced_in_questions: [],
            related_paragraphs: [],
          },
          metadata: para.metadata || {
            difficulty: "basic",
            content_priority: "medium",
          },
          created_at: now,
        };

        const newParagraphRef = db.collection("paragraphs").doc();
        batch.set(newParagraphRef, paragraphData);
        count++;

        // Firestore batch limit is 500 operations
        if (count >= 450) {
          break;
        }
      }

      // Update counts
      batch.update(db.collection("sections").doc(section_id), {
        paragraph_count: admin.firestore.FieldValue.increment(count),
      });
      batch.update(db.collection("books").doc(book_id), {
        total_paragraphs: admin.firestore.FieldValue.increment(count),
        updated_at: now,
      });

      await batch.commit();

      return {
        success: true,
        paragraphsInserted: count,
        message: `${count} paragraphs inserted successfully`,
      };
    } catch (error) {
      console.error("Error in bulkInsertParagraphs:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to bulk insert paragraphs"
      );
    }
  }
);

/**
 * HTTP function to insert a question
 */
export const insertQuestion = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {
    category,
    difficulty,
    question_ar,
    question_en,
    options,
    correct_answer,
    source,
    explanation_ar,
    explanation_en,
  } = data;

  // Validate required fields
  if (
    !category ||
    !difficulty ||
    !question_ar ||
    !question_en ||
    !options ||
    !correct_answer ||
    !source ||
    !explanation_ar ||
    !explanation_en
  ) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields"
    );
  }

  // Validate options structure
  if (!options.A || !options.B || !options.C || !options.D) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "All options (A, B, C, D) must be provided"
    );
  }

  // Validate correct answer
  if (!["A", "B", "C", "D"].includes(correct_answer)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Correct answer must be A, B, C, or D"
    );
  }

  try {
    // Verify paragraph exists
    if (source.paragraph_id) {
      const paragraphDoc = await db
        .collection("paragraphs")
        .doc(source.paragraph_id)
        .get();

      if (!paragraphDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Source paragraph not found"
        );
      }
    }

    const now = admin.firestore.Timestamp.now();

    // Calculate points based on difficulty
    const pointsMap = {
      basic: 10,
      intermediate: 15,
      advanced: 20,
      expert: 25,
    };

    const questionData: QuestionData = {
      category,
      difficulty,
      question_ar,
      question_en,
      options,
      correct_answer,
      source,
      explanation_ar,
      explanation_en,
      points: pointsMap[difficulty as keyof typeof pointsMap],
      verified: false,
      created_at: now,
    };

    const questionRef = await db.collection("questions").add(questionData);

    // Update paragraph to reference this question
    if (source.paragraph_id) {
      await db
        .collection("paragraphs")
        .doc(source.paragraph_id)
        .update({
          "references.referenced_in_questions":
            admin.firestore.FieldValue.arrayUnion(questionRef.id),
        });
    }

    return {
      success: true,
      questionId: questionRef.id,
      message: "Question inserted successfully",
    };
  } catch (error) {
    console.error("Error in insertQuestion:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to insert question"
    );
  }
});

/**
 * HTTP function to bulk insert questions
 */
export const bulkInsertQuestions = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {questions} = data;

    if (!questions || !Array.isArray(questions)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "questions array is required"
      );
    }

    try {
      const now = admin.firestore.Timestamp.now();
      const batch = db.batch();
      const pointsMap = {
        basic: 10,
        intermediate: 15,
        advanced: 20,
        expert: 25,
      };

      let count = 0;

      for (const q of questions) {
        const questionData: QuestionData = {
          category: q.category,
          difficulty: q.difficulty,
          question_ar: q.question_ar,
          question_en: q.question_en,
          options: q.options,
          correct_answer: q.correct_answer,
          source: q.source,
          explanation_ar: q.explanation_ar,
          explanation_en: q.explanation_en,
          points: pointsMap[q.difficulty as keyof typeof pointsMap],
          verified: false,
          created_at: now,
        };

        const newQuestionRef = db.collection("questions").doc();
        batch.set(newQuestionRef, questionData);
        count++;

        // Firestore batch limit is 500
        if (count >= 450) {
          break;
        }
      }

      await batch.commit();

      return {
        success: true,
        questionsInserted: count,
        message: `${count} questions inserted successfully`,
      };
    } catch (error) {
      console.error("Error in bulkInsertQuestions:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to bulk insert questions"
      );
    }
  }
);

/**
 * HTTP function to verify content (mark as verified)
 */
export const verifyContent = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  // TODO: Add scholar/admin role check

  const {contentType, contentId} = data;

  if (!contentType || !contentId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "contentType and contentId are required"
    );
  }

  try {
    const now = admin.firestore.Timestamp.now();

    if (contentType === "book") {
      await db.collection("books").doc(contentId).update({
        content_status: "verified",
        verified_by: context.auth.uid,
        updated_at: now,
      });
    } else if (contentType === "question") {
      await db.collection("questions").doc(contentId).update({
        verified: true,
        verified_by: context.auth.uid,
        verified_at: now,
      });
    } else {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "contentType must be 'book' or 'question'"
      );
    }

    return {
      success: true,
      message: `${contentType} verified successfully`,
    };
  } catch (error) {
    console.error("Error in verifyContent:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to verify content"
    );
  }
});

/**
 * HTTP function to publish a book (make it available to users)
 */
export const publishBook = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {bookId} = data;

  if (!bookId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "bookId is required"
    );
  }

  try {
    const bookDoc = await db.collection("books").doc(bookId).get();

    if (!bookDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Book not found");
    }

    const bookData = bookDoc.data() as BookData;

    // Check if book has been verified
    if (bookData.content_status !== "verified") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Book must be verified before publishing"
      );
    }

    await db.collection("books").doc(bookId).update({
      content_status: "published",
      published_at: admin.firestore.Timestamp.now(),
      published_by: context.auth.uid,
      updated_at: admin.firestore.Timestamp.now(),
    });

    return {
      success: true,
      message: "Book published successfully",
    };
  } catch (error) {
    console.error("Error in publishBook:", error);
    throw new functions.https.HttpsError("internal", "Failed to publish book");
  }
});

/**
 * HTTP function to search books
 */
export const searchBooks = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {searchTerm, language = "en", status = "published", limit = 20} = data;

  try {
    let query = db.collection("books").where("content_status", "==", status);

    if (searchTerm) {
      // Simple search - for better search, use Algolia or similar
      const titleField = language === "ar" ? "title_ar" : "title_en";
      query = query
        .where(titleField, ">=", searchTerm)
        .where(titleField, "<=", searchTerm + "\uf8ff");
    }

    const snapshot = await query.limit(limit).get();

    const books = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      success: true,
      books,
      count: books.length,
    };
  } catch (error) {
    console.error("Error in searchBooks:", error);
    throw new functions.https.HttpsError("internal", "Failed to search books");
  }
});

/**
 * HTTP function to get book details with sections
 */
export const getBookDetails = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {bookId} = data;

  if (!bookId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "bookId is required"
    );
  }

  try {
    const bookDoc = await db.collection("books").doc(bookId).get();

    if (!bookDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Book not found");
    }

    // Get sections for this book
    const sectionsSnapshot = await db
      .collection("sections")
      .where("book_id", "==", bookId)
      .orderBy("section_number", "asc")
      .get();

    const sections = sectionsSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      success: true,
      book: {
        id: bookDoc.id,
        ...bookDoc.data(),
      },
      sections,
    };
  } catch (error) {
    console.error("Error in getBookDetails:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to get book details"
    );
  }
});
