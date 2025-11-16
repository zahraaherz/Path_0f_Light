// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dua_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Dua _$DuaFromJson(Map<String, dynamic> json) {
  return _Dua.fromJson(json);
}

/// @nodoc
mixin _$Dua {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get arabicTitle => throw _privateConstructorUsedError;
  String get arabicText => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  String get transliteration => throw _privateConstructorUsedError;
  DuaCategory get category => throw _privateConstructorUsedError;
  String? get shortExcerpt => throw _privateConstructorUsedError;
  String? get meaning => throw _privateConstructorUsedError;
  String? get tafsir => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get benefits => throw _privateConstructorUsedError;
  String? get audioUrl => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError; // in seconds
  List<String>? get tags => throw _privateConstructorUsedError;
  bool get hasTashkeel => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this Dua to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Dua
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DuaCopyWith<Dua> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DuaCopyWith<$Res> {
  factory $DuaCopyWith(Dua value, $Res Function(Dua) then) =
      _$DuaCopyWithImpl<$Res, Dua>;
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String arabicText,
      String translation,
      String transliteration,
      DuaCategory category,
      String? shortExcerpt,
      String? meaning,
      String? tafsir,
      String? source,
      String? benefits,
      String? audioUrl,
      int? duration,
      List<String>? tags,
      bool hasTashkeel,
      bool isFavorite});
}

/// @nodoc
class _$DuaCopyWithImpl<$Res, $Val extends Dua> implements $DuaCopyWith<$Res> {
  _$DuaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Dua
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? arabicText = null,
    Object? translation = null,
    Object? transliteration = null,
    Object? category = null,
    Object? shortExcerpt = freezed,
    Object? meaning = freezed,
    Object? tafsir = freezed,
    Object? source = freezed,
    Object? benefits = freezed,
    Object? audioUrl = freezed,
    Object? duration = freezed,
    Object? tags = freezed,
    Object? hasTashkeel = null,
    Object? isFavorite = null,
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
      arabicText: null == arabicText
          ? _value.arabicText
          : arabicText // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      transliteration: null == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as DuaCategory,
      shortExcerpt: freezed == shortExcerpt
          ? _value.shortExcerpt
          : shortExcerpt // ignore: cast_nullable_to_non_nullable
              as String?,
      meaning: freezed == meaning
          ? _value.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String?,
      tafsir: freezed == tafsir
          ? _value.tafsir
          : tafsir // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      benefits: freezed == benefits
          ? _value.benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUrl: freezed == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      hasTashkeel: null == hasTashkeel
          ? _value.hasTashkeel
          : hasTashkeel // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DuaImplCopyWith<$Res> implements $DuaCopyWith<$Res> {
  factory _$$DuaImplCopyWith(_$DuaImpl value, $Res Function(_$DuaImpl) then) =
      __$$DuaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String arabicText,
      String translation,
      String transliteration,
      DuaCategory category,
      String? shortExcerpt,
      String? meaning,
      String? tafsir,
      String? source,
      String? benefits,
      String? audioUrl,
      int? duration,
      List<String>? tags,
      bool hasTashkeel,
      bool isFavorite});
}

