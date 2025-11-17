// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_ar')
  String get titleAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_en')
  String get titleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_ar')
  String get authorAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_en')
  String get authorEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sections')
  int get totalSections => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_paragraphs')
  int get totalParagraphs => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'pdf_url')
  String? get pdfUrl => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'verified_by')
  String? get verifiedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'content_status')
  ContentStatus get contentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get topics => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl => throw _privateConstructorUsedError;

  /// Serializes this Book to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'title_ar') String titleAr,
      @JsonKey(name: 'title_en') String titleEn,
      @JsonKey(name: 'author_ar') String authorAr,
      @JsonKey(name: 'author_en') String authorEn,
      @JsonKey(name: 'total_sections') int totalSections,
      @JsonKey(name: 'total_paragraphs') int totalParagraphs,
      String language,
      @JsonKey(name: 'pdf_url') String? pdfUrl,
      String version,
      @JsonKey(name: 'verified_by') String? verifiedBy,
      @JsonKey(name: 'content_status') ContentStatus contentStatus,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      String? description,
      List<String> topics,
      @JsonKey(name: 'cover_image_url') String? coverImageUrl});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleAr = null,
    Object? titleEn = null,
    Object? authorAr = null,
    Object? authorEn = null,
    Object? totalSections = null,
    Object? totalParagraphs = null,
    Object? language = null,
    Object? pdfUrl = freezed,
    Object? version = null,
    Object? verifiedBy = freezed,
    Object? contentStatus = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? description = freezed,
    Object? topics = null,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      authorAr: null == authorAr
          ? _value.authorAr
          : authorAr // ignore: cast_nullable_to_non_nullable
              as String,
      authorEn: null == authorEn
          ? _value.authorEn
          : authorEn // ignore: cast_nullable_to_non_nullable
              as String,
      totalSections: null == totalSections
          ? _value.totalSections
          : totalSections // ignore: cast_nullable_to_non_nullable
              as int,
      totalParagraphs: null == totalParagraphs
          ? _value.totalParagraphs
          : totalParagraphs // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      verifiedBy: freezed == verifiedBy
          ? _value.verifiedBy
          : verifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      contentStatus: null == contentStatus
          ? _value.contentStatus
          : contentStatus // ignore: cast_nullable_to_non_nullable
              as ContentStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      topics: null == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookImplCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$BookImplCopyWith(
          _$BookImpl value, $Res Function(_$BookImpl) then) =
      __$$BookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'title_ar') String titleAr,
      @JsonKey(name: 'title_en') String titleEn,
      @JsonKey(name: 'author_ar') String authorAr,
      @JsonKey(name: 'author_en') String authorEn,
      @JsonKey(name: 'total_sections') int totalSections,
      @JsonKey(name: 'total_paragraphs') int totalParagraphs,
      String language,
      @JsonKey(name: 'pdf_url') String? pdfUrl,
      String version,
      @JsonKey(name: 'verified_by') String? verifiedBy,
      @JsonKey(name: 'content_status') ContentStatus contentStatus,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      String? description,
      List<String> topics,
      @JsonKey(name: 'cover_image_url') String? coverImageUrl});
}

