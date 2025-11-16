// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Section _$SectionFromJson(Map<String, dynamic> json) {
  return _Section.fromJson(json);
}

/// @nodoc
mixin _$Section {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_title_ar')
  String get bookTitleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_title_en')
  String? get bookTitleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_number')
  int get sectionNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_ar')
  String get titleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_en')
  String get titleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_count')
  int get paragraphCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_range')
  String? get pageRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_level')
  DifficultyLevel get difficultyLevel => throw _privateConstructorUsedError;
  List<String> get topics => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Section to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionCopyWith<Section> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionCopyWith<$Res> {
  factory $SectionCopyWith(Section value, $Res Function(Section) then) =
      _$SectionCopyWithImpl<$Res, Section>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'book_title_ar') String bookTitleAr,
      @JsonKey(name: 'book_title_en') String? bookTitleEn,
      @JsonKey(name: 'section_number') int sectionNumber,
      @JsonKey(name: 'title_ar') String titleAr,
      @JsonKey(name: 'title_en') String titleEn,
      @JsonKey(name: 'paragraph_count') int paragraphCount,
      @JsonKey(name: 'page_range') String? pageRange,
      @JsonKey(name: 'difficulty_level') DifficultyLevel difficultyLevel,
      List<String> topics,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$SectionCopyWithImpl<$Res, $Val extends Section>
    implements $SectionCopyWith<$Res> {
  _$SectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? bookTitleAr = null,
    Object? bookTitleEn = freezed,
    Object? sectionNumber = null,
    Object? titleAr = null,
    Object? titleEn = null,
    Object? paragraphCount = null,
    Object? pageRange = freezed,
    Object? difficultyLevel = null,
    Object? topics = null,
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
      bookTitleAr: null == bookTitleAr
          ? _value.bookTitleAr
          : bookTitleAr // ignore: cast_nullable_to_non_nullable
              as String,
      bookTitleEn: freezed == bookTitleEn
          ? _value.bookTitleEn
          : bookTitleEn // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionNumber: null == sectionNumber
          ? _value.sectionNumber
          : sectionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphCount: null == paragraphCount
          ? _value.paragraphCount
          : paragraphCount // ignore: cast_nullable_to_non_nullable
              as int,
      pageRange: freezed == pageRange
          ? _value.pageRange
          : pageRange // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      topics: null == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionImplCopyWith<$Res> implements $SectionCopyWith<$Res> {
  factory _$$SectionImplCopyWith(
          _$SectionImpl value, $Res Function(_$SectionImpl) then) =
      __$$SectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'book_title_ar') String bookTitleAr,
      @JsonKey(name: 'book_title_en') String? bookTitleEn,
      @JsonKey(name: 'section_number') int sectionNumber,
      @JsonKey(name: 'title_ar') String titleAr,
      @JsonKey(name: 'title_en') String titleEn,
      @JsonKey(name: 'paragraph_count') int paragraphCount,
      @JsonKey(name: 'page_range') String? pageRange,
      @JsonKey(name: 'difficulty_level') DifficultyLevel difficultyLevel,
      List<String> topics,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$SectionImplCopyWithImpl<$Res>
    extends _$SectionCopyWithImpl<$Res, _$SectionImpl>
    implements _$$SectionImplCopyWith<$Res> {
  __$$SectionImplCopyWithImpl(
      _$SectionImpl _value, $Res Function(_$SectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? bookTitleAr = null,
    Object? bookTitleEn = freezed,
    Object? sectionNumber = null,
    Object? titleAr = null,
    Object? titleEn = null,
    Object? paragraphCount = null,
    Object? pageRange = freezed,
    Object? difficultyLevel = null,
    Object? topics = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$SectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      bookTitleAr: null == bookTitleAr
          ? _value.bookTitleAr
          : bookTitleAr // ignore: cast_nullable_to_non_nullable
              as String,
      bookTitleEn: freezed == bookTitleEn
          ? _value.bookTitleEn
          : bookTitleEn // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionNumber: null == sectionNumber
          ? _value.sectionNumber
          : sectionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphCount: null == paragraphCount
          ? _value.paragraphCount
          : paragraphCount // ignore: cast_nullable_to_non_nullable
              as int,
      pageRange: freezed == pageRange
          ? _value.pageRange
          : pageRange // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      topics: null == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionImpl implements _Section {
  const _$SectionImpl(
      {required this.id,
      @JsonKey(name: 'book_id') required this.bookId,
      @JsonKey(name: 'book_title_ar') required this.bookTitleAr,
      @JsonKey(name: 'book_title_en') this.bookTitleEn,
      @JsonKey(name: 'section_number') required this.sectionNumber,
      @JsonKey(name: 'title_ar') required this.titleAr,
      @JsonKey(name: 'title_en') required this.titleEn,
      @JsonKey(name: 'paragraph_count') this.paragraphCount = 0,
      @JsonKey(name: 'page_range') this.pageRange,
      @JsonKey(name: 'difficulty_level')
      this.difficultyLevel = DifficultyLevel.basic,
      final List<String> topics = const [],
      @JsonKey(name: 'created_at') this.createdAt})
      : _topics = topics;

  factory _$SectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'book_id')
  final String bookId;
  @override
  @JsonKey(name: 'book_title_ar')
  final String bookTitleAr;
  @override
  @JsonKey(name: 'book_title_en')
  final String? bookTitleEn;
  @override
  @JsonKey(name: 'section_number')
  final int sectionNumber;
  @override
  @JsonKey(name: 'title_ar')
  final String titleAr;
  @override
  @JsonKey(name: 'title_en')
  final String titleEn;
  @override
  @JsonKey(name: 'paragraph_count')
  final int paragraphCount;
  @override
  @JsonKey(name: 'page_range')
  final String? pageRange;
  @override
  @JsonKey(name: 'difficulty_level')
  final DifficultyLevel difficultyLevel;
  final List<String> _topics;
  @override
  @JsonKey()
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Section(id: $id, bookId: $bookId, bookTitleAr: $bookTitleAr, bookTitleEn: $bookTitleEn, sectionNumber: $sectionNumber, titleAr: $titleAr, titleEn: $titleEn, paragraphCount: $paragraphCount, pageRange: $pageRange, difficultyLevel: $difficultyLevel, topics: $topics, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.bookTitleAr, bookTitleAr) ||
                other.bookTitleAr == bookTitleAr) &&
            (identical(other.bookTitleEn, bookTitleEn) ||
                other.bookTitleEn == bookTitleEn) &&
            (identical(other.sectionNumber, sectionNumber) ||
                other.sectionNumber == sectionNumber) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            (identical(other.paragraphCount, paragraphCount) ||
                other.paragraphCount == paragraphCount) &&
            (identical(other.pageRange, pageRange) ||
                other.pageRange == pageRange) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      bookId,
      bookTitleAr,
      bookTitleEn,
      sectionNumber,
      titleAr,
      titleEn,
      paragraphCount,
      pageRange,
      difficultyLevel,
      const DeepCollectionEquality().hash(_topics),
      createdAt);

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      __$$SectionImplCopyWithImpl<_$SectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionImplToJson(
      this,
    );
  }
}

