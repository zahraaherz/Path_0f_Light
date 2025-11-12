/**
 * Process a single book with OCR (Linux compatible)
 * Usage: node process_single_book_ocr_v2.js <book_id>
 * Example: node process_single_book_ocr_v2.js prophet_muhammad_vol1_002
 */

const fs = require('fs');
const path = require('path');
const { createWorker } = require('tesseract.js');
const { execSync } = require('child_process');

// Import book metadata
const booksData = require('./firebase_books_import.json');

// Get book ID from command line argument
const bookId = process.argv[2] || 'prophet_muhammad_vol1_002';

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
  if (sections.length === 0 || sections.length > 100) {
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
 * Convert PDF to images using pdftoppm
 */
function pdfToImages(pdfPath, outputDir) {
  const prefix = path.join(outputDir, 'page');

  // Use pdftoppm to convert PDF to PNG images
  // -png: output format
  // -r 300: resolution (DPI)
  execSync(`pdftoppm -png -r 300 "${pdfPath}" "${prefix}"`, { stdio: 'inherit' });

  // Get list of generated images
  const files = fs.readdirSync(outputDir).filter(f => f.endsWith('.png'));
  return files.map(f => path.join(outputDir, f)).sort();
}

/**
 * Perform OCR on an image
 */
async function performOCR(imagePath, worker) {
  const { data: { text } } = await worker.recognize(imagePath);
  return text;
}

/**
 * Process book with OCR
 */
async function processBookWithOCR() {
  console.log('\n' + '='.repeat(70));
  console.log('  Single Book OCR Processing');
  console.log('='.repeat(70));

  // Find the book
  const book = booksData.books.find(b => b.id === bookId);
  if (!book) {
    console.error(`\n❌ Book not found: ${bookId}`);
    console.log('\nAvailable book IDs:');
    booksData.books.forEach(b => console.log(`  - ${b.id}: ${b.title_en}`));
    process.exit(1);
  }

  console.log(`\n📖 Processing: ${book.title_en}`);
  console.log(`   Arabic: ${book.title_ar}`);
  console.log(`   File: ${book.original_filename}\n`);

  const pdfPath = path.join(__dirname, 'PathOfLightBooks', book.original_filename);

  if (!fs.existsSync(pdfPath)) {
    console.error(`❌ PDF file not found: ${pdfPath}`);
    process.exit(1);
  }

  const fileSize = fs.statSync(pdfPath).size;
  console.log(`   Size: ${(fileSize / 1024 / 1024).toFixed(2)} MB`);

  try {
    // Create temporary directory for images
    const tempDir = path.join(__dirname, 'temp_images', book.id);
    if (fs.existsSync(tempDir)) {
      fs.rmSync(tempDir, { recursive: true });
    }
    fs.mkdirSync(tempDir, { recursive: true });

    console.log('\n   📄 Converting PDF to images (this may take a few minutes)...');
    const imageFiles = pdfToImages(pdfPath, tempDir);
    console.log(`   ✓ Generated ${imageFiles.length} images\n`);

    // Initialize Tesseract worker for Arabic
    console.log('   🔧 Initializing OCR engine (Arabic)...');
    const worker = await createWorker('ara');
    console.log('   ✓ OCR engine ready\n');

    console.log('   🔍 Performing OCR on pages...');
    console.log(`   Estimated time: ${Math.ceil(imageFiles.length / 2)} - ${Math.ceil(imageFiles.length)} minutes\n`);

    let fullText = '';
    let processedPages = 0;
    const startTime = Date.now();

    for (const imagePath of imageFiles) {
      const pageNumber = processedPages + 1;
      process.stdout.write(`\r      Page ${pageNumber}/${imageFiles.length} (${((pageNumber/imageFiles.length)*100).toFixed(1)}%)`);

      const pageText = await performOCR(imagePath, worker);
      fullText += pageText + '\n\n';
      processedPages++;

      if (processedPages % 50 === 0) {
        const elapsed = ((Date.now() - startTime) / 1000 / 60).toFixed(1);
        const rate = processedPages / elapsed;
        const remaining = ((imageFiles.length - processedPages) / rate).toFixed(1);
        console.log(` - Elapsed: ${elapsed}min, Est. remaining: ${remaining}min`);
      }
    }

    console.log('\n');

    await worker.terminate();

    // Clean up temp directory
    console.log('   🧹 Cleaning up temporary files...');
    fs.rmSync(tempDir, { recursive: true });

    const totalTime = ((Date.now() - startTime) / 1000 / 60).toFixed(1);
    console.log(`   ✓ OCR completed in ${totalTime} minutes`);
    console.log(`   ✓ ${fullText.length.toLocaleString()} characters extracted`);
    console.log(`   ✓ ${fullText.split(/\s+/).length.toLocaleString()} words extracted\n`);

    // Process the extracted text
    console.log('   📝 Processing content...');
    const cleanedText = cleanArabicText(fullText);

    console.log('   Detecting sections...');
    const sections = detectBookSections(cleanedText, book.id);
    console.log(`   ✓ Found ${sections.length} sections`);

    console.log('   Creating paragraphs...');
    const paragraphs = createParagraphsFromText(cleanedText, sections, book.id);
    console.log(`   ✓ Created ${paragraphs.length} paragraphs\n`);

    // Update book metadata
    const updatedBook = {
      ...book,
      total_pages: imageFiles.length,
      total_sections: sections.length,
      total_paragraphs: paragraphs.length,
      total_characters: fullText.length,
      total_words: fullText.split(/\s+/).length,
      processing_status: 'completed',
      extraction_method: 'ocr',
      ocr_processing_time_minutes: parseFloat(totalTime),
    };

    // Save results
    const result = {
      book: updatedBook,
      sections: sections,
      paragraphs: paragraphs,
    };

    const outputFile = `book_${book.id}_ocr.json`;
    fs.writeFileSync(outputFile, JSON.stringify(result, null, 2), 'utf8');

    console.log('   💾 Saved results to:', outputFile);

    console.log('\n' + '='.repeat(70));
    console.log('✅ SUCCESS!');
    console.log('='.repeat(70));
    console.log(`Book: ${book.title_en}`);
    console.log(`Pages: ${imageFiles.length}`);
    console.log(`Sections: ${sections.length}`);
    console.log(`Paragraphs: ${paragraphs.length}`);
    console.log(`Characters: ${fullText.length.toLocaleString()}`);
    console.log(`Words: ${fullText.split(/\s+/).length.toLocaleString()}`);
    console.log(`Processing time: ${totalTime} minutes`);
    console.log('='.repeat(70) + '\n');

  } catch (error) {
    console.error(`\n❌ Error: ${error.message}`);
    console.error(error.stack);
    process.exit(1);
  }
}

// Run the script
processBookWithOCR().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
