// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) {
  return _Bookmark.fromJson(json);
}

/// @nodoc
mixin _$Bookmark {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_title_ar')
  String get bookTitleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_title_en')
  String? get bookTitleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_id')
  String get sectionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_title_ar')
  String get sectionTitleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_title_en')
  String? get sectionTitleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_id')
  String get paragraphId => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_number')
  int get paragraphNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_number')
  int get pageNumber => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this Bookmark to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkCopyWith<Bookmark> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkCopyWith<$Res> {
  factory $BookmarkCopyWith(Bookmark value, $Res Function(Bookmark) then) =
      _$BookmarkCopyWithImpl<$Res, Bookmark>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'book_title_ar') String bookTitleAr,
      @JsonKey(name: 'book_title_en') String? bookTitleEn,
      @JsonKey(name: 'section_id') String sectionId,
      @JsonKey(name: 'section_title_ar') String sectionTitleAr,
      @JsonKey(name: 'section_title_en') String? sectionTitleEn,
      @JsonKey(name: 'paragraph_id') String paragraphId,
      @JsonKey(name: 'paragraph_number') int paragraphNumber,
      @JsonKey(name: 'page_number') int pageNumber,
      String? note,
      List<String> tags,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'is_favorite') bool isFavorite});
}

/// @nodoc
class _$BookmarkCopyWithImpl<$Res, $Val extends Bookmark>
    implements $BookmarkCopyWith<$Res> {
  _$BookmarkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookId = null,
    Object? bookTitleAr = null,
    Object? bookTitleEn = freezed,
    Object? sectionId = null,
    Object? sectionTitleAr = null,
    Object? sectionTitleEn = freezed,
    Object? paragraphId = null,
    Object? paragraphNumber = null,
    Object? pageNumber = null,
    Object? note = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isFavorite = null,
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
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphNumber: null == paragraphNumber
          ? _value.paragraphNumber
          : paragraphNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkImplCopyWith<$Res>
    implements $BookmarkCopyWith<$Res> {
  factory _$$BookmarkImplCopyWith(
          _$BookmarkImpl value, $Res Function(_$BookmarkImpl) then) =
      __$$BookmarkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'book_title_ar') String bookTitleAr,
      @JsonKey(name: 'book_title_en') String? bookTitleEn,
      @JsonKey(name: 'section_id') String sectionId,
      @JsonKey(name: 'section_title_ar') String sectionTitleAr,
      @JsonKey(name: 'section_title_en') String? sectionTitleEn,
      @JsonKey(name: 'paragraph_id') String paragraphId,
      @JsonKey(name: 'paragraph_number') int paragraphNumber,
      @JsonKey(name: 'page_number') int pageNumber,
      String? note,
      List<String> tags,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'is_favorite') bool isFavorite});
}

