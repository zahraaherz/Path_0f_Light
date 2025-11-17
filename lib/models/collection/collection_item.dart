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

  /// Get category display name (Arabic)
  String getCategoryName() {
    switch (category) {
      case CollectionCategory.morning:
        return 'الصباح';
      case CollectionCategory.evening:
        return 'المساء';
      case CollectionCategory.friday:
        return 'الجمعة';
      case CollectionCategory.ramadhan:
        return 'رمضان';
      case CollectionCategory.muharram:
        return 'محرم';
      case CollectionCategory.safar:
        return 'صفر';
      case CollectionCategory.rajab:
        return 'رجب';
      case CollectionCategory.shaban:
        return 'شعبان';
      case CollectionCategory.daily:
        return 'يومي';
      case CollectionCategory.weekly:
        return 'أسبوعي';
      case CollectionCategory.monthly:
        return 'شهري';
      case CollectionCategory.special:
        return 'مناسبات خاصة';
      case CollectionCategory.protection:
        return 'حماية';
      case CollectionCategory.forgiveness:
        return 'مغفرة';
      case CollectionCategory.gratitude:
        return 'شكر';
      case CollectionCategory.healing:
        return 'شفاء';
      case CollectionCategory.guidance:
        return 'هداية';
      case CollectionCategory.custom:
        return 'مخصص';
    }
  }

  /// Get type display name (Arabic)
  String getTypeName() {
    switch (type) {
      case CollectionItemType.dua:
        return 'دعاء';
      case CollectionItemType.surah:
        return 'سورة';
      case CollectionItemType.ayah:
        return 'آية';
      case CollectionItemType.ziyarat:
        return 'زيارة';
      case CollectionItemType.hadith:
        return 'حديث';
      case CollectionItemType.passage:
        return 'مقطع';
      case CollectionItemType.dhikr:
        return 'ذكر';
      case CollectionItemType.custom:
        return 'مخصص';
    }
  }

  /// Get source reference (e.g., "سورة 1، آية 5")
  String? get sourceReference {
    if (surahNumber != null && ayahNumber != null) {
      return 'سورة $surahNumber، آية $ayahNumber';
    } else if (surahNumber != null) {
      return 'سورة $surahNumber';
    } else if (bookReference != null && pageNumber != null) {
      return '$bookReference، صفحة $pageNumber';
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
