// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paragraph.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ParagraphContent _$ParagraphContentFromJson(Map<String, dynamic> json) {
  return _ParagraphContent.fromJson(json);
}

/// @nodoc
mixin _$ParagraphContent {
  @JsonKey(name: 'text_ar')
  String get textAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'text_en')
  String? get textEn => throw _privateConstructorUsedError;

  /// Serializes this ParagraphContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParagraphContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphContentCopyWith<ParagraphContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphContentCopyWith<$Res> {
  factory $ParagraphContentCopyWith(
          ParagraphContent value, $Res Function(ParagraphContent) then) =
      _$ParagraphContentCopyWithImpl<$Res, ParagraphContent>;
  @useResult
  $Res call(
      {@JsonKey(name: 'text_ar') String textAr,
      @JsonKey(name: 'text_en') String? textEn});
}

/// @nodoc
class _$ParagraphContentCopyWithImpl<$Res, $Val extends ParagraphContent>
    implements $ParagraphContentCopyWith<$Res> {
  _$ParagraphContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParagraphContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textAr = null,
    Object? textEn = freezed,
  }) {
    return _then(_value.copyWith(
      textAr: null == textAr
          ? _value.textAr
          : textAr // ignore: cast_nullable_to_non_nullable
              as String,
      textEn: freezed == textEn
          ? _value.textEn
          : textEn // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParagraphContentImplCopyWith<$Res>
    implements $ParagraphContentCopyWith<$Res> {
  factory _$$ParagraphContentImplCopyWith(_$ParagraphContentImpl value,
          $Res Function(_$ParagraphContentImpl) then) =
      __$$ParagraphContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'text_ar') String textAr,
      @JsonKey(name: 'text_en') String? textEn});
}

