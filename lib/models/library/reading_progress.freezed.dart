// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReadingProgress _$ReadingProgressFromJson(Map<String, dynamic> json) {
  return _ReadingProgress.fromJson(json);
}

/// @nodoc
mixin _$ReadingProgress {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_title_ar')
  String get bookTitleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_title_en')
  String? get bookTitleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_section_id')
  String? get currentSectionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_paragraph_id')
  String? get currentParagraphId => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraphs_read')
  List<String> get paragraphsRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_paragraphs')
  int get totalParagraphs => throw _privateConstructorUsedError;
  @JsonKey(name: 'progress_percentage')
  double get progressPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_date')
  DateTime? get lastReadDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_reading_time_minutes')
  int get totalReadingTimeMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_completed')
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Serializes this ReadingProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReadingProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadingProgressCopyWith<ReadingProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingProgressCopyWith<$Res> {
  factory $ReadingProgressCopyWith(
          ReadingProgress value, $Res Function(ReadingProgress) then) =
      _$ReadingProgressCopyWithImpl<$Res, ReadingProgress>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'book_title_ar') String bookTitleAr,
      @JsonKey(name: 'book_title_en') String? bookTitleEn,
      @JsonKey(name: 'current_section_id') String? currentSectionId,
      @JsonKey(name: 'current_paragraph_id') String? currentParagraphId,
      @JsonKey(name: 'paragraphs_read') List<String> paragraphsRead,
      @JsonKey(name: 'total_paragraphs') int totalParagraphs,
      @JsonKey(name: 'progress_percentage') double progressPercentage,
      @JsonKey(name: 'last_read_date') DateTime? lastReadDate,
      @JsonKey(name: 'total_reading_time_minutes') int totalReadingTimeMinutes,
      @JsonKey(name: 'started_at') DateTime? startedAt,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'is_completed') bool isCompleted});
}

/// @nodoc
class _$ReadingProgressCopyWithImpl<$Res, $Val extends ReadingProgress>
    implements $ReadingProgressCopyWith<$Res> {
  _$ReadingProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadingProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookId = null,
    Object? bookTitleAr = null,
    Object? bookTitleEn = freezed,
    Object? currentSectionId = freezed,
    Object? currentParagraphId = freezed,
    Object? paragraphsRead = null,
    Object? totalParagraphs = null,
    Object? progressPercentage = null,
    Object? lastReadDate = freezed,
    Object? totalReadingTimeMinutes = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
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
      currentSectionId: freezed == currentSectionId
          ? _value.currentSectionId
          : currentSectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentParagraphId: freezed == currentParagraphId
          ? _value.currentParagraphId
          : currentParagraphId // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphsRead: null == paragraphsRead
          ? _value.paragraphsRead
          : paragraphsRead // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalParagraphs: null == totalParagraphs
          ? _value.totalParagraphs
          : totalParagraphs // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      lastReadDate: freezed == lastReadDate
          ? _value.lastReadDate
          : lastReadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalReadingTimeMinutes: null == totalReadingTimeMinutes
          ? _value.totalReadingTimeMinutes
          : totalReadingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingProgressImplCopyWith<$Res>
    implements $ReadingProgressCopyWith<$Res> {
  factory _$$ReadingProgressImplCopyWith(_$ReadingProgressImpl value,
          $Res Function(_$ReadingProgressImpl) then) =
      __$$ReadingProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'book_title_ar') String bookTitleAr,
      @JsonKey(name: 'book_title_en') String? bookTitleEn,
      @JsonKey(name: 'current_section_id') String? currentSectionId,
      @JsonKey(name: 'current_paragraph_id') String? currentParagraphId,
      @JsonKey(name: 'paragraphs_read') List<String> paragraphsRead,
      @JsonKey(name: 'total_paragraphs') int totalParagraphs,
      @JsonKey(name: 'progress_percentage') double progressPercentage,
      @JsonKey(name: 'last_read_date') DateTime? lastReadDate,
      @JsonKey(name: 'total_reading_time_minutes') int totalReadingTimeMinutes,
      @JsonKey(name: 'started_at') DateTime? startedAt,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'is_completed') bool isCompleted});
}

