#!/usr/bin/env node
/**
 * Transform downloaded Quran JSON to app format
 */

const fs = require('fs');
const path = require('path');

// Read the downloaded Quran data
const quranData = JSON.parse(fs.readFileSync('/tmp/quran_source.json', 'utf8'));

// Surah metadata (114 Surahs) with page numbers
const SURAH_PAGES = [
  [1,1], [2,49], [50,76], [77,106], [106,127], [128,150], [151,176], [177,186], [187,207], [208,221],
  [221,235], [235,248], [249,255], [255,261], [262,267], [267,281], [282,293], [293,304], [305,312], [312,321],
  [322,331], [332,341], [342,349], [350,359], [359,366], [367,377], [377,385], [385,396], [396,404], [404,410],
  [411,414], [415,417], [418,427], [428,433], [434,440], [440,445], [446,452], [453,458], [458,467], [467,476],
  [477,482], [483,489], [489,495], [496,498], [499,502], [502,506], [507,510], [511,515], [515,517], [518,520],
  [520,523], [523,525], [526,528], [528,531], [531,534], [534,537], [537,541], [542,545], [545,548], [549,551],
  [551,553], [553,554], [554,555], [556,557], [558,560], [560,561], [562,564], [564,566], [566,568], [568,570],
  [570,571], [572,573], [574,575], [575,577], [577,578], [578,580], [580,581], [582,583], [583,585], [585,586],
  [586,587], [587,587], [587,589], [589,590], [590,591], [591,591], [591,592], [592,592], [593,594], [594,595],
  [595,595], [595,596], [596,596], [596,596], [597,597], [597,597], [598,598], [598,599], [599,599], [599,600],
  [600,600], [600,600], [600,600], [601,601], [601,601], [601,601], [602,602], [602,602], [603,603], [603,603],
  [603,603], [604,604], [604,604], [604,604]
];

// Extract keywords
function extractKeywords(text) {
  const words = text.split(/\s+/).filter(w => w.length > 2);
  return words.slice(0, 10);
}

// Generate sections
console.log('📝 Generating sections...');
const sections = [];

quranData.forEach((surah, idx) => {
  const pages = SURAH_PAGES[idx] || [1, 1];
  sections.push({
    id: `quran_001_surah_${String(surah.id).padStart(3, '0')}`,
    book_id: 'quran_001',
    book_title_ar: 'القرآن الكريم',
    book_title_en: 'The Holy Quran',
    section_number: surah.id,
    title_ar: surah.name,
    title_en: surah.transliteration,
    paragraph_count: surah.total_verses,
    page_range: `${pages[0]}-${pages[1]}`,
    difficulty_level: surah.total_verses < 20 ? 'basic' : (surah.total_verses < 100 ? 'intermediate' : 'advanced'),
    topics: [],
    revelation_place: surah.type === 'meccan' ? 'Makkah' : 'Madinah'
  });
});

//Save sections
const outputDir = path.join(__dirname, '..', 'assets', 'quran');
fs.writeFileSync(
  path.join(outputDir, 'quran_sections_complete.json'),
  JSON.stringify(sections, null, 2),
  'utf8'
);
console.log(`✅ Saved ${sections.length} sections`);

// Generate paragraphs
console.log('📝 Generating paragraphs...');
const paragraphs = [];
let currentPage = 1;

quranData.forEach((surah, surahIdx) => {
  const pages = SURAH_PAGES[surahIdx] || [1, 1];
  const versePerPage = (pages[1] - pages[0] + 1) / surah.total_verses || 1;

  surah.verses.forEach((verse, verseIdx) => {
    // Estimate page number
    const estimatedPage = Math.floor(pages[0] + (verseIdx * versePerPage));

    const paragraph = {
      id: `quran_para_${String(surah.id).padStart(3, '0')}_${String(verse.id).padStart(3, '0')}`,
      book_id: 'quran_001',
      section_id: `quran_001_surah_${String(surah.id).padStart(3, '0')}`,
      section_title_ar: surah.name,
      section_title_en: surah.transliteration,
      paragraph_number: verse.id,
      page_number: estimatedPage,
      content: {
        text_ar: verse.text,
        text_en: verse.translation
      },
      entities: {
        people: [],
        places: [],
        events: [],
        dates: []
      },
      search_data: {
        keywords_ar: extractKeywords(verse.text),
        keywords_en: extractKeywords(verse.translation)
      },
      references: {
        referenced_in_questions: [],
        related_paragraphs: []
      },
      metadata: {
        difficulty: 'basic',
        reading_time_seconds: Math.max(3, Math.floor(verse.text.length / 10)),
        question_potential: {
          facts_count: 0,
          can_generate_questions: true
        },
        content_priority: [1, 2, 18, 36, 55].includes(surah.id) ? 'high' : 'medium'
      },
      created_at: null
    };

    paragraphs.push(paragraph);
  });

  if ((surahIdx + 1) % 10 === 0) {
    console.log(`  ✓ Processed ${surahIdx + 1}/114 Surahs`);
  }
});

// Save paragraphs
fs.writeFileSync(
  path.join(outputDir, 'quran_paragraphs_complete.json'),
  JSON.stringify(paragraphs, null, 2),
  'utf8'
);
console.log(`✅ Saved ${paragraphs.length} paragraphs`);

console.log('\n🎉 Complete Quran JSON generated successfully!');
console.log(`📊 Summary:`);
console.log(`   - Total Surahs: ${sections.length}`);
console.log(`   - Total Ayahs: ${paragraphs.length}`);
console.log(`\n✅ Files ready for Firestore upload!`);
