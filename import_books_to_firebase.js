/**
 * Firebase Books Import Script
 *
 * This script imports book metadata from firebase_books_import.json into Firestore.
 *
 * Usage:
 * 1. Make sure Firebase Admin SDK is initialized
 * 2. Run: node import_books_to_firebase.js
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  // Make sure you have your service account key file
  // const serviceAccount = require('./path-to-your-service-account-key.json');

  admin.initializeApp({
    // credential: admin.credential.cert(serviceAccount),
    // Or use default credentials if running in Firebase Functions or Cloud
    credential: admin.credential.applicationDefault(),
  });
}

const db = admin.firestore();

/**
 * Import books from JSON file to Firestore
 */
async function importBooks() {
  try {
    console.log('📚 Starting book import process...\n');

    // Read the JSON file
    const jsonPath = path.join(__dirname, 'firebase_books_import.json');
    const jsonData = fs.readFileSync(jsonPath, 'utf8');
    const data = JSON.parse(jsonData);

    const books = data.books;
    console.log(`Found ${books.length} books to import\n`);

    // Import books in batches (Firestore batch limit is 500)
    const batchSize = 500;
    let importedCount = 0;
    let errorCount = 0;

    for (let i = 0; i < books.length; i += batchSize) {
      const batch = db.batch();
      const batchBooks = books.slice(i, i + batchSize);

      console.log(`Processing batch ${Math.floor(i / batchSize) + 1}...`);

      for (const book of batchBooks) {
        try {
          const bookRef = db.collection('books').doc(book.id);

          // Prepare the book data
          const bookData = {
            ...book,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
          };

          batch.set(bookRef, bookData, { merge: true });
          importedCount++;

          console.log(`  ✓ Queued: ${book.title_en} (${book.title_ar})`);
        } catch (error) {
          console.error(`  ✗ Error with book ${book.id}:`, error.message);
          errorCount++;
        }
      }

      // Commit the batch
      await batch.commit();
      console.log(`  Batch committed successfully!\n`);

      // Small delay between batches to avoid rate limits
      if (i + batchSize < books.length) {
        await new Promise(resolve => setTimeout(resolve, 100));
      }
    }

    console.log('\n' + '='.repeat(60));
    console.log('📊 Import Summary:');
    console.log('='.repeat(60));
    console.log(`✓ Successfully imported: ${importedCount} books`);
    if (errorCount > 0) {
      console.log(`✗ Errors: ${errorCount}`);
    }
    console.log('='.repeat(60) + '\n');

    console.log('✨ Import completed successfully!\n');
    console.log('Next steps:');
    console.log('1. Upload PDF files to Firebase Storage at: islamic_books/');
    console.log('2. The processUploadedBook Cloud Function will automatically extract text');
    console.log('3. Check the Firestore console to verify the imported data\n');

  } catch (error) {
    console.error('❌ Fatal error during import:', error);
    process.exit(1);
  }
}

/**
 * Verify book data before import
 */
async function verifyExistingBooks() {
  try {
    const snapshot = await db.collection('books').limit(5).get();
    console.log(`\nFound ${snapshot.size} existing books in Firestore`);

    if (!snapshot.empty) {
      console.log('\nFirst few existing books:');
      snapshot.forEach(doc => {
        const data = doc.data();
        console.log(`  - ${data.title_en} (${data.title_ar})`);
      });
      console.log('');
    }
  } catch (error) {
    console.error('Error checking existing books:', error.message);
  }
}

/**
 * Main execution
 */
async function main() {
  console.log('\n' + '='.repeat(60));
  console.log('  Firebase Books Import Script');
  console.log('  Path of Light - Islamic Books Library');
  console.log('='.repeat(60) + '\n');

  // Check existing books
  await verifyExistingBooks();

  // Confirm before proceeding
  console.log('⚠️  This will import/update book records in Firestore.');
  console.log('   Existing books with the same ID will be updated (merged).\n');

  // In production, you might want to add a confirmation prompt here
  // For now, we'll proceed automatically

  await importBooks();

  console.log('All done! 🎉\n');
  process.exit(0);
}

// Run the script
main().catch(error => {
  console.error('Unhandled error:', error);
  process.exit(1);
});
