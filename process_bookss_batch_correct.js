const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// Load book metadata
const booksMetadata = require('./bookss_metadata.json');

// Get all PDF files from bookss folder
const bookssDir = './bookss';
const pdfFiles = fs.readdirSync(bookssDir)
  .filter(file => file.endsWith('.pdf') && fs.statSync(path.join(bookssDir, file)).isFile())
  .sort();

// Map PDFs to their IDs
const pdfToIdMap = {};
Object.keys(booksMetadata).forEach((bookId, index) => {
  const book = booksMetadata[bookId];
  pdfToIdMap[book.original_filename] = bookId;
});

console.log(`Found ${pdfFiles.length} books to process\n`);

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
 * Detect book sections
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
 * Create paragraphs from text
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
      text_ar: cleanArabicText(paragraphText),
      word_count: paragraphText.split(/\s+/).length,
      character_count: paragraphText.length,
    });

    paragraphNumber++;
  });

  return paragraphs;
}

/**
 * Perform OCR on an image
 */
function performOCR(imagePath) {
  try {
    return execSync(`tesseract "${imagePath}" stdout -l ara --psm 6 2>/dev/null`, {
      encoding: 'utf8',
      maxBuffer: 10 * 1024 * 1024
    });
  } catch (error) {
    console.error(`\nOCR error for ${imagePath}: ${error.message}`);
    return '';
  }
}

// Process each book
for (let i = 0; i < pdfFiles.length; i++) {
  const pdfFile = pdfFiles[i];
  const pdfPath = path.join(bookssDir, pdfFile);
  const bookId = pdfToIdMap[pdfFile];

  if (!bookId) {
    console.log(`[${i + 1}/${pdfFiles.length}] SKIPPED: ${pdfFile} (no metadata found)`);
    continue;
  }

  const book = booksMetadata[bookId];
  const outputFile = `book_${bookId}_ocr.json`;

  // Check if already processed
  if (fs.existsSync(outputFile)) {
    console.log(`[${i + 1}/${pdfFiles.length}] SKIPPED: ${pdfFile} (already processed)`);
    continue;
  }

  console.log(`\n${'='.repeat(70)}`);
  console.log(`[${i + 1}/${pdfFiles.length}] Processing: ${book.title_ar}`);
  console.log(`${'='.repeat(70)}\n`);

  try {
    // Get page count
    const pageInfo = execSync(`pdfinfo "${pdfPath}" 2>&1 | grep "Pages:" || echo "Pages: unknown"`, { encoding: 'utf8' });
    const pageMatch = pageInfo.match(/Pages:\s+(\d+)/);
    const totalPages = pageMatch ? parseInt(pageMatch[1]) : 0;

    console.log(`📄 Pages: ${totalPages}`);
    console.log(`📝 Output: ${outputFile}\n`);

    // Convert PDF to images
    const tempDir = `temp_images_${bookId}`;
    if (!fs.existsSync(tempDir)) {
      fs.mkdirSync(tempDir);
    }

    console.log(`📸 Converting PDF to images...`);
    execSync(`pdftoppm -png -r 300 "${pdfPath}" "${tempDir}/page"`);

    // Get all image files
    const imageFiles = fs.readdirSync(tempDir)
      .filter(f => f.endsWith('.png'))
      .sort()
      .map(f => path.join(tempDir, f));

    console.log(`✓ Generated ${imageFiles.length} images\n`);

    // Process in chunks of 50 pages
    const CHUNK_SIZE = 50;
    let extractedText = '';

    for (let chunkStart = 0; chunkStart < imageFiles.length; chunkStart += CHUNK_SIZE) {
      const chunkEnd = Math.min(chunkStart + CHUNK_SIZE, imageFiles.length);
      const chunkFiles = imageFiles.slice(chunkStart, chunkEnd);

      console.log(`📦 Processing pages ${chunkStart + 1}-${chunkEnd}...`);

      for (let j = 0; j < chunkFiles.length; j++) {
        const imagePath = chunkFiles[j];
        const pageNum = chunkStart + j + 1;

        try {
          const text = performOCR(imagePath);
          extractedText += text + '\n\n';

          if (pageNum % 10 === 0 || pageNum === imageFiles.length) {
            process.stdout.write(`   ${pageNum}/${imageFiles.length} (${((pageNum / imageFiles.length) * 100).toFixed(1)}%)   `);
            if (pageNum % 50 === 0 || pageNum === imageFiles.length) {
              console.log('');
            }
          }
        } catch (error) {
          console.error(`\nError processing page ${pageNum}: ${error.message}`);
        }
      }

      console.log(`   ✓ Chunk complete\n`);
    }

    // Process the text
    console.log('📝 Processing content...');
    const cleanedText = cleanArabicText(extractedText);

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
      total_characters: extractedText.length,
      total_words: extractedText.split(/\s+/).length,
      processing_status: 'completed',
      extraction_method: 'ocr_system_tesseract',
      processed_date: new Date().toISOString()
    };

    // Save result in correct format
    const result = {
      book: updatedBook,
      sections: sections,
      paragraphs: paragraphs,
    };

    fs.writeFileSync(outputFile, JSON.stringify(result, null, 2), 'utf8');

    // Cleanup
    execSync(`rm -rf "${tempDir}"`);

    console.log(`\n✅ COMPLETE! Saved to: ${outputFile}`);
    console.log(`   Pages: ${imageFiles.length}`);
    console.log(`   Sections: ${sections.length}`);
    console.log(`   Paragraphs: ${paragraphs.length}`);
    console.log(`   Characters: ${extractedText.length.toLocaleString()}\n`);

  } catch (error) {
    console.error(`\n❌ ERROR processing ${pdfFile}:`, error.message);
  }
}

console.log(`\n${'='.repeat(70)}`);
console.log(`✨ ALL BOOKS PROCESSED!`);
console.log(`${'='.repeat(70)}\n`);
