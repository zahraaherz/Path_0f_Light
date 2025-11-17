// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionItem _$CollectionItemFromJson(Map<String, dynamic> json) {
  return _CollectionItem.fromJson(json);
}

/// @nodoc
mixin _$CollectionItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  CollectionItemType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'arabic_title')
  String? get arabicTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'arabic_text')
  String get arabicText => throw _privateConstructorUsedError;
  String? get translation => throw _privateConstructorUsedError;
  String? get transliteration => throw _privateConstructorUsedError;
  CollectionCategory get category =>
      throw _privateConstructorUsedError; // Optional fields for different content types
  @JsonKey(name: 'surah_number')
  int? get surahNumber => throw _privateConstructorUsedError; // For surahs
  @JsonKey(name: 'ayah_number')
  int? get ayahNumber => throw _privateConstructorUsedError; // For ayahs
  @JsonKey(name: 'juz_number')
  int? get juzNumber =>
      throw _privateConstructorUsedError; // For Quran passages
  @JsonKey(name: 'book_reference')
  String? get bookReference =>
      throw _privateConstructorUsedError; // For hadith/passages
  @JsonKey(name: 'page_number')
  int? get pageNumber => throw _privateConstructorUsedError; // Metadata
  String? get source => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError; // Audio
  @JsonKey(name: 'audio_url')
  String? get audioUrl =>
      throw _privateConstructorUsedError; // Favorites and organization
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError; // Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_accessed')
  DateTime? get lastAccessed => throw _privateConstructorUsedError;

  /// Serializes this CollectionItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionItemCopyWith<CollectionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionItemCopyWith<$Res> {
  factory $CollectionItemCopyWith(
          CollectionItem value, $Res Function(CollectionItem) then) =
      _$CollectionItemCopyWithImpl<$Res, CollectionItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      CollectionItemType type,
      String title,
      @JsonKey(name: 'arabic_title') String? arabicTitle,
      @JsonKey(name: 'arabic_text') String arabicText,
      String? translation,
      String? transliteration,
      CollectionCategory category,
      @JsonKey(name: 'surah_number') int? surahNumber,
      @JsonKey(name: 'ayah_number') int? ayahNumber,
      @JsonKey(name: 'juz_number') int? juzNumber,
      @JsonKey(name: 'book_reference') String? bookReference,
      @JsonKey(name: 'page_number') int? pageNumber,
      String? source,
      String? notes,
      List<String> tags,
      @JsonKey(name: 'audio_url') String? audioUrl,
      @JsonKey(name: 'is_favorite') bool isFavorite,
      @JsonKey(name: 'sort_order') int sortOrder,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'last_accessed') DateTime? lastAccessed});
}

/// @nodoc
class _$CollectionItemCopyWithImpl<$Res, $Val extends CollectionItem>
    implements $CollectionItemCopyWith<$Res> {
  _$CollectionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? arabicTitle = freezed,
    Object? arabicText = null,
    Object? translation = freezed,
    Object? transliteration = freezed,
    Object? category = null,
    Object? surahNumber = freezed,
    Object? ayahNumber = freezed,
    Object? juzNumber = freezed,
    Object? bookReference = freezed,
    Object? pageNumber = freezed,
    Object? source = freezed,
    Object? notes = freezed,
    Object? tags = null,
    Object? audioUrl = freezed,
    Object? isFavorite = null,
    Object? sortOrder = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastAccessed = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CollectionItemType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: freezed == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicText: null == arabicText
          ? _value.arabicText
          : arabicText // ignore: cast_nullable_to_non_nullable
              as String,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
      transliteration: freezed == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CollectionCategory,
      surahNumber: freezed == surahNumber
          ? _value.surahNumber
          : surahNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      ayahNumber: freezed == ayahNumber
          ? _value.ayahNumber
          : ayahNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      juzNumber: freezed == juzNumber
          ? _value.juzNumber
          : juzNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      bookReference: freezed == bookReference
          ? _value.bookReference
          : bookReference // ignore: cast_nullable_to_non_nullable
              as String?,
      pageNumber: freezed == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      audioUrl: freezed == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAccessed: freezed == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionItemImplCopyWith<$Res>
    implements $CollectionItemCopyWith<$Res> {
  factory _$$CollectionItemImplCopyWith(_$CollectionItemImpl value,
          $Res Function(_$CollectionItemImpl) then) =
      __$$CollectionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      CollectionItemType type,
      String title,
      @JsonKey(name: 'arabic_title') String? arabicTitle,
      @JsonKey(name: 'arabic_text') String arabicText,
      String? translation,
      String? transliteration,
      CollectionCategory category,
      @JsonKey(name: 'surah_number') int? surahNumber,
      @JsonKey(name: 'ayah_number') int? ayahNumber,
      @JsonKey(name: 'juz_number') int? juzNumber,
      @JsonKey(name: 'book_reference') String? bookReference,
      @JsonKey(name: 'page_number') int? pageNumber,
      String? source,
      String? notes,
      List<String> tags,
      @JsonKey(name: 'audio_url') String? audioUrl,
      @JsonKey(name: 'is_favorite') bool isFavorite,
      @JsonKey(name: 'sort_order') int sortOrder,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'last_accessed') DateTime? lastAccessed});
}

