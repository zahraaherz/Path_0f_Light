// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookProgressImpl _$$BookProgressImplFromJson(Map<String, dynamic> json) =>
    _$BookProgressImpl(
      bookId: json['bookId'] as String,
      userId: json['userId'] as String,
      currentParagraphId: json['currentParagraphId'] as String?,
      currentSectionId: json['currentSectionId'] as String?,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
      totalPagesRead: (json['totalPagesRead'] as num?)?.toInt() ?? 0,
      progressPercentage:
          (json['progressPercentage'] as num?)?.toDouble() ?? 0.0,
      lastReadAt: const TimestampConverter().fromJson(json['lastReadAt']),
      startedAt: const TimestampConverter().fromJson(json['startedAt']),
      completedAt: const TimestampConverter().fromJson(json['completedAt']),
      energyEarned: (json['energyEarned'] as num?)?.toInt() ?? 0,
      readingStreak: (json['readingStreak'] as num?)?.toInt() ?? 0,
      totalReadingTimeMinutes:
          (json['totalReadingTimeMinutes'] as num?)?.toInt() ?? 0,
      completedSections: (json['completedSections'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BookProgressImplToJson(_$BookProgressImpl instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'userId': instance.userId,
      'currentParagraphId': instance.currentParagraphId,
      'currentSectionId': instance.currentSectionId,
      'currentPage': instance.currentPage,
      'totalPagesRead': instance.totalPagesRead,
      'progressPercentage': instance.progressPercentage,
      'lastReadAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastReadAt, const TimestampConverter().toJson),
      'startedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.startedAt, const TimestampConverter().toJson),
      'completedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.completedAt, const TimestampConverter().toJson),
      'energyEarned': instance.energyEarned,
      'readingStreak': instance.readingStreak,
      'totalReadingTimeMinutes': instance.totalReadingTimeMinutes,
      'completedSections': instance.completedSections,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$UserBookmarkImpl _$$UserBookmarkImplFromJson(Map<String, dynamic> json) =>
    _$UserBookmarkImpl(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      userId: json['userId'] as String,
      paragraphId: json['paragraphId'] as String,
      pageNumber: (json['pageNumber'] as num).toInt(),
      sectionTitle: json['sectionTitle'] as String?,
      note: json['note'] as String?,
      color: json['color'] as String? ?? 'default',
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$UserBookmarkImplToJson(_$UserBookmarkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'userId': instance.userId,
      'paragraphId': instance.paragraphId,
      'pageNumber': instance.pageNumber,
      'sectionTitle': instance.sectionTitle,
      'note': instance.note,
      'color': instance.color,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
    };

_$ReadingPreferencesImpl _$$ReadingPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$ReadingPreferencesImpl(
      fontSize: $enumDecodeNullable(_$FontSizeEnumMap, json['fontSize']) ??
          FontSize.medium,
      fontFamily:
          $enumDecodeNullable(_$FontFamilyEnumMap, json['fontFamily']) ??
              FontFamily.amiri,
      backgroundColor: $enumDecodeNullable(
              _$BackgroundColorEnumMap, json['backgroundColor']) ??
          BackgroundColor.white,
      lineSpacing: (json['lineSpacing'] as num?)?.toDouble() ?? 1.5,
      textAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']) ??
          TextAlign.justified,
      autoScroll: json['autoScroll'] as bool? ?? false,
      scrollSpeed: (json['scrollSpeed'] as num?)?.toDouble() ?? 30.0,
      showPageNumbers: json['showPageNumbers'] as bool? ?? true,
      enableNightMode: json['enableNightMode'] as bool? ?? true,
      nightModeBrightness:
          (json['nightModeBrightness'] as num?)?.toDouble() ?? 18.0,
    );

Map<String, dynamic> _$$ReadingPreferencesImplToJson(
        _$ReadingPreferencesImpl instance) =>
    <String, dynamic>{
      'fontSize': _$FontSizeEnumMap[instance.fontSize]!,
      'fontFamily': _$FontFamilyEnumMap[instance.fontFamily]!,
      'backgroundColor': _$BackgroundColorEnumMap[instance.backgroundColor]!,
      'lineSpacing': instance.lineSpacing,
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
      'autoScroll': instance.autoScroll,
      'scrollSpeed': instance.scrollSpeed,
      'showPageNumbers': instance.showPageNumbers,
      'enableNightMode': instance.enableNightMode,
      'nightModeBrightness': instance.nightModeBrightness,
    };

const _$FontSizeEnumMap = {
  FontSize.small: 'small',
  FontSize.medium: 'medium',
  FontSize.large: 'large',
  FontSize.xlarge: 'xlarge',
};

const _$FontFamilyEnumMap = {
  FontFamily.amiri: 'amiri',
  FontFamily.scheherazade: 'scheherazade',
  FontFamily.notoNaskh: 'noto_naskh',
  FontFamily.traditional: 'traditional',
};

const _$BackgroundColorEnumMap = {
  BackgroundColor.white: 'white',
  BackgroundColor.sepia: 'sepia',
  BackgroundColor.dark: 'dark',
  BackgroundColor.black: 'black',
};

const _$TextAlignEnumMap = {
  TextAlign.justified: 'justified',
  TextAlign.right: 'right',
  TextAlign.left: 'left',
  TextAlign.center: 'center',
};

_$BookCollectionImpl _$$BookCollectionImplFromJson(Map<String, dynamic> json) =>
    _$BookCollectionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      bookIds: (json['bookIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPublic: json['isPublic'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      coverImageUrl: json['coverImageUrl'] as String?,
    );

Map<String, dynamic> _$$BookCollectionImplToJson(
        _$BookCollectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'bookIds': instance.bookIds,
      'isPublic': instance.isPublic,
      'isDefault': instance.isDefault,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
      'coverImageUrl': instance.coverImageUrl,
    };

_$ReadingStatisticsImpl _$$ReadingStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$ReadingStatisticsImpl(
      userId: json['userId'] as String,
      totalBooksRead: (json['totalBooksRead'] as num?)?.toInt() ?? 0,
      totalBooksStarted: (json['totalBooksStarted'] as num?)?.toInt() ?? 0,
      totalPagesRead: (json['totalPagesRead'] as num?)?.toInt() ?? 0,
      totalReadingTimeMinutes:
          (json['totalReadingTimeMinutes'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      totalEnergyEarned: (json['totalEnergyEarned'] as num?)?.toInt() ?? 0,
      totalCommentsPosted: (json['totalCommentsPosted'] as num?)?.toInt() ?? 0,
      totalBookmarksCreated:
          (json['totalBookmarksCreated'] as num?)?.toInt() ?? 0,
      lastReadDate: const TimestampConverter().fromJson(json['lastReadDate']),
      booksReadByCategory:
          (json['booksReadByCategory'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
    );

Map<String, dynamic> _$$ReadingStatisticsImplToJson(
        _$ReadingStatisticsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalBooksRead': instance.totalBooksRead,
      'totalBooksStarted': instance.totalBooksStarted,
      'totalPagesRead': instance.totalPagesRead,
      'totalReadingTimeMinutes': instance.totalReadingTimeMinutes,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalEnergyEarned': instance.totalEnergyEarned,
      'totalCommentsPosted': instance.totalCommentsPosted,
      'totalBookmarksCreated': instance.totalBookmarksCreated,
      'lastReadDate': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastReadDate, const TimestampConverter().toJson),
      'booksReadByCategory': instance.booksReadByCategory,
    };
