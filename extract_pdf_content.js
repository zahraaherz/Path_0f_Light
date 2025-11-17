/**
 * PDF Content Extraction Script
 *
 * Extracts text content from all PDF files and generates JSON files
 * with books, sections, and paragraphs ready for Firebase import.
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

  // Look for section headings
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

  // If no sections detected, create default sections (every ~5000 characters)
  if (sections.length === 0) {
    const avgSectionLength = Math.max(5000, Math.ceil(text.length / 15));
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

  // Split text into paragraphs (by double line breaks or minimum length)
  const rawParagraphs = text.split(/\n\s*\n/).filter(p => p.trim().length > 30);

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
 * Process a single PDF file
 */
async function processPdfFile(filePath, bookMetadata) {
  console.log(`\n📖 Processing: ${bookMetadata.title_en}`);
  console.log(`   File: ${path.basename(filePath)}`);

  try {
    // Read PDF file
    const dataBuffer = fs.readFileSync(filePath);

    console.log(`   Size: ${(dataBuffer.length / 1024 / 1024).toFixed(2)} MB`);

    // Extract text
    console.log('   Extracting text...');
    const pdfData = await pdfParse(dataBuffer, {
      normalizeWhitespace: true,
      disableCombineTextItems: false,
    });

    const extractedText = pdfData.text;
    const totalPages = pdfData.numpages;

    console.log(`   ✓ Extracted ${totalPages} pages`);
    console.log(`   ✓ ${extractedText.length.toLocaleString()} characters`);
    console.log(`   ✓ ${extractedText.split(/\s+/).length.toLocaleString()} words`);

    // Clean text
    const cleanedText = cleanArabicText(extractedText);

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
      total_pages: totalPages,
      total_sections: sections.length,
      total_paragraphs: paragraphs.length,
      total_characters: extractedText.length,
      total_words: extractedText.split(/\s+/).length,
      pdf_metadata: {
        title: pdfData.info?.Title || '',
        author: pdfData.info?.Author || '',
        creator: pdfData.info?.Creator || '',
        creation_date: pdfData.info?.CreationDate || null,
      },
      processing_status: 'completed',
    };

    return {
      book: updatedBook,
      sections: sections,
      paragraphs: paragraphs,
      success: true,
    };

  } catch (error) {
    console.error(`   ✗ Error: ${error.message}`);
    return {
      book: { ...bookMetadata, processing_status: 'error', error_message: error.message },
      sections: [],
      paragraphs: [],
      success: false,
    };
  }
}

/**
 * Main processing function
 */
async function processAllBooks() {
  console.log('\n' + '='.repeat(70));
  console.log('  PDF Content Extraction for Firebase Import');
  console.log('  Path of Light - Islamic Books Library');
  console.log('='.repeat(70));

  const pdfDirectory = path.join(__dirname, 'PathOfLightBooks');
  const books = booksData.books;

  const allBooks = [];
  const allSections = [];
  const allParagraphs = [];

  let successCount = 0;
  let errorCount = 0;

  console.log(`\nFound ${books.length} books to process\n`);

  for (const book of books) {
    const pdfPath = path.join(pdfDirectory, book.original_filename);

    if (!fs.existsSync(pdfPath)) {
      console.log(`\n⚠️  Skipping ${book.title_en} - PDF not found`);
      allBooks.push({ ...book, processing_status: 'file_not_found' });
      errorCount++;
      continue;
    }

    const result = await processPdfFile(pdfPath, book);

    allBooks.push(result.book);
    allSections.push(...result.sections);
    allParagraphs.push(...result.paragraphs);

    if (result.success) {
      successCount++;
    } else {
      errorCount++;
    }

    // Small delay between files
    await new Promise(resolve => setTimeout(resolve, 100));
  }

  // Generate output files
  console.log('\n' + '='.repeat(70));
  console.log('📊 Processing Summary');
  console.log('='.repeat(70));
  console.log(`✓ Successfully processed: ${successCount} books`);
  console.log(`✗ Errors: ${errorCount}`);
  console.log(`📚 Total books: ${allBooks.length}`);
  console.log(`📑 Total sections: ${allSections.length}`);
  console.log(`📄 Total paragraphs: ${allParagraphs.length}`);
  console.log('='.repeat(70));

  // Save complete data
  console.log('\n💾 Saving JSON files...\n');

  const completeData = {
    metadata: {
      generated_at: new Date().toISOString(),
      total_books: allBooks.length,
      total_sections: allSections.length,
      total_paragraphs: allParagraphs.length,
      success_count: successCount,
      error_count: errorCount,
    },
    books: allBooks,
    sections: allSections,
    paragraphs: allParagraphs,
  };

  // Save complete data in one file
  fs.writeFileSync(
    'firebase_complete_import.json',
    JSON.stringify(completeData, null, 2),
    'utf8'
  );
  console.log('✓ Saved: firebase_complete_import.json');

  // Save separate files for each collection
  fs.writeFileSync(
    'firebase_books_complete.json',
    JSON.stringify({ books: allBooks }, null, 2),
    'utf8'
  );
  console.log('✓ Saved: firebase_books_complete.json');

  fs.writeFileSync(
    'firebase_sections.json',
    JSON.stringify({ sections: allSections }, null, 2),
    'utf8'
  );
  console.log('✓ Saved: firebase_sections.json');

  // Split paragraphs into multiple files (to avoid large file size)
  const paragraphsPerFile = 1000;
  const totalParagraphFiles = Math.ceil(allParagraphs.length / paragraphsPerFile);

  for (let i = 0; i < totalParagraphFiles; i++) {
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

  console.log('\n✨ All done! Files are ready for Firebase import.\n');
  console.log('Next steps:');
  console.log('1. Review the generated JSON files');
  console.log('2. Run: node import_complete_content.js');
  console.log('3. Upload PDF files to Firebase Storage\n');
}

// Run the script
processAllBooks().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
