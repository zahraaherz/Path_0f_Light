// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'islamic_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IslamicEvent _$IslamicEventFromJson(Map<String, dynamic> json) {
  return _IslamicEvent.fromJson(json);
}

/// @nodoc
mixin _$IslamicEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get arabicTitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  IslamicEventType get type => throw _privateConstructorUsedError;
  String get hijriDate =>
      throw _privateConstructorUsedError; // e.g., "10 Muharram"
  String? get gregorianDate =>
      throw _privateConstructorUsedError; // Approximate or calculated
  String? get significance => throw _privateConstructorUsedError;
  List<String>? get recommendations => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isToday => throw _privateConstructorUsedError;
  bool get isUpcoming => throw _privateConstructorUsedError;

  /// Serializes this IslamicEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IslamicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IslamicEventCopyWith<IslamicEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IslamicEventCopyWith<$Res> {
  factory $IslamicEventCopyWith(
          IslamicEvent value, $Res Function(IslamicEvent) then) =
      _$IslamicEventCopyWithImpl<$Res, IslamicEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String description,
      IslamicEventType type,
      String hijriDate,
      String? gregorianDate,
      String? significance,
      List<String>? recommendations,
      String? imageUrl,
      bool isToday,
      bool isUpcoming});
}

/// @nodoc
class _$IslamicEventCopyWithImpl<$Res, $Val extends IslamicEvent>
    implements $IslamicEventCopyWith<$Res> {
  _$IslamicEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IslamicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? description = null,
    Object? type = null,
    Object? hijriDate = null,
    Object? gregorianDate = freezed,
    Object? significance = freezed,
    Object? recommendations = freezed,
    Object? imageUrl = freezed,
    Object? isToday = null,
    Object? isUpcoming = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: null == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IslamicEventType,
      hijriDate: null == hijriDate
          ? _value.hijriDate
          : hijriDate // ignore: cast_nullable_to_non_nullable
              as String,
      gregorianDate: freezed == gregorianDate
          ? _value.gregorianDate
          : gregorianDate // ignore: cast_nullable_to_non_nullable
              as String?,
      significance: freezed == significance
          ? _value.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendations: freezed == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isToday: null == isToday
          ? _value.isToday
          : isToday // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpcoming: null == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IslamicEventImplCopyWith<$Res>
    implements $IslamicEventCopyWith<$Res> {
  factory _$$IslamicEventImplCopyWith(
          _$IslamicEventImpl value, $Res Function(_$IslamicEventImpl) then) =
      __$$IslamicEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String description,
      IslamicEventType type,
      String hijriDate,
      String? gregorianDate,
      String? significance,
      List<String>? recommendations,
      String? imageUrl,
      bool isToday,
      bool isUpcoming});
}

