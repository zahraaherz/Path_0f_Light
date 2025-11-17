import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_progress.freezed.dart';
part 'reading_progress.g.dart';

/// User's reading progress for a book
@freezed
class ReadingProgress with _$ReadingProgress {
  const factory ReadingProgress({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'book_title_ar') required String bookTitleAr,
    @JsonKey(name: 'book_title_en') String? bookTitleEn,
    @JsonKey(name: 'current_section_id') String? currentSectionId,
    @JsonKey(name: 'current_paragraph_id') String? currentParagraphId,
    @JsonKey(name: 'paragraphs_read') @Default([]) List<String> paragraphsRead,
    @JsonKey(name: 'total_paragraphs') @Default(0) int totalParagraphs,
    @JsonKey(name: 'progress_percentage') @Default(0.0) double progressPercentage,
    @JsonKey(name: 'last_read_date') DateTime? lastReadDate,
    @JsonKey(name: 'total_reading_time_minutes') @Default(0) int totalReadingTimeMinutes,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,
  }) = _ReadingProgress;

  factory ReadingProgress.fromJson(Map<String, dynamic> json) =>
      _$ReadingProgressFromJson(json);
}

/// Extension methods for ReadingProgress
extension ReadingProgressExtensions on ReadingProgress {
  /// Get localized book title
  String getBookTitle(String languageCode) {
    if (languageCode == 'ar') return bookTitleAr;
    return bookTitleEn ?? bookTitleAr;
  }

  /// Check if reading has started
  bool get hasStarted => startedAt != null;

  /// Get number of paragraphs read
  int get paragraphsReadCount => paragraphsRead.length;

  /// Get remaining paragraphs
  int get remainingParagraphs => totalParagraphs - paragraphsReadCount;

  /// Calculate progress percentage
  double calculateProgress() {
    if (totalParagraphs == 0) return 0.0;
    return (paragraphsReadCount / totalParagraphs) * 100;
  }

  /// Get formatted reading time
  String get formattedReadingTime {
    final hours = totalReadingTimeMinutes ~/ 60;
    final minutes = totalReadingTimeMinutes % 60;

    if (hours > 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'} $minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    }
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
  }

  /// Check if recently read (within last 7 days)
  bool get isRecentlyRead {
    if (lastReadDate == null) return false;
    final daysSinceRead = DateTime.now().difference(lastReadDate!).inDays;
    return daysSinceRead <= 7;
  }
}
