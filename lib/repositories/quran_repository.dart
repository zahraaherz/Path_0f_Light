import '../models/quran/quran_verse.dart';

/// Repository for accessing Quran data
///
/// NOTE: This is a simplified implementation using mock data.
/// In a production app, you would integrate with a Quran API such as:
/// - https://api.alquran.cloud/v1/surah/{number}
/// - https://quran.com/api/v4
/// - Or use a local database with full Quran text
class QuranRepository {
  QuranRepository();

  /// Get all Surahs (meta information)
  Future<List<Surah>> getAllSurahs() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return _allSurahs;
  }

  /// Get a specific Surah by number
  Future<Surah?> getSurah(int surahNumber) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _allSurahs.firstWhere((s) => s.number == surahNumber);
    } catch (e) {
      return null;
    }
  }

  /// Get verses for a specific Surah
  ///
  /// In production, this would fetch from an API or local database
  Future<List<QuranVerse>> getVersesForSurah(int surahNumber) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // For now, return mock data for first 3 surahs
    // In production, integrate with Quran API
    switch (surahNumber) {
      case 1:
        return _getFatihahVerses();
      case 2:
        return _getBaqarahVerses(); // Just first few verses as example
      case 112:
        return _getIkhlasVerses();
      default:
        // Return placeholder for other surahs
        final surah = await getSurah(surahNumber);
        if (surah == null) return [];

        return List.generate(
          surah.numberOfVerses,
          (index) => QuranVerse(
            number: index + 1,
            numberInQuran: index + 1, // This should be calculated properly
            arabicText: 'الآية ${index + 1} من سورة ${surah.arabicName}',
            englishTranslation: 'Verse ${index + 1} of Surah ${surah.englishName} (API integration needed)',
          ),
        );
    }
  }

  /// Get a specific verse
  Future<QuranVerse?> getVerse(int surahNumber, int verseNumber) async {
    final verses = await getVersesForSurah(surahNumber);
    try {
      return verses.firstWhere((v) => v.number == verseNumber);
    } catch (e) {
      return null;
    }
  }

  // ===== Mock Data =====

  /// Al-Fatihah (The Opening) - Complete
  List<QuranVerse> _getFatihahVerses() {
    return [
      const QuranVerse(
        number: 1,
        numberInQuran: 1,
        arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        englishTranslation: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
        transliteration: 'Bismillāhi r-raḥmāni r-raḥīm',
        juzNumber: 1,
        pageNumber: 1,
      ),
      const QuranVerse(
        number: 2,
        numberInQuran: 2,
        arabicText: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        englishTranslation: '[All] praise is [due] to Allah, Lord of the worlds.',
        transliteration: 'Al-ḥamdu lillāhi rabbi l-ʿālamīn',
        juzNumber: 1,
        pageNumber: 1,
      ),
      const QuranVerse(
        number: 3,
        numberInQuran: 3,
        arabicText: 'الرَّحْمَٰنِ الرَّحِيمِ',
        englishTranslation: 'The Entirely Merciful, the Especially Merciful,',
        transliteration: 'Ar-raḥmāni r-raḥīm',
        juzNumber: 1,
        pageNumber: 1,
      ),
      const QuranVerse(
        number: 4,
        numberInQuran: 4,
        arabicText: 'مَالِكِ يَوْمِ الدِّينِ',
        englishTranslation: 'Sovereign of the Day of Recompense.',
        transliteration: 'Māliki yawmi d-dīn',
        juzNumber: 1,
        pageNumber: 1,
      ),
      const QuranVerse(
        number: 5,
        numberInQuran: 5,
        arabicText: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
        englishTranslation: 'It is You we worship and You we ask for help.',
        transliteration: 'Iyyāka naʿbudu wa-iyyāka nastaʿīn',
        juzNumber: 1,
        pageNumber: 1,
      ),
      const QuranVerse(
        number: 6,
        numberInQuran: 6,
        arabicText: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
        englishTranslation: 'Guide us to the straight path -',
        transliteration: 'Ihdinā ṣ-ṣirāṭa l-mustaqīm',
        juzNumber: 1,
        pageNumber: 1,
      ),
      const QuranVerse(
        number: 7,
        numberInQuran: 7,
        arabicText: 'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
        englishTranslation: 'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.',
        transliteration: 'Ṣirāṭa lladhīna anʿamta ʿalayhim ghayri l-maghḍūbi ʿalayhim wa-lā ḍ-ḍāllīn',
        juzNumber: 1,
        pageNumber: 1,
      ),
    ];
  }

  /// Al-Baqarah (The Cow) - First 5 verses as example
  List<QuranVerse> _getBaqarahVerses() {
    return [
      const QuranVerse(
        number: 1,
        numberInQuran: 8,
        arabicText: 'الم',
        englishTranslation: 'Alif, Lam, Meem.',
        transliteration: 'Alif-Lām-Mīm',
        juzNumber: 1,
        pageNumber: 2,
      ),
      const QuranVerse(
        number: 2,
        numberInQuran: 9,
        arabicText: 'ذَٰلِكَ الْكِتَابُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ',
        englishTranslation: 'This is the Book about which there is no doubt, a guidance for those conscious of Allah.',
        transliteration: 'Dhālika l-kitābu lā rayba fīhi hudan lil-muttaqīn',
        juzNumber: 1,
        pageNumber: 2,
      ),
      const QuranVerse(
        number: 3,
        numberInQuran: 10,
        arabicText: 'الَّذِينَ يُؤْمِنُونَ بِالْغَيْبِ وَيُقِيمُونَ الصَّلَاةَ وَمِمَّا رَزَقْنَاهُمْ يُنفِقُونَ',
        englishTranslation: 'Who believe in the unseen, establish prayer, and spend out of what We have provided for them.',
        transliteration: 'Alladhīna yuʾminūna bil-ghaybi wa-yuqīmūna ṣ-ṣalāta wa-mimmā razaqnāhum yunfiqūn',
        juzNumber: 1,
        pageNumber: 2,
      ),
      // Add more verses or indicate integration needed
      const QuranVerse(
        number: 4,
        numberInQuran: 11,
        arabicText: 'وَالَّذِينَ يُؤْمِنُونَ بِمَا أُنزِلَ إِلَيْكَ وَمَا أُنزِلَ مِن قَبْلِكَ وَبِالْآخِرَةِ هُمْ يُوقِنُونَ',
        englishTranslation: 'And who believe in what has been revealed to you, [O Muhammad], and what was revealed before you, and of the Hereafter they are certain [in faith].',
        juzNumber: 1,
        pageNumber: 2,
      ),
      const QuranVerse(
        number: 5,
        numberInQuran: 12,
        arabicText: 'أُولَٰئِكَ عَلَىٰ هُدًى مِّن رَّبِّهِمْ ۖ وَأُولَٰئِكَ هُمُ الْمُفْلِحُونَ',
        englishTranslation: 'Those are upon [right] guidance from their Lord, and it is those who are the successful.',
        juzNumber: 1,
        pageNumber: 2,
      ),
    ];
  }

  /// Al-Ikhlas (The Sincerity) - Complete
  List<QuranVerse> _getIkhlasVerses() {
    return [
      const QuranVerse(
        number: 1,
        numberInQuran: 6225,
        arabicText: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
        englishTranslation: 'Say, "He is Allah, [who is] One,',
        transliteration: 'Qul huwa Allāhu aḥad',
        juzNumber: 30,
        pageNumber: 604,
      ),
      const QuranVerse(
        number: 2,
        numberInQuran: 6226,
        arabicText: 'اللَّهُ الصَّمَدُ',
        englishTranslation: 'Allah, the Eternal Refuge.',
        transliteration: 'Allāhu ṣ-ṣamad',
        juzNumber: 30,
        pageNumber: 604,
      ),
      const QuranVerse(
        number: 3,
        numberInQuran: 6227,
        arabicText: 'لَمْ يَلِدْ وَلَمْ يُولَدْ',
        englishTranslation: 'He neither begets nor is born,',
        transliteration: 'Lam yalid wa-lam yūlad',
        juzNumber: 30,
        pageNumber: 604,
      ),
      const QuranVerse(
        number: 4,
        numberInQuran: 6228,
        arabicText: 'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
        englishTranslation: 'Nor is there to Him any equivalent."',
        transliteration: 'Wa-lam yakun lahu kufuwan aḥad',
        juzNumber: 30,
        pageNumber: 604,
      ),
    ];
  }

  /// All 114 Surahs metadata
  static final List<Surah> _allSurahs = [
    const Surah(number: 1, arabicName: 'الفاتحة', englishName: 'Al-Fatihah', englishNameTranslation: 'The Opening', numberOfVerses: 7, revelationType: RevelationType.meccan),
    const Surah(number: 2, arabicName: 'البقرة', englishName: 'Al-Baqarah', englishNameTranslation: 'The Cow', numberOfVerses: 286, revelationType: RevelationType.medinan),
    const Surah(number: 3, arabicName: 'آل عمران', englishName: 'Ali \'Imran', englishNameTranslation: 'Family of Imran', numberOfVerses: 200, revelationType: RevelationType.medinan),
    const Surah(number: 4, arabicName: 'النساء', englishName: 'An-Nisa', englishNameTranslation: 'The Women', numberOfVerses: 176, revelationType: RevelationType.medinan),
    const Surah(number: 5, arabicName: 'المائدة', englishName: 'Al-Ma\'idah', englishNameTranslation: 'The Table Spread', numberOfVerses: 120, revelationType: RevelationType.medinan),
    const Surah(number: 6, arabicName: 'الأنعام', englishName: 'Al-An\'am', englishNameTranslation: 'The Cattle', numberOfVerses: 165, revelationType: RevelationType.meccan),
    const Surah(number: 7, arabicName: 'الأعراف', englishName: 'Al-A\'raf', englishNameTranslation: 'The Heights', numberOfVerses: 206, revelationType: RevelationType.meccan),
    const Surah(number: 8, arabicName: 'الأنفال', englishName: 'Al-Anfal', englishNameTranslation: 'The Spoils of War', numberOfVerses: 75, revelationType: RevelationType.medinan),
    const Surah(number: 9, arabicName: 'التوبة', englishName: 'At-Tawbah', englishNameTranslation: 'The Repentance', numberOfVerses: 129, revelationType: RevelationType.medinan),
    const Surah(number: 10, arabicName: 'يونس', englishName: 'Yunus', englishNameTranslation: 'Jonah', numberOfVerses: 109, revelationType: RevelationType.meccan),
    // ... Continue with all 114 surahs
    // For brevity, including just a few more important ones
    const Surah(number: 18, arabicName: 'الكهف', englishName: 'Al-Kahf', englishNameTranslation: 'The Cave', numberOfVerses: 110, revelationType: RevelationType.meccan),
    const Surah(number: 36, arabicName: 'يس', englishName: 'Ya-Sin', englishNameTranslation: 'Ya-Sin', numberOfVerses: 83, revelationType: RevelationType.meccan),
    const Surah(number: 55, arabicName: 'الرحمن', englishName: 'Ar-Rahman', englishNameTranslation: 'The Beneficent', numberOfVerses: 78, revelationType: RevelationType.medinan),
    const Surah(number: 67, arabicName: 'الملك', englishName: 'Al-Mulk', englishNameTranslation: 'The Sovereignty', numberOfVerses: 30, revelationType: RevelationType.meccan),
    const Surah(number: 112, arabicName: 'الإخلاص', englishName: 'Al-Ikhlas', englishNameTranslation: 'The Sincerity', numberOfVerses: 4, revelationType: RevelationType.meccan),
    const Surah(number: 113, arabicName: 'الفلق', englishName: 'Al-Falaq', englishNameTranslation: 'The Daybreak', numberOfVerses: 5, revelationType: RevelationType.meccan),
    const Surah(number: 114, arabicName: 'الناس', englishName: 'An-Nas', englishNameTranslation: 'Mankind', numberOfVerses: 6, revelationType: RevelationType.meccan),
  ];
}