/// @nodoc
class __$$CollectionItemImplCopyWithImpl<$Res>
    extends _$CollectionItemCopyWithImpl<$Res, _$CollectionItemImpl>
    implements _$$CollectionItemImplCopyWith<$Res> {
  __$$CollectionItemImplCopyWithImpl(
      _$CollectionItemImpl _value, $Res Function(_$CollectionItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? arabicTitle = freezed,
    Object? arabicText = null,
    Object? translation = freezed,
    Object? transliteration = freezed,
    Object? category = null,
    Object? surahNumber = freezed,
    Object? ayahNumber = freezed,
    Object? juzNumber = freezed,
    Object? bookReference = freezed,
    Object? pageNumber = freezed,
    Object? source = freezed,
    Object? notes = freezed,
    Object? tags = null,
    Object? audioUrl = freezed,
    Object? isFavorite = null,
    Object? sortOrder = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastAccessed = freezed,
  }) {
    return _then(_$CollectionItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CollectionItemType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: freezed == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicText: null == arabicText
          ? _value.arabicText
          : arabicText // ignore: cast_nullable_to_non_nullable
              as String,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
      transliteration: freezed == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CollectionCategory,
      surahNumber: freezed == surahNumber
          ? _value.surahNumber
          : surahNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      ayahNumber: freezed == ayahNumber
          ? _value.ayahNumber
          : ayahNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      juzNumber: freezed == juzNumber
          ? _value.juzNumber
          : juzNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      bookReference: freezed == bookReference
          ? _value.bookReference
          : bookReference // ignore: cast_nullable_to_non_nullable
              as String?,
      pageNumber: freezed == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      audioUrl: freezed == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAccessed: freezed == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionItemImpl implements _CollectionItem {
  const _$CollectionItemImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.type,
      required this.title,
      @JsonKey(name: 'arabic_title') this.arabicTitle,
      @JsonKey(name: 'arabic_text') required this.arabicText,
      this.translation,
      this.transliteration,
      required this.category,
      @JsonKey(name: 'surah_number') this.surahNumber,
      @JsonKey(name: 'ayah_number') this.ayahNumber,
      @JsonKey(name: 'juz_number') this.juzNumber,
      @JsonKey(name: 'book_reference') this.bookReference,
      @JsonKey(name: 'page_number') this.pageNumber,
      this.source,
      this.notes,
      final List<String> tags = const [],
      @JsonKey(name: 'audio_url') this.audioUrl,
      @JsonKey(name: 'is_favorite') this.isFavorite = false,
      @JsonKey(name: 'sort_order') this.sortOrder = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'last_accessed') this.lastAccessed})
      : _tags = tags;

  factory _$CollectionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final CollectionItemType type;
  @override
  final String title;
  @override
  @JsonKey(name: 'arabic_title')
  final String? arabicTitle;
  @override
  @JsonKey(name: 'arabic_text')
  final String arabicText;
  @override
  final String? translation;
  @override
  final String? transliteration;
  @override
  final CollectionCategory category;
// Optional fields for different content types
  @override
  @JsonKey(name: 'surah_number')
  final int? surahNumber;
// For surahs
  @override
  @JsonKey(name: 'ayah_number')
  final int? ayahNumber;
// For ayahs
  @override
  @JsonKey(name: 'juz_number')
  final int? juzNumber;
// For Quran passages
  @override
  @JsonKey(name: 'book_reference')
  final String? bookReference;
// For hadith/passages
  @override
  @JsonKey(name: 'page_number')
  final int? pageNumber;
// Metadata
  @override
  final String? source;
  @override
  final String? notes;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

// Audio
  @override
  @JsonKey(name: 'audio_url')
  final String? audioUrl;
// Favorites and organization
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'last_accessed')
  final DateTime? lastAccessed;

  @override
  String toString() {
    return 'CollectionItem(id: $id, userId: $userId, type: $type, title: $title, arabicTitle: $arabicTitle, arabicText: $arabicText, translation: $translation, transliteration: $transliteration, category: $category, surahNumber: $surahNumber, ayahNumber: $ayahNumber, juzNumber: $juzNumber, bookReference: $bookReference, pageNumber: $pageNumber, source: $source, notes: $notes, tags: $tags, audioUrl: $audioUrl, isFavorite: $isFavorite, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt, lastAccessed: $lastAccessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicTitle, arabicTitle) ||
                other.arabicTitle == arabicTitle) &&
            (identical(other.arabicText, arabicText) ||
                other.arabicText == arabicText) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.surahNumber, surahNumber) ||
                other.surahNumber == surahNumber) &&
            (identical(other.ayahNumber, ayahNumber) ||
                other.ayahNumber == ayahNumber) &&
            (identical(other.juzNumber, juzNumber) ||
                other.juzNumber == juzNumber) &&
            (identical(other.bookReference, bookReference) ||
                other.bookReference == bookReference) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastAccessed, lastAccessed) ||
                other.lastAccessed == lastAccessed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        type,
        title,
        arabicTitle,
        arabicText,
        translation,
        transliteration,
        category,
        surahNumber,
        ayahNumber,
        juzNumber,
        bookReference,
        pageNumber,
        source,
        notes,
        const DeepCollectionEquality().hash(_tags),
        audioUrl,
        isFavorite,
        sortOrder,
        createdAt,
        updatedAt,
        lastAccessed
      ]);

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionItemImplCopyWith<_$CollectionItemImpl> get copyWith =>
      __$$CollectionItemImplCopyWithImpl<_$CollectionItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionItemImplToJson(
      this,
    );
  }
}

