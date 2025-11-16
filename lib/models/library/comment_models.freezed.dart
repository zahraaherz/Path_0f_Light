// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookComment _$BookCommentFromJson(Map<String, dynamic> json) {
  return _BookComment.fromJson(json);
}

/// @nodoc
mixin _$BookComment {
  String get id => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  String get paragraphId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get userPhoto => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  List<String> get likedBy => throw _privateConstructorUsedError;
  int get replies => throw _privateConstructorUsedError;
  String? get parentCommentId =>
      throw _privateConstructorUsedError; // For reply threading
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;
  bool get isReported => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this BookComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookCommentCopyWith<BookComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCommentCopyWith<$Res> {
  factory $BookCommentCopyWith(
          BookComment value, $Res Function(BookComment) then) =
      _$BookCommentCopyWithImpl<$Res, BookComment>;
  @useResult
  $Res call(
      {String id,
      String bookId,
      String paragraphId,
      String userId,
      String username,
      String? userPhoto,
      String text,
      bool isPrivate,
      int likes,
      List<String> likedBy,
      int replies,
      String? parentCommentId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt,
      bool isEdited,
      bool isReported,
      bool isDeleted});
}

/// @nodoc
class _$BookCommentCopyWithImpl<$Res, $Val extends BookComment>
    implements $BookCommentCopyWith<$Res> {
  _$BookCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? paragraphId = null,
    Object? userId = null,
    Object? username = null,
    Object? userPhoto = freezed,
    Object? text = null,
    Object? isPrivate = null,
    Object? likes = null,
    Object? likedBy = null,
    Object? replies = null,
    Object? parentCommentId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isEdited = null,
    Object? isReported = null,
    Object? isDeleted = null,
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
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userPhoto: freezed == userPhoto
          ? _value.userPhoto
          : userPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      likedBy: null == likedBy
          ? _value.likedBy
          : likedBy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as int,
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isReported: null == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookCommentImplCopyWith<$Res>
    implements $BookCommentCopyWith<$Res> {
  factory _$$BookCommentImplCopyWith(
          _$BookCommentImpl value, $Res Function(_$BookCommentImpl) then) =
      __$$BookCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookId,
      String paragraphId,
      String userId,
      String username,
      String? userPhoto,
      String text,
      bool isPrivate,
      int likes,
      List<String> likedBy,
      int replies,
      String? parentCommentId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt,
      bool isEdited,
      bool isReported,
      bool isDeleted});
}

