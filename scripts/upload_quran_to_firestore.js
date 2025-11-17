#!/usr/bin/env node
/**
 * Upload Complete Quran to Firestore
 *
 * IMPORTANT: Before running, ensure you have:
 * 1. Firebase Admin SDK installed: npm install firebase-admin
 * 2. Service account key file downloaded from Firebase Console
 * 3. Updated the serviceAccountPath below
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

//=====================================================
// CONFIGURATION - UPDATE THESE PATHS
//=====================================================
const serviceAccountPath = './serviceAccountKey.json'; // Path to your Firebase service account key
const assetsDir = path.join(__dirname, '..', 'assets', 'quran');

// Initialize Firebase Admin
try {
  const serviceAccount = require(serviceAccountPath);
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
  console.log('✅ Firebase Admin initialized');
} catch (error) {
  console.error('❌ Error initializing Firebase:');
  console.error('   Make sure you have downloaded the service account key from Firebase Console');
  console.error('   and updated the serviceAccountPath in this script.');
  console.error(`\n   Expected path: ${serviceAccountPath}`);
  process.exit(1);
}

const db = admin.firestore();

//=====================================================
// HELPER FUNCTIONS
//=====================================================

/**
 * Upload data in batches (Firestore limit: 500 operations per batch)
 */
async function uploadInBatches(collectionName, data, batchSize = 400) {
  const totalBatches = Math.ceil(data.length / batchSize);

  console.log(`📤 Uploading ${data.length} documents to '${collectionName}' in ${totalBatches} batches...`);

  for (let i = 0; i < data.length; i += batchSize) {
    const batch = db.batch();
    const chunk = data.slice(i, i + batchSize);

    chunk.forEach(item => {
      const docRef = db.collection(collectionName).doc(item.id);
      const docData = { ...item };
      delete docData.id; // Remove id from data (it's in the document path)
      batch.set(docRef, docData);
    });

    await batch.commit();
    const batchNum = Math.floor(i / batchSize) + 1;
    console.log(`   ✓ Batch ${batchNum}/${totalBatches} uploaded (${chunk.length} documents)`);
  }

  console.log(`✅ Successfully uploaded ${data.length} documents to '${collectionName}'`);
}

/**
 * Upload a single document
 */
async function uploadDocument(collectionName, docId, data) {
  await db.collection(collectionName).doc(docId).set(data);
  console.log(`✅ Uploaded document to '${collectionName}/${docId}'`);
}

//=====================================================
// UPLOAD FUNCTIONS
//=====================================================

/**
 * Upload Quran book metadata
 */
async function uploadQuranBook() {
  console.log('\n📖 Step 1: Uploading Quran book metadata...');

  const bookData = JSON.parse(
    fs.readFileSync(path.join(assetsDir, 'quran_book.json'), 'utf8')
  );

  await uploadDocument('books', bookData.id, bookData);
}

/**
 * Upload all Quran sections (114 Surahs)
 */
async function uploadQuranSections() {
  console.log('\n📚 Step 2: Uploading 114 Surah sections...');

  const sectionsData = JSON.parse(
    fs.readFileSync(path.join(assetsDir, 'quran_sections_complete.json'), 'utf8')
  );

  await uploadInBatches('sections', sectionsData);
}

/**
 * Upload all Quran paragraphs (6,236 verses)
 */
async function uploadQuranParagraphs() {
  console.log('\n📜 Step 3: Uploading 6,236 Quran verses...');
  console.log('⏳ This may take a few minutes...');

  const paragraphsData = JSON.parse(
    fs.readFileSync(path.join(assetsDir, 'quran_paragraphs_complete.json'), 'utf8')
  );

  await uploadInBatches('paragraphs', paragraphsData, 400); // 400 per batch for safety
}

//=====================================================
// MAIN EXECUTION
//=====================================================

async function main() {
  console.log('🌙 Quran Upload to Firestore');
  console.log('='.repeat(50));
  console.log('This will upload:');
  console.log('  - 1 book (Quran metadata)');
  console.log('  - 114 sections (Surahs)');
  console.log('  - 6,236 paragraphs (Ayahs/Verses)');
  console.log('='.repeat(50));

  const startTime = Date.now();

  try {
    // Step 1: Upload book
    await uploadQuranBook();

    // Step 2: Upload sections
    await uploadQuranSections();

    // Step 3: Upload paragraphs
    await uploadQuranParagraphs();

    const endTime = Date.now();
    const duration = ((endTime - startTime) / 1000).toFixed(2);

    console.log('\n' + '='.repeat(50));
    console.log('🎉 SUCCESS! Quran uploaded to Firestore!');
    console.log('='.repeat(50));
    console.log(`⏱️  Total time: ${duration} seconds`);
    console.log('\n✅ Your app can now:');
    console.log('   - Display Quran in library');
    console.log('   - Read all 114 Surahs');
    console.log('   - Search 6,236 verses');
    console.log('   - Bookmark verses');
    console.log('   - Track reading progress');
    console.log('\n📱 Open your app and check the library! 📖✨');

  } catch (error) {
    console.error('\n❌ Upload failed:', error);
    console.error('\nTroubleshooting:');
    console.error('  1. Check your internet connection');
    console.error('  2. Verify Firebase service account key is valid');
    console.error('  3. Ensure Firestore is enabled in Firebase Console');
    console.error('  4. Check Firestore security rules allow writes');
    process.exit(1);
  } finally {
    // Cleanup
    process.exit(0);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = { uploadQuranBook, uploadQuranSections, uploadQuranParagraphs };
