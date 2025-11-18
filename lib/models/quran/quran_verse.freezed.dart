// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_verse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuranVerse _$QuranVerseFromJson(Map<String, dynamic> json) {
  return _QuranVerse.fromJson(json);
}

/// @nodoc
mixin _$QuranVerse {
  int get number =>
      throw _privateConstructorUsedError; // Verse number within the surah
  int get numberInQuran =>
      throw _privateConstructorUsedError; // Verse number in the entire Quran
  @JsonKey(name: 'arabic_text')
  String get arabicText => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_translation')
  String? get englishTranslation => throw _privateConstructorUsedError;
  @JsonKey(name: 'transliteration')
  String? get transliteration => throw _privateConstructorUsedError;
  @JsonKey(name: 'tafsir')
  String? get tafsir =>
      throw _privateConstructorUsedError; // Interpretation/Commentary
  @JsonKey(name: 'juz_number')
  int? get juzNumber =>
      throw _privateConstructorUsedError; // Juz (part) number (1-30)
  @JsonKey(name: 'page_number')
  int? get pageNumber =>
      throw _privateConstructorUsedError; // Page number in Mushaf
  @JsonKey(name: 'sajda')
  bool get hasSajda => throw _privateConstructorUsedError;

  /// Serializes this QuranVerse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuranVerse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuranVerseCopyWith<QuranVerse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranVerseCopyWith<$Res> {
  factory $QuranVerseCopyWith(
          QuranVerse value, $Res Function(QuranVerse) then) =
      _$QuranVerseCopyWithImpl<$Res, QuranVerse>;
  @useResult
  $Res call(
      {int number,
      int numberInQuran,
      @JsonKey(name: 'arabic_text') String arabicText,
      @JsonKey(name: 'english_translation') String? englishTranslation,
      @JsonKey(name: 'transliteration') String? transliteration,
      @JsonKey(name: 'tafsir') String? tafsir,
      @JsonKey(name: 'juz_number') int? juzNumber,
      @JsonKey(name: 'page_number') int? pageNumber,
      @JsonKey(name: 'sajda') bool hasSajda});
}

/// @nodoc
class _$QuranVerseCopyWithImpl<$Res, $Val extends QuranVerse>
    implements $QuranVerseCopyWith<$Res> {
  _$QuranVerseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuranVerse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? numberInQuran = null,
    Object? arabicText = null,
    Object? englishTranslation = freezed,
    Object? transliteration = freezed,
    Object? tafsir = freezed,
    Object? juzNumber = freezed,
    Object? pageNumber = freezed,
    Object? hasSajda = null,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      numberInQuran: null == numberInQuran
          ? _value.numberInQuran
          : numberInQuran // ignore: cast_nullable_to_non_nullable
              as int,
      arabicText: null == arabicText
          ? _value.arabicText
          : arabicText // ignore: cast_nullable_to_non_nullable
              as String,
      englishTranslation: freezed == englishTranslation
          ? _value.englishTranslation
          : englishTranslation // ignore: cast_nullable_to_non_nullable
              as String?,
      transliteration: freezed == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String?,
      tafsir: freezed == tafsir
          ? _value.tafsir
          : tafsir // ignore: cast_nullable_to_non_nullable
              as String?,
      juzNumber: freezed == juzNumber
          ? _value.juzNumber
          : juzNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      pageNumber: freezed == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      hasSajda: null == hasSajda
          ? _value.hasSajda
          : hasSajda // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuranVerseImplCopyWith<$Res>
    implements $QuranVerseCopyWith<$Res> {
  factory _$$QuranVerseImplCopyWith(
          _$QuranVerseImpl value, $Res Function(_$QuranVerseImpl) then) =
      __$$QuranVerseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int number,
      int numberInQuran,
      @JsonKey(name: 'arabic_text') String arabicText,
      @JsonKey(name: 'english_translation') String? englishTranslation,
      @JsonKey(name: 'transliteration') String? transliteration,
      @JsonKey(name: 'tafsir') String? tafsir,
      @JsonKey(name: 'juz_number') int? juzNumber,
      @JsonKey(name: 'page_number') int? pageNumber,
      @JsonKey(name: 'sajda') bool hasSajda});
}