/// @nodoc
class __$$ReadingProgressImplCopyWithImpl<$Res>
    extends _$ReadingProgressCopyWithImpl<$Res, _$ReadingProgressImpl>
    implements _$$ReadingProgressImplCopyWith<$Res> {
  __$$ReadingProgressImplCopyWithImpl(
      _$ReadingProgressImpl _value, $Res Function(_$ReadingProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReadingProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookId = null,
    Object? bookTitleAr = null,
    Object? bookTitleEn = freezed,
    Object? currentSectionId = freezed,
    Object? currentParagraphId = freezed,
    Object? paragraphsRead = null,
    Object? totalParagraphs = null,
    Object? progressPercentage = null,
    Object? lastReadDate = freezed,
    Object? totalReadingTimeMinutes = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_$ReadingProgressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
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
      currentSectionId: freezed == currentSectionId
          ? _value.currentSectionId
          : currentSectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentParagraphId: freezed == currentParagraphId
          ? _value.currentParagraphId
          : currentParagraphId // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphsRead: null == paragraphsRead
          ? _value._paragraphsRead
          : paragraphsRead // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalParagraphs: null == totalParagraphs
          ? _value.totalParagraphs
          : totalParagraphs // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      lastReadDate: freezed == lastReadDate
          ? _value.lastReadDate
          : lastReadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalReadingTimeMinutes: null == totalReadingTimeMinutes
          ? _value.totalReadingTimeMinutes
          : totalReadingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadingProgressImpl implements _ReadingProgress {
  const _$ReadingProgressImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'book_id') required this.bookId,
      @JsonKey(name: 'book_title_ar') required this.bookTitleAr,
      @JsonKey(name: 'book_title_en') this.bookTitleEn,
      @JsonKey(name: 'current_section_id') this.currentSectionId,
      @JsonKey(name: 'current_paragraph_id') this.currentParagraphId,
      @JsonKey(name: 'paragraphs_read')
      final List<String> paragraphsRead = const [],
      @JsonKey(name: 'total_paragraphs') this.totalParagraphs = 0,
      @JsonKey(name: 'progress_percentage') this.progressPercentage = 0.0,
      @JsonKey(name: 'last_read_date') this.lastReadDate,
      @JsonKey(name: 'total_reading_time_minutes')
      this.totalReadingTimeMinutes = 0,
      @JsonKey(name: 'started_at') this.startedAt,
      @JsonKey(name: 'completed_at') this.completedAt,
      @JsonKey(name: 'is_completed') this.isCompleted = false})
      : _paragraphsRead = paragraphsRead;

  factory _$ReadingProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadingProgressImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
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
  @JsonKey(name: 'current_section_id')
  final String? currentSectionId;
  @override
  @JsonKey(name: 'current_paragraph_id')
  final String? currentParagraphId;
  final List<String> _paragraphsRead;
  @override
  @JsonKey(name: 'paragraphs_read')
  List<String> get paragraphsRead {
    if (_paragraphsRead is EqualUnmodifiableListView) return _paragraphsRead;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphsRead);
  }

  @override
  @JsonKey(name: 'total_paragraphs')
  final int totalParagraphs;
  @override
  @JsonKey(name: 'progress_percentage')
  final double progressPercentage;
  @override
  @JsonKey(name: 'last_read_date')
  final DateTime? lastReadDate;
  @override
  @JsonKey(name: 'total_reading_time_minutes')
  final int totalReadingTimeMinutes;
  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  @override
  String toString() {
    return 'ReadingProgress(id: $id, userId: $userId, bookId: $bookId, bookTitleAr: $bookTitleAr, bookTitleEn: $bookTitleEn, currentSectionId: $currentSectionId, currentParagraphId: $currentParagraphId, paragraphsRead: $paragraphsRead, totalParagraphs: $totalParagraphs, progressPercentage: $progressPercentage, lastReadDate: $lastReadDate, totalReadingTimeMinutes: $totalReadingTimeMinutes, startedAt: $startedAt, completedAt: $completedAt, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.bookTitleAr, bookTitleAr) ||
                other.bookTitleAr == bookTitleAr) &&
            (identical(other.bookTitleEn, bookTitleEn) ||
                other.bookTitleEn == bookTitleEn) &&
            (identical(other.currentSectionId, currentSectionId) ||
                other.currentSectionId == currentSectionId) &&
            (identical(other.currentParagraphId, currentParagraphId) ||
                other.currentParagraphId == currentParagraphId) &&
            const DeepCollectionEquality()
                .equals(other._paragraphsRead, _paragraphsRead) &&
            (identical(other.totalParagraphs, totalParagraphs) ||
                other.totalParagraphs == totalParagraphs) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.lastReadDate, lastReadDate) ||
                other.lastReadDate == lastReadDate) &&
            (identical(
                    other.totalReadingTimeMinutes, totalReadingTimeMinutes) ||
                other.totalReadingTimeMinutes == totalReadingTimeMinutes) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      bookId,
      bookTitleAr,
      bookTitleEn,
      currentSectionId,
      currentParagraphId,
      const DeepCollectionEquality().hash(_paragraphsRead),
      totalParagraphs,
      progressPercentage,
      lastReadDate,
      totalReadingTimeMinutes,
      startedAt,
      completedAt,
      isCompleted);

  /// Create a copy of ReadingProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingProgressImplCopyWith<_$ReadingProgressImpl> get copyWith =>
      __$$ReadingProgressImplCopyWithImpl<_$ReadingProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadingProgressImplToJson(
      this,
    );
  }
}

