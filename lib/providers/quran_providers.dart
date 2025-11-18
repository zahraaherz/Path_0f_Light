import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quran/quran_verse.dart';
import '../repositories/quran_repository.dart';

// ===== Repository Provider =====

/// Quran repository provider
final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  return QuranRepository();
});

// ===== Surah Providers =====

/// Get all Surahs (chapters)
final allSurahsProvider = FutureProvider.autoDispose<List<Surah>>((ref) async {
  final repository = ref.watch(quranRepositoryProvider);
  return repository.getAllSurahs();
});

/// Get a specific Surah by number
final surahProvider = FutureProvider.autoDispose
    .family<Surah?, int>((ref, surahNumber) async {
  final repository = ref.watch(quranRepositoryProvider);
  return repository.getSurah(surahNumber);
});

/// Get verses for a specific Surah
final surahVersesProvider = FutureProvider.autoDispose
    .family<List<QuranVerse>, int>((ref, surahNumber) async {
  final repository = ref.watch(quranRepositoryProvider);
  return repository.getVersesForSurah(surahNumber);
});

/// Get a specific verse
final verseProvider = FutureProvider.autoDispose
    .family<QuranVerse?, ({int surahNumber, int verseNumber})>((ref, params) async {
  final repository = ref.watch(quranRepositoryProvider);
  return repository.getVerse(params.surahNumber, params.verseNumber);
});

// ===== Reading Settings Providers =====

/// Font size for Arabic text
final quranArabicFontSizeProvider = StateProvider<double>((ref) => 24.0);

/// Font size for translation
final quranTranslationFontSizeProvider = StateProvider<double>((ref) => 16.0);

/// Show transliteration
final showTransliterationProvider = StateProvider<bool>((ref) => false);

/// Show translation
final showTranslationProvider = StateProvider<bool>((ref) => true);

/// Show tafsir
final showTafsirProvider = StateProvider<bool>((ref) => false);