/// @nodoc
class __$$DuaImplCopyWithImpl<$Res> extends _$DuaCopyWithImpl<$Res, _$DuaImpl>
    implements _$$DuaImplCopyWith<$Res> {
  __$$DuaImplCopyWithImpl(_$DuaImpl _value, $Res Function(_$DuaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Dua
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? arabicText = null,
    Object? translation = null,
    Object? transliteration = null,
    Object? category = null,
    Object? shortExcerpt = freezed,
    Object? meaning = freezed,
    Object? tafsir = freezed,
    Object? source = freezed,
    Object? benefits = freezed,
    Object? audioUrl = freezed,
    Object? duration = freezed,
    Object? tags = freezed,
    Object? hasTashkeel = null,
    Object? isFavorite = null,
  }) {
    return _then(_$DuaImpl(
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
      arabicText: null == arabicText
          ? _value.arabicText
          : arabicText // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      transliteration: null == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as DuaCategory,
      shortExcerpt: freezed == shortExcerpt
          ? _value.shortExcerpt
          : shortExcerpt // ignore: cast_nullable_to_non_nullable
              as String?,
      meaning: freezed == meaning
          ? _value.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String?,
      tafsir: freezed == tafsir
          ? _value.tafsir
          : tafsir // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      benefits: freezed == benefits
          ? _value.benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUrl: freezed == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      hasTashkeel: null == hasTashkeel
          ? _value.hasTashkeel
          : hasTashkeel // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DuaImpl implements _Dua {
  const _$DuaImpl(
      {required this.id,
      required this.title,
      required this.arabicTitle,
      required this.arabicText,
      required this.translation,
      required this.transliteration,
      required this.category,
      this.shortExcerpt,
      this.meaning,
      this.tafsir,
      this.source,
      this.benefits,
      this.audioUrl,
      this.duration,
      final List<String>? tags,
      this.hasTashkeel = false,
      this.isFavorite = false})
      : _tags = tags;

  factory _$DuaImpl.fromJson(Map<String, dynamic> json) =>
      _$$DuaImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String arabicTitle;
  @override
  final String arabicText;
  @override
  final String translation;
  @override
  final String transliteration;
  @override
  final DuaCategory category;
  @override
  final String? shortExcerpt;
  @override
  final String? meaning;
  @override
  final String? tafsir;
  @override
  final String? source;
  @override
  final String? benefits;
  @override
  final String? audioUrl;
  @override
  final int? duration;
// in seconds
  final List<String>? _tags;
// in seconds
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool hasTashkeel;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'Dua(id: $id, title: $title, arabicTitle: $arabicTitle, arabicText: $arabicText, translation: $translation, transliteration: $transliteration, category: $category, shortExcerpt: $shortExcerpt, meaning: $meaning, tafsir: $tafsir, source: $source, benefits: $benefits, audioUrl: $audioUrl, duration: $duration, tags: $tags, hasTashkeel: $hasTashkeel, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuaImpl &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.shortExcerpt, shortExcerpt) ||
                other.shortExcerpt == shortExcerpt) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.tafsir, tafsir) || other.tafsir == tafsir) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.benefits, benefits) ||
                other.benefits == benefits) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.hasTashkeel, hasTashkeel) ||
                other.hasTashkeel == hasTashkeel) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      arabicTitle,
      arabicText,
      translation,
      transliteration,
      category,
      shortExcerpt,
      meaning,
      tafsir,
      source,
      benefits,
      audioUrl,
      duration,
      const DeepCollectionEquality().hash(_tags),
      hasTashkeel,
      isFavorite);

  /// Create a copy of Dua
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DuaImplCopyWith<_$DuaImpl> get copyWith =>
      __$$DuaImplCopyWithImpl<_$DuaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DuaImplToJson(
      this,
    );
  }
}

abstract class _Dua implements Dua {
  const factory _Dua(
      {required final String id,
      required final String title,
      required final String arabicTitle,
      required final String arabicText,
      required final String translation,
      required final String transliteration,
      required final DuaCategory category,
      final String? shortExcerpt,
      final String? meaning,
      final String? tafsir,
      final String? source,
      final String? benefits,
      final String? audioUrl,
      final int? duration,
      final List<String>? tags,
      final bool hasTashkeel,
      final bool isFavorite}) = _$DuaImpl;

  factory _Dua.fromJson(Map<String, dynamic> json) = _$DuaImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get arabicTitle;
  @override
  String get arabicText;
  @override
  String get translation;
  @override
  String get transliteration;
  @override
  DuaCategory get category;
  @override
  String? get shortExcerpt;
  @override
  String? get meaning;
  @override
  String? get tafsir;
  @override
  String? get source;
  @override
  String? get benefits;
  @override
  String? get audioUrl;
  @override
  int? get duration; // in seconds
  @override
  List<String>? get tags;
  @override
  bool get hasTashkeel;
  @override
  bool get isFavorite;

  /// Create a copy of Dua
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DuaImplCopyWith<_$DuaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AudioRecitation _$AudioRecitationFromJson(Map<String, dynamic> json) {
  return _AudioRecitation.fromJson(json);
}

/// @nodoc
mixin _$AudioRecitation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get arabicTitle => throw _privateConstructorUsedError;
  String get reciter => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isDownloaded => throw _privateConstructorUsedError;

  /// Serializes this AudioRecitation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioRecitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioRecitationCopyWith<AudioRecitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioRecitationCopyWith<$Res> {
  factory $AudioRecitationCopyWith(
          AudioRecitation value, $Res Function(AudioRecitation) then) =
      _$AudioRecitationCopyWithImpl<$Res, AudioRecitation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String reciter,
      String audioUrl,
      int durationMinutes,
      String? description,
      String? imageUrl,
      bool isDownloaded});
}

