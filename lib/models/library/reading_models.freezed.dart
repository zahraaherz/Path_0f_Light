// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookProgress _$BookProgressFromJson(Map<String, dynamic> json) {
  return _BookProgress.fromJson(json);
}

/// @nodoc
mixin _$BookProgress {
  String get bookId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get currentParagraphId => throw _privateConstructorUsedError;
  String? get currentSectionId => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPagesRead => throw _privateConstructorUsedError;
  double get progressPercentage => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastReadAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get energyEarned => throw _privateConstructorUsedError;
  int get readingStreak => throw _privateConstructorUsedError;
  int get totalReadingTimeMinutes => throw _privateConstructorUsedError;
  List<String> get completedSections => throw _privateConstructorUsedError;

  /// Serializes this BookProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookProgressCopyWith<BookProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookProgressCopyWith<$Res> {
  factory $BookProgressCopyWith(
          BookProgress value, $Res Function(BookProgress) then) =
      _$BookProgressCopyWithImpl<$Res, BookProgress>;
  @useResult
  $Res call(
      {String bookId,
      String userId,
      String? currentParagraphId,
      String? currentSectionId,
      int currentPage,
      int totalPagesRead,
      double progressPercentage,
      @TimestampConverter() DateTime? lastReadAt,
      @TimestampConverter() DateTime? startedAt,
      @TimestampConverter() DateTime? completedAt,
      int energyEarned,
      int readingStreak,
      int totalReadingTimeMinutes,
      List<String> completedSections});
}

