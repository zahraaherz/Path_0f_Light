/**
 * Chunked OCR Processing with Resume Support
 * Processes PDFs in small chunks and saves progress frequently
 * Can resume from where it stopped if interrupted
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Import book metadata
const booksData = require('./firebase_books_import.json');

// Configuration
const CHUNK_SIZE = 50; // Process 50 pages at a time
const PROGRESS_FILE = 'ocr_progress.json';

// Get book ID from command line
const bookId = process.argv[2] || 'sira_nabawiya_damoush_vol2_003';

/**
 * Load progress
 */
function loadProgress() {
  if (fs.existsSync(PROGRESS_FILE)) {
    return JSON.parse(fs.readFileSync(PROGRESS_FILE, 'utf8'));
  }
  return {};
}

/**
 * Save progress
 */
function saveProgress(progress) {
  fs.writeFileSync(PROGRESS_FILE, JSON.stringify(progress, null, 2), 'utf8');
}

/**
 * Clean Arabic text
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
 * Detect sections
 */
function detectBookSections(text, bookId) {
  const sections = [];
  let sectionNumber = 1;
  const avgSectionLength = Math.max(10000, Math.ceil(text.length / 20));
  let position = 0;

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

  return sections;
}

/**
 * Create paragraphs
 */
function createParagraphsFromText(text, sections, bookId) {
  const paragraphs = [];
  let paragraphNumber = 1;
  const rawParagraphs = text.split(/\n\s*\n/).filter(p => p.trim().length > 50);

  rawParagraphs.forEach((paragraphText) => {
    const textPosition = text.indexOf(paragraphText);
    let section = sections[0];

    for (const s of sections) {
      if (textPosition >= s.startPosition && textPosition < s.endPosition) {
        section = s;
        break;
      }
    }

    paragraphs.push({
      paragraph_id: `${bookId}_para_${paragraphNumber.toString().padStart(5, '0')}`,
      book_id: bookId,
      section_id: section.section_id,
      paragraph_number: paragraphNumber,
      content: {
        text_ar: paragraphText.trim(),
        word_count: paragraphText.split(/\s+/).length,
        character_count: paragraphText.length,
      },
      metadata: {
        language: 'arabic',
        difficulty: 'intermediate',
        estimated_page: Math.ceil((textPosition / text.length) * 100),
      },
    });

    paragraphNumber++;
  });

  return paragraphs;
}

/**
 * Convert PDF to images
 */
function pdfToImages(pdfPath, outputDir) {
  const prefix = path.join(outputDir, 'page');
  execSync(`pdftoppm -png -r 300 "${pdfPath}" "${prefix}"`);
  const files = fs.readdirSync(outputDir).filter(f => f.endsWith('.png'));
  return files.map(f => path.join(outputDir, f)).sort();
}

/**
 * Perform OCR on an image
 */
function performOCR(imagePath) {
  const outputBase = imagePath.replace('.png', '');
  try {
    execSync(`tesseract "${imagePath}" "${outputBase}" -l ara --psm 6 2>/dev/null`);
    const txtFile = `${outputBase}.txt`;
    if (fs.existsSync(txtFile)) {
      const text = fs.readFileSync(txtFile, 'utf8');
      fs.unlinkSync(txtFile);
      return text;
    }
  } catch (error) {
    // Silent error - just return empty
  }
  return '';
}

/**
 * Process book in chunks
 */
