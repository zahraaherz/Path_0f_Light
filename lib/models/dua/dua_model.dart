import 'package:freezed_annotation/freezed_annotation.dart';

part 'dua_model.freezed.dart';
part 'dua_model.g.dart';

/// Category of du'a
enum DuaCategory {
  daily,
  morning,
  evening,
  protection,
  forgiveness,
  knowledge,
  health,
  family,
  special,
}

/// Du'a model with complete details
@freezed
class Dua with _$Dua {
  const factory Dua({
    required String id,
    required String title,
    required String arabicTitle,
    required String arabicText,
    required String translation,
    required String transliteration,
    required DuaCategory category,
    String? shortExcerpt,
    String? meaning,
    String? tafsir,
    String? source,
    String? benefits,
    String? audioUrl,
    int? duration, // in seconds
    List<String>? tags,
    @Default(false) bool hasTashkeel,
    @Default(false) bool isFavorite,
  }) = _Dua;

  factory Dua.fromJson(Map<String, dynamic> json) => _$DuaFromJson(json);
}

/// Audio recitation model
@freezed
class AudioRecitation with _$AudioRecitation {
  const factory AudioRecitation({
    required String id,
    required String title,
    required String arabicTitle,
    required String reciter,
    required String audioUrl,
    required int durationMinutes,
    String? description,
    String? imageUrl,
    @Default(false) bool isDownloaded,
  }) = _AudioRecitation;

  factory AudioRecitation.fromJson(Map<String, dynamic> json) =>
      _$AudioRecitationFromJson(json);
}

/// Spiritual checklist item
@freezed
class SpiritualChecklistItem with _$SpiritualChecklistItem {
  const factory SpiritualChecklistItem({
    required String id,
    required String title,
    required String arabicTitle,
    required String type, // 'dua', 'surah', 'dhikr', 'other'
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    int? targetCount,
    int? currentCount,
  }) = _SpiritualChecklistItem;

  factory SpiritualChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$SpiritualChecklistItemFromJson(json);
}
