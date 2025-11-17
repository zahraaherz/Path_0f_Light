#!/usr/bin/env node
/**
 * Generate Complete Quran JSON for Firestore
 * Downloads from Al-Quran Cloud API and formats for your app
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

// API endpoints
const QURAN_API = 'https://api.alquran.cloud/v1/quran';
const ARABIC_EDITION = 'quran-uthmani'; // Uthmani script
const ENGLISH_EDITION = 'en.sahih'; // Sahih International translation

// Complete Surah metadata (all 114 Surahs)
const SURAH_METADATA = [
  { num: 1, name_ar: "الفاتحة", name_en: "Al-Fatiha", verses: 7, place: "Makkah", page_start: 1, page_end: 1 },
  { num: 2, name_ar: "البقرة", name_en: "Al-Baqarah", verses: 286, place: "Madinah", page_start: 2, page_end: 49 },
  { num: 3, name_ar: "آل عمران", name_en: "Ali 'Imran", verses: 200, place: "Madinah", page_start: 50, page_end: 76 },
  { num: 4, name_ar: "النساء", name_en: "An-Nisa", verses: 176, place: "Madinah", page_start: 77, page_end: 106 },
  { num: 5, name_ar: "المائدة", name_en: "Al-Ma'idah", verses: 120, place: "Madinah", page_start: 106, page_end: 127 },
  { num: 6, name_ar: "الأنعام", name_en: "Al-An'am", verses: 165, place: "Makkah", page_start: 128, page_end: 150 },
  { num: 7, name_ar: "الأعراف", name_en: "Al-A'raf", verses: 206, place: "Makkah", page_start: 151, page_end: 176 },
  { num: 8, name_ar: "الأنفال", name_en: "Al-Anfal", verses: 75, place: "Madinah", page_start: 177, page_end: 186 },
  { num: 9, name_ar: "التوبة", name_en: "At-Tawbah", verses: 129, place: "Madinah", page_start: 187, page_end: 207 },
  { num: 10, name_ar: "يونس", name_en: "Yunus", verses: 109, place: "Makkah", page_start: 208, page_end: 221 },
  { num: 11, name_ar: "هود", name_en: "Hud", verses: 123, place: "Makkah", page_start: 221, page_end: 235 },
  { num: 12, name_ar: "يوسف", name_en: "Yusuf", verses: 111, place: "Makkah", page_start: 235, page_end: 248 },
  { num: 13, name_ar: "الرعد", name_en: "Ar-Ra'd", verses: 43, place: "Madinah", page_start: 249, page_end: 255 },
  { num: 14, name_ar: "إبراهيم", name_en: "Ibrahim", verses: 52, place: "Makkah", page_start: 255, page_end: 261 },
  { num: 15, name_ar: "الحجر", name_en: "Al-Hijr", verses: 99, place: "Makkah", page_start: 262, page_end: 267 },
  { num: 16, name_ar: "النحل", name_en: "An-Nahl", verses: 128, place: "Makkah", page_start: 267, page_end: 281 },
  { num: 17, name_ar: "الإسراء", name_en: "Al-Isra", verses: 111, place: "Makkah", page_start: 282, page_end: 293 },
  { num: 18, name_ar: "الكهف", name_en: "Al-Kahf", verses: 110, place: "Makkah", page_start: 293, page_end: 304 },
  { num: 19, name_ar: "مريم", name_en: "Maryam", verses: 98, place: "Makkah", page_start: 305, page_end: 312 },
  { num: 20, name_ar: "طه", name_en: "Taha", verses: 135, place: "Makkah", page_start: 312, page_end: 321 },
  { num: 21, name_ar: "الأنبياء", name_en: "Al-Anbya", verses: 112, place: "Makkah", page_start: 322, page_end: 331 },
  { num: 22, name_ar: "الحج", name_en: "Al-Hajj", verses: 78, place: "Madinah", page_start: 332, page_end: 341 },
  { num: 23, name_ar: "المؤمنون", name_en: "Al-Mu'minun", verses: 118, place: "Makkah", page_start: 342, page_end: 349 },
  { num: 24, name_ar: "النور", name_en: "An-Nur", verses: 64, place: "Madinah", page_start: 350, page_end: 359 },
  { num: 25, name_ar: "الفرقان", name_en: "Al-Furqan", verses: 77, place: "Makkah", page_start: 359, page_end: 366 },
  { num: 26, name_ar: "الشعراء", name_en: "Ash-Shu'ara", verses: 227, place: "Makkah", page_start: 367, page_end: 377 },
  { num: 27, name_ar: "النمل", name_en: "An-Naml", verses: 93, place: "Makkah", page_start: 377, page_end: 385 },
  { num: 28, name_ar: "القصص", name_en: "Al-Qasas", verses: 88, place: "Makkah", page_start: 385, page_end: 396 },
  { num: 29, name_ar: "العنكبوت", name_en: "Al-'Ankabut", verses: 69, place: "Makkah", page_start: 396, page_end: 404 },
  { num: 30, name_ar: "الروم", name_en: "Ar-Rum", verses: 60, place: "Makkah", page_start: 404, page_end: 410 },
  { num: 31, name_ar: "لقمان", name_en: "Luqman", verses: 34, place: "Makkah", page_start: 411, page_end: 414 },
  { num: 32, name_ar: "السجدة", name_en: "As-Sajdah", verses: 30, place: "Makkah", page_start: 415, page_end: 417 },
  { num: 33, name_ar: "الأحزاب", name_en: "Al-Ahzab", verses: 73, place: "Madinah", page_start: 418, page_end: 427 },
  { num: 34, name_ar: "سبأ", name_en: "Saba", verses: 54, place: "Makkah", page_start: 428, page_end: 433 },
  { num: 35, name_ar: "فاطر", name_en: "Fatir", verses: 45, place: "Makkah", page_start: 434, page_end: 440 },
  { num: 36, name_ar: "يس", name_en: "Ya-Sin", verses: 83, place: "Makkah", page_start: 440, page_end: 445 },
  { num: 37, name_ar: "الصافات", name_en: "As-Saffat", verses: 182, place: "Makkah", page_start: 446, page_end: 452 },
  { num: 38, name_ar: "ص", name_en: "Sad", verses: 88, place: "Makkah", page_start: 453, page_end: 458 },
  { num: 39, name_ar: "الزمر", name_en: "Az-Zumar", verses: 75, place: "Makkah", page_start: 458, page_end: 467 },
  { num: 40, name_ar: "غافر", name_en: "Ghafir", verses: 85, place: "Makkah", page_start: 467, page_end: 476 },
  { num: 41, name_ar: "فصلت", name_en: "Fussilat", verses: 54, place: "Makkah", page_start: 477, page_end: 482 },
  { num: 42, name_ar: "الشورى", name_en: "Ash-Shuraa", verses: 53, place: "Makkah", page_start: 483, page_end: 489 },
  { num: 43, name_ar: "الزخرف", name_en: "Az-Zukhruf", verses: 89, place: "Makkah", page_start: 489, page_end: 495 },
  { num: 44, name_ar: "الدخان", name_en: "Ad-Dukhan", verses: 59, place: "Makkah", page_start: 496, page_end: 498 },
  { num: 45, name_ar: "الجاثية", name_en: "Al-Jathiyah", verses: 37, place: "Makkah", page_start: 499, page_end: 502 },
  { num: 46, name_ar: "الأحقاف", name_en: "Al-Ahqaf", verses: 35, place: "Makkah", page_start: 502, page_end: 506 },
  { num: 47, name_ar: "محمد", name_en: "Muhammad", verses: 38, place: "Madinah", page_start: 507, page_end: 510 },
  { num: 48, name_ar: "الفتح", name_en: "Al-Fath", verses: 29, place: "Madinah", page_start: 511, page_end: 515 },
  { num: 49, name_ar: "الحجرات", name_en: "Al-Hujurat", verses: 18, place: "Madinah", page_start: 515, page_end: 517 },
  { num: 50, name_ar: "ق", name_en: "Qaf", verses: 45, place: "Makkah", page_start: 518, page_end: 520 },
  { num: 51, name_ar: "الذاريات", name_en: "Adh-Dhariyat", verses: 60, place: "Makkah", page_start: 520, page_end: 523 },
  { num: 52, name_ar: "الطور", name_en: "At-Tur", verses: 49, place: "Makkah", page_start: 523, page_end: 525 },
  { num: 53, name_ar: "النجم", name_en: "An-Najm", verses: 62, place: "Makkah", page_start: 526, page_end: 528 },
  { num: 54, name_ar: "القمر", name_en: "Al-Qamar", verses: 55, place: "Makkah", page_start: 528, page_end: 531 },
  { num: 55, name_ar: "الرحمن", name_en: "Ar-Rahman", verses: 78, place: "Madinah", page_start: 531, page_end: 534 },
  { num: 56, name_ar: "الواقعة", name_en: "Al-Waqi'ah", verses: 96, place: "Makkah", page_start: 534, page_end: 537 },
  { num: 57, name_ar: "الحديد", name_en: "Al-Hadid", verses: 29, place: "Madinah", page_start: 537, page_end: 541 },
  { num: 58, name_ar: "المجادلة", name_en: "Al-Mujadila", verses: 22, place: "Madinah", page_start: 542, page_end: 545 },
  { num: 59, name_ar: "الحشر", name_en: "Al-Hashr", verses: 24, place: "Madinah", page_start: 545, page_end: 548 },
  { num: 60, name_ar: "الممتحنة", name_en: "Al-Mumtahanah", verses: 13, place: "Madinah", page_start: 549, page_end: 551 },
  { num: 61, name_ar: "الصف", name_en: "As-Saf", verses: 14, place: "Madinah", page_start: 551, page_end: 553 },
  { num: 62, name_ar: "الجمعة", name_en: "Al-Jumu'ah", verses: 11, place: "Madinah", page_start: 553, page_end: 554 },
  { num: 63, name_ar: "المنافقون", name_en: "Al-Munafiqun", verses: 11, place: "Madinah", page_start: 554, page_end: 555 },
  { num: 64, name_ar: "التغابن", name_en: "At-Taghabun", verses: 18, place: "Madinah", page_start: 556, page_end: 557 },
  { num: 65, name_ar: "الطلاق", name_en: "At-Talaq", verses: 12, place: "Madinah", page_start: 558, page_end: 560 },
  { num: 66, name_ar: "التحريم", name_en: "At-Tahrim", verses: 12, place: "Madinah", page_start: 560, page_end: 561 },
  { num: 67, name_ar: "الملك", name_en: "Al-Mulk", verses: 30, place: "Makkah", page_start: 562, page_end: 564 },
  { num: 68, name_ar: "القلم", name_en: "Al-Qalam", verses: 52, place: "Makkah", page_start: 564, page_end: 566 },
  { num: 69, name_ar: "الحاقة", name_en: "Al-Haqqah", verses: 52, place: "Makkah", page_start: 566, page_end: 568 },
  { num: 70, name_ar: "المعارج", name_en: "Al-Ma'arij", verses: 44, place: "Makkah", page_start: 568, page_end: 570 },
  { num: 71, name_ar: "نوح", name_en: "Nuh", verses: 28, place: "Makkah", page_start: 570, page_end: 571 },
  { num: 72, name_ar: "الجن", name_en: "Al-Jinn", verses: 28, place: "Makkah", page_start: 572, page_end: 573 },
  { num: 73, name_ar: "المزمل", name_en: "Al-Muzzammil", verses: 20, place: "Makkah", page_start: 574, page_end: 575 },
  { num: 74, name_ar: "المدثر", name_en: "Al-Muddaththir", verses: 56, place: "Makkah", page_start: 575, page_end: 577 },
  { num: 75, name_ar: "القيامة", name_en: "Al-Qiyamah", verses: 40, place: "Makkah", page_start: 577, page_end: 578 },
  { num: 76, name_ar: "الإنسان", name_en: "Al-Insan", verses: 31, place: "Madinah", page_start: 578, page_end: 580 },
  { num: 77, name_ar: "المرسلات", name_en: "Al-Mursalat", verses: 50, place: "Makkah", page_start: 580, page_end: 581 },
  { num: 78, name_ar: "النبأ", name_en: "An-Naba", verses: 40, place: "Makkah", page_start: 582, page_end: 583 },
  { num: 79, name_ar: "النازعات", name_en: "An-Nazi'at", verses: 46, place: "Makkah", page_start: 583, page_end: 585 },
  { num: 80, name_ar: "عبس", name_en: "'Abasa", verses: 42, place: "Makkah", page_start: 585, page_end: 586 },
  { num: 81, name_ar: "التكوير", name_en: "At-Takwir", verses: 29, place: "Makkah", page_start: 586, page_end: 587 },
  { num: 82, name_ar: "الإنفطار", name_en: "Al-Infitar", verses: 19, place: "Makkah", page_start: 587, page_end: 587 },
  { num: 83, name_ar: "المطففين", name_en: "Al-Mutaffifin", verses: 36, place: "Makkah", page_start: 587, page_end: 589 },
  { num: 84, name_ar: "الإنشقاق", name_en: "Al-Inshiqaq", verses: 25, place: "Makkah", page_start: 589, page_end: 590 },
  { num: 85, name_ar: "البروج", name_en: "Al-Buruj", verses: 22, place: "Makkah", page_start: 590, page_end: 591 },
  { num: 86, name_ar: "الطارق", name_en: "At-Tariq", verses: 17, place: "Makkah", page_start: 591, page_end: 591 },
  { num: 87, name_ar: "الأعلى", name_en: "Al-A'la", verses: 19, place: "Makkah", page_start: 591, page_end: 592 },
  { num: 88, name_ar: "الغاشية", name_en: "Al-Ghashiyah", verses: 26, place: "Makkah", page_start: 592, page_end: 592 },
  { num: 89, name_ar: "الفجر", name_en: "Al-Fajr", verses: 30, place: "Makkah", page_start: 593, page_end: 594 },
  { num: 90, name_ar: "البلد", name_en: "Al-Balad", verses: 20, place: "Makkah", page_start: 594, page_end: 595 },
  { num: 91, name_ar: "الشمس", name_en: "Ash-Shams", verses: 15, place: "Makkah", page_start: 595, page_end: 595 },
  { num: 92, name_ar: "الليل", name_en: "Al-Layl", verses: 21, place: "Makkah", page_start: 595, page_end: 596 },
  { num: 93, name_ar: "الضحى", name_en: "Ad-Duhaa", verses: 11, place: "Makkah", page_start: 596, page_end: 596 },
  { num: 94, name_ar: "الشرح", name_en: "Ash-Sharh", verses: 8, place: "Makkah", page_start: 596, page_end: 596 },
  { num: 95, name_ar: "التين", name_en: "At-Tin", verses: 8, place: "Makkah", page_start: 597, page_end: 597 },
  { num: 96, name_ar: "العلق", name_en: "Al-'Alaq", verses: 19, place: "Makkah", page_start: 597, page_end: 597 },
  { num: 97, name_ar: "القدر", name_en: "Al-Qadr", verses: 5, place: "Makkah", page_start: 598, page_end: 598 },
  { num: 98, name_ar: "البينة", name_en: "Al-Bayyinah", verses: 8, place: "Madinah", page_start: 598, page_end: 599 },
  { num: 99, name_ar: "الزلزلة", name_en: "Az-Zalzalah", verses: 8, place: "Madinah", page_start: 599, page_end: 599 },
  { num: 100, name_ar: "العاديات", name_en: "Al-'Adiyat", verses: 11, place: "Makkah", page_start: 599, page_end: 600 },
  { num: 101, name_ar: "القارعة", name_en: "Al-Qari'ah", verses: 11, place: "Makkah", page_start: 600, page_end: 600 },
  { num: 102, name_ar: "التكاثر", name_en: "At-Takathur", verses: 8, place: "Makkah", page_start: 600, page_end: 600 },
  { num: 103, name_ar: "العصر", name_en: "Al-'Asr", verses: 3, place: "Makkah", page_start: 600, page_end: 600 },
  { num: 104, name_ar: "الهمزة", name_en: "Al-Humazah", verses: 9, place: "Makkah", page_start: 601, page_end: 601 },
  { num: 105, name_ar: "الفيل", name_en: "Al-Fil", verses: 5, place: "Makkah", page_start: 601, page_end: 601 },
  { num: 106, name_ar: "قريش", name_en: "Quraysh", verses: 4, place: "Makkah", page_start: 601, page_end: 601 },
  { num: 107, name_ar: "الماعون", name_en: "Al-Ma'un", verses: 7, place: "Makkah", page_start: 602, page_end: 602 },
  { num: 108, name_ar: "الكوثر", name_en: "Al-Kawthar", verses: 3, place: "Makkah", page_start: 602, page_end: 602 },
  { num: 109, name_ar: "الكافرون", name_en: "Al-Kafirun", verses: 6, place: "Makkah", page_start: 603, page_end: 603 },
  { num: 110, name_ar: "النصر", name_en: "An-Nasr", verses: 3, place: "Madinah", page_start: 603, page_end: 603 },
  { num: 111, name_ar: "المسد", name_en: "Al-Masad", verses: 5, place: "Makkah", page_start: 603, page_end: 603 },
  { num: 112, name_ar: "الإخلاص", name_en: "Al-Ikhlas", verses: 4, place: "Makkah", page_start: 604, page_end: 604 },
  { num: 113, name_ar: "الفلق", name_en: "Al-Falaq", verses: 5, place: "Makkah", page_start: 604, page_end: 604 },
  { num: 114, name_ar: "الناس", name_en: "An-Nas", verses: 6, place: "Makkah", page_start: 604, page_end: 604 }
];

// Fetch JSON from URL
function fetchJSON(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          resolve(JSON.parse(data));
        } catch (e) {
          reject(e);
        }
      });
    }).on('error', reject);
  });
}

// Generate complete sections JSON
function generateSections() {
  console.log('📝 Generating all 114 Surah sections...');

  const sections = SURAH_METADATA.map(surah => ({
    id: `quran_001_surah_${String(surah.num).padStart(3, '0')}`,
    book_id: 'quran_001',
    book_title_ar: 'القرآن الكريم',
    book_title_en: 'The Holy Quran',
    section_number: surah.num,
    title_ar: surah.name_ar,
    title_en: surah.name_en,
    paragraph_count: surah.verses,
    page_range: `${surah.page_start}-${surah.page_end}`,
    difficulty_level: surah.verses < 20 ? 'basic' : (surah.verses < 100 ? 'intermediate' : 'advanced'),
    topics: [],
    revelation_place: surah.place
  }));

  return sections;
}

// Extract keywords from text
function extractKeywords(text) {
  const words = text.split(/\s+/).filter(w => w.length > 2);
  return words.slice(0, 10);
}

// Generate complete paragraphs (verses) JSON
async function generateParagraphs() {
  console.log('📥 Fetching Quran verses from API...');

  try {
    // Fetch Arabic text
    const arabicData = await fetchJSON(`${QURAN_API}/${ARABIC_EDITION}`);
    // Fetch English translation
    const englishData = await fetchJSON(`${QURAN_API}/${ENGLISH_EDITION}`);

    console.log('📝 Processing all 6,236 verses...');

    const paragraphs = [];

    for (let surahNum = 1; surahNum <= 114; surahNum++) {
      const surahMeta = SURAH_METADATA[surahNum - 1];
      const arabicSurah = arabicData.data.surahs[surahNum - 1];
      const englishSurah = englishData.data.surahs[surahNum - 1];

      for (let verseNum = 1; verseNum <= surahMeta.verses; verseNum++) {
        const arabicVerse = arabicSurah.ayahs[verseNum - 1];
        const englishVerse = englishSurah.ayahs[verseNum - 1];

        const paragraph = {
          id: `quran_para_${String(surahNum).padStart(3, '0')}_${String(verseNum).padStart(3, '0')}`,
          book_id: 'quran_001',
          section_id: `quran_001_surah_${String(surahNum).padStart(3, '0')}`,
          section_title_ar: surahMeta.name_ar,
          section_title_en: surahMeta.name_en,
          paragraph_number: verseNum,
          page_number: arabicVerse.page || surahMeta.page_start,
          content: {
            text_ar: arabicVerse.text,
            text_en: englishVerse.text
          },
          entities: {
            people: [],
            places: [],
            events: [],
            dates: []
          },
          search_data: {
            keywords_ar: extractKeywords(arabicVerse.text),
            keywords_en: extractKeywords(englishVerse.text)
          },
          references: {
            referenced_in_questions: [],
            related_paragraphs: []
          },
          metadata: {
            difficulty: 'basic',
            reading_time_seconds: Math.max(3, Math.floor(arabicVerse.text.length / 10)),
            question_potential: {
              facts_count: 0,
              can_generate_questions: true
            },
            content_priority: [1, 2, 18, 36, 55].includes(surahNum) ? 'high' : 'medium'
          },
          created_at: null
        };

        paragraphs.push(paragraph);
      }

      if (surahNum % 10 === 0) {
        console.log(`  ✓ Processed ${surahNum}/114 Surahs`);
      }
    }

    return paragraphs;

  } catch (error) {
    console.error('❌ Error fetching Quran data:', error.message);
    throw error;
  }
}

// Main function
async function main() {
  console.log('🌙 Generating Complete Quran JSON');
  console.log('='.repeat(50));

  const outputDir = path.join(__dirname, '..', 'assets', 'quran');

  try {
    // Generate sections
    const sections = generateSections();
    fs.writeFileSync(
      path.join(outputDir, 'quran_sections_complete.json'),
      JSON.stringify(sections, null, 2),
      'utf-8'
    );
    console.log(`✅ Generated ${sections.length} sections → quran_sections_complete.json`);

    // Generate paragraphs
    const paragraphs = await generateParagraphs();
    fs.writeFileSync(
      path.join(outputDir, 'quran_paragraphs_complete.json'),
      JSON.stringify(paragraphs, null, 2),
      'utf-8'
    );
    console.log(`✅ Generated ${paragraphs.length} verses → quran_paragraphs_complete.json`);

    console.log('\n🎉 Complete Quran JSON generated successfully!');
    console.log(`\n📊 Summary:`);
    console.log(`   - Total Surahs: ${sections.length}`);
    console.log(`   - Total Ayahs: ${paragraphs.length}`);
    console.log(`\n📤 Next: Upload to Firestore using the upload script`);

  } catch (error) {
    console.error('❌ Failed to generate Quran JSON:', error);
    process.exit(1);
  }
}

main();
