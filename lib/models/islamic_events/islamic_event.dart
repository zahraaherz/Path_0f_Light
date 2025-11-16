import 'package:freezed_annotation/freezed_annotation.dart';

part 'islamic_event.freezed.dart';
part 'islamic_event.g.dart';

/// Type of Islamic event
enum IslamicEventType {
  birth,
  martyrdom,
  occasion,
  fastingDay,
  celebration,
}

/// Islamic calendar event
@freezed
class IslamicEvent with _$IslamicEvent {
  const factory IslamicEvent({
    required String id,
    required String title,
    required String arabicTitle,
    required String description,
    required IslamicEventType type,
    required String hijriDate, // e.g., "10 Muharram"
    String? gregorianDate, // Approximate or calculated
    String? significance,
    List<String>? recommendations,
    String? imageUrl,
    @Default(false) bool isToday,
    @Default(false) bool isUpcoming,
  }) = _IslamicEvent;

  factory IslamicEvent.fromJson(Map<String, dynamic> json) =>
      _$IslamicEventFromJson(json);
}

/// Hijri calendar date
@freezed
class HijriDate with _$HijriDate {
  const factory HijriDate({
    required int day,
    required int month,
    required int year,
    required String monthName,
    required String monthNameArabic,
    String? weekdayName,
    String? weekdayNameArabic,
  }) = _HijriDate;

  factory HijriDate.fromJson(Map<String, dynamic> json) =>
      _$HijriDateFromJson(json);
}