/// @nodoc
class __$$BookImplCopyWithImpl<$Res>
    extends _$BookCopyWithImpl<$Res, _$BookImpl>
    implements _$$BookImplCopyWith<$Res> {
  __$$BookImplCopyWithImpl(_$BookImpl _value, $Res Function(_$BookImpl) _then)
      : super(_value, _then);

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleAr = null,
    Object? titleEn = null,
    Object? authorAr = null,
    Object? authorEn = null,
    Object? totalSections = null,
    Object? totalParagraphs = null,
    Object? language = null,
    Object? pdfUrl = freezed,
    Object? version = null,
    Object? verifiedBy = freezed,
    Object? contentStatus = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? description = freezed,
    Object? topics = null,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_$BookImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      authorAr: null == authorAr
          ? _value.authorAr
          : authorAr // ignore: cast_nullable_to_non_nullable
              as String,
      authorEn: null == authorEn
          ? _value.authorEn
          : authorEn // ignore: cast_nullable_to_non_nullable
              as String,
      totalSections: null == totalSections
          ? _value.totalSections
          : totalSections // ignore: cast_nullable_to_non_nullable
              as int,
      totalParagraphs: null == totalParagraphs
          ? _value.totalParagraphs
          : totalParagraphs // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      verifiedBy: freezed == verifiedBy
          ? _value.verifiedBy
          : verifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      contentStatus: null == contentStatus
          ? _value.contentStatus
          : contentStatus // ignore: cast_nullable_to_non_nullable
              as ContentStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      topics: null == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookImpl implements _Book {
  const _$BookImpl(
      {required this.id,
      @JsonKey(name: 'title_ar') required this.titleAr,
      @JsonKey(name: 'title_en') required this.titleEn,
      @JsonKey(name: 'author_ar') required this.authorAr,
      @JsonKey(name: 'author_en') required this.authorEn,
      @JsonKey(name: 'total_sections') this.totalSections = 0,
      @JsonKey(name: 'total_paragraphs') this.totalParagraphs = 0,
      this.language = 'ar',
      @JsonKey(name: 'pdf_url') this.pdfUrl,
      this.version = '1.0',
      @JsonKey(name: 'verified_by') this.verifiedBy,
      @JsonKey(name: 'content_status') this.contentStatus = ContentStatus.draft,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.description,
      final List<String> topics = const [],
      @JsonKey(name: 'cover_image_url') this.coverImageUrl})
      : _topics = topics;

  factory _$BookImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'title_ar')
  final String titleAr;
  @override
  @JsonKey(name: 'title_en')
  final String titleEn;
  @override
  @JsonKey(name: 'author_ar')
  final String authorAr;
  @override
  @JsonKey(name: 'author_en')
  final String authorEn;
  @override
  @JsonKey(name: 'total_sections')
  final int totalSections;
  @override
  @JsonKey(name: 'total_paragraphs')
  final int totalParagraphs;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey(name: 'pdf_url')
  final String? pdfUrl;
  @override
  @JsonKey()
  final String version;
  @override
  @JsonKey(name: 'verified_by')
  final String? verifiedBy;
  @override
  @JsonKey(name: 'content_status')
  final ContentStatus contentStatus;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  final String? description;
  final List<String> _topics;
  @override
  @JsonKey()
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  @override
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;

  @override
  String toString() {
    return 'Book(id: $id, titleAr: $titleAr, titleEn: $titleEn, authorAr: $authorAr, authorEn: $authorEn, totalSections: $totalSections, totalParagraphs: $totalParagraphs, language: $language, pdfUrl: $pdfUrl, version: $version, verifiedBy: $verifiedBy, contentStatus: $contentStatus, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, topics: $topics, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            (identical(other.authorAr, authorAr) ||
                other.authorAr == authorAr) &&
            (identical(other.authorEn, authorEn) ||
                other.authorEn == authorEn) &&
            (identical(other.totalSections, totalSections) ||
                other.totalSections == totalSections) &&
            (identical(other.totalParagraphs, totalParagraphs) ||
                other.totalParagraphs == totalParagraphs) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.verifiedBy, verifiedBy) ||
                other.verifiedBy == verifiedBy) &&
            (identical(other.contentStatus, contentStatus) ||
                other.contentStatus == contentStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      titleAr,
      titleEn,
      authorAr,
      authorEn,
      totalSections,
      totalParagraphs,
      language,
      pdfUrl,
      version,
      verifiedBy,
      contentStatus,
      createdAt,
      updatedAt,
      description,
      const DeepCollectionEquality().hash(_topics),
      coverImageUrl);

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookImplCopyWith<_$BookImpl> get copyWith =>
      __$$BookImplCopyWithImpl<_$BookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookImplToJson(
      this,
    );
  }
}

abstract class _Book implements Book {
  const factory _Book(
          {required final String id,
          @JsonKey(name: 'title_ar') required final String titleAr,
          @JsonKey(name: 'title_en') required final String titleEn,
          @JsonKey(name: 'author_ar') required final String authorAr,
          @JsonKey(name: 'author_en') required final String authorEn,
          @JsonKey(name: 'total_sections') final int totalSections,
          @JsonKey(name: 'total_paragraphs') final int totalParagraphs,
          final String language,
          @JsonKey(name: 'pdf_url') final String? pdfUrl,
          final String version,
          @JsonKey(name: 'verified_by') final String? verifiedBy,
          @JsonKey(name: 'content_status') final ContentStatus contentStatus,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt,
          final String? description,
          final List<String> topics,
          @JsonKey(name: 'cover_image_url') final String? coverImageUrl}) =
      _$BookImpl;

  factory _Book.fromJson(Map<String, dynamic> json) = _$BookImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'title_ar')
  String get titleAr;
  @override
  @JsonKey(name: 'title_en')
  String get titleEn;
  @override
  @JsonKey(name: 'author_ar')
  String get authorAr;
  @override
  @JsonKey(name: 'author_en')
  String get authorEn;
  @override
  @JsonKey(name: 'total_sections')
  int get totalSections;
  @override
  @JsonKey(name: 'total_paragraphs')
  int get totalParagraphs;
  @override
  String get language;
  @override
  @JsonKey(name: 'pdf_url')
  String? get pdfUrl;
  @override
  String get version;
  @override
  @JsonKey(name: 'verified_by')
  String? get verifiedBy;
  @override
  @JsonKey(name: 'content_status')
  ContentStatus get contentStatus;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  String? get description;
  @override
  List<String> get topics;
  @override
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookImplCopyWith<_$BookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