/// @nodoc
class __$$IslamicEventImplCopyWithImpl<$Res>
    extends _$IslamicEventCopyWithImpl<$Res, _$IslamicEventImpl>
    implements _$$IslamicEventImplCopyWith<$Res> {
  __$$IslamicEventImplCopyWithImpl(
      _$IslamicEventImpl _value, $Res Function(_$IslamicEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of IslamicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? description = null,
    Object? type = null,
    Object? hijriDate = null,
    Object? gregorianDate = freezed,
    Object? significance = freezed,
    Object? recommendations = freezed,
    Object? imageUrl = freezed,
    Object? isToday = null,
    Object? isUpcoming = null,
  }) {
    return _then(_$IslamicEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: null == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IslamicEventType,
      hijriDate: null == hijriDate
          ? _value.hijriDate
          : hijriDate // ignore: cast_nullable_to_non_nullable
              as String,
      gregorianDate: freezed == gregorianDate
          ? _value.gregorianDate
          : gregorianDate // ignore: cast_nullable_to_non_nullable
              as String?,
      significance: freezed == significance
          ? _value.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendations: freezed == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isToday: null == isToday
          ? _value.isToday
          : isToday // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpcoming: null == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IslamicEventImpl implements _IslamicEvent {
  const _$IslamicEventImpl(
      {required this.id,
      required this.title,
      required this.arabicTitle,
      required this.description,
      required this.type,
      required this.hijriDate,
      this.gregorianDate,
      this.significance,
      final List<String>? recommendations,
      this.imageUrl,
      this.isToday = false,
      this.isUpcoming = false})
      : _recommendations = recommendations;

  factory _$IslamicEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$IslamicEventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String arabicTitle;
  @override
  final String description;
  @override
  final IslamicEventType type;
  @override
  final String hijriDate;
// e.g., "10 Muharram"
  @override
  final String? gregorianDate;
// Approximate or calculated
  @override
  final String? significance;
  final List<String>? _recommendations;
  @override
  List<String>? get recommendations {
    final value = _recommendations;
    if (value == null) return null;
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isToday;
  @override
  @JsonKey()
  final bool isUpcoming;

  @override
  String toString() {
    return 'IslamicEvent(id: $id, title: $title, arabicTitle: $arabicTitle, description: $description, type: $type, hijriDate: $hijriDate, gregorianDate: $gregorianDate, significance: $significance, recommendations: $recommendations, imageUrl: $imageUrl, isToday: $isToday, isUpcoming: $isUpcoming)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IslamicEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicTitle, arabicTitle) ||
                other.arabicTitle == arabicTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.hijriDate, hijriDate) ||
                other.hijriDate == hijriDate) &&
            (identical(other.gregorianDate, gregorianDate) ||
                other.gregorianDate == gregorianDate) &&
            (identical(other.significance, significance) ||
                other.significance == significance) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isToday, isToday) || other.isToday == isToday) &&
            (identical(other.isUpcoming, isUpcoming) ||
                other.isUpcoming == isUpcoming));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      arabicTitle,
      description,
      type,
      hijriDate,
      gregorianDate,
      significance,
      const DeepCollectionEquality().hash(_recommendations),
      imageUrl,
      isToday,
      isUpcoming);

  /// Create a copy of IslamicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IslamicEventImplCopyWith<_$IslamicEventImpl> get copyWith =>
      __$$IslamicEventImplCopyWithImpl<_$IslamicEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IslamicEventImplToJson(
      this,
    );
  }
}

abstract class _IslamicEvent implements IslamicEvent {
  const factory _IslamicEvent(
      {required final String id,
      required final String title,
      required final String arabicTitle,
      required final String description,
      required final IslamicEventType type,
      required final String hijriDate,
      final String? gregorianDate,
      final String? significance,
      final List<String>? recommendations,
      final String? imageUrl,
      final bool isToday,
      final bool isUpcoming}) = _$IslamicEventImpl;

  factory _IslamicEvent.fromJson(Map<String, dynamic> json) =
      _$IslamicEventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get arabicTitle;
  @override
  String get description;
  @override
  IslamicEventType get type;
  @override
  String get hijriDate; // e.g., "10 Muharram"
  @override
  String? get gregorianDate; // Approximate or calculated
  @override
  String? get significance;
  @override
  List<String>? get recommendations;
  @override
  String? get imageUrl;
  @override
  bool get isToday;
  @override
  bool get isUpcoming;

  /// Create a copy of IslamicEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IslamicEventImplCopyWith<_$IslamicEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HijriDate _$HijriDateFromJson(Map<String, dynamic> json) {
  return _HijriDate.fromJson(json);
}

/// @nodoc
mixin _$HijriDate {
  int get day => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  String get monthName => throw _privateConstructorUsedError;
  String get monthNameArabic => throw _privateConstructorUsedError;
  String? get weekdayName => throw _privateConstructorUsedError;
  String? get weekdayNameArabic => throw _privateConstructorUsedError;

  /// Serializes this HijriDate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HijriDateCopyWith<HijriDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HijriDateCopyWith<$Res> {
  factory $HijriDateCopyWith(HijriDate value, $Res Function(HijriDate) then) =
      _$HijriDateCopyWithImpl<$Res, HijriDate>;
  @useResult
  $Res call(
      {int day,
      int month,
      int year,
      String monthName,
      String monthNameArabic,
      String? weekdayName,
      String? weekdayNameArabic});
}

