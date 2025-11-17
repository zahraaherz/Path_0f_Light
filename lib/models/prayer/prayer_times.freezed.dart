// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_times.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrayerTime _$PrayerTimeFromJson(Map<String, dynamic> json) {
  return _PrayerTime.fromJson(json);
}

/// @nodoc
mixin _$PrayerTime {
  String get name => throw _privateConstructorUsedError;
  String get arabicName => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get isPassed => throw _privateConstructorUsedError;
  String? get iqamaTime => throw _privateConstructorUsedError;

  /// Serializes this PrayerTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrayerTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrayerTimeCopyWith<PrayerTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerTimeCopyWith<$Res> {
  factory $PrayerTimeCopyWith(
          PrayerTime value, $Res Function(PrayerTime) then) =
      _$PrayerTimeCopyWithImpl<$Res, PrayerTime>;
  @useResult
  $Res call(
      {String name,
      String arabicName,
      String time,
      bool isPassed,
      String? iqamaTime});
}

/// @nodoc
class _$PrayerTimeCopyWithImpl<$Res, $Val extends PrayerTime>
    implements $PrayerTimeCopyWith<$Res> {
  _$PrayerTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrayerTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? arabicName = null,
    Object? time = null,
    Object? isPassed = null,
    Object? iqamaTime = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      isPassed: null == isPassed
          ? _value.isPassed
          : isPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      iqamaTime: freezed == iqamaTime
          ? _value.iqamaTime
          : iqamaTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrayerTimeImplCopyWith<$Res>
    implements $PrayerTimeCopyWith<$Res> {
  factory _$$PrayerTimeImplCopyWith(
          _$PrayerTimeImpl value, $Res Function(_$PrayerTimeImpl) then) =
      __$$PrayerTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String arabicName,
      String time,
      bool isPassed,
      String? iqamaTime});
}

/// @nodoc
class __$$PrayerTimeImplCopyWithImpl<$Res>
    extends _$PrayerTimeCopyWithImpl<$Res, _$PrayerTimeImpl>
    implements _$$PrayerTimeImplCopyWith<$Res> {
  __$$PrayerTimeImplCopyWithImpl(
      _$PrayerTimeImpl _value, $Res Function(_$PrayerTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrayerTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? arabicName = null,
    Object? time = null,
    Object? isPassed = null,
    Object? iqamaTime = freezed,
  }) {
    return _then(_$PrayerTimeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      isPassed: null == isPassed
          ? _value.isPassed
          : isPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      iqamaTime: freezed == iqamaTime
          ? _value.iqamaTime
          : iqamaTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerTimeImpl implements _PrayerTime {
  const _$PrayerTimeImpl(
      {required this.name,
      required this.arabicName,
      required this.time,
      required this.isPassed,
      this.iqamaTime});

  factory _$PrayerTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerTimeImplFromJson(json);

  @override
  final String name;
  @override
  final String arabicName;
  @override
  final String time;
  @override
  final bool isPassed;
  @override
  final String? iqamaTime;

  @override
  String toString() {
    return 'PrayerTime(name: $name, arabicName: $arabicName, time: $time, isPassed: $isPassed, iqamaTime: $iqamaTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerTimeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arabicName, arabicName) ||
                other.arabicName == arabicName) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isPassed, isPassed) ||
                other.isPassed == isPassed) &&
            (identical(other.iqamaTime, iqamaTime) ||
                other.iqamaTime == iqamaTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, arabicName, time, isPassed, iqamaTime);

  /// Create a copy of PrayerTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerTimeImplCopyWith<_$PrayerTimeImpl> get copyWith =>
      __$$PrayerTimeImplCopyWithImpl<_$PrayerTimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerTimeImplToJson(
      this,
    );
  }
}

abstract class _PrayerTime implements PrayerTime {
  const factory _PrayerTime(
      {required final String name,
      required final String arabicName,
      required final String time,
      required final bool isPassed,
      final String? iqamaTime}) = _$PrayerTimeImpl;

  factory _PrayerTime.fromJson(Map<String, dynamic> json) =
      _$PrayerTimeImpl.fromJson;

  @override
  String get name;
  @override
  String get arabicName;
  @override
  String get time;
  @override
  bool get isPassed;
  @override
  String? get iqamaTime;

  /// Create a copy of PrayerTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrayerTimeImplCopyWith<_$PrayerTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyPrayerTimes _$DailyPrayerTimesFromJson(Map<String, dynamic> json) {
  return _DailyPrayerTimes.fromJson(json);
}