/// @nodoc
class _$AudioRecitationCopyWithImpl<$Res, $Val extends AudioRecitation>
    implements $AudioRecitationCopyWith<$Res> {
  _$AudioRecitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioRecitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? reciter = null,
    Object? audioUrl = null,
    Object? durationMinutes = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? isDownloaded = null,
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
      reciter: null == reciter
          ? _value.reciter
          : reciter // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isDownloaded: null == isDownloaded
          ? _value.isDownloaded
          : isDownloaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioRecitationImplCopyWith<$Res>
    implements $AudioRecitationCopyWith<$Res> {
  factory _$$AudioRecitationImplCopyWith(_$AudioRecitationImpl value,
          $Res Function(_$AudioRecitationImpl) then) =
      __$$AudioRecitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String reciter,
      String audioUrl,
      int durationMinutes,
      String? description,
      String? imageUrl,
      bool isDownloaded});
}

/// @nodoc
class __$$AudioRecitationImplCopyWithImpl<$Res>
    extends _$AudioRecitationCopyWithImpl<$Res, _$AudioRecitationImpl>
    implements _$$AudioRecitationImplCopyWith<$Res> {
  __$$AudioRecitationImplCopyWithImpl(
      _$AudioRecitationImpl _value, $Res Function(_$AudioRecitationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioRecitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? reciter = null,
    Object? audioUrl = null,
    Object? durationMinutes = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? isDownloaded = null,
  }) {
    return _then(_$AudioRecitationImpl(
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
      reciter: null == reciter
          ? _value.reciter
          : reciter // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isDownloaded: null == isDownloaded
          ? _value.isDownloaded
          : isDownloaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioRecitationImpl implements _AudioRecitation {
  const _$AudioRecitationImpl(
      {required this.id,
      required this.title,
      required this.arabicTitle,
      required this.reciter,
      required this.audioUrl,
      required this.durationMinutes,
      this.description,
      this.imageUrl,
      this.isDownloaded = false});

  factory _$AudioRecitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioRecitationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String arabicTitle;
  @override
  final String reciter;
  @override
  final String audioUrl;
  @override
  final int durationMinutes;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isDownloaded;

  @override
  String toString() {
    return 'AudioRecitation(id: $id, title: $title, arabicTitle: $arabicTitle, reciter: $reciter, audioUrl: $audioUrl, durationMinutes: $durationMinutes, description: $description, imageUrl: $imageUrl, isDownloaded: $isDownloaded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioRecitationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicTitle, arabicTitle) ||
                other.arabicTitle == arabicTitle) &&
            (identical(other.reciter, reciter) || other.reciter == reciter) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isDownloaded, isDownloaded) ||
                other.isDownloaded == isDownloaded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, arabicTitle, reciter,
      audioUrl, durationMinutes, description, imageUrl, isDownloaded);

  /// Create a copy of AudioRecitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioRecitationImplCopyWith<_$AudioRecitationImpl> get copyWith =>
      __$$AudioRecitationImplCopyWithImpl<_$AudioRecitationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioRecitationImplToJson(
      this,
    );
  }
}

abstract class _AudioRecitation implements AudioRecitation {
  const factory _AudioRecitation(
      {required final String id,
      required final String title,
      required final String arabicTitle,
      required final String reciter,
      required final String audioUrl,
      required final int durationMinutes,
      final String? description,
      final String? imageUrl,
      final bool isDownloaded}) = _$AudioRecitationImpl;

  factory _AudioRecitation.fromJson(Map<String, dynamic> json) =
      _$AudioRecitationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get arabicTitle;
  @override
  String get reciter;
  @override
  String get audioUrl;
  @override
  int get durationMinutes;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  bool get isDownloaded;

  /// Create a copy of AudioRecitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioRecitationImplCopyWith<_$AudioRecitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpiritualChecklistItem _$SpiritualChecklistItemFromJson(
    Map<String, dynamic> json) {
  return _SpiritualChecklistItem.fromJson(json);
}

/// @nodoc
mixin _$SpiritualChecklistItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get arabicTitle => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'dua', 'surah', 'dhikr', 'other'
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int? get targetCount => throw _privateConstructorUsedError;
  int? get currentCount => throw _privateConstructorUsedError;

  /// Serializes this SpiritualChecklistItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpiritualChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpiritualChecklistItemCopyWith<SpiritualChecklistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpiritualChecklistItemCopyWith<$Res> {
  factory $SpiritualChecklistItemCopyWith(SpiritualChecklistItem value,
          $Res Function(SpiritualChecklistItem) then) =
      _$SpiritualChecklistItemCopyWithImpl<$Res, SpiritualChecklistItem>;
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String type,
      bool isCompleted,
      DateTime? completedAt,
      int? targetCount,
      int? currentCount});
}