abstract class _Section implements Section {
  const factory _Section(
      {required final String id,
      @JsonKey(name: 'book_id') required final String bookId,
      @JsonKey(name: 'book_title_ar') required final String bookTitleAr,
      @JsonKey(name: 'book_title_en') final String? bookTitleEn,
      @JsonKey(name: 'section_number') required final int sectionNumber,
      @JsonKey(name: 'title_ar') required final String titleAr,
      @JsonKey(name: 'title_en') required final String titleEn,
      @JsonKey(name: 'paragraph_count') final int paragraphCount,
      @JsonKey(name: 'page_range') final String? pageRange,
      @JsonKey(name: 'difficulty_level') final DifficultyLevel difficultyLevel,
      final List<String> topics,
      @JsonKey(name: 'created_at') final DateTime? createdAt}) = _$SectionImpl;

  factory _Section.fromJson(Map<String, dynamic> json) = _$SectionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'book_id')
  String get bookId;
  @override
  @JsonKey(name: 'book_title_ar')
  String get bookTitleAr;
  @override
  @JsonKey(name: 'book_title_en')
  String? get bookTitleEn;
  @override
  @JsonKey(name: 'section_number')
  int get sectionNumber;
  @override
  @JsonKey(name: 'title_ar')
  String get titleAr;
  @override
  @JsonKey(name: 'title_en')
  String get titleEn;
  @override
  @JsonKey(name: 'paragraph_count')
  int get paragraphCount;
  @override
  @JsonKey(name: 'page_range')
  String? get pageRange;
  @override
  @JsonKey(name: 'difficulty_level')
  DifficultyLevel get difficultyLevel;
  @override
  List<String> get topics;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