/// @nodoc
class __$$BookCommentImplCopyWithImpl<$Res>
    extends _$BookCommentCopyWithImpl<$Res, _$BookCommentImpl>
    implements _$$BookCommentImplCopyWith<$Res> {
  __$$BookCommentImplCopyWithImpl(
      _$BookCommentImpl _value, $Res Function(_$BookCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? paragraphId = null,
    Object? userId = null,
    Object? username = null,
    Object? userPhoto = freezed,
    Object? text = null,
    Object? isPrivate = null,
    Object? likes = null,
    Object? likedBy = null,
    Object? replies = null,
    Object? parentCommentId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isEdited = null,
    Object? isReported = null,
    Object? isDeleted = null,
  }) {
    return _then(_$BookCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userPhoto: freezed == userPhoto
          ? _value.userPhoto
          : userPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      likedBy: null == likedBy
          ? _value._likedBy
          : likedBy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as int,
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isReported: null == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookCommentImpl implements _BookComment {
  const _$BookCommentImpl(
      {required this.id,
      required this.bookId,
      required this.paragraphId,
      required this.userId,
      required this.username,
      this.userPhoto,
      required this.text,
      this.isPrivate = false,
      this.likes = 0,
      final List<String> likedBy = const [],
      this.replies = 0,
      this.parentCommentId,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() this.updatedAt,
      this.isEdited = false,
      this.isReported = false,
      this.isDeleted = false})
      : _likedBy = likedBy;

  factory _$BookCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookCommentImplFromJson(json);

  @override
  final String id;
  @override
  final String bookId;
  @override
  final String paragraphId;
  @override
  final String userId;
  @override
  final String username;
  @override
  final String? userPhoto;
  @override
  final String text;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  @JsonKey()
  final int likes;
  final List<String> _likedBy;
  @override
  @JsonKey()
  List<String> get likedBy {
    if (_likedBy is EqualUnmodifiableListView) return _likedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedBy);
  }

  @override
  @JsonKey()
  final int replies;
  @override
  final String? parentCommentId;
// For reply threading
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isEdited;
  @override
  @JsonKey()
  final bool isReported;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'BookComment(id: $id, bookId: $bookId, paragraphId: $paragraphId, userId: $userId, username: $username, userPhoto: $userPhoto, text: $text, isPrivate: $isPrivate, likes: $likes, likedBy: $likedBy, replies: $replies, parentCommentId: $parentCommentId, createdAt: $createdAt, updatedAt: $updatedAt, isEdited: $isEdited, isReported: $isReported, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userPhoto, userPhoto) ||
                other.userPhoto == userPhoto) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            const DeepCollectionEquality().equals(other._likedBy, _likedBy) &&
            (identical(other.replies, replies) || other.replies == replies) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isReported, isReported) ||
                other.isReported == isReported) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      bookId,
      paragraphId,
      userId,
      username,
      userPhoto,
      text,
      isPrivate,
      likes,
      const DeepCollectionEquality().hash(_likedBy),
      replies,
      parentCommentId,
      createdAt,
      updatedAt,
      isEdited,
      isReported,
      isDeleted);

  /// Create a copy of BookComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookCommentImplCopyWith<_$BookCommentImpl> get copyWith =>
      __$$BookCommentImplCopyWithImpl<_$BookCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookCommentImplToJson(
      this,
    );
  }
}

abstract class _BookComment implements BookComment {
  const factory _BookComment(
      {required final String id,
      required final String bookId,
      required final String paragraphId,
      required final String userId,
      required final String username,
      final String? userPhoto,
      required final String text,
      final bool isPrivate,
      final int likes,
      final List<String> likedBy,
      final int replies,
      final String? parentCommentId,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() final DateTime? updatedAt,
      final bool isEdited,
      final bool isReported,
      final bool isDeleted}) = _$BookCommentImpl;

  factory _BookComment.fromJson(Map<String, dynamic> json) =
      _$BookCommentImpl.fromJson;

  @override
  String get id;
  @override
  String get bookId;
  @override
  String get paragraphId;
  @override
  String get userId;
  @override
  String get username;
  @override
  String? get userPhoto;
  @override
  String get text;
  @override
  bool get isPrivate;
  @override
  int get likes;
  @override
  List<String> get likedBy;
  @override
  int get replies;
  @override
  String? get parentCommentId; // For reply threading
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  bool get isEdited;
  @override
  bool get isReported;
  @override
  bool get isDeleted;

  /// Create a copy of BookComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookCommentImplCopyWith<_$BookCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParagraphReport _$ParagraphReportFromJson(Map<String, dynamic> json) {
  return _ParagraphReport.fromJson(json);
}

/// @nodoc
mixin _$ParagraphReport {
  String get id => throw _privateConstructorUsedError;
  String get bookId => throw _privateConstructorUsedError;
  String get paragraphId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get issueType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ReportStatus get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  String? get resolvedBy => throw _privateConstructorUsedError;
  String? get resolution => throw _privateConstructorUsedError;

  /// Serializes this ParagraphReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParagraphReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParagraphReportCopyWith<ParagraphReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphReportCopyWith<$Res> {
  factory $ParagraphReportCopyWith(
          ParagraphReport value, $Res Function(ParagraphReport) then) =
      _$ParagraphReportCopyWithImpl<$Res, ParagraphReport>;
  @useResult
  $Res call(
      {String id,
      String bookId,
      String paragraphId,
      String userId,
      String issueType,
      String description,
      ReportStatus status,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? resolvedAt,
      String? resolvedBy,
      String? resolution});
}