/// @nodoc
class __$$BookmarkImplCopyWithImpl<$Res>
    extends _$BookmarkCopyWithImpl<$Res, _$BookmarkImpl>
    implements _$$BookmarkImplCopyWith<$Res> {
  __$$BookmarkImplCopyWithImpl(
      _$BookmarkImpl _value, $Res Function(_$BookmarkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookId = null,
    Object? bookTitleAr = null,
    Object? bookTitleEn = freezed,
    Object? sectionId = null,
    Object? sectionTitleAr = null,
    Object? sectionTitleEn = freezed,
    Object? paragraphId = null,
    Object? paragraphNumber = null,
    Object? pageNumber = null,
    Object? note = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_$BookmarkImpl(
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
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphNumber: null == paragraphNumber
          ? _value.paragraphNumber
          : paragraphNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkImpl implements _Bookmark {
  const _$BookmarkImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'book_id') required this.bookId,
      @JsonKey(name: 'book_title_ar') required this.bookTitleAr,
      @JsonKey(name: 'book_title_en') this.bookTitleEn,
      @JsonKey(name: 'section_id') required this.sectionId,
      @JsonKey(name: 'section_title_ar') required this.sectionTitleAr,
      @JsonKey(name: 'section_title_en') this.sectionTitleEn,
      @JsonKey(name: 'paragraph_id') required this.paragraphId,
      @JsonKey(name: 'paragraph_number') required this.paragraphNumber,
      @JsonKey(name: 'page_number') required this.pageNumber,
      this.note,
      final List<String> tags = const [],
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'is_favorite') this.isFavorite = false})
      : _tags = tags;

  factory _$BookmarkImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkImplFromJson(json);

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
  @JsonKey(name: 'section_id')
  final String sectionId;
  @override
  @JsonKey(name: 'section_title_ar')
  final String sectionTitleAr;
  @override
  @JsonKey(name: 'section_title_en')
  final String? sectionTitleEn;
  @override
  @JsonKey(name: 'paragraph_id')
  final String paragraphId;
  @override
  @JsonKey(name: 'paragraph_number')
  final int paragraphNumber;
  @override
  @JsonKey(name: 'page_number')
  final int pageNumber;
  @override
  final String? note;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  @override
  String toString() {
    return 'Bookmark(id: $id, userId: $userId, bookId: $bookId, bookTitleAr: $bookTitleAr, bookTitleEn: $bookTitleEn, sectionId: $sectionId, sectionTitleAr: $sectionTitleAr, sectionTitleEn: $sectionTitleEn, paragraphId: $paragraphId, paragraphNumber: $paragraphNumber, pageNumber: $pageNumber, note: $note, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.bookTitleAr, bookTitleAr) ||
                other.bookTitleAr == bookTitleAr) &&
            (identical(other.bookTitleEn, bookTitleEn) ||
                other.bookTitleEn == bookTitleEn) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.sectionTitleAr, sectionTitleAr) ||
                other.sectionTitleAr == sectionTitleAr) &&
            (identical(other.sectionTitleEn, sectionTitleEn) ||
                other.sectionTitleEn == sectionTitleEn) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.paragraphNumber, paragraphNumber) ||
                other.paragraphNumber == paragraphNumber) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.note, note) || other.note == note) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
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
      sectionId,
      sectionTitleAr,
      sectionTitleEn,
      paragraphId,
      paragraphNumber,
      pageNumber,
      note,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt,
      isFavorite);

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      __$$BookmarkImplCopyWithImpl<_$BookmarkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkImplToJson(
      this,
    );
  }
}

abstract class _Bookmark implements Bookmark {
  const factory _Bookmark(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'book_id') required final String bookId,
      @JsonKey(name: 'book_title_ar') required final String bookTitleAr,
      @JsonKey(name: 'book_title_en') final String? bookTitleEn,
      @JsonKey(name: 'section_id') required final String sectionId,
      @JsonKey(name: 'section_title_ar') required final String sectionTitleAr,
      @JsonKey(name: 'section_title_en') final String? sectionTitleEn,
      @JsonKey(name: 'paragraph_id') required final String paragraphId,
      @JsonKey(name: 'paragraph_number') required final int paragraphNumber,
      @JsonKey(name: 'page_number') required final int pageNumber,
      final String? note,
      final List<String> tags,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'is_favorite') final bool isFavorite}) = _$BookmarkImpl;

  factory _Bookmark.fromJson(Map<String, dynamic> json) =
      _$BookmarkImpl.fromJson;

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
  @JsonKey(name: 'section_id')
  String get sectionId;
  @override
  @JsonKey(name: 'section_title_ar')
  String get sectionTitleAr;
  @override
  @JsonKey(name: 'section_title_en')
  String? get sectionTitleEn;
  @override
  @JsonKey(name: 'paragraph_id')
  String get paragraphId;
  @override
  @JsonKey(name: 'paragraph_number')
  int get paragraphNumber;
  @override
  @JsonKey(name: 'page_number')
  int get pageNumber;
  @override
  String? get note;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Highlight _$HighlightFromJson(Map<String, dynamic> json) {
  return _Highlight.fromJson(json);
}