/// @nodoc
class __$$ParagraphContentImplCopyWithImpl<$Res>
    extends _$ParagraphContentCopyWithImpl<$Res, _$ParagraphContentImpl>
    implements _$$ParagraphContentImplCopyWith<$Res> {
  __$$ParagraphContentImplCopyWithImpl(_$ParagraphContentImpl _value,
      $Res Function(_$ParagraphContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParagraphContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textAr = null,
    Object? textEn = freezed,
  }) {
    return _then(_$ParagraphContentImpl(
      textAr: null == textAr
          ? _value.textAr
          : textAr // ignore: cast_nullable_to_non_nullable
              as String,
      textEn: freezed == textEn
          ? _value.textEn
          : textEn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphContentImpl implements _ParagraphContent {
  const _$ParagraphContentImpl(
      {@JsonKey(name: 'text_ar') required this.textAr,
      @JsonKey(name: 'text_en') this.textEn});

  factory _$ParagraphContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphContentImplFromJson(json);

  @override
  @JsonKey(name: 'text_ar')
  final String textAr;
  @override
  @JsonKey(name: 'text_en')
  final String? textEn;

  @override
  String toString() {
    return 'ParagraphContent(textAr: $textAr, textEn: $textEn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphContentImpl &&
            (identical(other.textAr, textAr) || other.textAr == textAr) &&
            (identical(other.textEn, textEn) || other.textEn == textEn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, textAr, textEn);

  /// Create a copy of ParagraphContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphContentImplCopyWith<_$ParagraphContentImpl> get copyWith =>
      __$$ParagraphContentImplCopyWithImpl<_$ParagraphContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphContentImplToJson(
      this,
    );
  }
}

abstract class _ParagraphContent implements ParagraphContent {
  const factory _ParagraphContent(
      {@JsonKey(name: 'text_ar') required final String textAr,
      @JsonKey(name: 'text_en') final String? textEn}) = _$ParagraphContentImpl;

  factory _ParagraphContent.fromJson(Map<String, dynamic> json) =
      _$ParagraphContentImpl.fromJson;

  @override
  @JsonKey(name: 'text_ar')
  String get textAr;
  @override
  @JsonKey(name: 'text_en')
  String? get textEn;

  /// Create a copy of ParagraphContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphContentImplCopyWith<_$ParagraphContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParagraphEntities _$ParagraphEntitiesFromJson(Map<String, dynamic> json) {
  return _ParagraphEntities.fromJson(json);
}

/// @nodoc
mixin _$ParagraphEntities {
  List<String> get people => throw _privateConstructorUsedError;
  List<String> get places => throw _privateConstructorUsedError;
  List<String> get events => throw _privateConstructorUsedError;
  List<String> get dates => throw _privateConstructorUsedError;

  /// Serializes this ParagraphEntities to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParagraphEntities
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphEntitiesCopyWith<ParagraphEntities> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphEntitiesCopyWith<$Res> {
  factory $ParagraphEntitiesCopyWith(
          ParagraphEntities value, $Res Function(ParagraphEntities) then) =
      _$ParagraphEntitiesCopyWithImpl<$Res, ParagraphEntities>;
  @useResult
  $Res call(
      {List<String> people,
      List<String> places,
      List<String> events,
      List<String> dates});
}

/// @nodoc
class _$ParagraphEntitiesCopyWithImpl<$Res, $Val extends ParagraphEntities>
    implements $ParagraphEntitiesCopyWith<$Res> {
  _$ParagraphEntitiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParagraphEntities
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? people = null,
    Object? places = null,
    Object? events = null,
    Object? dates = null,
  }) {
    return _then(_value.copyWith(
      people: null == people
          ? _value.people
          : people // ignore: cast_nullable_to_non_nullable
              as List<String>,
      places: null == places
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dates: null == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParagraphEntitiesImplCopyWith<$Res>
    implements $ParagraphEntitiesCopyWith<$Res> {
  factory _$$ParagraphEntitiesImplCopyWith(_$ParagraphEntitiesImpl value,
          $Res Function(_$ParagraphEntitiesImpl) then) =
      __$$ParagraphEntitiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> people,
      List<String> places,
      List<String> events,
      List<String> dates});
}

/// @nodoc
class __$$ParagraphEntitiesImplCopyWithImpl<$Res>
    extends _$ParagraphEntitiesCopyWithImpl<$Res, _$ParagraphEntitiesImpl>
    implements _$$ParagraphEntitiesImplCopyWith<$Res> {
  __$$ParagraphEntitiesImplCopyWithImpl(_$ParagraphEntitiesImpl _value,
      $Res Function(_$ParagraphEntitiesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParagraphEntities
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? people = null,
    Object? places = null,
    Object? events = null,
    Object? dates = null,
  }) {
    return _then(_$ParagraphEntitiesImpl(
      people: null == people
          ? _value._people
          : people // ignore: cast_nullable_to_non_nullable
              as List<String>,
      places: null == places
          ? _value._places
          : places // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dates: null == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphEntitiesImpl implements _ParagraphEntities {
  const _$ParagraphEntitiesImpl(
      {final List<String> people = const [],
      final List<String> places = const [],
      final List<String> events = const [],
      final List<String> dates = const []})
      : _people = people,
        _places = places,
        _events = events,
        _dates = dates;

  factory _$ParagraphEntitiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphEntitiesImplFromJson(json);

  final List<String> _people;
  @override
  @JsonKey()
  List<String> get people {
    if (_people is EqualUnmodifiableListView) return _people;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_people);
  }

  final List<String> _places;
  @override
  @JsonKey()
  List<String> get places {
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_places);
  }

  final List<String> _events;
  @override
  @JsonKey()
  List<String> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<String> _dates;
  @override
  @JsonKey()
  List<String> get dates {
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dates);
  }

  @override
  String toString() {
    return 'ParagraphEntities(people: $people, places: $places, events: $events, dates: $dates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphEntitiesImpl &&
            const DeepCollectionEquality().equals(other._people, _people) &&
            const DeepCollectionEquality().equals(other._places, _places) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._dates, _dates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_people),
      const DeepCollectionEquality().hash(_places),
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_dates));

  /// Create a copy of ParagraphEntities
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphEntitiesImplCopyWith<_$ParagraphEntitiesImpl> get copyWith =>
      __$$ParagraphEntitiesImplCopyWithImpl<_$ParagraphEntitiesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphEntitiesImplToJson(
      this,
    );
  }
}

abstract class _ParagraphEntities implements ParagraphEntities {
  const factory _ParagraphEntities(
      {final List<String> people,
      final List<String> places,
      final List<String> events,
      final List<String> dates}) = _$ParagraphEntitiesImpl;

  factory _ParagraphEntities.fromJson(Map<String, dynamic> json) =
      _$ParagraphEntitiesImpl.fromJson;

  @override
  List<String> get people;
  @override
  List<String> get places;
  @override
  List<String> get events;
  @override
  List<String> get dates;

  /// Create a copy of ParagraphEntities
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphEntitiesImplCopyWith<_$ParagraphEntitiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParagraphSearchData _$ParagraphSearchDataFromJson(Map<String, dynamic> json) {
  return _ParagraphSearchData.fromJson(json);
}

/// @nodoc
mixin _$ParagraphSearchData {
  @JsonKey(name: 'keywords_ar')
  List<String> get keywordsAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'keywords_en')
  List<String> get keywordsEn => throw _privateConstructorUsedError;

  /// Serializes this ParagraphSearchData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParagraphSearchData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphSearchDataCopyWith<ParagraphSearchData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphSearchDataCopyWith<$Res> {
  factory $ParagraphSearchDataCopyWith(
          ParagraphSearchData value, $Res Function(ParagraphSearchData) then) =
      _$ParagraphSearchDataCopyWithImpl<$Res, ParagraphSearchData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'keywords_ar') List<String> keywordsAr,
      @JsonKey(name: 'keywords_en') List<String> keywordsEn});
}

/// @nodoc
class _$ParagraphSearchDataCopyWithImpl<$Res, $Val extends ParagraphSearchData>
    implements $ParagraphSearchDataCopyWith<$Res> {
  _$ParagraphSearchDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParagraphSearchData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keywordsAr = null,
    Object? keywordsEn = null,
  }) {
    return _then(_value.copyWith(
      keywordsAr: null == keywordsAr
          ? _value.keywordsAr
          : keywordsAr // ignore: cast_nullable_to_non_nullable
              as List<String>,
      keywordsEn: null == keywordsEn
          ? _value.keywordsEn
          : keywordsEn // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParagraphSearchDataImplCopyWith<$Res>
    implements $ParagraphSearchDataCopyWith<$Res> {
  factory _$$ParagraphSearchDataImplCopyWith(_$ParagraphSearchDataImpl value,
          $Res Function(_$ParagraphSearchDataImpl) then) =
      __$$ParagraphSearchDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'keywords_ar') List<String> keywordsAr,
      @JsonKey(name: 'keywords_en') List<String> keywordsEn});
}