/// @nodoc
class _$BookProgressCopyWithImpl<$Res, $Val extends BookProgress>
    implements $BookProgressCopyWith<$Res> {
  _$BookProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? userId = null,
    Object? currentParagraphId = freezed,
    Object? currentSectionId = freezed,
    Object? currentPage = null,
    Object? totalPagesRead = null,
    Object? progressPercentage = null,
    Object? lastReadAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? energyEarned = null,
    Object? readingStreak = null,
    Object? totalReadingTimeMinutes = null,
    Object? completedSections = null,
  }) {
    return _then(_value.copyWith(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentParagraphId: freezed == currentParagraphId
          ? _value.currentParagraphId
          : currentParagraphId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSectionId: freezed == currentSectionId
          ? _value.currentSectionId
          : currentSectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPagesRead: null == totalPagesRead
          ? _value.totalPagesRead
          : totalPagesRead // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      energyEarned: null == energyEarned
          ? _value.energyEarned
          : energyEarned // ignore: cast_nullable_to_non_nullable
              as int,
      readingStreak: null == readingStreak
          ? _value.readingStreak
          : readingStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalReadingTimeMinutes: null == totalReadingTimeMinutes
          ? _value.totalReadingTimeMinutes
          : totalReadingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      completedSections: null == completedSections
          ? _value.completedSections
          : completedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookProgressImplCopyWith<$Res>
    implements $BookProgressCopyWith<$Res> {
  factory _$$BookProgressImplCopyWith(
          _$BookProgressImpl value, $Res Function(_$BookProgressImpl) then) =
      __$$BookProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bookId,
      String userId,
      String? currentParagraphId,
      String? currentSectionId,
      int currentPage,
      int totalPagesRead,
      double progressPercentage,
      @TimestampConverter() DateTime? lastReadAt,
      @TimestampConverter() DateTime? startedAt,
      @TimestampConverter() DateTime? completedAt,
      int energyEarned,
      int readingStreak,
      int totalReadingTimeMinutes,
      List<String> completedSections});
}

/// @nodoc
class __$$BookProgressImplCopyWithImpl<$Res>
    extends _$BookProgressCopyWithImpl<$Res, _$BookProgressImpl>
    implements _$$BookProgressImplCopyWith<$Res> {
  __$$BookProgressImplCopyWithImpl(
      _$BookProgressImpl _value, $Res Function(_$BookProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? userId = null,
    Object? currentParagraphId = freezed,
    Object? currentSectionId = freezed,
    Object? currentPage = null,
    Object? totalPagesRead = null,
    Object? progressPercentage = null,
    Object? lastReadAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? energyEarned = null,
    Object? readingStreak = null,
    Object? totalReadingTimeMinutes = null,
    Object? completedSections = null,
  }) {
    return _then(_$BookProgressImpl(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentParagraphId: freezed == currentParagraphId
          ? _value.currentParagraphId
          : currentParagraphId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSectionId: freezed == currentSectionId
          ? _value.currentSectionId
          : currentSectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPagesRead: null == totalPagesRead
          ? _value.totalPagesRead
          : totalPagesRead // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      energyEarned: null == energyEarned
          ? _value.energyEarned
          : energyEarned // ignore: cast_nullable_to_non_nullable
              as int,
      readingStreak: null == readingStreak
          ? _value.readingStreak
          : readingStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalReadingTimeMinutes: null == totalReadingTimeMinutes
          ? _value.totalReadingTimeMinutes
          : totalReadingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      completedSections: null == completedSections
          ? _value._completedSections
          : completedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookProgressImpl implements _BookProgress {
  const _$BookProgressImpl(
      {required this.bookId,
      required this.userId,
      this.currentParagraphId,
      this.currentSectionId,
      this.currentPage = 0,
      this.totalPagesRead = 0,
      this.progressPercentage = 0.0,
      @TimestampConverter() this.lastReadAt,
      @TimestampConverter() this.startedAt,
      @TimestampConverter() this.completedAt,
      this.energyEarned = 0,
      this.readingStreak = 0,
      this.totalReadingTimeMinutes = 0,
      final List<String> completedSections = const []})
      : _completedSections = completedSections;

  factory _$BookProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookProgressImplFromJson(json);

  @override
  final String bookId;
  @override
  final String userId;
  @override
  final String? currentParagraphId;
  @override
  final String? currentSectionId;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPagesRead;
  @override
  @JsonKey()
  final double progressPercentage;
  @override
  @TimestampConverter()
  final DateTime? lastReadAt;
  @override
  @TimestampConverter()
  final DateTime? startedAt;
  @override
  @TimestampConverter()
  final DateTime? completedAt;
  @override
  @JsonKey()
  final int energyEarned;
  @override
  @JsonKey()
  final int readingStreak;
  @override
  @JsonKey()
  final int totalReadingTimeMinutes;
  final List<String> _completedSections;
  @override
  @JsonKey()
  List<String> get completedSections {
    if (_completedSections is EqualUnmodifiableListView)
      return _completedSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSections);
  }

  @override
  String toString() {
    return 'BookProgress(bookId: $bookId, userId: $userId, currentParagraphId: $currentParagraphId, currentSectionId: $currentSectionId, currentPage: $currentPage, totalPagesRead: $totalPagesRead, progressPercentage: $progressPercentage, lastReadAt: $lastReadAt, startedAt: $startedAt, completedAt: $completedAt, energyEarned: $energyEarned, readingStreak: $readingStreak, totalReadingTimeMinutes: $totalReadingTimeMinutes, completedSections: $completedSections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookProgressImpl &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentParagraphId, currentParagraphId) ||
                other.currentParagraphId == currentParagraphId) &&
            (identical(other.currentSectionId, currentSectionId) ||
                other.currentSectionId == currentSectionId) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPagesRead, totalPagesRead) ||
                other.totalPagesRead == totalPagesRead) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.energyEarned, energyEarned) ||
                other.energyEarned == energyEarned) &&
            (identical(other.readingStreak, readingStreak) ||
                other.readingStreak == readingStreak) &&
            (identical(
                    other.totalReadingTimeMinutes, totalReadingTimeMinutes) ||
                other.totalReadingTimeMinutes == totalReadingTimeMinutes) &&
            const DeepCollectionEquality()
                .equals(other._completedSections, _completedSections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bookId,
      userId,
      currentParagraphId,
      currentSectionId,
      currentPage,
      totalPagesRead,
      progressPercentage,
      lastReadAt,
      startedAt,
      completedAt,
      energyEarned,
      readingStreak,
      totalReadingTimeMinutes,
      const DeepCollectionEquality().hash(_completedSections));

  /// Create a copy of BookProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookProgressImplCopyWith<_$BookProgressImpl> get copyWith =>
      __$$BookProgressImplCopyWithImpl<_$BookProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookProgressImplToJson(
      this,
    );
  }
}

abstract class _BookProgress implements BookProgress {
  const factory _BookProgress(
      {required final String bookId,
      required final String userId,
      final String? currentParagraphId,
      final String? currentSectionId,
      final int currentPage,
      final int totalPagesRead,
      final double progressPercentage,
      @TimestampConverter() final DateTime? lastReadAt,
      @TimestampConverter() final DateTime? startedAt,
      @TimestampConverter() final DateTime? completedAt,
      final int energyEarned,
      final int readingStreak,
      final int totalReadingTimeMinutes,
      final List<String> completedSections}) = _$BookProgressImpl;

  factory _BookProgress.fromJson(Map<String, dynamic> json) =
      _$BookProgressImpl.fromJson;

  @override
  String get bookId;
  @override
  String get userId;
  @override
  String? get currentParagraphId;
  @override
  String? get currentSectionId;
  @override
  int get currentPage;
  @override
  int get totalPagesRead;
  @override
  double get progressPercentage;
  @override
  @TimestampConverter()
  DateTime? get lastReadAt;
  @override
  @TimestampConverter()
  DateTime? get startedAt;
  @override
  @TimestampConverter()
  DateTime? get completedAt;
  @override
  int get energyEarned;
  @override
  int get readingStreak;
  @override
  int get totalReadingTimeMinutes;
  @override
  List<String> get completedSections;

