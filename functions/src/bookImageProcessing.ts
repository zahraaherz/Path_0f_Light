/**
 * Book Image Processing - Extract and store page images from PDFs
 *
 * This module handles:
 * 1. Converting PDF pages to images
 * 2. Uploading images to Firebase Storage
 * 3. Storing image URLs in Firestore
 * 4. OCR text extraction (optional)
 */

import * as admin from 'firebase-admin';
import { Storage } from '@google-cloud/storage';
import { onObjectFinalized } from 'firebase-functions/v2/storage';
import { onCall, HttpsError } from 'firebase-functions/v2/https';
import { setGlobalOptions } from 'firebase-functions/v2/options';
import * as path from 'path';
import * as os from 'os';
import * as fs from 'fs/promises';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

// Set global options
setGlobalOptions({
  maxInstances: 5,
  timeoutSeconds: 540, // 9 minutes max
  memory: '4GiB',
  region: 'us-central1',
});

interface PageImage {
  page_number: number;
  image_url: string;
  storage_path: string;
  width: number;
  height: number;
  file_size: number;
}

interface BookPage {
  page_id: string;
  book_id: string;
  page_number: number;
  image_url: string;
  storage_path: string;
  text_content?: string;
  word_count?: number;
  character_count?: number;
  has_ocr: boolean;
  created_at: admin.firestore.FieldValue;
}

/**
 * Auto-process uploaded books and extract page images
 */
