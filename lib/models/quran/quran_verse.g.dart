// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuranVerseImpl _$$QuranVerseImplFromJson(Map<String, dynamic> json) =>
    _$QuranVerseImpl(
      number: (json['number'] as num).toInt(),
      numberInQuran: (json['numberInQuran'] as num).toInt(),
      arabicText: json['arabic_text'] as String,
      englishTranslation: json['english_translation'] as String?,
      transliteration: json['transliteration'] as String?,
      tafsir: json['tafsir'] as String?,
      juzNumber: (json['juz_number'] as num?)?.toInt(),
      pageNumber: (json['page_number'] as num?)?.toInt(),
      hasSajda: json['sajda'] as bool? ?? false,
    );

Map<String, dynamic> _$$QuranVerseImplToJson(_$QuranVerseImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'numberInQuran': instance.numberInQuran,
      'arabic_text': instance.arabicText,
      'english_translation': instance.englishTranslation,
      'transliteration': instance.transliteration,
      'tafsir': instance.tafsir,
      'juz_number': instance.juzNumber,
      'page_number': instance.pageNumber,
      'sajda': instance.hasSajda,
    };

_$SurahImpl _$$SurahImplFromJson(Map<String, dynamic> json) => _$SurahImpl(
      number: (json['number'] as num).toInt(),
      arabicName: json['arabic_name'] as String,
      englishName: json['english_name'] as String,
      englishNameTranslation: json['english_name_translation'] as String,
      numberOfVerses: (json['number_of_verses'] as num).toInt(),
      revelationType:
          $enumDecode(_$RevelationTypeEnumMap, json['revelation_type']),
      revelationPlace: json['revelation_place'] as String?,
    );

Map<String, dynamic> _$$SurahImplToJson(_$SurahImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'arabic_name': instance.arabicName,
      'english_name': instance.englishName,
      'english_name_translation': instance.englishNameTranslation,
      'number_of_verses': instance.numberOfVerses,
      'revelation_type': _$RevelationTypeEnumMap[instance.revelationType]!,
      'revelation_place': instance.revelationPlace,
    };

const _$RevelationTypeEnumMap = {
  RevelationType.meccan: 'Meccan',
  RevelationType.medinan: 'Medinan',
};