/// @nodoc
class __$$ParagraphSearchDataImplCopyWithImpl<$Res>
    extends _$ParagraphSearchDataCopyWithImpl<$Res, _$ParagraphSearchDataImpl>
    implements _$$ParagraphSearchDataImplCopyWith<$Res> {
  __$$ParagraphSearchDataImplCopyWithImpl(_$ParagraphSearchDataImpl _value,
      $Res Function(_$ParagraphSearchDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParagraphSearchData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keywordsAr = null,
    Object? keywordsEn = null,
  }) {
    return _then(_$ParagraphSearchDataImpl(
      keywordsAr: null == keywordsAr
          ? _value._keywordsAr
          : keywordsAr // ignore: cast_nullable_to_non_nullable
              as List<String>,
      keywordsEn: null == keywordsEn
          ? _value._keywordsEn
          : keywordsEn // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphSearchDataImpl implements _ParagraphSearchData {
  const _$ParagraphSearchDataImpl(
      {@JsonKey(name: 'keywords_ar') final List<String> keywordsAr = const [],
      @JsonKey(name: 'keywords_en') final List<String> keywordsEn = const []})
      : _keywordsAr = keywordsAr,
        _keywordsEn = keywordsEn;

  factory _$ParagraphSearchDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphSearchDataImplFromJson(json);

  final List<String> _keywordsAr;
  @override
  @JsonKey(name: 'keywords_ar')
  List<String> get keywordsAr {
    if (_keywordsAr is EqualUnmodifiableListView) return _keywordsAr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywordsAr);
  }

  final List<String> _keywordsEn;
  @override
  @JsonKey(name: 'keywords_en')
  List<String> get keywordsEn {
    if (_keywordsEn is EqualUnmodifiableListView) return _keywordsEn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywordsEn);
  }

  @override
  String toString() {
    return 'ParagraphSearchData(keywordsAr: $keywordsAr, keywordsEn: $keywordsEn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphSearchDataImpl &&
            const DeepCollectionEquality()
                .equals(other._keywordsAr, _keywordsAr) &&
            const DeepCollectionEquality()
                .equals(other._keywordsEn, _keywordsEn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_keywordsAr),
      const DeepCollectionEquality().hash(_keywordsEn));

  /// Create a copy of ParagraphSearchData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphSearchDataImplCopyWith<_$ParagraphSearchDataImpl> get copyWith =>
      __$$ParagraphSearchDataImplCopyWithImpl<_$ParagraphSearchDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphSearchDataImplToJson(
      this,
    );
  }
}

abstract class _ParagraphSearchData implements ParagraphSearchData {
  const factory _ParagraphSearchData(
          {@JsonKey(name: 'keywords_ar') final List<String> keywordsAr,
          @JsonKey(name: 'keywords_en') final List<String> keywordsEn}) =
      _$ParagraphSearchDataImpl;

  factory _ParagraphSearchData.fromJson(Map<String, dynamic> json) =
      _$ParagraphSearchDataImpl.fromJson;

  @override
  @JsonKey(name: 'keywords_ar')
  List<String> get keywordsAr;
  @override
  @JsonKey(name: 'keywords_en')
  List<String> get keywordsEn;

  /// Create a copy of ParagraphSearchData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphSearchDataImplCopyWith<_$ParagraphSearchDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParagraphReferences _$ParagraphReferencesFromJson(Map<String, dynamic> json) {
  return _ParagraphReferences.fromJson(json);
}

/// @nodoc
mixin _$ParagraphReferences {
  @JsonKey(name: 'referenced_in_questions')
  List<String> get referencedInQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'related_paragraphs')
  List<String> get relatedParagraphs => throw _privateConstructorUsedError;

  /// Serializes this ParagraphReferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParagraphReferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphReferencesCopyWith<ParagraphReferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphReferencesCopyWith<$Res> {
  factory $ParagraphReferencesCopyWith(
          ParagraphReferences value, $Res Function(ParagraphReferences) then) =
      _$ParagraphReferencesCopyWithImpl<$Res, ParagraphReferences>;
  @useResult
  $Res call(
      {@JsonKey(name: 'referenced_in_questions')
      List<String> referencedInQuestions,
      @JsonKey(name: 'related_paragraphs') List<String> relatedParagraphs});
}

/// @nodoc
class _$ParagraphReferencesCopyWithImpl<$Res, $Val extends ParagraphReferences>
    implements $ParagraphReferencesCopyWith<$Res> {
  _$ParagraphReferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParagraphReferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referencedInQuestions = null,
    Object? relatedParagraphs = null,
  }) {
    return _then(_value.copyWith(
      referencedInQuestions: null == referencedInQuestions
          ? _value.referencedInQuestions
          : referencedInQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      relatedParagraphs: null == relatedParagraphs
          ? _value.relatedParagraphs
          : relatedParagraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParagraphReferencesImplCopyWith<$Res>
    implements $ParagraphReferencesCopyWith<$Res> {
  factory _$$ParagraphReferencesImplCopyWith(_$ParagraphReferencesImpl value,
          $Res Function(_$ParagraphReferencesImpl) then) =
      __$$ParagraphReferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'referenced_in_questions')
      List<String> referencedInQuestions,
      @JsonKey(name: 'related_paragraphs') List<String> relatedParagraphs});
}

