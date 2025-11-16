import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_item.freezed.dart';
part 'collection_item.g.dart';

/// Type of content in the collection
enum CollectionItemType {
  dua,
  surah,
  ayah,
  ziyarat,
  hadith,
  passage,
  dhikr,
  custom,
}

/// Category for organizing collection items
enum CollectionCategory {
  morning,
  evening,
  friday,
  ramadhan,
  muharram,
  safar,
  rajab,
  shaban,
  daily,
  weekly,
  monthly,
  special,
  protection,
  forgiveness,
  gratitude,
  healing,
  guidance,
  custom,
}

/// A collection item that can be a du'a, surah, ziyarat, or custom content
@freezed
class CollectionItem with _$CollectionItem {
  const factory CollectionItem({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required CollectionItemType type,
    required String title,
    @JsonKey(name: 'arabic_title') String? arabicTitle,
    @JsonKey(name: 'arabic_text') required String arabicText,
    String? translation,
    String? transliteration,
    required CollectionCategory category,

    // Optional fields for different content types
    @JsonKey(name: 'surah_number') int? surahNumber, // For surahs
    @JsonKey(name: 'ayah_number') int? ayahNumber, // For ayahs
    @JsonKey(name: 'juz_number') int? juzNumber, // For Quran passages
    @JsonKey(name: 'book_reference') String? bookReference, // For hadith/passages
    @JsonKey(name: 'page_number') int? pageNumber,

    // Metadata
    String? source,
    String? notes,
    @Default([]) List<String> tags,

    // Audio
    @JsonKey(name: 'audio_url') String? audioUrl,

    // Favorites and organization
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,

    // Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'last_accessed') DateTime? lastAccessed,
  }) = _CollectionItem;

  factory CollectionItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionItemFromJson(json);
}

/// Extension methods for CollectionItem
extension CollectionItemExtensions on CollectionItem {
  /// Get display title based on language
  String getTitle(String languageCode) {
    if (languageCode == 'ar' && arabicTitle != null) {
      return arabicTitle!;
    }
    return title;
  }

  /// Get category display name
  String getCategoryName() {
    switch (category) {
      case CollectionCategory.morning:
        return 'Morning';
      case CollectionCategory.evening:
        return 'Evening';
      case CollectionCategory.friday:
        return 'Friday';
      case CollectionCategory.ramadhan:
        return 'Ramadhan';
      case CollectionCategory.muharram:
        return 'Muharram';
      case CollectionCategory.safar:
        return 'Safar';
      case CollectionCategory.rajab:
        return 'Rajab';
      case CollectionCategory.shaban:
        return 'Sha\'ban';
      case CollectionCategory.daily:
        return 'Daily';
      case CollectionCategory.weekly:
        return 'Weekly';
      case CollectionCategory.monthly:
        return 'Monthly';
      case CollectionCategory.special:
        return 'Special Occasions';
      case CollectionCategory.protection:
        return 'Protection';
      case CollectionCategory.forgiveness:
        return 'Forgiveness';
      case CollectionCategory.gratitude:
        return 'Gratitude';
      case CollectionCategory.healing:
        return 'Healing';
      case CollectionCategory.guidance:
        return 'Guidance';
      case CollectionCategory.custom:
        return 'Custom';
    }
  }

  /// Get type display name
  String getTypeName() {
    switch (type) {
      case CollectionItemType.dua:
        return 'Du\'a';
      case CollectionItemType.surah:
        return 'Surah';
      case CollectionItemType.ayah:
        return 'Ayah';
      case CollectionItemType.ziyarat:
        return 'Ziyarat';
      case CollectionItemType.hadith:
        return 'Hadith';
      case CollectionItemType.passage:
        return 'Passage';
      case CollectionItemType.dhikr:
        return 'Dhikr';
      case CollectionItemType.custom:
        return 'Custom';
    }
  }

  /// Get source reference (e.g., "Surah 1, Ayah 5")
  String? get sourceReference {
    if (surahNumber != null && ayahNumber != null) {
      return 'Surah $surahNumber, Ayah $ayahNumber';
    } else if (surahNumber != null) {
      return 'Surah $surahNumber';
    } else if (bookReference != null && pageNumber != null) {
      return '$bookReference, Page $pageNumber';
    } else if (bookReference != null) {
      return bookReference;
    }
    return source;
  }

  /// Check if has audio
  bool get hasAudio => audioUrl != null && audioUrl!.isNotEmpty;

  /// Check if has notes
  bool get hasNotes => notes != null && notes!.isNotEmpty;

  /// Check if has tags
  bool get hasTags => tags.isNotEmpty;

  /// Check if recently accessed (within last 7 days)
  bool get isRecentlyAccessed {
    if (lastAccessed == null) return false;
    final daysSinceAccess = DateTime.now().difference(lastAccessed!).inDays;
    return daysSinceAccess <= 7;
  }

  /// Get text preview (first 100 characters of Arabic text)
  String get textPreview {
    if (arabicText.length <= 100) return arabicText;
    return '${arabicText.substring(0, 100)}...';
  }

  /// Check if is Quranic content
  bool get isQuranic =>
      type == CollectionItemType.surah || type == CollectionItemType.ayah;
}
