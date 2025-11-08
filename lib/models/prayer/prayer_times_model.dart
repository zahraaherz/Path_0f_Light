import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_times_model.freezed.dart';
part 'prayer_times_model.g.dart';

/// Prayer times for a specific day
@freezed
class PrayerTimesModel with _$PrayerTimesModel {
  const factory PrayerTimesModel({
    required DateTime date,
    required DateTime fajr,
    required DateTime sunrise,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,
    required DateTime midnight,
    required String locationName,
    required double latitude,
    required double longitude,
  }) = _PrayerTimesModel;

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimesModelFromJson(json);
}

/// Prayer time calculation method
enum CalculationMethod {
  @JsonValue('muslim_world_league')
  muslimWorldLeague,
  @JsonValue('egyptian')
  egyptian,
  @JsonValue('karachi')
  karachi,
  @JsonValue('umm_al_qura')
  ummAlQura,
  @JsonValue('dubai')
  dubai,
  @JsonValue('qatar')
  qatar,
  @JsonValue('kuwait')
  kuwait,
  @JsonValue('moon_sighting_committee')
  moonSightingCommittee,
  @JsonValue('singapore')
  singapore,
  @JsonValue('north_america')
  northAmerica,
  @JsonValue('other')
  other,
}

/// Extension methods for CalculationMethod
extension CalculationMethodExtensions on CalculationMethod {
  String get displayName {
    switch (this) {
      case CalculationMethod.muslimWorldLeague:
        return 'Muslim World League';
      case CalculationMethod.egyptian:
        return 'Egyptian General Authority';
      case CalculationMethod.karachi:
        return 'University of Islamic Sciences, Karachi';
      case CalculationMethod.ummAlQura:
        return 'Umm al-Qura University, Makkah';
      case CalculationMethod.dubai:
        return 'Dubai';
      case CalculationMethod.qatar:
        return 'Qatar';
      case CalculationMethod.kuwait:
        return 'Kuwait';
      case CalculationMethod.moonSightingCommittee:
        return 'Moonsighting Committee';
      case CalculationMethod.singapore:
        return 'Singapore';
      case CalculationMethod.northAmerica:
        return 'Islamic Society of North America';
      case CalculationMethod.other:
        return 'Other';
    }
  }
}

/// Prayer name enum
enum PrayerName {
  fajr,
  sunrise,
  dhuhr,
  asr,
  maghrib,
  isha,
  midnight,
}

/// Extension methods for PrayerName
extension PrayerNameExtensions on PrayerName {
  String get displayNameEn {
    switch (this) {
      case PrayerName.fajr:
        return 'Fajr';
      case PrayerName.sunrise:
        return 'Sunrise';
      case PrayerName.dhuhr:
        return 'Dhuhr';
      case PrayerName.asr:
        return 'Asr';
      case PrayerName.maghrib:
        return 'Maghrib';
      case PrayerName.isha:
        return 'Isha';
      case PrayerName.midnight:
        return 'Midnight';
    }
  }

  String get displayNameAr {
    switch (this) {
      case PrayerName.fajr:
        return 'الفجر';
      case PrayerName.sunrise:
        return 'الشروق';
      case PrayerName.dhuhr:
        return 'الظهر';
      case PrayerName.asr:
        return 'العصر';
      case PrayerName.maghrib:
        return 'المغرب';
      case PrayerName.isha:
        return 'العشاء';
      case PrayerName.midnight:
        return 'منتصف الليل';
    }
  }
}