/// @nodoc
mixin _$DailyPrayerTimes {
  DateTime get date => throw _privateConstructorUsedError;
  PrayerTime get fajr => throw _privateConstructorUsedError;
  PrayerTime get sunrise => throw _privateConstructorUsedError;
  PrayerTime get dhuhr => throw _privateConstructorUsedError;
  PrayerTime get asr => throw _privateConstructorUsedError;
  PrayerTime get maghrib => throw _privateConstructorUsedError;
  PrayerTime get isha => throw _privateConstructorUsedError;
  String? get nextPrayer => throw _privateConstructorUsedError;
  String? get timeUntilNext => throw _privateConstructorUsedError;

  /// Serializes this DailyPrayerTimes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyPrayerTimesCopyWith<DailyPrayerTimes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPrayerTimesCopyWith<$Res> {
  factory $DailyPrayerTimesCopyWith(
          DailyPrayerTimes value, $Res Function(DailyPrayerTimes) then) =
      _$DailyPrayerTimesCopyWithImpl<$Res, DailyPrayerTimes>;
  @useResult
  $Res call(
      {DateTime date,
      PrayerTime fajr,
      PrayerTime sunrise,
      PrayerTime dhuhr,
      PrayerTime asr,
      PrayerTime maghrib,
      PrayerTime isha,
      String? nextPrayer,
      String? timeUntilNext});

  $PrayerTimeCopyWith<$Res> get fajr;
  $PrayerTimeCopyWith<$Res> get sunrise;
  $PrayerTimeCopyWith<$Res> get dhuhr;
  $PrayerTimeCopyWith<$Res> get asr;
  $PrayerTimeCopyWith<$Res> get maghrib;
  $PrayerTimeCopyWith<$Res> get isha;
}