/// @nodoc
class __$$ParagraphReferencesImplCopyWithImpl<$Res>
    extends _$ParagraphReferencesCopyWithImpl<$Res, _$ParagraphReferencesImpl>
    implements _$$ParagraphReferencesImplCopyWith<$Res> {
  __$$ParagraphReferencesImplCopyWithImpl(_$ParagraphReferencesImpl _value,
      $Res Function(_$ParagraphReferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParagraphReferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referencedInQuestions = null,
    Object? relatedParagraphs = null,
  }) {
    return _then(_$ParagraphReferencesImpl(
      referencedInQuestions: null == referencedInQuestions
          ? _value._referencedInQuestions
          : referencedInQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      relatedParagraphs: null == relatedParagraphs
          ? _value._relatedParagraphs
          : relatedParagraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphReferencesImpl implements _ParagraphReferences {
  const _$ParagraphReferencesImpl(
      {@JsonKey(name: 'referenced_in_questions')
      final List<String> referencedInQuestions = const [],
      @JsonKey(name: 'related_paragraphs')
      final List<String> relatedParagraphs = const []})
      : _referencedInQuestions = referencedInQuestions,
        _relatedParagraphs = relatedParagraphs;

  factory _$ParagraphReferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphReferencesImplFromJson(json);

  final List<String> _referencedInQuestions;
  @override
  @JsonKey(name: 'referenced_in_questions')
  List<String> get referencedInQuestions {
    if (_referencedInQuestions is EqualUnmodifiableListView)
      return _referencedInQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_referencedInQuestions);
  }

  final List<String> _relatedParagraphs;
  @override
  @JsonKey(name: 'related_paragraphs')
  List<String> get relatedParagraphs {
    if (_relatedParagraphs is EqualUnmodifiableListView)
      return _relatedParagraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedParagraphs);
  }

  @override
  String toString() {
    return 'ParagraphReferences(referencedInQuestions: $referencedInQuestions, relatedParagraphs: $relatedParagraphs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphReferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._referencedInQuestions, _referencedInQuestions) &&
            const DeepCollectionEquality()
                .equals(other._relatedParagraphs, _relatedParagraphs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_referencedInQuestions),
      const DeepCollectionEquality().hash(_relatedParagraphs));

  /// Create a copy of ParagraphReferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphReferencesImplCopyWith<_$ParagraphReferencesImpl> get copyWith =>
      __$$ParagraphReferencesImplCopyWithImpl<_$ParagraphReferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphReferencesImplToJson(
      this,
    );
  }
}

abstract class _ParagraphReferences implements ParagraphReferences {
  const factory _ParagraphReferences(
      {@JsonKey(name: 'referenced_in_questions')
      final List<String> referencedInQuestions,
      @JsonKey(name: 'related_paragraphs')
      final List<String> relatedParagraphs}) = _$ParagraphReferencesImpl;

  factory _ParagraphReferences.fromJson(Map<String, dynamic> json) =
      _$ParagraphReferencesImpl.fromJson;

  @override
  @JsonKey(name: 'referenced_in_questions')
  List<String> get referencedInQuestions;
  @override
  @JsonKey(name: 'related_paragraphs')
  List<String> get relatedParagraphs;

  /// Create a copy of ParagraphReferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphReferencesImplCopyWith<_$ParagraphReferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestionPotential _$QuestionPotentialFromJson(Map<String, dynamic> json) {
  return _QuestionPotential.fromJson(json);
}

/// @nodoc
mixin _$QuestionPotential {
  @JsonKey(name: 'facts_count')
  int get factsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_generate_questions')
  bool get canGenerateQuestions => throw _privateConstructorUsedError;

  /// Serializes this QuestionPotential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionPotential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionPotentialCopyWith<QuestionPotential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionPotentialCopyWith<$Res> {
  factory $QuestionPotentialCopyWith(
          QuestionPotential value, $Res Function(QuestionPotential) then) =
      _$QuestionPotentialCopyWithImpl<$Res, QuestionPotential>;
  @useResult
  $Res call(
      {@JsonKey(name: 'facts_count') int factsCount,
      @JsonKey(name: 'can_generate_questions') bool canGenerateQuestions});
}

/// @nodoc
class _$QuestionPotentialCopyWithImpl<$Res, $Val extends QuestionPotential>
    implements $QuestionPotentialCopyWith<$Res> {
  _$QuestionPotentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionPotential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factsCount = null,
    Object? canGenerateQuestions = null,
  }) {
    return _then(_value.copyWith(
      factsCount: null == factsCount
          ? _value.factsCount
          : factsCount // ignore: cast_nullable_to_non_nullable
              as int,
      canGenerateQuestions: null == canGenerateQuestions
          ? _value.canGenerateQuestions
          : canGenerateQuestions // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionPotentialImplCopyWith<$Res>
    implements $QuestionPotentialCopyWith<$Res> {
  factory _$$QuestionPotentialImplCopyWith(_$QuestionPotentialImpl value,
          $Res Function(_$QuestionPotentialImpl) then) =
      __$$QuestionPotentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'facts_count') int factsCount,
      @JsonKey(name: 'can_generate_questions') bool canGenerateQuestions});
}