/// @nodoc
class _$HijriDateCopyWithImpl<$Res, $Val extends HijriDate>
    implements $HijriDateCopyWith<$Res> {
  _$HijriDateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? month = null,
    Object? year = null,
    Object? monthName = null,
    Object? monthNameArabic = null,
    Object? weekdayName = freezed,
    Object? weekdayNameArabic = freezed,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      monthName: null == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String,
      monthNameArabic: null == monthNameArabic
          ? _value.monthNameArabic
          : monthNameArabic // ignore: cast_nullable_to_non_nullable
              as String,
      weekdayName: freezed == weekdayName
          ? _value.weekdayName
          : weekdayName // ignore: cast_nullable_to_non_nullable
              as String?,
      weekdayNameArabic: freezed == weekdayNameArabic
          ? _value.weekdayNameArabic
          : weekdayNameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HijriDateImplCopyWith<$Res>
    implements $HijriDateCopyWith<$Res> {
  factory _$$HijriDateImplCopyWith(
          _$HijriDateImpl value, $Res Function(_$HijriDateImpl) then) =
      __$$HijriDateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int day,
      int month,
      int year,
      String monthName,
      String monthNameArabic,
      String? weekdayName,
      String? weekdayNameArabic});
}

/// @nodoc
class __$$HijriDateImplCopyWithImpl<$Res>
    extends _$HijriDateCopyWithImpl<$Res, _$HijriDateImpl>
    implements _$$HijriDateImplCopyWith<$Res> {
  __$$HijriDateImplCopyWithImpl(
      _$HijriDateImpl _value, $Res Function(_$HijriDateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? month = null,
    Object? year = null,
    Object? monthName = null,
    Object? monthNameArabic = null,
    Object? weekdayName = freezed,
    Object? weekdayNameArabic = freezed,
  }) {
    return _then(_$HijriDateImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      monthName: null == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String,
      monthNameArabic: null == monthNameArabic
          ? _value.monthNameArabic
          : monthNameArabic // ignore: cast_nullable_to_non_nullable
              as String,
      weekdayName: freezed == weekdayName
          ? _value.weekdayName
          : weekdayName // ignore: cast_nullable_to_non_nullable
              as String?,
      weekdayNameArabic: freezed == weekdayNameArabic
          ? _value.weekdayNameArabic
          : weekdayNameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HijriDateImpl implements _HijriDate {
  const _$HijriDateImpl(
      {required this.day,
      required this.month,
      required this.year,
      required this.monthName,
      required this.monthNameArabic,
      this.weekdayName,
      this.weekdayNameArabic});

  factory _$HijriDateImpl.fromJson(Map<String, dynamic> json) =>
      _$$HijriDateImplFromJson(json);

  @override
  final int day;
  @override
  final int month;
  @override
  final int year;
  @override
  final String monthName;
  @override
  final String monthNameArabic;
  @override
  final String? weekdayName;
  @override
  final String? weekdayNameArabic;

  @override
  String toString() {
    return 'HijriDate(day: $day, month: $month, year: $year, monthName: $monthName, monthNameArabic: $monthNameArabic, weekdayName: $weekdayName, weekdayNameArabic: $weekdayNameArabic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HijriDateImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.monthName, monthName) ||
                other.monthName == monthName) &&
            (identical(other.monthNameArabic, monthNameArabic) ||
                other.monthNameArabic == monthNameArabic) &&
            (identical(other.weekdayName, weekdayName) ||
                other.weekdayName == weekdayName) &&
            (identical(other.weekdayNameArabic, weekdayNameArabic) ||
                other.weekdayNameArabic == weekdayNameArabic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, month, year, monthName,
      monthNameArabic, weekdayName, weekdayNameArabic);

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HijriDateImplCopyWith<_$HijriDateImpl> get copyWith =>
      __$$HijriDateImplCopyWithImpl<_$HijriDateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HijriDateImplToJson(
      this,
    );
  }
}

abstract class _HijriDate implements HijriDate {
  const factory _HijriDate(
      {required final int day,
      required final int month,
      required final int year,
      required final String monthName,
      required final String monthNameArabic,
      final String? weekdayName,
      final String? weekdayNameArabic}) = _$HijriDateImpl;

  factory _HijriDate.fromJson(Map<String, dynamic> json) =
      _$HijriDateImpl.fromJson;

  @override
  int get day;
  @override
  int get month;
  @override
  int get year;
  @override
  String get monthName;
  @override
  String get monthNameArabic;
  @override
  String? get weekdayName;
  @override
  String? get weekdayNameArabic;

  /// Create a copy of HijriDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HijriDateImplCopyWith<_$HijriDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