/// @nodoc
class _$SpiritualChecklistItemCopyWithImpl<$Res,
        $Val extends SpiritualChecklistItem>
    implements $SpiritualChecklistItemCopyWith<$Res> {
  _$SpiritualChecklistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpiritualChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? type = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? targetCount = freezed,
    Object? currentCount = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetCount: freezed == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int?,
      currentCount: freezed == currentCount
          ? _value.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpiritualChecklistItemImplCopyWith<$Res>
    implements $SpiritualChecklistItemCopyWith<$Res> {
  factory _$$SpiritualChecklistItemImplCopyWith(
          _$SpiritualChecklistItemImpl value,
          $Res Function(_$SpiritualChecklistItemImpl) then) =
      __$$SpiritualChecklistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String arabicTitle,
      String type,
      bool isCompleted,
      DateTime? completedAt,
      int? targetCount,
      int? currentCount});
}

/// @nodoc
class __$$SpiritualChecklistItemImplCopyWithImpl<$Res>
    extends _$SpiritualChecklistItemCopyWithImpl<$Res,
        _$SpiritualChecklistItemImpl>
    implements _$$SpiritualChecklistItemImplCopyWith<$Res> {
  __$$SpiritualChecklistItemImplCopyWithImpl(
      _$SpiritualChecklistItemImpl _value,
      $Res Function(_$SpiritualChecklistItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpiritualChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabicTitle = null,
    Object? type = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? targetCount = freezed,
    Object? currentCount = freezed,
  }) {
    return _then(_$SpiritualChecklistItemImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetCount: freezed == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int?,
      currentCount: freezed == currentCount
          ? _value.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpiritualChecklistItemImpl implements _SpiritualChecklistItem {
  const _$SpiritualChecklistItemImpl(
      {required this.id,
      required this.title,
      required this.arabicTitle,
      required this.type,
      this.isCompleted = false,
      this.completedAt,
      this.targetCount,
      this.currentCount});

  factory _$SpiritualChecklistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpiritualChecklistItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String arabicTitle;
  @override
  final String type;
// 'dua', 'surah', 'dhikr', 'other'
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final int? targetCount;
  @override
  final int? currentCount;

  @override
  String toString() {
    return 'SpiritualChecklistItem(id: $id, title: $title, arabicTitle: $arabicTitle, type: $type, isCompleted: $isCompleted, completedAt: $completedAt, targetCount: $targetCount, currentCount: $currentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpiritualChecklistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicTitle, arabicTitle) ||
                other.arabicTitle == arabicTitle) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.currentCount, currentCount) ||
                other.currentCount == currentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, arabicTitle, type,
      isCompleted, completedAt, targetCount, currentCount);

  /// Create a copy of SpiritualChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpiritualChecklistItemImplCopyWith<_$SpiritualChecklistItemImpl>
      get copyWith => __$$SpiritualChecklistItemImplCopyWithImpl<
          _$SpiritualChecklistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpiritualChecklistItemImplToJson(
      this,
    );
  }
}

abstract class _SpiritualChecklistItem implements SpiritualChecklistItem {
  const factory _SpiritualChecklistItem(
      {required final String id,
      required final String title,
      required final String arabicTitle,
      required final String type,
      final bool isCompleted,
      final DateTime? completedAt,
      final int? targetCount,
      final int? currentCount}) = _$SpiritualChecklistItemImpl;

  factory _SpiritualChecklistItem.fromJson(Map<String, dynamic> json) =
      _$SpiritualChecklistItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get arabicTitle;
  @override
  String get type; // 'dua', 'surah', 'dhikr', 'other'
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  int? get targetCount;
  @override
  int? get currentCount;

  /// Create a copy of SpiritualChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpiritualChecklistItemImplCopyWith<_$SpiritualChecklistItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