/// @nodoc
class __$$QuranVerseImplCopyWithImpl<$Res>
    extends _$QuranVerseCopyWithImpl<$Res, _$QuranVerseImpl>
    implements _$$QuranVerseImplCopyWith<$Res> {
  __$$QuranVerseImplCopyWithImpl(
      _$QuranVerseImpl _value, $Res Function(_$QuranVerseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuranVerse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? numberInQuran = null,
    Object? arabicText = null,
    Object? englishTranslation = freezed,
    Object? transliteration = freezed,
    Object? tafsir = freezed,
    Object? juzNumber = freezed,
    Object? pageNumber = freezed,
    Object? hasSajda = null,
  }) {
    return _then(_$QuranVerseImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      numberInQuran: null == numberInQuran
          ? _value.numberInQuran
          : numberInQuran // ignore: cast_nullable_to_non_nullable
              as int,
      arabicText: null == arabicText
          ? _value.arabicText
          : arabicText // ignore: cast_nullable_to_non_nullable
              as String,
      englishTranslation: freezed == englishTranslation
          ? _value.englishTranslation
          : englishTranslation // ignore: cast_nullable_to_non_nullable
              as String?,
      transliteration: freezed == transliteration
          ? _value.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String?,
      tafsir: freezed == tafsir
          ? _value.tafsir
          : tafsir // ignore: cast_nullable_to_non_nullable
              as String?,
      juzNumber: freezed == juzNumber
          ? _value.juzNumber
          : juzNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      pageNumber: freezed == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      hasSajda: null == hasSajda
          ? _value.hasSajda
          : hasSajda // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuranVerseImpl implements _QuranVerse {
  const _$QuranVerseImpl(
      {required this.number,
      required this.numberInQuran,
      @JsonKey(name: 'arabic_text') required this.arabicText,
      @JsonKey(name: 'english_translation') this.englishTranslation,
      @JsonKey(name: 'transliteration') this.transliteration,
      @JsonKey(name: 'tafsir') this.tafsir,
      @JsonKey(name: 'juz_number') this.juzNumber,
      @JsonKey(name: 'page_number') this.pageNumber,
      @JsonKey(name: 'sajda') this.hasSajda = false});

  factory _$QuranVerseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuranVerseImplFromJson(json);

  @override
  final int number;
// Verse number within the surah
  @override
  final int numberInQuran;
// Verse number in the entire Quran
  @override
  @JsonKey(name: 'arabic_text')
  final String arabicText;
  @override
  @JsonKey(name: 'english_translation')
  final String? englishTranslation;
  @override
  @JsonKey(name: 'transliteration')
  final String? transliteration;
  @override
  @JsonKey(name: 'tafsir')
  final String? tafsir;
// Interpretation/Commentary
  @override
  @JsonKey(name: 'juz_number')
  final int? juzNumber;
// Juz (part) number (1-30)
  @override
  @JsonKey(name: 'page_number')
  final int? pageNumber;
// Page number in Mushaf
  @override
  @JsonKey(name: 'sajda')
  final bool hasSajda;

  @override
  String toString() {
    return 'QuranVerse(number: $number, numberInQuran: $numberInQuran, arabicText: $arabicText, englishTranslation: $englishTranslation, transliteration: $transliteration, tafsir: $tafsir, juzNumber: $juzNumber, pageNumber: $pageNumber, hasSajda: $hasSajda)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuranVerseImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.numberInQuran, numberInQuran) ||
                other.numberInQuran == numberInQuran) &&
            (identical(other.arabicText, arabicText) ||
                other.arabicText == arabicText) &&
            (identical(other.englishTranslation, englishTranslation) ||
                other.englishTranslation == englishTranslation) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.tafsir, tafsir) || other.tafsir == tafsir) &&
            (identical(other.juzNumber, juzNumber) ||
                other.juzNumber == juzNumber) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.hasSajda, hasSajda) ||
                other.hasSajda == hasSajda));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      number,
      numberInQuran,
      arabicText,
      englishTranslation,
      transliteration,
      tafsir,
      juzNumber,
      pageNumber,
      hasSajda);

  /// Create a copy of QuranVerse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuranVerseImplCopyWith<_$QuranVerseImpl> get copyWith =>
      __$$QuranVerseImplCopyWithImpl<_$QuranVerseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuranVerseImplToJson(
      this,
    );
  }
}