export const processBookWithImages = onObjectFinalized(async (event) => {
  const object = event.data;
  const filePath = object.name;
  const fileName = filePath.split('/').pop();

  console.log('Checking uploaded file:', filePath);

  // Only process PDFs in islamic_books folder
  if (!filePath.startsWith('islamic_books/') || !fileName?.endsWith('.pdf')) {
    console.log('Skipping file - not an Islamic book PDF');
    return null;
  }

  console.log('Processing book with images:', fileName);

  try {
    // Find book record
    const bookRecord = await findBookByFilename(fileName);
    if (!bookRecord) {
      console.error('Book record not found for:', fileName);
      return null;
    }

    const bookId = bookRecord.id;
    console.log('Found book record:', bookId);

    // Update status
    await admin.firestore().collection('books').doc(bookId).update({
      processing_status: 'extracting_images',
      processing_started: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Download PDF
    const bucket = admin.storage().bucket();
    const file = bucket.file(filePath);
    const tempDir = path.join(os.tmpdir(), `book_${bookId}`);
    await fs.mkdir(tempDir, { recursive: true });

    const pdfPath = path.join(tempDir, 'book.pdf');
    await file.download({ destination: pdfPath });

    console.log('PDF downloaded to:', pdfPath);

    // Extract pages as images
    console.log('Extracting page images...');
    const pageImages = await extractPageImages(pdfPath, tempDir, bookId);
    console.log(`Extracted ${pageImages.length} page images`);

    // Upload images to Firebase Storage
    console.log('Uploading images to Storage...');
    const uploadedImages = await uploadPageImages(
      pageImages,
      bookId,
      bucket
    );
    console.log(`Uploaded ${uploadedImages.length} images`);

    // Create page documents in Firestore
    console.log('Creating page documents...');
    await createPageDocuments(uploadedImages, bookId);

    // Optional: Extract text via OCR if needed
    // const withOcr = await extractTextFromImages(uploadedImages);

    // Update book record
    await admin.firestore().collection('books').doc(bookId).update({
      processing_status: 'completed',
      total_pages: pageImages.length,
      has_page_images: true,
      processing_completed: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Cleanup
    await fs.rm(tempDir, { recursive: true, force: true });

    console.log('Book processing completed successfully!');
    return {
      success: true,
      bookId,
      totalPages: pageImages.length,
    };
  } catch (error) {
    console.error('Error processing book:', error);
    throw error;
  }
});

/**
 * Manual trigger to process a specific book
 */
export const processBookImagesManually = onCall(async (request) => {
  const { bookId } = request.data;

  if (!bookId) {
    throw new HttpsError('invalid-argument', 'Book ID is required');
  }

  console.log('Manual image processing for book:', bookId);

  try {
    const bookDoc = await admin.firestore().collection('books').doc(bookId).get();
    if (!bookDoc.exists) {
      throw new HttpsError('not-found', 'Book not found');
    }

    const bookData = bookDoc.data();
    const storagePath = bookData?.storage_path;

    if (!storagePath) {
      throw new HttpsError('failed-precondition', 'Book has no storage path');
    }

    // Get the file from storage
    const bucket = admin.storage().bucket();
    const file = bucket.file(storagePath);

    // Download to temp
    const tempDir = path.join(os.tmpdir(), `book_${bookId}_manual`);
    await fs.mkdir(tempDir, { recursive: true });
    const pdfPath = path.join(tempDir, 'book.pdf');

    await file.download({ destination: pdfPath });

    // Extract and upload images
    const pageImages = await extractPageImages(pdfPath, tempDir, bookId);
    const uploadedImages = await uploadPageImages(pageImages, bookId, bucket);
    await createPageDocuments(uploadedImages, bookId);

    // Cleanup
    await fs.rm(tempDir, { recursive: true, force: true });

    // Update book
    await admin.firestore().collection('books').doc(bookId).update({
      processing_status: 'completed',
      total_pages: pageImages.length,
      has_page_images: true,
      processing_completed: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      message: 'Images processed successfully',
      totalPages: pageImages.length,
    };
  } catch (error) {
    console.error('Manual processing error:', error);
    throw new HttpsError('internal', (error as Error).message);
  }
});

/**
 * Extract PDF pages as images using pdftoppm
 */
async function extractPageImages(
  pdfPath: string,
  outputDir: string,
  bookId: string
): Promise<string[]> {
  const outputPrefix = path.join(outputDir, 'page');

  // Use pdftoppm to convert PDF to PNG images
  // -png: output format
  // -r 300: 300 DPI resolution
  // -jpegopt quality=90: if using JPEG
  const command = `pdftoppm -png -r 200 "${pdfPath}" "${outputPrefix}"`;

  console.log('Running command:', command);
  await execAsync(command);

  // Get all generated PNG files
  const files = await fs.readdir(outputDir);
  const imageFiles = files
    .filter(f => f.endsWith('.png') && f.startsWith('page'))
    .sort()
    .map(f => path.join(outputDir, f));

  console.log(`Generated ${imageFiles.length} image files`);
  return imageFiles;
}

/**
 * Upload page images to Firebase Storage
 */
async function uploadPageImages(
  imagePaths: string[],
  bookId: string,
  bucket: any
): Promise<PageImage[]> {
  const uploadedImages: PageImage[] = [];

  for (let i = 0; i < imagePaths.length; i++) {
    const imagePath = imagePaths[i];
    const pageNumber = i + 1;

    // Storage path for this page
    const storagePath = `book_pages/${bookId}/page_${pageNumber.toString().padStart(4, '0')}.png`;

    console.log(`Uploading page ${pageNumber}/${imagePaths.length}...`);

    // Upload to Firebase Storage
    await bucket.upload(imagePath, {
      destination: storagePath,
      metadata: {
        contentType: 'image/png',
        metadata: {
          bookId,
          pageNumber: pageNumber.toString(),
        },
      },
    });

    // Get download URL
    const file = bucket.file(storagePath);
    const [url] = await file.getSignedUrl({
      action: 'read',
      expires: '01-01-2100', // Far future date for permanent access
    });

    // Get file stats
    const stats = await fs.stat(imagePath);

    uploadedImages.push({
      page_number: pageNumber,
      image_url: url,
      storage_path: storagePath,
      width: 0, // Can be extracted if needed
      height: 0,
      file_size: stats.size,
    });
  }

  return uploadedImages;
}

/**
 * Create page documents in Firestore
 */
async function createPageDocuments(
  images: PageImage[],
  bookId: string
): Promise<void> {
  const batchSize = 500;

  for (let i = 0; i < images.length; i += batchSize) {
    const batch = admin.firestore().batch();
    const batchImages = images.slice(i, i + batchSize);

    for (const image of batchImages) {
      const pageId = `${bookId}_page_${image.page_number.toString().padStart(4, '0')}`;
      const pageRef = admin.firestore().collection('book_pages').doc(pageId);

      const pageData: BookPage = {
        page_id: pageId,
        book_id: bookId,
        page_number: image.page_number,
        image_url: image.image_url,
        storage_path: image.storage_path,
        has_ocr: false,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      };

      batch.set(pageRef, pageData);
    }

    await batch.commit();
    console.log(`Saved batch: ${i + batchImages.length}/${images.length} pages`);
  }
}

/**
 * Extract text from images using OCR (optional)
 */
async function extractTextFromImages(
  images: PageImage[]
): Promise<PageImage[]> {
  // TODO: Implement OCR using Google Cloud Vision API or Tesseract
  // For now, return images as-is
  console.log('OCR not yet implemented');
  return images;
}

/**
 * Helper: Find book by filename
 */
async function findBookByFilename(filename: string) {
  const snapshot = await admin.firestore()
    .collection('books')
    .where('original_filename', '==', filename)
    .limit(1)
    .get();

  return snapshot.empty ? null : snapshot.docs[0];
}