abstract class _CollectionItem implements CollectionItem {
  const factory _CollectionItem(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          required final CollectionItemType type,
          required final String title,
          @JsonKey(name: 'arabic_title') final String? arabicTitle,
          @JsonKey(name: 'arabic_text') required final String arabicText,
          final String? translation,
          final String? transliteration,
          required final CollectionCategory category,
          @JsonKey(name: 'surah_number') final int? surahNumber,
          @JsonKey(name: 'ayah_number') final int? ayahNumber,
          @JsonKey(name: 'juz_number') final int? juzNumber,
          @JsonKey(name: 'book_reference') final String? bookReference,
          @JsonKey(name: 'page_number') final int? pageNumber,
          final String? source,
          final String? notes,
          final List<String> tags,
          @JsonKey(name: 'audio_url') final String? audioUrl,
          @JsonKey(name: 'is_favorite') final bool isFavorite,
          @JsonKey(name: 'sort_order') final int sortOrder,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt,
          @JsonKey(name: 'last_accessed') final DateTime? lastAccessed}) =
      _$CollectionItemImpl;

  factory _CollectionItem.fromJson(Map<String, dynamic> json) =
      _$CollectionItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  CollectionItemType get type;
  @override
  String get title;
  @override
  @JsonKey(name: 'arabic_title')
  String? get arabicTitle;
  @override
  @JsonKey(name: 'arabic_text')
  String get arabicText;
  @override
  String? get translation;
  @override
  String? get transliteration;
  @override
  CollectionCategory
      get category; // Optional fields for different content types
  @override
  @JsonKey(name: 'surah_number')
  int? get surahNumber; // For surahs
  @override
  @JsonKey(name: 'ayah_number')
  int? get ayahNumber; // For ayahs
  @override
  @JsonKey(name: 'juz_number')
  int? get juzNumber; // For Quran passages
  @override
  @JsonKey(name: 'book_reference')
  String? get bookReference; // For hadith/passages
  @override
  @JsonKey(name: 'page_number')
  int? get pageNumber; // Metadata
  @override
  String? get source;
  @override
  String? get notes;
  @override
  List<String> get tags; // Audio
  @override
  @JsonKey(name: 'audio_url')
  String? get audioUrl; // Favorites and organization
  @override
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder; // Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'last_accessed')
  DateTime? get lastAccessed;

  /// Create a copy of CollectionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionItemImplCopyWith<_$CollectionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