  /// Create a copy of BookProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookProgressImplCopyWith<_$BookProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserBookmark _$UserBookmarkFromJson(Map<String, dynamic> json) {
  return _UserBookmark.fromJson(json);
}

/// @nodoc
mixin _$UserBookmark {
  String get id => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get paragraphId => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  String? get sectionTitle => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserBookmark to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserBookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserBookmarkCopyWith<UserBookmark> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBookmarkCopyWith<$Res> {
  factory $UserBookmarkCopyWith(
          UserBookmark value, $Res Function(UserBookmark) then) =
      _$UserBookmarkCopyWithImpl<$Res, UserBookmark>;
  @useResult
  $Res call(
      {String id,
      String bookId,
      String userId,
      String paragraphId,
      int pageNumber,
      String? sectionTitle,
      String? note,
      String color,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$UserBookmarkCopyWithImpl<$Res, $Val extends UserBookmark>
    implements $UserBookmarkCopyWith<$Res> {
  _$UserBookmarkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserBookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? userId = null,
    Object? paragraphId = null,
    Object? pageNumber = null,
    Object? sectionTitle = freezed,
    Object? note = freezed,
    Object? color = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      sectionTitle: freezed == sectionTitle
          ? _value.sectionTitle
          : sectionTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBookmarkImplCopyWith<$Res>
    implements $UserBookmarkCopyWith<$Res> {
  factory _$$UserBookmarkImplCopyWith(
          _$UserBookmarkImpl value, $Res Function(_$UserBookmarkImpl) then) =
      __$$UserBookmarkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookId,
      String userId,
      String paragraphId,
      int pageNumber,
      String? sectionTitle,
      String? note,
      String color,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$UserBookmarkImplCopyWithImpl<$Res>
    extends _$UserBookmarkCopyWithImpl<$Res, _$UserBookmarkImpl>
    implements _$$UserBookmarkImplCopyWith<$Res> {
  __$$UserBookmarkImplCopyWithImpl(
      _$UserBookmarkImpl _value, $Res Function(_$UserBookmarkImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserBookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? userId = null,
    Object? paragraphId = null,
    Object? pageNumber = null,
    Object? sectionTitle = freezed,
    Object? note = freezed,
    Object? color = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserBookmarkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      sectionTitle: freezed == sectionTitle
          ? _value.sectionTitle
          : sectionTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserBookmarkImpl implements _UserBookmark {
  const _$UserBookmarkImpl(
      {required this.id,
      required this.bookId,
      required this.userId,
      required this.paragraphId,
      required this.pageNumber,
      this.sectionTitle,
      this.note,
      this.color = 'default',
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() this.updatedAt});

  factory _$UserBookmarkImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBookmarkImplFromJson(json);

  @override
  final String id;
  @override
  final String bookId;
  @override
  final String userId;
  @override
  final String paragraphId;
  @override
  final int pageNumber;
  @override
  final String? sectionTitle;
  @override
  final String? note;
  @override
  @JsonKey()
  final String color;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserBookmark(id: $id, bookId: $bookId, userId: $userId, paragraphId: $paragraphId, pageNumber: $pageNumber, sectionTitle: $sectionTitle, note: $note, color: $color, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBookmarkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.sectionTitle, sectionTitle) ||
                other.sectionTitle == sectionTitle) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, bookId, userId, paragraphId,
      pageNumber, sectionTitle, note, color, createdAt, updatedAt);

  /// Create a copy of UserBookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBookmarkImplCopyWith<_$UserBookmarkImpl> get copyWith =>
      __$$UserBookmarkImplCopyWithImpl<_$UserBookmarkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBookmarkImplToJson(
      this,
    );
  }
}

abstract class _UserBookmark implements UserBookmark {
  const factory _UserBookmark(
      {required final String id,
      required final String bookId,
      required final String userId,
      required final String paragraphId,
      required final int pageNumber,
      final String? sectionTitle,
      final String? note,
      final String color,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$UserBookmarkImpl;

  factory _UserBookmark.fromJson(Map<String, dynamic> json) =
      _$UserBookmarkImpl.fromJson;

  @override
  String get id;
  @override
  String get bookId;
  @override
  String get userId;
  @override
  String get paragraphId;
  @override
  int get pageNumber;
  @override
  String? get sectionTitle;
  @override
  String? get note;
  @override
  String get color;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of UserBookmark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBookmarkImplCopyWith<_$UserBookmarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReadingPreferences _$ReadingPreferencesFromJson(Map<String, dynamic> json) {
  return _ReadingPreferences.fromJson(json);
}

/// @nodoc
mixin _$ReadingPreferences {
  FontSize get fontSize => throw _privateConstructorUsedError;
  FontFamily get fontFamily => throw _privateConstructorUsedError;
  BackgroundColor get backgroundColor => throw _privateConstructorUsedError;
  double get lineSpacing => throw _privateConstructorUsedError;
  TextAlign get textAlign => throw _privateConstructorUsedError;
  bool get autoScroll => throw _privateConstructorUsedError;
  double get scrollSpeed => throw _privateConstructorUsedError;
  bool get showPageNumbers => throw _privateConstructorUsedError;
  bool get enableNightMode => throw _privateConstructorUsedError;
  double get nightModeBrightness => throw _privateConstructorUsedError;

  /// Serializes this ReadingPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReadingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadingPreferencesCopyWith<ReadingPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingPreferencesCopyWith<$Res> {
  factory $ReadingPreferencesCopyWith(
          ReadingPreferences value, $Res Function(ReadingPreferences) then) =
      _$ReadingPreferencesCopyWithImpl<$Res, ReadingPreferences>;
  @useResult
  $Res call(
      {FontSize fontSize,
      FontFamily fontFamily,
      BackgroundColor backgroundColor,
      double lineSpacing,
      TextAlign textAlign,
      bool autoScroll,
      double scrollSpeed,
      bool showPageNumbers,
      bool enableNightMode,
      double nightModeBrightness});
}

/// @nodoc
class _$ReadingPreferencesCopyWithImpl<$Res, $Val extends ReadingPreferences>
    implements $ReadingPreferencesCopyWith<$Res> {
  _$ReadingPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? backgroundColor = null,
    Object? lineSpacing = null,
    Object? textAlign = null,
    Object? autoScroll = null,
    Object? scrollSpeed = null,
    Object? showPageNumbers = null,
    Object? enableNightMode = null,
    Object? nightModeBrightness = null,
  }) {
    return _then(_value.copyWith(
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as FontSize,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as FontFamily,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as BackgroundColor,
      lineSpacing: null == lineSpacing
          ? _value.lineSpacing
          : lineSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      textAlign: null == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as TextAlign,
      autoScroll: null == autoScroll
          ? _value.autoScroll
          : autoScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      scrollSpeed: null == scrollSpeed
          ? _value.scrollSpeed
          : scrollSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      showPageNumbers: null == showPageNumbers
          ? _value.showPageNumbers
          : showPageNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      enableNightMode: null == enableNightMode
          ? _value.enableNightMode
          : enableNightMode // ignore: cast_nullable_to_non_nullable
              as bool,
      nightModeBrightness: null == nightModeBrightness
          ? _value.nightModeBrightness
          : nightModeBrightness // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingPreferencesImplCopyWith<$Res>
    implements $ReadingPreferencesCopyWith<$Res> {
  factory _$$ReadingPreferencesImplCopyWith(_$ReadingPreferencesImpl value,
          $Res Function(_$ReadingPreferencesImpl) then) =
      __$$ReadingPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FontSize fontSize,
      FontFamily fontFamily,
      BackgroundColor backgroundColor,
      double lineSpacing,
      TextAlign textAlign,
      bool autoScroll,
      double scrollSpeed,
      bool showPageNumbers,
      bool enableNightMode,
      double nightModeBrightness});
}

/// @nodoc
class __$$ReadingPreferencesImplCopyWithImpl<$Res>
    extends _$ReadingPreferencesCopyWithImpl<$Res, _$ReadingPreferencesImpl>
    implements _$$ReadingPreferencesImplCopyWith<$Res> {
  __$$ReadingPreferencesImplCopyWithImpl(_$ReadingPreferencesImpl _value,
      $Res Function(_$ReadingPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReadingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? backgroundColor = null,
    Object? lineSpacing = null,
    Object? textAlign = null,
    Object? autoScroll = null,
    Object? scrollSpeed = null,
    Object? showPageNumbers = null,
    Object? enableNightMode = null,
    Object? nightModeBrightness = null,
  }) {
    return _then(_$ReadingPreferencesImpl(
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as FontSize,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as FontFamily,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as BackgroundColor,
      lineSpacing: null == lineSpacing
          ? _value.lineSpacing
          : lineSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      textAlign: null == textAlign
          ? _value.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as TextAlign,
      autoScroll: null == autoScroll
          ? _value.autoScroll
          : autoScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      scrollSpeed: null == scrollSpeed
          ? _value.scrollSpeed
          : scrollSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      showPageNumbers: null == showPageNumbers
          ? _value.showPageNumbers
          : showPageNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      enableNightMode: null == enableNightMode
          ? _value.enableNightMode
          : enableNightMode // ignore: cast_nullable_to_non_nullable
              as bool,
      nightModeBrightness: null == nightModeBrightness
          ? _value.nightModeBrightness
          : nightModeBrightness // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadingPreferencesImpl implements _ReadingPreferences {
  const _$ReadingPreferencesImpl(
      {this.fontSize = FontSize.medium,
      this.fontFamily = FontFamily.amiri,
      this.backgroundColor = BackgroundColor.white,
      this.lineSpacing = 1.5,
      this.textAlign = TextAlign.justified,
      this.autoScroll = false,
      this.scrollSpeed = 30.0,
      this.showPageNumbers = true,
      this.enableNightMode = true,
      this.nightModeBrightness = 18.0});

  factory _$ReadingPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadingPreferencesImplFromJson(json);

  @override
  @JsonKey()
  final FontSize fontSize;
  @override
  @JsonKey()
  final FontFamily fontFamily;
  @override
  @JsonKey()
  final BackgroundColor backgroundColor;
  @override
  @JsonKey()
  final double lineSpacing;
  @override
  @JsonKey()
  final TextAlign textAlign;
  @override
  @JsonKey()
  final bool autoScroll;
  @override
  @JsonKey()
  final double scrollSpeed;
  @override
  @JsonKey()
  final bool showPageNumbers;
  @override
  @JsonKey()
  final bool enableNightMode;
  @override
  @JsonKey()
  final double nightModeBrightness;

  @override
  String toString() {
    return 'ReadingPreferences(fontSize: $fontSize, fontFamily: $fontFamily, backgroundColor: $backgroundColor, lineSpacing: $lineSpacing, textAlign: $textAlign, autoScroll: $autoScroll, scrollSpeed: $scrollSpeed, showPageNumbers: $showPageNumbers, enableNightMode: $enableNightMode, nightModeBrightness: $nightModeBrightness)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingPreferencesImpl &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.lineSpacing, lineSpacing) ||
                other.lineSpacing == lineSpacing) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.autoScroll, autoScroll) ||
                other.autoScroll == autoScroll) &&
            (identical(other.scrollSpeed, scrollSpeed) ||
                other.scrollSpeed == scrollSpeed) &&
            (identical(other.showPageNumbers, showPageNumbers) ||
                other.showPageNumbers == showPageNumbers) &&
            (identical(other.enableNightMode, enableNightMode) ||
                other.enableNightMode == enableNightMode) &&
            (identical(other.nightModeBrightness, nightModeBrightness) ||
                other.nightModeBrightness == nightModeBrightness));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fontSize,
      fontFamily,
      backgroundColor,
      lineSpacing,
      textAlign,
      autoScroll,
      scrollSpeed,
      showPageNumbers,
      enableNightMode,
      nightModeBrightness);

  /// Create a copy of ReadingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingPreferencesImplCopyWith<_$ReadingPreferencesImpl> get copyWith =>
      __$$ReadingPreferencesImplCopyWithImpl<_$ReadingPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadingPreferencesImplToJson(
      this,
    );
  }
}

abstract class _ReadingPreferences implements ReadingPreferences {
  const factory _ReadingPreferences(
      {final FontSize fontSize,
      final FontFamily fontFamily,
      final BackgroundColor backgroundColor,
      final double lineSpacing,
      final TextAlign textAlign,
      final bool autoScroll,
      final double scrollSpeed,
      final bool showPageNumbers,
      final bool enableNightMode,
      final double nightModeBrightness}) = _$ReadingPreferencesImpl;

  factory _ReadingPreferences.fromJson(Map<String, dynamic> json) =
      _$ReadingPreferencesImpl.fromJson;

  @override
  FontSize get fontSize;
  @override
  FontFamily get fontFamily;
  @override
  BackgroundColor get backgroundColor;
  @override
  double get lineSpacing;
  @override
  TextAlign get textAlign;
  @override
  bool get autoScroll;
  @override
  double get scrollSpeed;
  @override
  bool get showPageNumbers;
  @override
  bool get enableNightMode;
  @override
  double get nightModeBrightness;

  /// Create a copy of ReadingPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadingPreferencesImplCopyWith<_$ReadingPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookCollection _$BookCollectionFromJson(Map<String, dynamic> json) {
  return _BookCollection.fromJson(json);
}

/// @nodoc
mixin _$BookCollection {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get bookIds => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;

  /// Serializes this BookCollection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookCollection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookCollectionCopyWith<BookCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCollectionCopyWith<$Res> {
  factory $BookCollectionCopyWith(
          BookCollection value, $Res Function(BookCollection) then) =
      _$BookCollectionCopyWithImpl<$Res, BookCollection>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String? description,
      List<String> bookIds,
      bool isPublic,
      bool isDefault,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt,
      String? coverImageUrl});
}

/// @nodoc
class _$BookCollectionCopyWithImpl<$Res, $Val extends BookCollection>
    implements $BookCollectionCopyWith<$Res> {
  _$BookCollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookCollection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? description = freezed,
    Object? bookIds = null,
    Object? isPublic = null,
    Object? isDefault = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? coverImageUrl = freezed,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      bookIds: null == bookIds
          ? _value.bookIds
          : bookIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookCollectionImplCopyWith<$Res>
    implements $BookCollectionCopyWith<$Res> {
  factory _$$BookCollectionImplCopyWith(_$BookCollectionImpl value,
          $Res Function(_$BookCollectionImpl) then) =
      __$$BookCollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String? description,
      List<String> bookIds,
      bool isPublic,
      bool isDefault,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt,
      String? coverImageUrl});
}

/// @nodoc
class __$$BookCollectionImplCopyWithImpl<$Res>
    extends _$BookCollectionCopyWithImpl<$Res, _$BookCollectionImpl>
    implements _$$BookCollectionImplCopyWith<$Res> {
  __$$BookCollectionImplCopyWithImpl(
      _$BookCollectionImpl _value, $Res Function(_$BookCollectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookCollection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? description = freezed,
    Object? bookIds = null,
    Object? isPublic = null,
    Object? isDefault = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_$BookCollectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      bookIds: null == bookIds
          ? _value._bookIds
          : bookIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookCollectionImpl implements _BookCollection {
  const _$BookCollectionImpl(
      {required this.id,
      required this.userId,
      required this.name,
      this.description,
      final List<String> bookIds = const [],
      this.isPublic = false,
      this.isDefault = false,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() this.updatedAt,
      this.coverImageUrl})
      : _bookIds = bookIds;

  factory _$BookCollectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookCollectionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String? description;
  final List<String> _bookIds;
  @override
  @JsonKey()
  List<String> get bookIds {
    if (_bookIds is EqualUnmodifiableListView) return _bookIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookIds);
  }

  @override
  @JsonKey()
  final bool isPublic;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  final String? coverImageUrl;

  @override
  String toString() {
    return 'BookCollection(id: $id, userId: $userId, name: $name, description: $description, bookIds: $bookIds, isPublic: $isPublic, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookCollectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._bookIds, _bookIds) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      description,
      const DeepCollectionEquality().hash(_bookIds),
      isPublic,
      isDefault,
      createdAt,
      updatedAt,
      coverImageUrl);

  /// Create a copy of BookCollection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookCollectionImplCopyWith<_$BookCollectionImpl> get copyWith =>
      __$$BookCollectionImplCopyWithImpl<_$BookCollectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookCollectionImplToJson(
      this,
    );
  }
}

abstract class _BookCollection implements BookCollection {
  const factory _BookCollection(
      {required final String id,
      required final String userId,
      required final String name,
      final String? description,
      final List<String> bookIds,
      final bool isPublic,
      final bool isDefault,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() final DateTime? updatedAt,
      final String? coverImageUrl}) = _$BookCollectionImpl;

  factory _BookCollection.fromJson(Map<String, dynamic> json) =
      _$BookCollectionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String? get description;
  @override
  List<String> get bookIds;
  @override
  bool get isPublic;
  @override
  bool get isDefault;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  String? get coverImageUrl;

  /// Create a copy of BookCollection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookCollectionImplCopyWith<_$BookCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReadingStatistics _$ReadingStatisticsFromJson(Map<String, dynamic> json) {
  return _ReadingStatistics.fromJson(json);
}

/// @nodoc
mixin _$ReadingStatistics {
  String get userId => throw _privateConstructorUsedError;
  int get totalBooksRead => throw _privateConstructorUsedError;
  int get totalBooksStarted => throw _privateConstructorUsedError;
  int get totalPagesRead => throw _privateConstructorUsedError;
  int get totalReadingTimeMinutes => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  int get totalEnergyEarned => throw _privateConstructorUsedError;
  int get totalCommentsPosted => throw _privateConstructorUsedError;
  int get totalBookmarksCreated => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastReadDate => throw _privateConstructorUsedError;
  Map<String, int> get booksReadByCategory =>
      throw _privateConstructorUsedError;

  /// Serializes this ReadingStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReadingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadingStatisticsCopyWith<ReadingStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingStatisticsCopyWith<$Res> {
  factory $ReadingStatisticsCopyWith(
          ReadingStatistics value, $Res Function(ReadingStatistics) then) =
      _$ReadingStatisticsCopyWithImpl<$Res, ReadingStatistics>;
  @useResult
  $Res call(
      {String userId,
      int totalBooksRead,
      int totalBooksStarted,
      int totalPagesRead,
      int totalReadingTimeMinutes,
      int currentStreak,
      int longestStreak,
      int totalEnergyEarned,
      int totalCommentsPosted,
      int totalBookmarksCreated,
      @TimestampConverter() DateTime? lastReadDate,
      Map<String, int> booksReadByCategory});
}

/// @nodoc
class _$ReadingStatisticsCopyWithImpl<$Res, $Val extends ReadingStatistics>
    implements $ReadingStatisticsCopyWith<$Res> {
  _$ReadingStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalBooksRead = null,
    Object? totalBooksStarted = null,
    Object? totalPagesRead = null,
    Object? totalReadingTimeMinutes = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalEnergyEarned = null,
    Object? totalCommentsPosted = null,
    Object? totalBookmarksCreated = null,
    Object? lastReadDate = freezed,
    Object? booksReadByCategory = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalBooksRead: null == totalBooksRead
          ? _value.totalBooksRead
          : totalBooksRead // ignore: cast_nullable_to_non_nullable
              as int,
      totalBooksStarted: null == totalBooksStarted
          ? _value.totalBooksStarted
          : totalBooksStarted // ignore: cast_nullable_to_non_nullable
              as int,
      totalPagesRead: null == totalPagesRead
          ? _value.totalPagesRead
          : totalPagesRead // ignore: cast_nullable_to_non_nullable
              as int,
      totalReadingTimeMinutes: null == totalReadingTimeMinutes
          ? _value.totalReadingTimeMinutes
          : totalReadingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnergyEarned: null == totalEnergyEarned
          ? _value.totalEnergyEarned
          : totalEnergyEarned // ignore: cast_nullable_to_non_nullable
              as int,
      totalCommentsPosted: null == totalCommentsPosted
          ? _value.totalCommentsPosted
          : totalCommentsPosted // ignore: cast_nullable_to_non_nullable
              as int,
      totalBookmarksCreated: null == totalBookmarksCreated
          ? _value.totalBookmarksCreated
          : totalBookmarksCreated // ignore: cast_nullable_to_non_nullable
              as int,
      lastReadDate: freezed == lastReadDate
          ? _value.lastReadDate
          : lastReadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      booksReadByCategory: null == booksReadByCategory
          ? _value.booksReadByCategory
          : booksReadByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingStatisticsImplCopyWith<$Res>
    implements $ReadingStatisticsCopyWith<$Res> {
  factory _$$ReadingStatisticsImplCopyWith(_$ReadingStatisticsImpl value,
          $Res Function(_$ReadingStatisticsImpl) then) =
      __$$ReadingStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int totalBooksRead,
      int totalBooksStarted,
      int totalPagesRead,
      int totalReadingTimeMinutes,
      int currentStreak,
      int longestStreak,
      int totalEnergyEarned,
      int totalCommentsPosted,
      int totalBookmarksCreated,
      @TimestampConverter() DateTime? lastReadDate,
      Map<String, int> booksReadByCategory});
}

/// @nodoc
class __$$ReadingStatisticsImplCopyWithImpl<$Res>
    extends _$ReadingStatisticsCopyWithImpl<$Res, _$ReadingStatisticsImpl>
    implements _$$ReadingStatisticsImplCopyWith<$Res> {
  __$$ReadingStatisticsImplCopyWithImpl(_$ReadingStatisticsImpl _value,
      $Res Function(_$ReadingStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReadingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalBooksRead = null,
    Object? totalBooksStarted = null,
    Object? totalPagesRead = null,
    Object? totalReadingTimeMinutes = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalEnergyEarned = null,
    Object? totalCommentsPosted = null,
    Object? totalBookmarksCreated = null,
    Object? lastReadDate = freezed,
    Object? booksReadByCategory = null,
  }) {
    return _then(_$ReadingStatisticsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalBooksRead: null == totalBooksRead
          ? _value.totalBooksRead
          : totalBooksRead // ignore: cast_nullable_to_non_nullable
              as int,
      totalBooksStarted: null == totalBooksStarted
          ? _value.totalBooksStarted
          : totalBooksStarted // ignore: cast_nullable_to_non_nullable
              as int,
      totalPagesRead: null == totalPagesRead
          ? _value.totalPagesRead
          : totalPagesRead // ignore: cast_nullable_to_non_nullable
              as int,
      totalReadingTimeMinutes: null == totalReadingTimeMinutes
          ? _value.totalReadingTimeMinutes
          : totalReadingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnergyEarned: null == totalEnergyEarned
          ? _value.totalEnergyEarned
          : totalEnergyEarned // ignore: cast_nullable_to_non_nullable
              as int,
      totalCommentsPosted: null == totalCommentsPosted
          ? _value.totalCommentsPosted
          : totalCommentsPosted // ignore: cast_nullable_to_non_nullable
              as int,
      totalBookmarksCreated: null == totalBookmarksCreated
          ? _value.totalBookmarksCreated
          : totalBookmarksCreated // ignore: cast_nullable_to_non_nullable
              as int,
      lastReadDate: freezed == lastReadDate
          ? _value.lastReadDate
          : lastReadDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      booksReadByCategory: null == booksReadByCategory
          ? _value._booksReadByCategory
          : booksReadByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadingStatisticsImpl implements _ReadingStatistics {
  const _$ReadingStatisticsImpl(
      {required this.userId,
      this.totalBooksRead = 0,
      this.totalBooksStarted = 0,
      this.totalPagesRead = 0,
      this.totalReadingTimeMinutes = 0,
      this.currentStreak = 0,
      this.longestStreak = 0,
      this.totalEnergyEarned = 0,
      this.totalCommentsPosted = 0,
      this.totalBookmarksCreated = 0,
      @TimestampConverter() this.lastReadDate,
      final Map<String, int> booksReadByCategory = const {}})
      : _booksReadByCategory = booksReadByCategory;

  factory _$ReadingStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadingStatisticsImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final int totalBooksRead;
  @override
  @JsonKey()
  final int totalBooksStarted;
  @override
  @JsonKey()
  final int totalPagesRead;
  @override
  @JsonKey()
  final int totalReadingTimeMinutes;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  @JsonKey()
  final int totalEnergyEarned;
  @override
  @JsonKey()
  final int totalCommentsPosted;
  @override
  @JsonKey()
  final int totalBookmarksCreated;
  @override
  @TimestampConverter()
  final DateTime? lastReadDate;
  final Map<String, int> _booksReadByCategory;
  @override
  @JsonKey()
  Map<String, int> get booksReadByCategory {
    if (_booksReadByCategory is EqualUnmodifiableMapView)
      return _booksReadByCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_booksReadByCategory);
  }

  @override
  String toString() {
    return 'ReadingStatistics(userId: $userId, totalBooksRead: $totalBooksRead, totalBooksStarted: $totalBooksStarted, totalPagesRead: $totalPagesRead, totalReadingTimeMinutes: $totalReadingTimeMinutes, currentStreak: $currentStreak, longestStreak: $longestStreak, totalEnergyEarned: $totalEnergyEarned, totalCommentsPosted: $totalCommentsPosted, totalBookmarksCreated: $totalBookmarksCreated, lastReadDate: $lastReadDate, booksReadByCategory: $booksReadByCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingStatisticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalBooksRead, totalBooksRead) ||
                other.totalBooksRead == totalBooksRead) &&
            (identical(other.totalBooksStarted, totalBooksStarted) ||
                other.totalBooksStarted == totalBooksStarted) &&
            (identical(other.totalPagesRead, totalPagesRead) ||
                other.totalPagesRead == totalPagesRead) &&
            (identical(
                    other.totalReadingTimeMinutes, totalReadingTimeMinutes) ||
                other.totalReadingTimeMinutes == totalReadingTimeMinutes) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalEnergyEarned, totalEnergyEarned) ||
                other.totalEnergyEarned == totalEnergyEarned) &&
            (identical(other.totalCommentsPosted, totalCommentsPosted) ||
                other.totalCommentsPosted == totalCommentsPosted) &&
            (identical(other.totalBookmarksCreated, totalBookmarksCreated) ||
                other.totalBookmarksCreated == totalBookmarksCreated) &&
            (identical(other.lastReadDate, lastReadDate) ||
                other.lastReadDate == lastReadDate) &&
            const DeepCollectionEquality()
                .equals(other._booksReadByCategory, _booksReadByCategory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      totalBooksRead,
      totalBooksStarted,
      totalPagesRead,
      totalReadingTimeMinutes,
      currentStreak,
      longestStreak,
      totalEnergyEarned,
      totalCommentsPosted,
      totalBookmarksCreated,
      lastReadDate,
      const DeepCollectionEquality().hash(_booksReadByCategory));

  /// Create a copy of ReadingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingStatisticsImplCopyWith<_$ReadingStatisticsImpl> get copyWith =>
      __$$ReadingStatisticsImplCopyWithImpl<_$ReadingStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadingStatisticsImplToJson(
      this,
    );
  }
}

abstract class _ReadingStatistics implements ReadingStatistics {
  const factory _ReadingStatistics(
      {required final String userId,
      final int totalBooksRead,
      final int totalBooksStarted,
      final int totalPagesRead,
      final int totalReadingTimeMinutes,
      final int currentStreak,
      final int longestStreak,
      final int totalEnergyEarned,
      final int totalCommentsPosted,
      final int totalBookmarksCreated,
      @TimestampConverter() final DateTime? lastReadDate,
      final Map<String, int> booksReadByCategory}) = _$ReadingStatisticsImpl;

  factory _ReadingStatistics.fromJson(Map<String, dynamic> json) =
      _$ReadingStatisticsImpl.fromJson;

  @override
  String get userId;
  @override
  int get totalBooksRead;
  @override
  int get totalBooksStarted;
  @override
  int get totalPagesRead;
  @override
  int get totalReadingTimeMinutes;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  int get totalEnergyEarned;
  @override
  int get totalCommentsPosted;
  @override
  int get totalBookmarksCreated;
  @override
  @TimestampConverter()
  DateTime? get lastReadDate;
  @override
  Map<String, int> get booksReadByCategory;

  /// Create a copy of ReadingStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadingStatisticsImplCopyWith<_$ReadingStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
