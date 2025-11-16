/**
 * Process PDFs One by One - Smart Text/OCR Detection
 *
 * This script processes each PDF individually, automatically detecting
 * whether it's text-based or image-based, and uses the appropriate method.
 */

const fs = require('fs');
const path = require('path');
const pdfParse = require('pdf-parse');

// Import book metadata
const booksData = require('./firebase_books_import.json');

/**
 * Clean and normalize Arabic text
 */
function cleanArabicText(text) {
  return text
    .replace(/\r\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .replace(/\s{2,}/g, ' ')
    .replace(/[\u200B-\u200D\uFEFF]/g, '')
    .replace(/^\s*[\r\n]/gm, '')
    .trim();
}

/**
 * Check if a line is likely a section heading
 */
function isLikelySectionHeading(line) {
  if (line.length < 5 || line.length > 100) return false;

  const headingPatterns = [
    /^(الفصل|الباب|المبحث|الجزء|القسم|الفرع|المطلب)/,
    /^[أ-ي\s]{10,60}$/,
  ];

  for (const pattern of headingPatterns) {
    if (pattern.test(line)) return true;
  }

  const arabicRatio = (line.match(/[\u0600-\u06FF]/g) || []).length / line.length;
  return arabicRatio > 0.7 && line.length > 10 && line.length < 80;
}

/**
 * Detect sections in text
 */
function detectBookSections(text, bookId) {
  const sections = [];
  let sectionNumber = 1;

  const lines = text.split('\n');
  let currentPosition = 0;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    if (isLikelySectionHeading(line)) {
      if (sections.length > 0) {
        sections[sections.length - 1].endPosition = currentPosition;
      }

      sections.push({
        section_id: `${bookId}_section_${sectionNumber.toString().padStart(3, '0')}`,
        book_id: bookId,
        section_number: sectionNumber,
        title_ar: line,
        title_en: '',
        startPosition: currentPosition,
        endPosition: text.length,
        estimated_page: Math.ceil((i / lines.length) * 100),
      });

      sectionNumber++;
    }

    currentPosition += lines[i].length + 1;
  }

  // If no sections detected or too many, create default sections
  if (sections.length === 0 || sections.length > 1000) {
    sections.length = 0;
    const avgSectionLength = Math.max(10000, Math.ceil(text.length / 20));
    let position = 0;
    sectionNumber = 1;

    while (position < text.length) {
      const endPos = Math.min(position + avgSectionLength, text.length);
      sections.push({
        section_id: `${bookId}_section_${sectionNumber.toString().padStart(3, '0')}`,
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

/**
 * Find section for a given text position
 */
function findSectionForPosition(position, sections) {
  for (const section of sections) {
    if (position >= section.startPosition && position < section.endPosition) {
      return section;
    }
  }
  return sections[0];
}

/**
 * Estimate text difficulty
 */
function estimateTextDifficulty(text) {
  const wordCount = text.split(/\s+/).length;
  const avgWordLength = text.replace(/\s/g, '').length / wordCount;

  if (wordCount < 50 && avgWordLength < 5) return 'basic';
  if (wordCount < 100 && avgWordLength < 6) return 'intermediate';
  if (wordCount < 200) return 'advanced';
  return 'expert';
}

/**
 * Create paragraphs from text
 */
function createParagraphsFromText(text, sections, bookId) {
  const paragraphs = [];
  let paragraphNumber = 1;

  const rawParagraphs = text.split(/\n\s*\n/).filter(p => p.trim().length > 50);

  rawParagraphs.forEach((paragraphText) => {
    const textPosition = text.indexOf(paragraphText);
    const section = findSectionForPosition(textPosition, sections);

    if (section) {
      const wordCount = paragraphText.split(/\s+/).length;
      const characterCount = paragraphText.length;

      paragraphs.push({
        paragraph_id: `${bookId}_para_${paragraphNumber.toString().padStart(5, '0')}`,
        book_id: bookId,
        section_id: section.section_id,
        paragraph_number: paragraphNumber,
        content: {
          text_ar: paragraphText.trim(),
          word_count: wordCount,
          character_count: characterCount,
        },
        metadata: {
          language: 'arabic',
          difficulty: estimateTextDifficulty(paragraphText),
          estimated_page: Math.ceil((textPosition / text.length) * 100),
        },
      });

      paragraphNumber++;
    }
  });

  return paragraphs;
}

/**
 * Check if PDF is text-based or image-based
 */
async function checkPdfType(filePath) {
  const dataBuffer = fs.readFileSync(filePath);
  const pdfData = await pdfParse(dataBuffer, {
    normalizeWhitespace: true,
    disableCombineTextItems: false,
  });

  const totalPages = pdfData.numpages;
  const extractedText = pdfData.text;
  const wordCount = extractedText.split(/\s+/).filter(w => w.length > 0).length;
  const charsPerPage = extractedText.length / totalPages;
  const wordsPerPage = wordCount / totalPages;

  // If we get less than 50 words per page, it's likely image-based
  const isTextBased = wordsPerPage > 50 && charsPerPage > 200;

  return {
    isTextBased,
    totalPages,
    extractedChars: extractedText.length,
    extractedWords: wordCount,
    charsPerPage: charsPerPage.toFixed(0),
    wordsPerPage: wordsPerPage.toFixed(0),
    rawText: extractedText,
  };
}

/**
 * Process a single PDF file
 */
async function processSinglePdf(filePath, bookMetadata) {
  console.log(`\n${'='.repeat(70)}`);
  console.log(`📖 Processing: ${bookMetadata.title_en}`);
  console.log(`   Arabic: ${bookMetadata.title_ar}`);
  console.log(`   File: ${path.basename(filePath)}`);
  console.log(`   Size: ${(fs.statSync(filePath).size / 1024 / 1024).toFixed(2)} MB`);

  try {
    // Check PDF type
    console.log('\n   🔍 Analyzing PDF type...');
    const pdfInfo = await checkPdfType(filePath);

    console.log(`   Total Pages: ${pdfInfo.totalPages}`);
    console.log(`   Characters extracted: ${pdfInfo.extractedChars.toLocaleString()}`);
    console.log(`   Words extracted: ${pdfInfo.extractedWords.toLocaleString()}`);
    console.log(`   Average per page: ${pdfInfo.charsPerPage} chars, ${pdfInfo.wordsPerPage} words`);

    if (pdfInfo.isTextBased) {
      console.log(`\n   ✅ TEXT-BASED PDF - Using direct text extraction`);
    } else {
      console.log(`\n   📷 IMAGE-BASED PDF - Would need OCR (skipping for now)`);
      console.log(`   💡 To process this book with OCR, use: extract_pdf_with_ocr.js`);

      return {
        book: {
          ...bookMetadata,
          total_pages: pdfInfo.totalPages,
          total_sections: 0,
          total_paragraphs: 0,
          total_characters: pdfInfo.extractedChars,
          total_words: pdfInfo.extractedWords,
          processing_status: 'needs_ocr',
          pdf_type: 'image_based',
        },
        sections: [],
        paragraphs: [],
        success: false,
        needsOcr: true,
      };
    }

    // Process text-based PDF
    console.log(`\n   📝 Processing content...`);
    const cleanedText = cleanArabicText(pdfInfo.rawText);

    // Detect sections
    console.log('   Detecting sections...');
    const sections = detectBookSections(cleanedText, bookMetadata.id);
    console.log(`   ✓ Found ${sections.length} sections`);

    // Create paragraphs
    console.log('   Creating paragraphs...');
    const paragraphs = createParagraphsFromText(cleanedText, sections, bookMetadata.id);
    console.log(`   ✓ Created ${paragraphs.length} paragraphs`);

    // Update book metadata
    const updatedBook = {
      ...bookMetadata,
      total_pages: pdfInfo.totalPages,
      total_sections: sections.length,
      total_paragraphs: paragraphs.length,
      total_characters: pdfInfo.extractedChars,
      total_words: pdfInfo.extractedWords,
      processing_status: 'completed',
      pdf_type: 'text_based',
    };

    console.log(`\n   ✅ SUCCESS!`);
    console.log(`   Extracted: ${sections.length} sections, ${paragraphs.length} paragraphs`);

    return {
      book: updatedBook,
      sections: sections,
      paragraphs: paragraphs,
      success: true,
      needsOcr: false,
    };

  } catch (error) {
    console.error(`\n   ❌ Error: ${error.message}`);
    return {
      book: {
        ...bookMetadata,
        processing_status: 'error',
        error_message: error.message
      },
      sections: [],
      paragraphs: [],
      success: false,
      needsOcr: false,
    };
  }
}

/**
 * Main function - Process books one by one
 */
async function processOneByOne() {
  console.log('\n' + '='.repeat(70));
  console.log('  PDF Processing - One by One');
  console.log('  Path of Light - Islamic Books Library');
  console.log('='.repeat(70));

  const pdfDirectory = path.join(__dirname, 'PathOfLightBooks');
  const books = booksData.books;

  console.log(`\nFound ${books.length} books to process\n`);

  const allBooks = [];
  const allSections = [];
  const allParagraphs = [];

  let successCount = 0;
  let needsOcrCount = 0;
  let errorCount = 0;

  for (let i = 0; i < books.length; i++) {
    const book = books[i];
    const pdfPath = path.join(pdfDirectory, book.original_filename);

    console.log(`\n[${i + 1}/${books.length}] Processing: ${book.title_en}`);

    if (!fs.existsSync(pdfPath)) {
      console.log(`⚠️  PDF not found, skipping...`);
      allBooks.push({ ...book, processing_status: 'file_not_found' });
      errorCount++;
      continue;
    }

    const result = await processSinglePdf(pdfPath, book);

    allBooks.push(result.book);
    allSections.push(...result.sections);
    allParagraphs.push(...result.paragraphs);

    if (result.success) {
      successCount++;
    } else if (result.needsOcr) {
      needsOcrCount++;
    } else {
      errorCount++;
    }

    // Save progress after each book
    const progressData = {
      metadata: {
        generated_at: new Date().toISOString(),
        processed_books: i + 1,
        total_books: books.length,
        success_count: successCount,
        needs_ocr_count: needsOcrCount,
        error_count: errorCount,
      },
      books: allBooks,
      sections: allSections,
      paragraphs: allParagraphs,
    };

    fs.writeFileSync(
      'firebase_progress.json',
      JSON.stringify(progressData, null, 2),
      'utf8'
    );

    console.log(`\n   💾 Progress saved to firebase_progress.json`);
  }

  // Final summary
  console.log('\n' + '='.repeat(70));
  console.log('📊 Final Summary');
  console.log('='.repeat(70));
  console.log(`✅ Text-based PDFs extracted: ${successCount}`);
  console.log(`📷 Image-based PDFs (need OCR): ${needsOcrCount}`);
  console.log(`❌ Errors: ${errorCount}`);
  console.log(`📚 Total books: ${books.length}`);
  console.log(`📑 Total sections: ${allSections.length}`);
  console.log(`📄 Total paragraphs: ${allParagraphs.length}`);
  console.log('='.repeat(70));

  // Save final data
  console.log('\n💾 Saving final JSON files...\n');

  const completeData = {
    metadata: {
      generated_at: new Date().toISOString(),
      total_books: allBooks.length,
      total_sections: allSections.length,
      total_paragraphs: allParagraphs.length,
      success_count: successCount,
      needs_ocr_count: needsOcrCount,
      error_count: errorCount,
    },
    books: allBooks,
    sections: allSections,
    paragraphs: allParagraphs,
  };

  fs.writeFileSync(
    'firebase_complete_import.json',
    JSON.stringify(completeData, null, 2),
    'utf8'
  );
  console.log('✓ Saved: firebase_complete_import.json');

  fs.writeFileSync(
    'firebase_books_complete.json',
    JSON.stringify({ books: allBooks }, null, 2),
    'utf8'
  );
  console.log('✓ Saved: firebase_books_complete.json');

  if (allSections.length > 0) {
    fs.writeFileSync(
      'firebase_sections.json',
      JSON.stringify({ sections: allSections }, null, 2),
      'utf8'
    );
    console.log('✓ Saved: firebase_sections.json');
  }

  if (allParagraphs.length > 0) {
    // Split paragraphs into files
    const paragraphsPerFile = 1000;
    const totalFiles = Math.ceil(allParagraphs.length / paragraphsPerFile);

    for (let i = 0; i < totalFiles; i++) {
      const start = i * paragraphsPerFile;
      const end = Math.min(start + paragraphsPerFile, allParagraphs.length);
      const fileParagraphs = allParagraphs.slice(start, end);

      fs.writeFileSync(
        `firebase_paragraphs_part${i + 1}.json`,
        JSON.stringify({ paragraphs: fileParagraphs }, null, 2),
        'utf8'
      );
      console.log(`✓ Saved: firebase_paragraphs_part${i + 1}.json (${fileParagraphs.length} paragraphs)`);
    }
  }

  // List books that need OCR
  if (needsOcrCount > 0) {
    console.log('\n' + '='.repeat(70));
    console.log('📷 Books that need OCR processing:');
    console.log('='.repeat(70));

    allBooks
      .filter(b => b.processing_status === 'needs_ocr')
      .forEach((book, idx) => {
        console.log(`${idx + 1}. ${book.title_en}`);
        console.log(`   ${book.title_ar}`);
        console.log(`   File: ${book.original_filename}\n`);
      });

    console.log('To process these with OCR, use: node extract_pdf_with_ocr.js');
  }

  console.log('\n✨ Processing complete!\n');
}

// Run the script
processOneByOne().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