/// @nodoc
mixin _$Highlight {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  String get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_id')
  String get paragraphId => throw _privateConstructorUsedError;
  @JsonKey(name: 'highlighted_text')
  String get highlightedText => throw _privateConstructorUsedError;
  @JsonKey(name: 'highlight_color')
  String get highlightColor => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Highlight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Highlight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HighlightCopyWith<Highlight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighlightCopyWith<$Res> {
  factory $HighlightCopyWith(Highlight value, $Res Function(Highlight) then) =
      _$HighlightCopyWithImpl<$Res, Highlight>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'paragraph_id') String paragraphId,
      @JsonKey(name: 'highlighted_text') String highlightedText,
      @JsonKey(name: 'highlight_color') String highlightColor,
      String? note,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$HighlightCopyWithImpl<$Res, $Val extends Highlight>
    implements $HighlightCopyWith<$Res> {
  _$HighlightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Highlight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookId = null,
    Object? paragraphId = null,
    Object? highlightedText = null,
    Object? highlightColor = null,
    Object? note = freezed,
    Object? createdAt = freezed,
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
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      highlightedText: null == highlightedText
          ? _value.highlightedText
          : highlightedText // ignore: cast_nullable_to_non_nullable
              as String,
      highlightColor: null == highlightColor
          ? _value.highlightColor
          : highlightColor // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HighlightImplCopyWith<$Res>
    implements $HighlightCopyWith<$Res> {
  factory _$$HighlightImplCopyWith(
          _$HighlightImpl value, $Res Function(_$HighlightImpl) then) =
      __$$HighlightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') String bookId,
      @JsonKey(name: 'paragraph_id') String paragraphId,
      @JsonKey(name: 'highlighted_text') String highlightedText,
      @JsonKey(name: 'highlight_color') String highlightColor,
      String? note,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$HighlightImplCopyWithImpl<$Res>
    extends _$HighlightCopyWithImpl<$Res, _$HighlightImpl>
    implements _$$HighlightImplCopyWith<$Res> {
  __$$HighlightImplCopyWithImpl(
      _$HighlightImpl _value, $Res Function(_$HighlightImpl) _then)
      : super(_value, _then);

  /// Create a copy of Highlight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookId = null,
    Object? paragraphId = null,
    Object? highlightedText = null,
    Object? highlightColor = null,
    Object? note = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$HighlightImpl(
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
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      highlightedText: null == highlightedText
          ? _value.highlightedText
          : highlightedText // ignore: cast_nullable_to_non_nullable
              as String,
      highlightColor: null == highlightColor
          ? _value.highlightColor
          : highlightColor // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HighlightImpl implements _Highlight {
  const _$HighlightImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'book_id') required this.bookId,
      @JsonKey(name: 'paragraph_id') required this.paragraphId,
      @JsonKey(name: 'highlighted_text') required this.highlightedText,
      @JsonKey(name: 'highlight_color') this.highlightColor = '#FFEB3B',
      this.note,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$HighlightImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighlightImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'book_id')
  final String bookId;
  @override
  @JsonKey(name: 'paragraph_id')
  final String paragraphId;
  @override
  @JsonKey(name: 'highlighted_text')
  final String highlightedText;
  @override
  @JsonKey(name: 'highlight_color')
  final String highlightColor;
  @override
  final String? note;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Highlight(id: $id, userId: $userId, bookId: $bookId, paragraphId: $paragraphId, highlightedText: $highlightedText, highlightColor: $highlightColor, note: $note, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighlightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.highlightedText, highlightedText) ||
                other.highlightedText == highlightedText) &&
            (identical(other.highlightColor, highlightColor) ||
                other.highlightColor == highlightColor) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, bookId, paragraphId,
      highlightedText, highlightColor, note, createdAt);

  /// Create a copy of Highlight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HighlightImplCopyWith<_$HighlightImpl> get copyWith =>
      __$$HighlightImplCopyWithImpl<_$HighlightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HighlightImplToJson(
      this,
    );
  }
}

abstract class _Highlight implements Highlight {
  const factory _Highlight(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'book_id') required final String bookId,
      @JsonKey(name: 'paragraph_id') required final String paragraphId,
      @JsonKey(name: 'highlighted_text') required final String highlightedText,
      @JsonKey(name: 'highlight_color') final String highlightColor,
      final String? note,
      @JsonKey(name: 'created_at')
      final DateTime? createdAt}) = _$HighlightImpl;

  factory _Highlight.fromJson(Map<String, dynamic> json) =
      _$HighlightImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'book_id')
  String get bookId;
  @override
  @JsonKey(name: 'paragraph_id')
  String get paragraphId;
  @override
  @JsonKey(name: 'highlighted_text')
  String get highlightedText;
  @override
  @JsonKey(name: 'highlight_color')
  String get highlightColor;
  @override
  String? get note;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Highlight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HighlightImplCopyWith<_$HighlightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