/// @nodoc
class _$DailyPrayerTimesCopyWithImpl<$Res, $Val extends DailyPrayerTimes>
    implements $DailyPrayerTimesCopyWith<$Res> {
  _$DailyPrayerTimesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? fajr = null,
    Object? sunrise = null,
    Object? dhuhr = null,
    Object? asr = null,
    Object? maghrib = null,
    Object? isha = null,
    Object? nextPrayer = freezed,
    Object? timeUntilNext = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fajr: null == fajr
          ? _value.fajr
          : fajr // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      sunrise: null == sunrise
          ? _value.sunrise
          : sunrise // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      dhuhr: null == dhuhr
          ? _value.dhuhr
          : dhuhr // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      asr: null == asr
          ? _value.asr
          : asr // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      maghrib: null == maghrib
          ? _value.maghrib
          : maghrib // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      isha: null == isha
          ? _value.isha
          : isha // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      nextPrayer: freezed == nextPrayer
          ? _value.nextPrayer
          : nextPrayer // ignore: cast_nullable_to_non_nullable
              as String?,
      timeUntilNext: freezed == timeUntilNext
          ? _value.timeUntilNext
          : timeUntilNext // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrayerTimeCopyWith<$Res> get fajr {
    return $PrayerTimeCopyWith<$Res>(_value.fajr, (value) {
      return _then(_value.copyWith(fajr: value) as $Val);
    });
  }

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrayerTimeCopyWith<$Res> get sunrise {
    return $PrayerTimeCopyWith<$Res>(_value.sunrise, (value) {
      return _then(_value.copyWith(sunrise: value) as $Val);
    });
  }

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrayerTimeCopyWith<$Res> get dhuhr {
    return $PrayerTimeCopyWith<$Res>(_value.dhuhr, (value) {
      return _then(_value.copyWith(dhuhr: value) as $Val);
    });
  }

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrayerTimeCopyWith<$Res> get asr {
    return $PrayerTimeCopyWith<$Res>(_value.asr, (value) {
      return _then(_value.copyWith(asr: value) as $Val);
    });
  }

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrayerTimeCopyWith<$Res> get maghrib {
    return $PrayerTimeCopyWith<$Res>(_value.maghrib, (value) {
      return _then(_value.copyWith(maghrib: value) as $Val);
    });
  }

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrayerTimeCopyWith<$Res> get isha {
    return $PrayerTimeCopyWith<$Res>(_value.isha, (value) {
      return _then(_value.copyWith(isha: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyPrayerTimesImplCopyWith<$Res>
    implements $DailyPrayerTimesCopyWith<$Res> {
  factory _$$DailyPrayerTimesImplCopyWith(_$DailyPrayerTimesImpl value,
          $Res Function(_$DailyPrayerTimesImpl) then) =
      __$$DailyPrayerTimesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      PrayerTime fajr,
      PrayerTime sunrise,
      PrayerTime dhuhr,
      PrayerTime asr,
      PrayerTime maghrib,
      PrayerTime isha,
      String? nextPrayer,
      String? timeUntilNext});

  @override
  $PrayerTimeCopyWith<$Res> get fajr;
  @override
  $PrayerTimeCopyWith<$Res> get sunrise;
  @override
  $PrayerTimeCopyWith<$Res> get dhuhr;
  @override
  $PrayerTimeCopyWith<$Res> get asr;
  @override
  $PrayerTimeCopyWith<$Res> get maghrib;
  @override
  $PrayerTimeCopyWith<$Res> get isha;
}

/// @nodoc
class __$$DailyPrayerTimesImplCopyWithImpl<$Res>
    extends _$DailyPrayerTimesCopyWithImpl<$Res, _$DailyPrayerTimesImpl>
    implements _$$DailyPrayerTimesImplCopyWith<$Res> {
  __$$DailyPrayerTimesImplCopyWithImpl(_$DailyPrayerTimesImpl _value,
      $Res Function(_$DailyPrayerTimesImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? fajr = null,
    Object? sunrise = null,
    Object? dhuhr = null,
    Object? asr = null,
    Object? maghrib = null,
    Object? isha = null,
    Object? nextPrayer = freezed,
    Object? timeUntilNext = freezed,
  }) {
    return _then(_$DailyPrayerTimesImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fajr: null == fajr
          ? _value.fajr
          : fajr // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      sunrise: null == sunrise
          ? _value.sunrise
          : sunrise // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      dhuhr: null == dhuhr
          ? _value.dhuhr
          : dhuhr // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      asr: null == asr
          ? _value.asr
          : asr // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      maghrib: null == maghrib
          ? _value.maghrib
          : maghrib // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      isha: null == isha
          ? _value.isha
          : isha // ignore: cast_nullable_to_non_nullable
              as PrayerTime,
      nextPrayer: freezed == nextPrayer
          ? _value.nextPrayer
          : nextPrayer // ignore: cast_nullable_to_non_nullable
              as String?,
      timeUntilNext: freezed == timeUntilNext
          ? _value.timeUntilNext
          : timeUntilNext // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyPrayerTimesImpl implements _DailyPrayerTimes {
  const _$DailyPrayerTimesImpl(
      {required this.date,
      required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      this.nextPrayer,
      this.timeUntilNext});

  factory _$DailyPrayerTimesImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyPrayerTimesImplFromJson(json);

  @override
  final DateTime date;
  @override
  final PrayerTime fajr;
  @override
  final PrayerTime sunrise;
  @override
  final PrayerTime dhuhr;
  @override
  final PrayerTime asr;
  @override
  final PrayerTime maghrib;
  @override
  final PrayerTime isha;
  @override
  final String? nextPrayer;
  @override
  final String? timeUntilNext;

  @override
  String toString() {
    return 'DailyPrayerTimes(date: $date, fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, nextPrayer: $nextPrayer, timeUntilNext: $timeUntilNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPrayerTimesImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.fajr, fajr) || other.fajr == fajr) &&
            (identical(other.sunrise, sunrise) || other.sunrise == sunrise) &&
            (identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr) &&
            (identical(other.asr, asr) || other.asr == asr) &&
            (identical(other.maghrib, maghrib) || other.maghrib == maghrib) &&
            (identical(other.isha, isha) || other.isha == isha) &&
            (identical(other.nextPrayer, nextPrayer) ||
                other.nextPrayer == nextPrayer) &&
            (identical(other.timeUntilNext, timeUntilNext) ||
                other.timeUntilNext == timeUntilNext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, fajr, sunrise, dhuhr, asr,
      maghrib, isha, nextPrayer, timeUntilNext);

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPrayerTimesImplCopyWith<_$DailyPrayerTimesImpl> get copyWith =>
      __$$DailyPrayerTimesImplCopyWithImpl<_$DailyPrayerTimesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyPrayerTimesImplToJson(
      this,
    );
  }
}

abstract class _DailyPrayerTimes implements DailyPrayerTimes {
  const factory _DailyPrayerTimes(
      {required final DateTime date,
      required final PrayerTime fajr,
      required final PrayerTime sunrise,
      required final PrayerTime dhuhr,
      required final PrayerTime asr,
      required final PrayerTime maghrib,
      required final PrayerTime isha,
      final String? nextPrayer,
      final String? timeUntilNext}) = _$DailyPrayerTimesImpl;

  factory _DailyPrayerTimes.fromJson(Map<String, dynamic> json) =
      _$DailyPrayerTimesImpl.fromJson;

  @override
  DateTime get date;
  @override
  PrayerTime get fajr;
  @override
  PrayerTime get sunrise;
  @override
  PrayerTime get dhuhr;
  @override
  PrayerTime get asr;
  @override
  PrayerTime get maghrib;
  @override
  PrayerTime get isha;
  @override
  String? get nextPrayer;
  @override
  String? get timeUntilNext;

  /// Create a copy of DailyPrayerTimes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyPrayerTimesImplCopyWith<_$DailyPrayerTimesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