/// @nodoc
class __$$QuestionPotentialImplCopyWithImpl<$Res>
    extends _$QuestionPotentialCopyWithImpl<$Res, _$QuestionPotentialImpl>
    implements _$$QuestionPotentialImplCopyWith<$Res> {
  __$$QuestionPotentialImplCopyWithImpl(_$QuestionPotentialImpl _value,
      $Res Function(_$QuestionPotentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionPotential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factsCount = null,
    Object? canGenerateQuestions = null,
  }) {
    return _then(_$QuestionPotentialImpl(
      factsCount: null == factsCount
          ? _value.factsCount
          : factsCount // ignore: cast_nullable_to_non_nullable
              as int,
      canGenerateQuestions: null == canGenerateQuestions
          ? _value.canGenerateQuestions
          : canGenerateQuestions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionPotentialImpl implements _QuestionPotential {
  const _$QuestionPotentialImpl(
      {@JsonKey(name: 'facts_count') this.factsCount = 0,
      @JsonKey(name: 'can_generate_questions')
      this.canGenerateQuestions = false});

  factory _$QuestionPotentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionPotentialImplFromJson(json);

  @override
  @JsonKey(name: 'facts_count')
  final int factsCount;
  @override
  @JsonKey(name: 'can_generate_questions')
  final bool canGenerateQuestions;

  @override
  String toString() {
    return 'QuestionPotential(factsCount: $factsCount, canGenerateQuestions: $canGenerateQuestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionPotentialImpl &&
            (identical(other.factsCount, factsCount) ||
                other.factsCount == factsCount) &&
            (identical(other.canGenerateQuestions, canGenerateQuestions) ||
                other.canGenerateQuestions == canGenerateQuestions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, factsCount, canGenerateQuestions);

  /// Create a copy of QuestionPotential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionPotentialImplCopyWith<_$QuestionPotentialImpl> get copyWith =>
      __$$QuestionPotentialImplCopyWithImpl<_$QuestionPotentialImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionPotentialImplToJson(
      this,
    );
  }
}

abstract class _QuestionPotential implements QuestionPotential {
  const factory _QuestionPotential(
      {@JsonKey(name: 'facts_count') final int factsCount,
      @JsonKey(name: 'can_generate_questions')
      final bool canGenerateQuestions}) = _$QuestionPotentialImpl;

  factory _QuestionPotential.fromJson(Map<String, dynamic> json) =
      _$QuestionPotentialImpl.fromJson;

  @override
  @JsonKey(name: 'facts_count')
  int get factsCount;
  @override
  @JsonKey(name: 'can_generate_questions')
  bool get canGenerateQuestions;

  /// Create a copy of QuestionPotential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionPotentialImplCopyWith<_$QuestionPotentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParagraphMetadata _$ParagraphMetadataFromJson(Map<String, dynamic> json) {
  return _ParagraphMetadata.fromJson(json);
}

/// @nodoc
mixin _$ParagraphMetadata {
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'reading_time_seconds')
  int get readingTimeSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_potential')
  QuestionPotential? get questionPotential =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'content_priority')
  ContentPriority get contentPriority => throw _privateConstructorUsedError;

  /// Serializes this ParagraphMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParagraphMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphMetadataCopyWith<ParagraphMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphMetadataCopyWith<$Res> {
  factory $ParagraphMetadataCopyWith(
          ParagraphMetadata value, $Res Function(ParagraphMetadata) then) =
      _$ParagraphMetadataCopyWithImpl<$Res, ParagraphMetadata>;
  @useResult
  $Res call(
      {DifficultyLevel difficulty,
      @JsonKey(name: 'reading_time_seconds') int readingTimeSeconds,
      @JsonKey(name: 'question_potential') QuestionPotential? questionPotential,
      @JsonKey(name: 'content_priority') ContentPriority contentPriority});

  $QuestionPotentialCopyWith<$Res>? get questionPotential;
}

/// @nodoc
class _$ParagraphMetadataCopyWithImpl<$Res, $Val extends ParagraphMetadata>
    implements $ParagraphMetadataCopyWith<$Res> {
  _$ParagraphMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParagraphMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? difficulty = null,
    Object? readingTimeSeconds = null,
    Object? questionPotential = freezed,
    Object? contentPriority = null,
  }) {
    return _then(_value.copyWith(
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      readingTimeSeconds: null == readingTimeSeconds
          ? _value.readingTimeSeconds
          : readingTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      questionPotential: freezed == questionPotential
          ? _value.questionPotential
          : questionPotential // ignore: cast_nullable_to_non_nullable
              as QuestionPotential?,
      contentPriority: null == contentPriority
          ? _value.contentPriority
          : contentPriority // ignore: cast_nullable_to_non_nullable
              as ContentPriority,
    ) as $Val);
  }

  /// Create a copy of ParagraphMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionPotentialCopyWith<$Res>? get questionPotential {
    if (_value.questionPotential == null) {
      return null;
    }

    return $QuestionPotentialCopyWith<$Res>(_value.questionPotential!, (value) {
      return _then(_value.copyWith(questionPotential: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParagraphMetadataImplCopyWith<$Res>
    implements $ParagraphMetadataCopyWith<$Res> {
  factory _$$ParagraphMetadataImplCopyWith(_$ParagraphMetadataImpl value,
          $Res Function(_$ParagraphMetadataImpl) then) =
      __$$ParagraphMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DifficultyLevel difficulty,
      @JsonKey(name: 'reading_time_seconds') int readingTimeSeconds,
      @JsonKey(name: 'question_potential') QuestionPotential? questionPotential,
      @JsonKey(name: 'content_priority') ContentPriority contentPriority});

  @override
  $QuestionPotentialCopyWith<$Res>? get questionPotential;
}

/// @nodoc
class __$$ParagraphMetadataImplCopyWithImpl<$Res>
    extends _$ParagraphMetadataCopyWithImpl<$Res, _$ParagraphMetadataImpl>
    implements _$$ParagraphMetadataImplCopyWith<$Res> {
  __$$ParagraphMetadataImplCopyWithImpl(_$ParagraphMetadataImpl _value,
      $Res Function(_$ParagraphMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParagraphMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? difficulty = null,
    Object? readingTimeSeconds = null,
    Object? questionPotential = freezed,
    Object? contentPriority = null,
  }) {
    return _then(_$ParagraphMetadataImpl(
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      readingTimeSeconds: null == readingTimeSeconds
          ? _value.readingTimeSeconds
          : readingTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      questionPotential: freezed == questionPotential
          ? _value.questionPotential
          : questionPotential // ignore: cast_nullable_to_non_nullable
              as QuestionPotential?,
      contentPriority: null == contentPriority
          ? _value.contentPriority
          : contentPriority // ignore: cast_nullable_to_non_nullable
              as ContentPriority,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphMetadataImpl implements _ParagraphMetadata {
  const _$ParagraphMetadataImpl(
      {this.difficulty = DifficultyLevel.basic,
      @JsonKey(name: 'reading_time_seconds') this.readingTimeSeconds = 0,
      @JsonKey(name: 'question_potential') this.questionPotential,
      @JsonKey(name: 'content_priority')
      this.contentPriority = ContentPriority.medium});

  factory _$ParagraphMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphMetadataImplFromJson(json);

  @override
  @JsonKey()
  final DifficultyLevel difficulty;
  @override
  @JsonKey(name: 'reading_time_seconds')
  final int readingTimeSeconds;
  @override
  @JsonKey(name: 'question_potential')
  final QuestionPotential? questionPotential;
  @override
  @JsonKey(name: 'content_priority')
  final ContentPriority contentPriority;

  @override
  String toString() {
    return 'ParagraphMetadata(difficulty: $difficulty, readingTimeSeconds: $readingTimeSeconds, questionPotential: $questionPotential, contentPriority: $contentPriority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphMetadataImpl &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.readingTimeSeconds, readingTimeSeconds) ||
                other.readingTimeSeconds == readingTimeSeconds) &&
            (identical(other.questionPotential, questionPotential) ||
                other.questionPotential == questionPotential) &&
            (identical(other.contentPriority, contentPriority) ||
                other.contentPriority == contentPriority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, difficulty, readingTimeSeconds,
      questionPotential, contentPriority);

  /// Create a copy of ParagraphMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphMetadataImplCopyWith<_$ParagraphMetadataImpl> get copyWith =>
      __$$ParagraphMetadataImplCopyWithImpl<_$ParagraphMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphMetadataImplToJson(
      this,
    );
  }
}

abstract class _ParagraphMetadata implements ParagraphMetadata {
  const factory _ParagraphMetadata(
      {final DifficultyLevel difficulty,
      @JsonKey(name: 'reading_time_seconds') final int readingTimeSeconds,
      @JsonKey(name: 'question_potential')
      final QuestionPotential? questionPotential,
      @JsonKey(name: 'content_priority')
      final ContentPriority contentPriority}) = _$ParagraphMetadataImpl;

  factory _ParagraphMetadata.fromJson(Map<String, dynamic> json) =
      _$ParagraphMetadataImpl.fromJson;

  @override
  DifficultyLevel get difficulty;
  @override
  @JsonKey(name: 'reading_time_seconds')
  int get readingTimeSeconds;
  @override
  @JsonKey(name: 'question_potential')
  QuestionPotential? get questionPotential;
  @override
  @JsonKey(name: 'content_priority')
  ContentPriority get contentPriority;

  /// Create a copy of ParagraphMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphMetadataImplCopyWith<_$ParagraphMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Paragraph _$ParagraphFromJson(Map<String, dynamic> json) {
  return _Paragraph.fromJson(json);
}

/// @nodoc
mixin _$Paragraph {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_id')
  String get sectionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_title_ar')
  String get sectionTitleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_title_en')
  String? get sectionTitleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_number')
  int get paragraphNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_number')
  int get pageNumber => throw _privateConstructorUsedError;
  ParagraphContent get content => throw _privateConstructorUsedError;
  ParagraphEntities get entities => throw _privateConstructorUsedError;
  @JsonKey(name: 'search_data')
  ParagraphSearchData get searchData => throw _privateConstructorUsedError;
  ParagraphReferences get references => throw _privateConstructorUsedError;
  ParagraphMetadata get metadata => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Paragraph to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphCopyWith<Paragraph> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphCopyWith<$Res> {
  factory $ParagraphCopyWith(Paragraph value, $Res Function(Paragraph) then) =
      _$ParagraphCopyWithImpl<$Res, Paragraph>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'section_id') String sectionId,
      @JsonKey(name: 'section_title_ar') String sectionTitleAr,
      @JsonKey(name: 'section_title_en') String? sectionTitleEn,
      @JsonKey(name: 'paragraph_number') int paragraphNumber,
      @JsonKey(name: 'page_number') int pageNumber,
      ParagraphContent content,
      ParagraphEntities entities,
      @JsonKey(name: 'search_data') ParagraphSearchData searchData,
      ParagraphReferences references,
      ParagraphMetadata metadata,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $ParagraphContentCopyWith<$Res> get content;
  $ParagraphEntitiesCopyWith<$Res> get entities;
  $ParagraphSearchDataCopyWith<$Res> get searchData;
  $ParagraphReferencesCopyWith<$Res> get references;
  $ParagraphMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$ParagraphCopyWithImpl<$Res, $Val extends Paragraph>
    implements $ParagraphCopyWith<$Res> {
  _$ParagraphCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? sectionId = null,
    Object? sectionTitleAr = null,
    Object? sectionTitleEn = freezed,
    Object? paragraphNumber = null,
    Object? pageNumber = null,
    Object? content = null,
    Object? entities = null,
    Object? searchData = null,
    Object? references = null,
    Object? metadata = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionTitleAr: null == sectionTitleAr
          ? _value.sectionTitleAr
          : sectionTitleAr // ignore: cast_nullable_to_non_nullable
              as String,
      sectionTitleEn: freezed == sectionTitleEn
          ? _value.sectionTitleEn
          : sectionTitleEn // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphNumber: null == paragraphNumber
          ? _value.paragraphNumber
          : paragraphNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ParagraphContent,
      entities: null == entities
          ? _value.entities
          : entities // ignore: cast_nullable_to_non_nullable
              as ParagraphEntities,
      searchData: null == searchData
          ? _value.searchData
          : searchData // ignore: cast_nullable_to_non_nullable
              as ParagraphSearchData,
      references: null == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as ParagraphReferences,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ParagraphMetadata,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParagraphContentCopyWith<$Res> get content {
    return $ParagraphContentCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParagraphEntitiesCopyWith<$Res> get entities {
    return $ParagraphEntitiesCopyWith<$Res>(_value.entities, (value) {
      return _then(_value.copyWith(entities: value) as $Val);
    });
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParagraphSearchDataCopyWith<$Res> get searchData {
    return $ParagraphSearchDataCopyWith<$Res>(_value.searchData, (value) {
      return _then(_value.copyWith(searchData: value) as $Val);
    });
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParagraphReferencesCopyWith<$Res> get references {
    return $ParagraphReferencesCopyWith<$Res>(_value.references, (value) {
      return _then(_value.copyWith(references: value) as $Val);
    });
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParagraphMetadataCopyWith<$Res> get metadata {
    return $ParagraphMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParagraphImplCopyWith<$Res>
    implements $ParagraphCopyWith<$Res> {
  factory _$$ParagraphImplCopyWith(
          _$ParagraphImpl value, $Res Function(_$ParagraphImpl) then) =
      __$$ParagraphImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'section_id') String sectionId,
      @JsonKey(name: 'section_title_ar') String sectionTitleAr,
      @JsonKey(name: 'section_title_en') String? sectionTitleEn,
      @JsonKey(name: 'paragraph_number') int paragraphNumber,
      @JsonKey(name: 'page_number') int pageNumber,
      ParagraphContent content,
      ParagraphEntities entities,
      @JsonKey(name: 'search_data') ParagraphSearchData searchData,
      ParagraphReferences references,
      ParagraphMetadata metadata,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $ParagraphContentCopyWith<$Res> get content;
  @override
  $ParagraphEntitiesCopyWith<$Res> get entities;
  @override
  $ParagraphSearchDataCopyWith<$Res> get searchData;
  @override
  $ParagraphReferencesCopyWith<$Res> get references;
  @override
  $ParagraphMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$ParagraphImplCopyWithImpl<$Res>
    extends _$ParagraphCopyWithImpl<$Res, _$ParagraphImpl>
    implements _$$ParagraphImplCopyWith<$Res> {
  __$$ParagraphImplCopyWithImpl(
      _$ParagraphImpl _value, $Res Function(_$ParagraphImpl) _then)
      : super(_value, _then);

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? sectionId = null,
    Object? sectionTitleAr = null,
    Object? sectionTitleEn = freezed,
    Object? paragraphNumber = null,
    Object? pageNumber = null,
    Object? content = null,
    Object? entities = null,
    Object? searchData = null,
    Object? references = null,
    Object? metadata = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$ParagraphImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionTitleAr: null == sectionTitleAr
          ? _value.sectionTitleAr
          : sectionTitleAr // ignore: cast_nullable_to_non_nullable
              as String,
      sectionTitleEn: freezed == sectionTitleEn
          ? _value.sectionTitleEn
          : sectionTitleEn // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphNumber: null == paragraphNumber
          ? _value.paragraphNumber
          : paragraphNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ParagraphContent,
      entities: null == entities
          ? _value.entities
          : entities // ignore: cast_nullable_to_non_nullable
              as ParagraphEntities,
      searchData: null == searchData
          ? _value.searchData
          : searchData // ignore: cast_nullable_to_non_nullable
              as ParagraphSearchData,
      references: null == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as ParagraphReferences,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ParagraphMetadata,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphImpl implements _Paragraph {
  const _$ParagraphImpl(
      {required this.id,
      @JsonKey(name: 'book_id') required this.bookId,
      @JsonKey(name: 'section_id') required this.sectionId,
      @JsonKey(name: 'section_title_ar') required this.sectionTitleAr,
      @JsonKey(name: 'section_title_en') this.sectionTitleEn,
      @JsonKey(name: 'paragraph_number') required this.paragraphNumber,
      @JsonKey(name: 'page_number') required this.pageNumber,
      required this.content,
      this.entities = const ParagraphEntities(),
      @JsonKey(name: 'search_data')
      this.searchData = const ParagraphSearchData(),
      this.references = const ParagraphReferences(),
      this.metadata = const ParagraphMetadata(),
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$ParagraphImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'book_id')
  final String bookId;
  @override
  @JsonKey(name: 'section_id')
  final String sectionId;
  @override
  @JsonKey(name: 'section_title_ar')
  final String sectionTitleAr;
  @override
  @JsonKey(name: 'section_title_en')
  final String? sectionTitleEn;
  @override
  @JsonKey(name: 'paragraph_number')
  final int paragraphNumber;
  @override
  @JsonKey(name: 'page_number')
  final int pageNumber;
  @override
  final ParagraphContent content;
  @override
  @JsonKey()
  final ParagraphEntities entities;
  @override
  @JsonKey(name: 'search_data')
  final ParagraphSearchData searchData;
  @override
  @JsonKey()
  final ParagraphReferences references;
  @override
  @JsonKey()
  final ParagraphMetadata metadata;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Paragraph(id: $id, bookId: $bookId, sectionId: $sectionId, sectionTitleAr: $sectionTitleAr, sectionTitleEn: $sectionTitleEn, paragraphNumber: $paragraphNumber, pageNumber: $pageNumber, content: $content, entities: $entities, searchData: $searchData, references: $references, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.sectionTitleAr, sectionTitleAr) ||
                other.sectionTitleAr == sectionTitleAr) &&
            (identical(other.sectionTitleEn, sectionTitleEn) ||
                other.sectionTitleEn == sectionTitleEn) &&
            (identical(other.paragraphNumber, paragraphNumber) ||
                other.paragraphNumber == paragraphNumber) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.entities, entities) ||
                other.entities == entities) &&
            (identical(other.searchData, searchData) ||
                other.searchData == searchData) &&
            (identical(other.references, references) ||
                other.references == references) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      bookId,
      sectionId,
      sectionTitleAr,
      sectionTitleEn,
      paragraphNumber,
      pageNumber,
      content,
      entities,
      searchData,
      references,
      metadata,
      createdAt);

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphImplCopyWith<_$ParagraphImpl> get copyWith =>
      __$$ParagraphImplCopyWithImpl<_$ParagraphImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphImplToJson(
      this,
    );
  }
}

abstract class _Paragraph implements Paragraph {
  const factory _Paragraph(
      {required final String id,
      @JsonKey(name: 'book_id') required final String bookId,
      @JsonKey(name: 'section_id') required final String sectionId,
      @JsonKey(name: 'section_title_ar') required final String sectionTitleAr,
      @JsonKey(name: 'section_title_en') final String? sectionTitleEn,
      @JsonKey(name: 'paragraph_number') required final int paragraphNumber,
      @JsonKey(name: 'page_number') required final int pageNumber,
      required final ParagraphContent content,
      final ParagraphEntities entities,
      @JsonKey(name: 'search_data') final ParagraphSearchData searchData,
      final ParagraphReferences references,
      final ParagraphMetadata metadata,
      @JsonKey(name: 'created_at')
      final DateTime? createdAt}) = _$ParagraphImpl;

  factory _Paragraph.fromJson(Map<String, dynamic> json) =
      _$ParagraphImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'book_id')
  String get bookId;
  @override
  @JsonKey(name: 'section_id')
  String get sectionId;
  @override
  @JsonKey(name: 'section_title_ar')
  String get sectionTitleAr;
  @override
  @JsonKey(name: 'section_title_en')
  String? get sectionTitleEn;
  @override
  @JsonKey(name: 'paragraph_number')
  int get paragraphNumber;
  @override
  @JsonKey(name: 'page_number')
  int get pageNumber;
  @override
  ParagraphContent get content;
  @override
  ParagraphEntities get entities;
  @override
  @JsonKey(name: 'search_data')
  ParagraphSearchData get searchData;
  @override
  ParagraphReferences get references;
  @override
  ParagraphMetadata get metadata;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphImplCopyWith<_$ParagraphImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
