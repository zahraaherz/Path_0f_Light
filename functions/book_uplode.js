const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {setGlobalOptions} = require("firebase-functions/v2/options");
const admin = require("firebase-admin");
const pdf = require("pdf-parse");

// Set global options for all functions
setGlobalOptions({
  maxInstances: 10,
  timeoutSeconds: 540,
  memory: "2GiB",
  region: "us-central1",
});

// ============================================================================
// FUNCTION 1: Automatic Text Extraction when PDF is uploaded
// ============================================================================
exports.processUploadedBook = onObjectFinalized(async (event) => {
  const object = event.data;
  const filePath = object.name;
  const fileName = filePath.split("/").pop();

  console.log("Checking uploaded file:", filePath);

  // Only process PDFs in islamic_books folder
  if (!filePath.startsWith("islamic_books/") || !fileName.endsWith(".pdf")) {
    console.log("Skipping file - not an Islamic book PDF");
    return null;
  }

  console.log("Processing Islamic book PDF:", fileName);

  try {
    // Find the book record in Firestore
    const bookRecord = await findBookByFilename(fileName);
    if (!bookRecord) {
      console.error("Book record not found for:", fileName);
      return null;
    }

    const bookId = bookRecord.id;
    const bookData = bookRecord.data();
    console.log("Found book record:", bookId);

    // Update status to processing
    await admin.firestore().collection("books").doc(bookId).update({
      processing_status: "extracting_text",
      processing_started: admin.firestore.FieldValue.serverTimestamp(),
      last_update: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log("Downloading PDF from storage...");
    // Download PDF from Firebase Storage
    const bucket = admin.storage().bucket();
    const file = bucket.file(filePath);
    const [buffer] = await file.download();

    const sizeInMB = (buffer.length / 1024 / 1024).toFixed(2);
    console.log(`PDF downloaded successfully. Size: ${sizeInMB} MB`);

    // Extract text from PDF
    console.log("Extracting text from PDF...");
    const pdfData = await pdf(buffer, {
      normalizeWhitespace: true,
      disableCombineTextItems: false,
    });

    const extractedText = pdfData.text;
    const totalPages = pdfData.numpages;
    const pdfInfo = pdfData.info;

    console.log(`Text extraction completed:`);
    console.log(`   Pages: ${totalPages}`);
    console.log(`   Characters: ${extractedText.length.toLocaleString()}`);
    console.log(`   Words: ${extractedText.split(/\s+/).length.toLocaleString()}`);

    // Process text into sections and paragraphs
    const processingResult = await processBookContent(
        extractedText,
        bookId,
        bookData,
        totalPages,
    );

    // Update book record with final results
    await admin.firestore().collection("books").doc(bookId).update({
      processing_status: "completed",
      total_pages: totalPages,
      total_sections: processingResult.totalSections,
      total_paragraphs: processingResult.totalParagraphs,
      total_characters: extractedText.length,
      total_words: extractedText.split(/\s+/).length,

      // PDF metadata
      pdf_metadata: {
        title: pdfInfo.Title || "",
        author: pdfInfo.Author || "",
        creator: pdfInfo.Creator || "",
        creation_date: pdfInfo.CreationDate || null,
      },

      processing_completed: admin.firestore.FieldValue.serverTimestamp(),
      last_update: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log("Book processing completed successfully!");
    console.log(`   Sections created: ${processingResult.totalSections}`);
    console.log(`   Paragraphs created: ${processingResult.totalParagraphs}`);

    return {
      success: true,
      bookId: bookId,
      totalPages: totalPages,
      totalSections: processingResult.totalSections,
      totalParagraphs: processingResult.totalParagraphs,
    };
  } catch (error) {
    console.error("Error processing book:", error);

    // Update book with error status
    try {
      const bookRecord = await findBookByFilename(fileName);
      if (bookRecord) {
        await admin.firestore().collection("books").doc(bookRecord.id).update({
          processing_status: "error",
          error_message: error.message,
          error_timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    } catch (updateError) {
      console.error("Failed to update error status:", updateError);
    }

    throw error;
  }
});

// ============================================================================
// FUNCTION 2: Manual trigger for processing specific book
// ============================================================================
exports.processBookManually = onCall(async (request) => {
  const {bookId} = request.data;

  console.log("Manual processing requested for book:", bookId);

  if (!bookId) {
    throw new HttpsError("invalid-argument", "Book ID is required");
  }

  try {
    // Get book record
    const bookDoc = await admin.firestore().collection("books").doc(bookId).get();
    if (!bookDoc.exists) {
      throw new HttpsError("not-found", "Book not found");
    }

    const bookData = bookDoc.data();
    const downloadURL = bookData.download_url;

    if (!downloadURL) {
      throw new HttpsError("failed-precondition", "Book has no download URL");
    }

    console.log("Downloading PDF from URL...");
    // Download PDF
    const response = await fetch(downloadURL);
    const buffer = Buffer.from(await response.arrayBuffer());

    // Extract and process (same logic as automatic function)
    const pdfData = await pdf(buffer);
    const processingResult = await processBookContent(
        pdfData.text,
        bookId,
        bookData,
        pdfData.numpages,
    );

    // Update book record
    await admin.firestore().collection("books").doc(bookId).update({
      processing_status: "completed",
      total_pages: pdfData.numpages,
      total_sections: processingResult.totalSections,
      total_paragraphs: processingResult.totalParagraphs,
      processing_completed: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      message: "Book processed successfully",
      totalSections: processingResult.totalSections,
      totalParagraphs: processingResult.totalParagraphs,
    };
  } catch (error) {
    console.error("Manual processing error:", error);
    throw new HttpsError("internal", error.message);
  }
});

// ============================================================================
// CORE PROCESSING FUNCTION: Convert text to sections and paragraphs
// ============================================================================
async function processBookContent(fullText, bookId, bookMetadata, totalPages) {
  console.log("Processing book content into sections and paragraphs...");

  // Clean and normalize Arabic text
  const cleanedText = cleanArabicText(fullText);

  // Detect sections/chapters in the text
  const sections = detectBookSections(cleanedText, bookId);
  console.log(`Detected ${sections.length} sections`);

  // Create section documents in Firestore
  await createSectionDocuments(sections, bookId, bookMetadata);

  // Split text into paragraphs and assign to sections
  const paragraphs = createParagraphsFromText(cleanedText, sections, bookId);
  console.log(`Created ${paragraphs.length} paragraphs`);

  // Save paragraphs to Firestore in batches
  await saveParagraphsBatch(paragraphs);

  return {
    totalSections: sections.length,
    totalParagraphs: paragraphs.length,
  };
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

async function findBookByFilename(filename) {
  const snapshot = await admin.firestore()
      .collection("books")
      .where("original_filename", "==", filename)
      .limit(1)
      .get();

  return snapshot.empty ? null : snapshot.docs[0];
}

function cleanArabicText(text) {
  return text
      .replace(/\r\n/g, "\n")
      .replace(/\n{3,}/g, "\n\n")
      .replace(/\s{2,}/g, " ")
      .replace(/[\u200B-\u200D\uFEFF]/g, "")
      .replace(/^\s*[\r\n]/gm, "")
      .trim();
}

function detectBookSections(text, bookId) {
  const sections = [];
  let sectionNumber = 1;

  const lines = text.split("\n");
  let currentPosition = 0;

  // Look for section headings
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    if (isLikelySectionHeading(line)) {
      if (sections.length > 0) {
        sections[sections.length - 1].endPosition = currentPosition;
      }

      sections.push({
        section_id: `${bookId}_section_${sectionNumber.toString().padStart(2, "0")}`,
        book_id: bookId,
        section_number: sectionNumber,
        title_ar: line,
        title_en: "",
        startPosition: currentPosition,
        endPosition: text.length,
        estimated_page: Math.ceil((i / lines.length) * 100),
      });

      sectionNumber++;
    }

    currentPosition += lines[i].length + 1;
  }

  // If no sections detected, create default sections
  if (sections.length === 0) {
    const avgSectionLength = Math.ceil(text.length / 15);
    let position = 0;
    sectionNumber = 1;

    while (position < text.length) {
      const endPos = Math.min(position + avgSectionLength, text.length);
      sections.push({
        section_id: `${bookId}_section_${sectionNumber.toString().padStart(2, "0")}`,
        book_id: bookId,
        section_number: sectionNumber,
        title_ar: `القسم ${sectionNumber}`,
        title_en: `Part ${sectionNumber}`,
        startPosition: position,
        endPosition: endPos,
        estimated_page: Math.ceil((position / text.length) * 100),
      });

      position = endPos;
      sectionNumber++;
    }
  }

  return sections;
}

function isLikelySectionHeading(line) {
  if (line.length < 5 || line.length > 100) return false;

  const headingPatterns = [
    /^(الفصل|الباب|المبحث|الجزء|القسم)/,
    /^[أ-ي\s]{10,60}$/,
  ];

  for (const pattern of headingPatterns) {
    if (pattern.test(line)) return true;
  }

  const arabicRatio = (line.match(/[\u0600-\u06FF]/g) || []).length / line.length;
  return arabicRatio > 0.7 && line.length > 10 && line.length < 80;
}

async function createSectionDocuments(sections, bookId, bookMetadata) {
  console.log("Creating section documents...");

  const batch = admin.firestore().batch();

  sections.forEach((section, index) => {
    const sectionRef = admin.firestore().collection("sections").doc(section.section_id);

    batch.set(sectionRef, {
      section_id: section.section_id,
      book_id: bookId,
      section_number: section.section_number,
      title_ar: section.title_ar,
      title_en: section.title_en,
      estimated_page_start: section.estimated_page,
      estimated_page_end: sections[index + 1] ? sections[index + 1].estimated_page : 100,
      created_date: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  await batch.commit();
  console.log(`Created ${sections.length} section documents`);
}

function createParagraphsFromText(text, sections, bookId) {
  console.log("Creating paragraphs from text...");

  const paragraphs = [];
  let paragraphNumber = 1;

  const rawParagraphs = text.split(/\n\s*\n/).filter((p) => p.trim().length > 30);

  rawParagraphs.forEach((paragraphText) => {
    const textPosition = text.indexOf(paragraphText);
    const section = findSectionForPosition(textPosition, sections);

    if (section) {
      paragraphs.push({
        paragraph_id: `${bookId}_para_${paragraphNumber.toString().padStart(4, "0")}`,
        book_id: bookId,
        section_id: section.section_id,
        paragraph_number: paragraphNumber,

        content: {
          text_ar: paragraphText.trim(),
          word_count: paragraphText.split(/\s+/).length,
          character_count: paragraphText.length,
        },

        metadata: {
          language: "arabic",
          difficulty: estimateTextDifficulty(paragraphText),
          estimated_page: Math.ceil((textPosition / text.length) * 100),
        },

        created_date: admin.firestore.FieldValue.serverTimestamp(),
      });

      paragraphNumber++;
    }
  });

  return paragraphs;
}

function findSectionForPosition(position, sections) {
  for (const section of sections) {
    if (position >= section.startPosition && position < section.endPosition) {
      return section;
    }
  }
  return sections[0];
}

function estimateTextDifficulty(text) {
  const wordCount = text.split(/\s+/).length;
  const avgWordLength = text.replace(/\s/g, "").length / wordCount;

  if (wordCount < 50 && avgWordLength < 5) return "basic";
  if (wordCount < 100 && avgWordLength < 6) return "intermediate";
  if (wordCount < 200) return "advanced";
  return "expert";
}

async function saveParagraphsBatch(paragraphs) {
  console.log("Saving paragraphs to Firestore...");

  const batchSize = 500;
  let savedCount = 0;

  for (let i = 0; i < paragraphs.length; i += batchSize) {
    const batch = admin.firestore().batch();
    const batchParagraphs = paragraphs.slice(i, i + batchSize);

    batchParagraphs.forEach((paragraph) => {
      const paragraphRef = admin.firestore().collection("paragraphs").doc(paragraph.paragraph_id);
      batch.set(paragraphRef, paragraph);
    });

    await batch.commit();
    savedCount += batchParagraphs.length;
    console.log(`Saved batch: ${savedCount}/${paragraphs.length} paragraphs`);

    if (i + batchSize < paragraphs.length) {
      await new Promise((resolve) => setTimeout(resolve, 100));
    }
  }

  console.log(`Successfully saved all ${paragraphs.length} paragraphs`);
}