/// @nodoc
class _$ParagraphReportCopyWithImpl<$Res, $Val extends ParagraphReport>
    implements $ParagraphReportCopyWith<$Res> {
  _$ParagraphReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParagraphReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? paragraphId = null,
    Object? userId = null,
    Object? issueType = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
    Object? resolvedBy = freezed,
    Object? resolution = freezed,
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
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      issueType: null == issueType
          ? _value.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReportStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedBy: freezed == resolvedBy
          ? _value.resolvedBy
          : resolvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParagraphReportImplCopyWith<$Res>
    implements $ParagraphReportCopyWith<$Res> {
  factory _$$ParagraphReportImplCopyWith(_$ParagraphReportImpl value,
          $Res Function(_$ParagraphReportImpl) then) =
      __$$ParagraphReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookId,
      String paragraphId,
      String userId,
      String issueType,
      String description,
      ReportStatus status,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? resolvedAt,
      String? resolvedBy,
      String? resolution});
}

/// @nodoc
class __$$ParagraphReportImplCopyWithImpl<$Res>
    extends _$ParagraphReportCopyWithImpl<$Res, _$ParagraphReportImpl>
    implements _$$ParagraphReportImplCopyWith<$Res> {
  __$$ParagraphReportImplCopyWithImpl(
      _$ParagraphReportImpl _value, $Res Function(_$ParagraphReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParagraphReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookId = null,
    Object? paragraphId = null,
    Object? userId = null,
    Object? issueType = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
    Object? resolvedBy = freezed,
    Object? resolution = freezed,
  }) {
    return _then(_$ParagraphReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      issueType: null == issueType
          ? _value.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReportStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedBy: freezed == resolvedBy
          ? _value.resolvedBy
          : resolvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphReportImpl implements _ParagraphReport {
  const _$ParagraphReportImpl(
      {required this.id,
      required this.bookId,
      required this.paragraphId,
      required this.userId,
      required this.issueType,
      required this.description,
      this.status = ReportStatus.pending,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() this.resolvedAt,
      this.resolvedBy,
      this.resolution});

  factory _$ParagraphReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphReportImplFromJson(json);

  @override
  final String id;
  @override
  final String bookId;
  @override
  final String paragraphId;
  @override
  final String userId;
  @override
  final String issueType;
  @override
  final String description;
  @override
  @JsonKey()
  final ReportStatus status;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? resolvedAt;
  @override
  final String? resolvedBy;
  @override
  final String? resolution;

  @override
  String toString() {
    return 'ParagraphReport(id: $id, bookId: $bookId, paragraphId: $paragraphId, userId: $userId, issueType: $issueType, description: $description, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt, resolvedBy: $resolvedBy, resolution: $resolution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.issueType, issueType) ||
                other.issueType == issueType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.resolvedBy, resolvedBy) ||
                other.resolvedBy == resolvedBy) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      bookId,
      paragraphId,
      userId,
      issueType,
      description,
      status,
      createdAt,
      resolvedAt,
      resolvedBy,
      resolution);

  /// Create a copy of ParagraphReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphReportImplCopyWith<_$ParagraphReportImpl> get copyWith =>
      __$$ParagraphReportImplCopyWithImpl<_$ParagraphReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphReportImplToJson(
      this,
    );
  }
}

abstract class _ParagraphReport implements ParagraphReport {
  const factory _ParagraphReport(
      {required final String id,
      required final String bookId,
      required final String paragraphId,
      required final String userId,
      required final String issueType,
      required final String description,
      final ReportStatus status,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() final DateTime? resolvedAt,
      final String? resolvedBy,
      final String? resolution}) = _$ParagraphReportImpl;

  factory _ParagraphReport.fromJson(Map<String, dynamic> json) =
      _$ParagraphReportImpl.fromJson;

