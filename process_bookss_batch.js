const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// Get all PDF files from bookss folder (excluding subdirectories)
const bookssDir = './bookss';
const pdfFiles = fs.readdirSync(bookssDir)
  .filter(file => file.endsWith('.pdf') && fs.statSync(path.join(bookssDir, file)).isFile())
  .sort();

console.log(`Found ${pdfFiles.length} books to process\n`);

// Process each book
for (let i = 0; i < pdfFiles.length; i++) {
  const pdfFile = pdfFiles[i];
  const pdfPath = path.join(bookssDir, pdfFile);

  // Create a simple book ID from filename
  const bookId = pdfFile
    .replace(/\.pdf$/i, '')
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '_')
    .substring(0, 50)
    .toLowerCase();

  const outputFile = `book_bookss_${String(i + 1).padStart(3, '0')}_${bookId}_ocr.json`;

  // Check if already processed
  if (fs.existsSync(outputFile)) {
    console.log(`[${i + 1}/${pdfFiles.length}] SKIPPED: ${pdfFile} (already processed)`);
    continue;
  }

  console.log(`\n${'='.repeat(70)}`);
  console.log(`[${i + 1}/${pdfFiles.length}] Processing: ${pdfFile}`);
  console.log(`${'='.repeat(70)}\n`);

  try {
    // Get page count
    const pageInfo = execSync(`pdfinfo "${pdfPath}" 2>&1 | grep "Pages:" || echo "Pages: unknown"`, { encoding: 'utf8' });
    const pageMatch = pageInfo.match(/Pages:\s+(\d+)/);
    const totalPages = pageMatch ? parseInt(pageMatch[1]) : 0;

    console.log(`📄 Pages: ${totalPages}`);
    console.log(`📝 Output: ${outputFile}\n`);

    // Convert PDF to images
    const tempDir = `temp_images_bookss_${i + 1}`;
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
          const text = execSync(`tesseract "${imagePath}" stdout -l ara --psm 6 2>/dev/null`, { encoding: 'utf8' });
          extractedText += text + '\n';

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

    // Save output
    const output = {
      book_id: bookId,
      title: pdfFile.replace('.pdf', ''),
      original_filename: pdfFile,
      total_pages: totalPages,
      characters: extractedText.length,
      extracted_text: extractedText,
      processed_date: new Date().toISOString()
    };

    fs.writeFileSync(outputFile, JSON.stringify(output, null, 2), 'utf8');

    // Cleanup
    execSync(`rm -rf "${tempDir}"`);

    console.log(`\n✅ COMPLETE! Saved to: ${outputFile}`);
    console.log(`   Characters: ${extractedText.length.toLocaleString()}\n`);

  } catch (error) {
    console.error(`\n❌ ERROR processing ${pdfFile}:`, error.message);
  }
}

console.log(`\n${'='.repeat(70)}`);
console.log(`✨ ALL BOOKS PROCESSED!`);
console.log(`${'='.repeat(70)}\n`);