abstract class _QuranVerse implements QuranVerse {
  const factory _QuranVerse(
      {required final int number,
      required final int numberInQuran,
      @JsonKey(name: 'arabic_text') required final String arabicText,
      @JsonKey(name: 'english_translation') final String? englishTranslation,
      @JsonKey(name: 'transliteration') final String? transliteration,
      @JsonKey(name: 'tafsir') final String? tafsir,
      @JsonKey(name: 'juz_number') final int? juzNumber,
      @JsonKey(name: 'page_number') final int? pageNumber,
      @JsonKey(name: 'sajda') final bool hasSajda}) = _$QuranVerseImpl;

  factory _QuranVerse.fromJson(Map<String, dynamic> json) =
      _$QuranVerseImpl.fromJson;

  @override
  int get number; // Verse number within the surah
  @override
  int get numberInQuran; // Verse number in the entire Quran
  @override
  @JsonKey(name: 'arabic_text')
  String get arabicText;
  @override
  @JsonKey(name: 'english_translation')
  String? get englishTranslation;
  @override
  @JsonKey(name: 'transliteration')
  String? get transliteration;
  @override
  @JsonKey(name: 'tafsir')
  String? get tafsir; // Interpretation/Commentary
  @override
  @JsonKey(name: 'juz_number')
  int? get juzNumber; // Juz (part) number (1-30)
  @override
  @JsonKey(name: 'page_number')
  int? get pageNumber; // Page number in Mushaf
  @override
  @JsonKey(name: 'sajda')
  bool get hasSajda;

  /// Create a copy of QuranVerse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuranVerseImplCopyWith<_$QuranVerseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Surah _$SurahFromJson(Map<String, dynamic> json) {
  return _Surah.fromJson(json);
}

/// @nodoc
mixin _$Surah {
  int get number => throw _privateConstructorUsedError; // Surah number (1-114)
  @JsonKey(name: 'arabic_name')
  String get arabicName => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_name')
  String get englishName => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_name_translation')
  String get englishNameTranslation => throw _privateConstructorUsedError;
  @JsonKey(name: 'number_of_verses')
  int get numberOfVerses => throw _privateConstructorUsedError;
  @JsonKey(name: 'revelation_type')
  RevelationType get revelationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'revelation_place')
  String? get revelationPlace => throw _privateConstructorUsedError;

  /// Serializes this Surah to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurahCopyWith<Surah> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurahCopyWith<$Res> {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) then) =
      _$SurahCopyWithImpl<$Res, Surah>;
  @useResult
  $Res call(
      {int number,
      @JsonKey(name: 'arabic_name') String arabicName,
      @JsonKey(name: 'english_name') String englishName,
      @JsonKey(name: 'english_name_translation') String englishNameTranslation,
      @JsonKey(name: 'number_of_verses') int numberOfVerses,
      @JsonKey(name: 'revelation_type') RevelationType revelationType,
      @JsonKey(name: 'revelation_place') String? revelationPlace});
}

/// @nodoc
class _$SurahCopyWithImpl<$Res, $Val extends Surah>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? arabicName = null,
    Object? englishName = null,
    Object? englishNameTranslation = null,
    Object? numberOfVerses = null,
    Object? revelationType = null,
    Object? revelationPlace = freezed,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      englishName: null == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String,
      englishNameTranslation: null == englishNameTranslation
          ? _value.englishNameTranslation
          : englishNameTranslation // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfVerses: null == numberOfVerses
          ? _value.numberOfVerses
          : numberOfVerses // ignore: cast_nullable_to_non_nullable
              as int,
      revelationType: null == revelationType
          ? _value.revelationType
          : revelationType // ignore: cast_nullable_to_non_nullable
              as RevelationType,
      revelationPlace: freezed == revelationPlace
          ? _value.revelationPlace
          : revelationPlace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SurahImplCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$$SurahImplCopyWith(
          _$SurahImpl value, $Res Function(_$SurahImpl) then) =
      __$$SurahImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int number,
      @JsonKey(name: 'arabic_name') String arabicName,
      @JsonKey(name: 'english_name') String englishName,
      @JsonKey(name: 'english_name_translation') String englishNameTranslation,
      @JsonKey(name: 'number_of_verses') int numberOfVerses,
      @JsonKey(name: 'revelation_type') RevelationType revelationType,
      @JsonKey(name: 'revelation_place') String? revelationPlace});
}