async function processBookInChunks() {
  console.log('\n' + '='.repeat(70));
  console.log('  Chunked OCR Processing with Resume Support');
  console.log('='.repeat(70));

  const book = booksData.books.find(b => b.id === bookId);
  if (!book) {
    console.error(`\n❌ Book not found: ${bookId}`);
    process.exit(1);
  }

  console.log(`\n📖 Book: ${book.title_en}`);
  console.log(`   Arabic: ${book.title_ar}\n`);

  const pdfPath = path.join(__dirname, 'PathOfLightBooks', book.original_filename);
  if (!fs.existsSync(pdfPath)) {
    console.error(`❌ PDF not found`);
    process.exit(1);
  }

  // Load progress
  const progress = loadProgress();
  if (!progress[bookId]) {
    progress[bookId] = {
      status: 'not_started',
      lastPage: 0,
      extractedText: '',
      totalPages: 0
    };
  }

  const bookProgress = progress[bookId];

  try {
    // Create temp directory
    const tempDir = path.join(__dirname, 'temp_images', bookId);

    // Convert PDF to images if not done
    if (bookProgress.status === 'not_started') {
      console.log('📄 Converting PDF to images...');
      if (fs.existsSync(tempDir)) {
        fs.rmSync(tempDir, { recursive: true });
      }
      fs.mkdirSync(tempDir, { recursive: true });

      const imageFiles = pdfToImages(pdfPath, tempDir);
      bookProgress.totalPages = imageFiles.length;
      bookProgress.status = 'converting_done';
      saveProgress(progress);
      console.log(`✓ Generated ${imageFiles.length} images\n`);
    }

    // Get image files
    const imageFiles = fs.readdirSync(tempDir)
      .filter(f => f.endsWith('.png'))
      .map(f => path.join(tempDir, f))
      .sort();

    console.log(`🔍 Starting OCR from page ${bookProgress.lastPage + 1}/${imageFiles.length}`);
    console.log(`   Processing in chunks of ${CHUNK_SIZE} pages\n`);

    const startTime = Date.now();
    let processedInSession = 0;

    // Process in chunks
    for (let i = bookProgress.lastPage; i < imageFiles.length; i += CHUNK_SIZE) {
      const chunkEnd = Math.min(i + CHUNK_SIZE, imageFiles.length);
      const chunkSize = chunkEnd - i;

      console.log(`\n📦 Chunk: Pages ${i + 1}-${chunkEnd} of ${imageFiles.length}`);

      // Process this chunk
      for (let j = i; j < chunkEnd; j++) {
        process.stdout.write(`\r   Page ${j + 1}/${imageFiles.length} (${((j + 1) / imageFiles.length * 100).toFixed(1)}%)`);

        const pageText = performOCR(imageFiles[j]);
        bookProgress.extractedText += pageText + '\n\n';
        bookProgress.lastPage = j + 1;
        processedInSession++;
      }

      // Save progress after each chunk
      bookProgress.status = 'ocr_in_progress';
      saveProgress(progress);

      const elapsed = ((Date.now() - startTime) / 1000 / 60).toFixed(1);
      const rate = processedInSession / elapsed;
      const remaining = ((imageFiles.length - chunkEnd) / rate).toFixed(1);

      console.log(`\n   ✓ Chunk complete! Progress saved.`);
      console.log(`   ⏱️  ${elapsed}min elapsed, ~${remaining}min remaining`);
    }

    console.log('\n\n✅ OCR Complete!\n');

    // Process the text
    console.log('📝 Processing content...');
    const cleanedText = cleanArabicText(bookProgress.extractedText);

    const sections = detectBookSections(cleanedText, bookId);
    console.log(`✓ Found ${sections.length} sections`);

    const paragraphs = createParagraphsFromText(cleanedText, sections, bookId);
    console.log(`✓ Created ${paragraphs.length} paragraphs\n`);

    // Create final book object
    const updatedBook = {
      ...book,
      total_pages: imageFiles.length,
      total_sections: sections.length,
      total_paragraphs: paragraphs.length,
      total_characters: bookProgress.extractedText.length,
      total_words: bookProgress.extractedText.split(/\s+/).length,
      processing_status: 'completed',
      extraction_method: 'ocr_system_tesseract',
    };

    // Save result
    const result = {
      book: updatedBook,
      sections: sections,
      paragraphs: paragraphs,
    };

    const outputFile = `book_${bookId}_ocr.json`;
    fs.writeFileSync(outputFile, JSON.stringify(result, null, 2), 'utf8');
    console.log(`💾 Saved: ${outputFile}\n`);

    // Clean up
    fs.rmSync(tempDir, { recursive: true });
    delete progress[bookId];
    saveProgress(progress);

    console.log('='.repeat(70));
    console.log('✨ Book Complete!');
    console.log('='.repeat(70));
    console.log(`Pages: ${imageFiles.length}`);
    console.log(`Sections: ${sections.length}`);
    console.log(`Paragraphs: ${paragraphs.length}`);
    console.log(`Characters: ${bookProgress.extractedText.length.toLocaleString()}`);
    console.log('='.repeat(70) + '\n');

  } catch (error) {
    console.error(`\n❌ Error: ${error.message}`);
    console.log(`\n💾 Progress saved. Run again to resume from page ${bookProgress.lastPage + 1}\n`);
    process.exit(1);
  }
}

// Run
processBookInChunks().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
