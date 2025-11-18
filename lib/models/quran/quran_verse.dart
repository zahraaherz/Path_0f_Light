import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_verse.freezed.dart';
part 'quran_verse.g.dart';

/// Quran Verse Model
@freezed
class QuranVerse with _$QuranVerse {
  const factory QuranVerse({
    required int number, // Verse number within the surah
    required int numberInQuran, // Verse number in the entire Quran
    @JsonKey(name: 'arabic_text') required String arabicText,
    @JsonKey(name: 'english_translation') String? englishTranslation,
    @JsonKey(name: 'transliteration') String? transliteration,
    @JsonKey(name: 'tafsir') String? tafsir, // Interpretation/Commentary
    @JsonKey(name: 'juz_number') int? juzNumber, // Juz (part) number (1-30)
    @JsonKey(name: 'page_number') int? pageNumber, // Page number in Mushaf
    @JsonKey(name: 'sajda') @Default(false) bool hasSajda, // Prostration required
  }) = _QuranVerse;

  factory QuranVerse.fromJson(Map<String, dynamic> json) =>
      _$QuranVerseFromJson(json);
}

/// Surah (Chapter) Model
@freezed
class Surah with _$Surah {
  const factory Surah({
    required int number, // Surah number (1-114)
    @JsonKey(name: 'arabic_name') required String arabicName,
    @JsonKey(name: 'english_name') required String englishName,
    @JsonKey(name: 'english_name_translation') required String englishNameTranslation,
    @JsonKey(name: 'number_of_verses') required int numberOfVerses,
    @JsonKey(name: 'revelation_type') required RevelationType revelationType,
    @JsonKey(name: 'revelation_place') String? revelationPlace,
  }) = _Surah;

  factory Surah.fromJson(Map<String, dynamic> json) =>
      _$SurahFromJson(json);
}

/// Revelation type (Meccan or Medinan)
enum RevelationType {
  @JsonValue('Meccan')
  meccan,
  @JsonValue('Medinan')
  medinan,
}

/// Extension methods for RevelationType
extension RevelationTypeExtension on RevelationType {
  String get displayName {
    switch (this) {
      case RevelationType.meccan:
        return 'Meccan';
      case RevelationType.medinan:
        return 'Medinan';
    }
  }

  String get displayNameAr {
    switch (this) {
      case RevelationType.meccan:
        return 'مكية';
      case RevelationType.medinan:
        return 'مدنية';
    }
  }
}