/// @nodoc
class __$$SurahImplCopyWithImpl<$Res>
    extends _$SurahCopyWithImpl<$Res, _$SurahImpl>
    implements _$$SurahImplCopyWith<$Res> {
  __$$SurahImplCopyWithImpl(
      _$SurahImpl _value, $Res Function(_$SurahImpl) _then)
      : super(_value, _then);

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? arabicName = null,
    Object? englishName = null,
    Object? englishNameTranslation = null,
    Object? numberOfVerses = null,
    Object? revelationType = null,
    Object? revelationPlace = freezed,
  }) {
    return _then(_$SurahImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      englishName: null == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String,
      englishNameTranslation: null == englishNameTranslation
          ? _value.englishNameTranslation
          : englishNameTranslation // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfVerses: null == numberOfVerses
          ? _value.numberOfVerses
          : numberOfVerses // ignore: cast_nullable_to_non_nullable
              as int,
      revelationType: null == revelationType
          ? _value.revelationType
          : revelationType // ignore: cast_nullable_to_non_nullable
              as RevelationType,
      revelationPlace: freezed == revelationPlace
          ? _value.revelationPlace
          : revelationPlace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SurahImpl implements _Surah {
  const _$SurahImpl(
      {required this.number,
      @JsonKey(name: 'arabic_name') required this.arabicName,
      @JsonKey(name: 'english_name') required this.englishName,
      @JsonKey(name: 'english_name_translation')
      required this.englishNameTranslation,
      @JsonKey(name: 'number_of_verses') required this.numberOfVerses,
      @JsonKey(name: 'revelation_type') required this.revelationType,
      @JsonKey(name: 'revelation_place') this.revelationPlace});

  factory _$SurahImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurahImplFromJson(json);

  @override
  final int number;
// Surah number (1-114)
  @override
  @JsonKey(name: 'arabic_name')
  final String arabicName;
  @override
  @JsonKey(name: 'english_name')
  final String englishName;
  @override
  @JsonKey(name: 'english_name_translation')
  final String englishNameTranslation;
  @override
  @JsonKey(name: 'number_of_verses')
  final int numberOfVerses;
  @override
  @JsonKey(name: 'revelation_type')
  final RevelationType revelationType;
  @override
  @JsonKey(name: 'revelation_place')
  final String? revelationPlace;

  @override
  String toString() {
    return 'Surah(number: $number, arabicName: $arabicName, englishName: $englishName, englishNameTranslation: $englishNameTranslation, numberOfVerses: $numberOfVerses, revelationType: $revelationType, revelationPlace: $revelationPlace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurahImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.arabicName, arabicName) ||
                other.arabicName == arabicName) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName) &&
            (identical(other.englishNameTranslation, englishNameTranslation) ||
                other.englishNameTranslation == englishNameTranslation) &&
            (identical(other.numberOfVerses, numberOfVerses) ||
                other.numberOfVerses == numberOfVerses) &&
            (identical(other.revelationType, revelationType) ||
                other.revelationType == revelationType) &&
            (identical(other.revelationPlace, revelationPlace) ||
                other.revelationPlace == revelationPlace));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, number, arabicName, englishName,
      englishNameTranslation, numberOfVerses, revelationType, revelationPlace);

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurahImplCopyWith<_$SurahImpl> get copyWith =>
      __$$SurahImplCopyWithImpl<_$SurahImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurahImplToJson(
      this,
    );
  }
}

abstract class _Surah implements Surah {
  const factory _Surah(
          {required final int number,
          @JsonKey(name: 'arabic_name') required final String arabicName,
          @JsonKey(name: 'english_name') required final String englishName,
          @JsonKey(name: 'english_name_translation')
          required final String englishNameTranslation,
          @JsonKey(name: 'number_of_verses') required final int numberOfVerses,
          @JsonKey(name: 'revelation_type')
          required final RevelationType revelationType,
          @JsonKey(name: 'revelation_place') final String? revelationPlace}) =
      _$SurahImpl;

  factory _Surah.fromJson(Map<String, dynamic> json) = _$SurahImpl.fromJson;

  @override
  int get number; // Surah number (1-114)
  @override
  @JsonKey(name: 'arabic_name')
  String get arabicName;
  @override
  @JsonKey(name: 'english_name')
  String get englishName;
  @override
  @JsonKey(name: 'english_name_translation')
  String get englishNameTranslation;
  @override
  @JsonKey(name: 'number_of_verses')
  int get numberOfVerses;
  @override
  @JsonKey(name: 'revelation_type')
  RevelationType get revelationType;
  @override
  @JsonKey(name: 'revelation_place')
  String? get revelationPlace;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurahImplCopyWith<_$SurahImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
