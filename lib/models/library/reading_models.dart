import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'reading_models.freezed.dart';
part 'reading_models.g.dart';

/// User's reading progress for a specific book
@freezed
class BookProgress with _$BookProgress {
  const factory BookProgress({
    required String bookId,
    required String userId,
    String? currentParagraphId,
    String? currentSectionId,
    @Default(0) int currentPage,
    @Default(0) int totalPagesRead,
    @Default(0.0) double progressPercentage,
    @TimestampConverter() DateTime? lastReadAt,
    @TimestampConverter() DateTime? startedAt,
    @TimestampConverter() DateTime? completedAt,
    @Default(0) int energyEarned,
    @Default(0) int readingStreak,
    @Default(0) int totalReadingTimeMinutes,
    @Default([]) List<String> completedSections,
  }) = _BookProgress;

  factory BookProgress.fromJson(Map<String, dynamic> json) =>
      _$BookProgressFromJson(json);
}

/// User bookmark model
@freezed
class UserBookmark with _$UserBookmark {
  const factory UserBookmark({
    required String id,
    required String bookId,
    required String userId,
    required String paragraphId,
    required int pageNumber,
    String? sectionTitle,
    String? note,
    @Default('default') String color,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _UserBookmark;

  factory UserBookmark.fromJson(Map<String, dynamic> json) =>
      _$UserBookmarkFromJson(json);
}

/// Reading preferences
@freezed
class ReadingPreferences with _$ReadingPreferences {
  const factory ReadingPreferences({
    @Default(FontSize.medium) FontSize fontSize,
    @Default(FontFamily.amiri) FontFamily fontFamily,
    @Default(BackgroundColor.white) BackgroundColor backgroundColor,
    @Default(1.5) double lineSpacing,
    @Default(TextAlign.justified) TextAlign textAlign,
    @Default(false) bool autoScroll,
    @Default(30.0) double scrollSpeed,
    @Default(true) bool showPageNumbers,
    @Default(true) bool enableNightMode,
    @Default(18.0) double nightModeBrightness,
  }) = _ReadingPreferences;

  factory ReadingPreferences.fromJson(Map<String, dynamic> json) =>
      _$ReadingPreferencesFromJson(json);
}

/// Font size enum
enum FontSize {
  @JsonValue('small')
  small,
  @JsonValue('medium')
  medium,
  @JsonValue('large')
  large,
  @JsonValue('xlarge')
  xlarge,
}

/// Font family enum
enum FontFamily {
  @JsonValue('amiri')
  amiri,
  @JsonValue('scheherazade')
  scheherazade,
  @JsonValue('noto_naskh')
  notoNaskh,
  @JsonValue('traditional')
  traditional,
}

/// Background color enum
enum BackgroundColor {
  @JsonValue('white')
  white,
  @JsonValue('sepia')
  sepia,
  @JsonValue('dark')
  dark,
  @JsonValue('black')
  black,
}

/// Text alignment enum
enum TextAlign {
  @JsonValue('justified')
  justified,
  @JsonValue('right')
  right,
  @JsonValue('left')
  left,
  @JsonValue('center')
  center,
}

/// Book collection model
@freezed
class BookCollection with _$BookCollection {
  const factory BookCollection({
    required String id,
    required String userId,
    required String name,
    String? description,
    @Default([]) List<String> bookIds,
    @Default(false) bool isPublic,
    @Default(false) bool isDefault,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    String? coverImageUrl,
  }) = _BookCollection;

  factory BookCollection.fromJson(Map<String, dynamic> json) =>
      _$BookCollectionFromJson(json);
}

/// Reading statistics
@freezed
class ReadingStatistics with _$ReadingStatistics {
  const factory ReadingStatistics({
    required String userId,
    @Default(0) int totalBooksRead,
    @Default(0) int totalBooksStarted,
    @Default(0) int totalPagesRead,
    @Default(0) int totalReadingTimeMinutes,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @Default(0) int totalEnergyEarned,
    @Default(0) int totalCommentsPosted,
    @Default(0) int totalBookmarksCreated,
    @TimestampConverter() DateTime? lastReadDate,
    @Default({}) Map<String, int> booksReadByCategory,
  }) = _ReadingStatistics;

  factory ReadingStatistics.fromJson(Map<String, dynamic> json) =>
      _$ReadingStatisticsFromJson(json);
}

/// Timestamp converter for Freezed
class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}

/// Extension methods for BookProgress
extension BookProgressExtensions on BookProgress {
  /// Check if book is completed
  bool get isCompleted => completedAt != null;

  /// Check if book is in progress
  bool get isInProgress => startedAt != null && completedAt == null;

  /// Check if user has started reading
  bool get hasStarted => startedAt != null;

  /// Get reading time in human-readable format
  String get readingTimeFormatted {
    if (totalReadingTimeMinutes < 60) {
      return '$totalReadingTimeMinutes min';
    }
    final hours = totalReadingTimeMinutes ~/ 60;
    final minutes = totalReadingTimeMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  /// Check if read today
  bool get readToday {
    if (lastReadAt == null) return false;
    final now = DateTime.now();
    final lastRead = lastReadAt!;
    return now.year == lastRead.year &&
        now.month == lastRead.month &&
        now.day == lastRead.day;
  }
}

/// Extension methods for ReadingPreferences
extension ReadingPreferencesExtensions on ReadingPreferences {
  /// Get font size in pixels
  double get fontSizeValue {
    switch (fontSize) {
      case FontSize.small:
        return 16.0;
      case FontSize.medium:
        return 18.0;
      case FontSize.large:
        return 22.0;
      case FontSize.xlarge:
        return 26.0;
    }
  }

  /// Get font family name
  String get fontFamilyName {
    switch (fontFamily) {
      case FontFamily.amiri:
        return 'Amiri';
      case FontFamily.scheherazade:
        return 'Scheherazade';
      case FontFamily.notoNaskh:
        return 'Noto Naskh Arabic';
      case FontFamily.traditional:
        return 'Traditional Arabic';
    }
  }

  /// Get background color hex value
  String get backgroundColorHex {
    switch (backgroundColor) {
      case BackgroundColor.white:
        return '#FFFFFF';
      case BackgroundColor.sepia:
        return '#F4ECD8';
      case BackgroundColor.dark:
        return '#2C2C2E';
      case BackgroundColor.black:
        return '#000000';
    }
  }

  /// Get text color based on background
  String get textColorHex {
    switch (backgroundColor) {
      case BackgroundColor.white:
      case BackgroundColor.sepia:
        return '#000000';
      case BackgroundColor.dark:
      case BackgroundColor.black:
        return '#FFFFFF';
    }
  }
}

/// Extension methods for UserBookmark
extension UserBookmarkExtensions on UserBookmark {
  /// Check if bookmark has a note
  bool get hasNote => note != null && note!.isNotEmpty;

  /// Get time since created
  String get timeSinceCreated {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inMinutes}m ago';
    }
  }
}