  @override
  String get id;
  @override
  String get bookId;
  @override
  String get paragraphId;
  @override
  String get userId;
  @override
  String get issueType;
  @override
  String get description;
  @override
  ReportStatus get status;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get resolvedAt;
  @override
  String? get resolvedBy;
  @override
  String? get resolution;

  /// Create a copy of ParagraphReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParagraphReportImplCopyWith<_$ParagraphReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentActionResult _$CommentActionResultFromJson(Map<String, dynamic> json) {
  return _CommentActionResult.fromJson(json);
}

/// @nodoc
mixin _$CommentActionResult {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  BookComment? get comment => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this CommentActionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentActionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentActionResultCopyWith<CommentActionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentActionResultCopyWith<$Res> {
  factory $CommentActionResultCopyWith(
          CommentActionResult value, $Res Function(CommentActionResult) then) =
      _$CommentActionResultCopyWithImpl<$Res, CommentActionResult>;
  @useResult
  $Res call(
      {bool success, String message, BookComment? comment, String? error});

  $BookCommentCopyWith<$Res>? get comment;
}

/// @nodoc
class _$CommentActionResultCopyWithImpl<$Res, $Val extends CommentActionResult>
    implements $CommentActionResultCopyWith<$Res> {
  _$CommentActionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentActionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? comment = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as BookComment?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CommentActionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookCommentCopyWith<$Res>? get comment {
    if (_value.comment == null) {
      return null;
    }

    return $BookCommentCopyWith<$Res>(_value.comment!, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentActionResultImplCopyWith<$Res>
    implements $CommentActionResultCopyWith<$Res> {
  factory _$$CommentActionResultImplCopyWith(_$CommentActionResultImpl value,
          $Res Function(_$CommentActionResultImpl) then) =
      __$$CommentActionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success, String message, BookComment? comment, String? error});

  @override
  $BookCommentCopyWith<$Res>? get comment;
}

/// @nodoc
class __$$CommentActionResultImplCopyWithImpl<$Res>
    extends _$CommentActionResultCopyWithImpl<$Res, _$CommentActionResultImpl>
    implements _$$CommentActionResultImplCopyWith<$Res> {
  __$$CommentActionResultImplCopyWithImpl(_$CommentActionResultImpl _value,
      $Res Function(_$CommentActionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentActionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? comment = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CommentActionResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as BookComment?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentActionResultImpl implements _CommentActionResult {
  const _$CommentActionResultImpl(
      {required this.success, required this.message, this.comment, this.error});

  factory _$CommentActionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentActionResultImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final BookComment? comment;
  @override
  final String? error;

  @override
  String toString() {
    return 'CommentActionResult(success: $success, message: $message, comment: $comment, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentActionResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, comment, error);

  /// Create a copy of CommentActionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentActionResultImplCopyWith<_$CommentActionResultImpl> get copyWith =>
      __$$CommentActionResultImplCopyWithImpl<_$CommentActionResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentActionResultImplToJson(
      this,
    );
  }
}

abstract class _CommentActionResult implements CommentActionResult {
  const factory _CommentActionResult(
      {required final bool success,
      required final String message,
      final BookComment? comment,
      final String? error}) = _$CommentActionResultImpl;

  factory _CommentActionResult.fromJson(Map<String, dynamic> json) =
      _$CommentActionResultImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  BookComment? get comment;
  @override
  String? get error;

  /// Create a copy of CommentActionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentActionResultImplCopyWith<_$CommentActionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentsList _$CommentsListFromJson(Map<String, dynamic> json) {
  return _CommentsList.fromJson(json);
}

/// @nodoc
mixin _$CommentsList {
  List<BookComment> get comments => throw _privateConstructorUsedError;
  List<BookComment> get replies => throw _privateConstructorUsedError;
  int get totalComments => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get lastDocumentId => throw _privateConstructorUsedError;

  /// Serializes this CommentsList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentsList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentsListCopyWith<CommentsList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentsListCopyWith<$Res> {
  factory $CommentsListCopyWith(
          CommentsList value, $Res Function(CommentsList) then) =
      _$CommentsListCopyWithImpl<$Res, CommentsList>;
  @useResult
  $Res call(
      {List<BookComment> comments,
      List<BookComment> replies,
      int totalComments,
      bool hasMore,
      String? lastDocumentId});
}

/// @nodoc
class _$CommentsListCopyWithImpl<$Res, $Val extends CommentsList>
    implements $CommentsListCopyWith<$Res> {
  _$CommentsListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentsList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? replies = null,
    Object? totalComments = null,
    Object? hasMore = null,
    Object? lastDocumentId = freezed,
  }) {
    return _then(_value.copyWith(
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<BookComment>,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<BookComment>,
      totalComments: null == totalComments
          ? _value.totalComments
          : totalComments // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      lastDocumentId: freezed == lastDocumentId
          ? _value.lastDocumentId
          : lastDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentsListImplCopyWith<$Res>
    implements $CommentsListCopyWith<$Res> {
  factory _$$CommentsListImplCopyWith(
          _$CommentsListImpl value, $Res Function(_$CommentsListImpl) then) =
      __$$CommentsListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BookComment> comments,
      List<BookComment> replies,
      int totalComments,
      bool hasMore,
      String? lastDocumentId});
}

/// @nodoc
class __$$CommentsListImplCopyWithImpl<$Res>
    extends _$CommentsListCopyWithImpl<$Res, _$CommentsListImpl>
    implements _$$CommentsListImplCopyWith<$Res> {
  __$$CommentsListImplCopyWithImpl(
      _$CommentsListImpl _value, $Res Function(_$CommentsListImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentsList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? replies = null,
    Object? totalComments = null,
    Object? hasMore = null,
    Object? lastDocumentId = freezed,
  }) {
    return _then(_$CommentsListImpl(
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<BookComment>,
      replies: null == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<BookComment>,
      totalComments: null == totalComments
          ? _value.totalComments
          : totalComments // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      lastDocumentId: freezed == lastDocumentId
          ? _value.lastDocumentId
          : lastDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentsListImpl implements _CommentsList {
  const _$CommentsListImpl(
      {final List<BookComment> comments = const [],
      final List<BookComment> replies = const [],
      required this.totalComments,
      required this.hasMore,
      this.lastDocumentId})
      : _comments = comments,
        _replies = replies;

  factory _$CommentsListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentsListImplFromJson(json);

  final List<BookComment> _comments;
  @override
  @JsonKey()
  List<BookComment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  final List<BookComment> _replies;
  @override
  @JsonKey()
  List<BookComment> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  final int totalComments;
  @override
  final bool hasMore;
  @override
  final String? lastDocumentId;

  @override
  String toString() {
    return 'CommentsList(comments: $comments, replies: $replies, totalComments: $totalComments, hasMore: $hasMore, lastDocumentId: $lastDocumentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsListImpl &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.totalComments, totalComments) ||
                other.totalComments == totalComments) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.lastDocumentId, lastDocumentId) ||
                other.lastDocumentId == lastDocumentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_comments),
      const DeepCollectionEquality().hash(_replies),
      totalComments,
      hasMore,
      lastDocumentId);

  /// Create a copy of CommentsList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsListImplCopyWith<_$CommentsListImpl> get copyWith =>
      __$$CommentsListImplCopyWithImpl<_$CommentsListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentsListImplToJson(
      this,
    );
  }
}

abstract class _CommentsList implements CommentsList {
  const factory _CommentsList(
      {final List<BookComment> comments,
      final List<BookComment> replies,
      required final int totalComments,
      required final bool hasMore,
      final String? lastDocumentId}) = _$CommentsListImpl;

  factory _CommentsList.fromJson(Map<String, dynamic> json) =
      _$CommentsListImpl.fromJson;

  @override
  List<BookComment> get comments;
  @override
  List<BookComment> get replies;
  @override
  int get totalComments;
  @override
  bool get hasMore;
  @override
  String? get lastDocumentId;

  /// Create a copy of CommentsList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentsListImplCopyWith<_$CommentsListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