abstract class _ReadingProgress implements ReadingProgress {
  const factory _ReadingProgress(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'book_id') required final String bookId,
      @JsonKey(name: 'book_title_ar') required final String bookTitleAr,
      @JsonKey(name: 'book_title_en') final String? bookTitleEn,
      @JsonKey(name: 'current_section_id') final String? currentSectionId,
      @JsonKey(name: 'current_paragraph_id') final String? currentParagraphId,
      @JsonKey(name: 'paragraphs_read') final List<String> paragraphsRead,
      @JsonKey(name: 'total_paragraphs') final int totalParagraphs,
      @JsonKey(name: 'progress_percentage') final double progressPercentage,
      @JsonKey(name: 'last_read_date') final DateTime? lastReadDate,
      @JsonKey(name: 'total_reading_time_minutes')
      final int totalReadingTimeMinutes,
      @JsonKey(name: 'started_at') final DateTime? startedAt,
      @JsonKey(name: 'completed_at') final DateTime? completedAt,
      @JsonKey(name: 'is_completed')
      final bool isCompleted}) = _$ReadingProgressImpl;

  factory _ReadingProgress.fromJson(Map<String, dynamic> json) =
      _$ReadingProgressImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
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
  @JsonKey(name: 'current_section_id')
  String? get currentSectionId;
  @override
  @JsonKey(name: 'current_paragraph_id')
  String? get currentParagraphId;
  @override
  @JsonKey(name: 'paragraphs_read')
  List<String> get paragraphsRead;
  @override
  @JsonKey(name: 'total_paragraphs')
  int get totalParagraphs;
  @override
  @JsonKey(name: 'progress_percentage')
  double get progressPercentage;
  @override
  @JsonKey(name: 'last_read_date')
  DateTime? get lastReadDate;
  @override
  @JsonKey(name: 'total_reading_time_minutes')
  int get totalReadingTimeMinutes;
  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'is_completed')
  bool get isCompleted;

  /// Create a copy of ReadingProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadingProgressImplCopyWith<_$ReadingProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
