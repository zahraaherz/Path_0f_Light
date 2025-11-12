// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  bool get enabled => throw _privateConstructorUsedError;
  bool get prayerTimes => throw _privateConstructorUsedError;
  bool get quizReminders => throw _privateConstructorUsedError;
  bool get achievementUnlocked => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {bool enabled,
      bool prayerTimes,
      bool quizReminders,
      bool achievementUnlocked});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? prayerTimes = null,
    Object? quizReminders = null,
    Object? achievementUnlocked = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      prayerTimes: null == prayerTimes
          ? _value.prayerTimes
          : prayerTimes // ignore: cast_nullable_to_non_nullable
              as bool,
      quizReminders: null == quizReminders
          ? _value.quizReminders
          : quizReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      achievementUnlocked: null == achievementUnlocked
          ? _value.achievementUnlocked
          : achievementUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      bool prayerTimes,
      bool quizReminders,
      bool achievementUnlocked});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? prayerTimes = null,
    Object? quizReminders = null,
    Object? achievementUnlocked = null,
  }) {
    return _then(_$NotificationSettingsImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      prayerTimes: null == prayerTimes
          ? _value.prayerTimes
          : prayerTimes // ignore: cast_nullable_to_non_nullable
              as bool,
      quizReminders: null == quizReminders
          ? _value.quizReminders
          : quizReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      achievementUnlocked: null == achievementUnlocked
          ? _value.achievementUnlocked
          : achievementUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl(
      {this.enabled = true,
      this.prayerTimes = true,
      this.quizReminders = true,
      this.achievementUnlocked = true});

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final bool prayerTimes;
  @override
  @JsonKey()
  final bool quizReminders;
  @override
  @JsonKey()
  final bool achievementUnlocked;

  @override
  String toString() {
    return 'NotificationSettings(enabled: $enabled, prayerTimes: $prayerTimes, quizReminders: $quizReminders, achievementUnlocked: $achievementUnlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.prayerTimes, prayerTimes) ||
                other.prayerTimes == prayerTimes) &&
            (identical(other.quizReminders, quizReminders) ||
                other.quizReminders == quizReminders) &&
            (identical(other.achievementUnlocked, achievementUnlocked) ||
                other.achievementUnlocked == achievementUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, prayerTimes, quizReminders, achievementUnlocked);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings(
      {final bool enabled,
      final bool prayerTimes,
      final bool quizReminders,
      final bool achievementUnlocked}) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  bool get enabled;
  @override
  bool get prayerTimes;
  @override
  bool get quizReminders;
  @override
  bool get achievementUnlocked;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) {
  return _PrivacySettings.fromJson(json);
}

/// @nodoc
mixin _$PrivacySettings {
  bool get profileVisible => throw _privateConstructorUsedError;
  bool get showInLeaderboard => throw _privateConstructorUsedError;
  bool get allowFriendRequests => throw _privateConstructorUsedError;

  /// Serializes this PrivacySettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrivacySettingsCopyWith<PrivacySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivacySettingsCopyWith<$Res> {
  factory $PrivacySettingsCopyWith(
          PrivacySettings value, $Res Function(PrivacySettings) then) =
      _$PrivacySettingsCopyWithImpl<$Res, PrivacySettings>;
  @useResult
  $Res call(
      {bool profileVisible, bool showInLeaderboard, bool allowFriendRequests});
}

/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res, $Val extends PrivacySettings>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileVisible = null,
    Object? showInLeaderboard = null,
    Object? allowFriendRequests = null,
  }) {
    return _then(_value.copyWith(
      profileVisible: null == profileVisible
          ? _value.profileVisible
          : profileVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      showInLeaderboard: null == showInLeaderboard
          ? _value.showInLeaderboard
          : showInLeaderboard // ignore: cast_nullable_to_non_nullable
              as bool,
      allowFriendRequests: null == allowFriendRequests
          ? _value.allowFriendRequests
          : allowFriendRequests // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrivacySettingsImplCopyWith<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  factory _$$PrivacySettingsImplCopyWith(_$PrivacySettingsImpl value,
          $Res Function(_$PrivacySettingsImpl) then) =
      __$$PrivacySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool profileVisible, bool showInLeaderboard, bool allowFriendRequests});
}

/// @nodoc
class __$$PrivacySettingsImplCopyWithImpl<$Res>
    extends _$PrivacySettingsCopyWithImpl<$Res, _$PrivacySettingsImpl>
    implements _$$PrivacySettingsImplCopyWith<$Res> {
  __$$PrivacySettingsImplCopyWithImpl(
      _$PrivacySettingsImpl _value, $Res Function(_$PrivacySettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileVisible = null,
    Object? showInLeaderboard = null,
    Object? allowFriendRequests = null,
  }) {
    return _then(_$PrivacySettingsImpl(
      profileVisible: null == profileVisible
          ? _value.profileVisible
          : profileVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      showInLeaderboard: null == showInLeaderboard
          ? _value.showInLeaderboard
          : showInLeaderboard // ignore: cast_nullable_to_non_nullable
              as bool,
      allowFriendRequests: null == allowFriendRequests
          ? _value.allowFriendRequests
          : allowFriendRequests // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivacySettingsImpl implements _PrivacySettings {
  const _$PrivacySettingsImpl(
      {this.profileVisible = true,
      this.showInLeaderboard = true,
      this.allowFriendRequests = true});

  factory _$PrivacySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivacySettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool profileVisible;
  @override
  @JsonKey()
  final bool showInLeaderboard;
  @override
  @JsonKey()
  final bool allowFriendRequests;

  @override
  String toString() {
    return 'PrivacySettings(profileVisible: $profileVisible, showInLeaderboard: $showInLeaderboard, allowFriendRequests: $allowFriendRequests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivacySettingsImpl &&
            (identical(other.profileVisible, profileVisible) ||
                other.profileVisible == profileVisible) &&
            (identical(other.showInLeaderboard, showInLeaderboard) ||
                other.showInLeaderboard == showInLeaderboard) &&
            (identical(other.allowFriendRequests, allowFriendRequests) ||
                other.allowFriendRequests == allowFriendRequests));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, profileVisible, showInLeaderboard, allowFriendRequests);

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      __$$PrivacySettingsImplCopyWithImpl<_$PrivacySettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivacySettingsImplToJson(
      this,
    );
  }
}

abstract class _PrivacySettings implements PrivacySettings {
  const factory _PrivacySettings(
      {final bool profileVisible,
      final bool showInLeaderboard,
      final bool allowFriendRequests}) = _$PrivacySettingsImpl;

  factory _PrivacySettings.fromJson(Map<String, dynamic> json) =
      _$PrivacySettingsImpl.fromJson;

  @override
  bool get profileVisible;
  @override
  bool get showInLeaderboard;
  @override
  bool get allowFriendRequests;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  String get theme => throw _privateConstructorUsedError;
  String get fontSize => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call({String theme, String fontSize, String language});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? fontSize = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String theme, String fontSize, String language});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? fontSize = null,
    Object? language = null,
  }) {
    return _then(_$UserPreferencesImpl(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl(
      {this.theme = 'light', this.fontSize = 'medium', this.language = 'auto'});

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  @override
  @JsonKey()
  final String theme;
  @override
  @JsonKey()
  final String fontSize;
  @override
  @JsonKey()
  final String language;

  @override
  String toString() {
    return 'UserPreferences(theme: $theme, fontSize: $fontSize, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, theme, fontSize, language);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
      {final String theme,
      final String fontSize,
      final String language}) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  String get theme;
  @override
  String get fontSize;
  @override
  String get language;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  NotificationSettings get notifications => throw _privateConstructorUsedError;
  PrivacySettings get privacy => throw _privateConstructorUsedError;
  UserPreferences get preferences => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call(
      {NotificationSettings notifications,
      PrivacySettings privacy,
      UserPreferences preferences});

  $NotificationSettingsCopyWith<$Res> get notifications;
  $PrivacySettingsCopyWith<$Res> get privacy;
  $UserPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? privacy = null,
    Object? preferences = null,
  }) {
    return _then(_value.copyWith(
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      privacy: null == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as PrivacySettings,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
    ) as $Val);
  }

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res> get notifications {
    return $NotificationSettingsCopyWith<$Res>(_value.notifications, (value) {
      return _then(_value.copyWith(notifications: value) as $Val);
    });
  }

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrivacySettingsCopyWith<$Res> get privacy {
    return $PrivacySettingsCopyWith<$Res>(_value.privacy, (value) {
      return _then(_value.copyWith(privacy: value) as $Val);
    });
  }

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res> get preferences {
    return $UserPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
          _$UserSettingsImpl value, $Res Function(_$UserSettingsImpl) then) =
      __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationSettings notifications,
      PrivacySettings privacy,
      UserPreferences preferences});

  @override
  $NotificationSettingsCopyWith<$Res> get notifications;
  @override
  $PrivacySettingsCopyWith<$Res> get privacy;
  @override
  $UserPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
      _$UserSettingsImpl _value, $Res Function(_$UserSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? privacy = null,
    Object? preferences = null,
  }) {
    return _then(_$UserSettingsImpl(
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      privacy: null == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as PrivacySettings,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl(
      {this.notifications = const NotificationSettings(),
      this.privacy = const PrivacySettings(),
      this.preferences = const UserPreferences()});

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  @JsonKey()
  final NotificationSettings notifications;
  @override
  @JsonKey()
  final PrivacySettings privacy;
  @override
  @JsonKey()
  final UserPreferences preferences;

  @override
  String toString() {
    return 'UserSettings(notifications: $notifications, privacy: $privacy, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.privacy, privacy) || other.privacy == privacy) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notifications, privacy, preferences);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(
      this,
    );
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings(
      {final NotificationSettings notifications,
      final PrivacySettings privacy,
      final UserPreferences preferences}) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  NotificationSettings get notifications;
  @override
  PrivacySettings get privacy;
  @override
  UserPreferences get preferences;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EnergyData _$EnergyDataFromJson(Map<String, dynamic> json) {
  return _EnergyData.fromJson(json);
}

/// @nodoc
mixin _$EnergyData {
  int get currentEnergy => throw _privateConstructorUsedError;
  int get maxEnergy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get lastUpdateTime => throw _privateConstructorUsedError;
  String get lastDailyBonusDate => throw _privateConstructorUsedError;
  int get totalEnergyUsed => throw _privateConstructorUsedError;
  int get totalEnergyEarned => throw _privateConstructorUsedError;

  /// Serializes this EnergyData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnergyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnergyDataCopyWith<EnergyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnergyDataCopyWith<$Res> {
  factory $EnergyDataCopyWith(
          EnergyData value, $Res Function(EnergyData) then) =
      _$EnergyDataCopyWithImpl<$Res, EnergyData>;
  @useResult
  $Res call(
      {int currentEnergy,
      int maxEnergy,
      @TimestampConverter() DateTime lastUpdateTime,
      String lastDailyBonusDate,
      int totalEnergyUsed,
      int totalEnergyEarned});
}

/// @nodoc
class _$EnergyDataCopyWithImpl<$Res, $Val extends EnergyData>
    implements $EnergyDataCopyWith<$Res> {
  _$EnergyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnergyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentEnergy = null,
    Object? maxEnergy = null,
    Object? lastUpdateTime = null,
    Object? lastDailyBonusDate = null,
    Object? totalEnergyUsed = null,
    Object? totalEnergyEarned = null,
  }) {
    return _then(_value.copyWith(
      currentEnergy: null == currentEnergy
          ? _value.currentEnergy
          : currentEnergy // ignore: cast_nullable_to_non_nullable
              as int,
      maxEnergy: null == maxEnergy
          ? _value.maxEnergy
          : maxEnergy // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdateTime: null == lastUpdateTime
          ? _value.lastUpdateTime
          : lastUpdateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastDailyBonusDate: null == lastDailyBonusDate
          ? _value.lastDailyBonusDate
          : lastDailyBonusDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalEnergyUsed: null == totalEnergyUsed
          ? _value.totalEnergyUsed
          : totalEnergyUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnergyEarned: null == totalEnergyEarned
          ? _value.totalEnergyEarned
          : totalEnergyEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnergyDataImplCopyWith<$Res>
    implements $EnergyDataCopyWith<$Res> {
  factory _$$EnergyDataImplCopyWith(
          _$EnergyDataImpl value, $Res Function(_$EnergyDataImpl) then) =
      __$$EnergyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentEnergy,
      int maxEnergy,
      @TimestampConverter() DateTime lastUpdateTime,
      String lastDailyBonusDate,
      int totalEnergyUsed,
      int totalEnergyEarned});
}

/// @nodoc
class __$$EnergyDataImplCopyWithImpl<$Res>
    extends _$EnergyDataCopyWithImpl<$Res, _$EnergyDataImpl>
    implements _$$EnergyDataImplCopyWith<$Res> {
  __$$EnergyDataImplCopyWithImpl(
      _$EnergyDataImpl _value, $Res Function(_$EnergyDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnergyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentEnergy = null,
    Object? maxEnergy = null,
    Object? lastUpdateTime = null,
    Object? lastDailyBonusDate = null,
    Object? totalEnergyUsed = null,
    Object? totalEnergyEarned = null,
  }) {
    return _then(_$EnergyDataImpl(
      currentEnergy: null == currentEnergy
          ? _value.currentEnergy
          : currentEnergy // ignore: cast_nullable_to_non_nullable
              as int,
      maxEnergy: null == maxEnergy
          ? _value.maxEnergy
          : maxEnergy // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdateTime: null == lastUpdateTime
          ? _value.lastUpdateTime
          : lastUpdateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastDailyBonusDate: null == lastDailyBonusDate
          ? _value.lastDailyBonusDate
          : lastDailyBonusDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalEnergyUsed: null == totalEnergyUsed
          ? _value.totalEnergyUsed
          : totalEnergyUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnergyEarned: null == totalEnergyEarned
          ? _value.totalEnergyEarned
          : totalEnergyEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnergyDataImpl implements _EnergyData {
  const _$EnergyDataImpl(
      {required this.currentEnergy,
      required this.maxEnergy,
      @TimestampConverter() required this.lastUpdateTime,
      required this.lastDailyBonusDate,
      this.totalEnergyUsed = 0,
      this.totalEnergyEarned = 0});

  factory _$EnergyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnergyDataImplFromJson(json);

  @override
  final int currentEnergy;
  @override
  final int maxEnergy;
  @override
  @TimestampConverter()
  final DateTime lastUpdateTime;
  @override
  final String lastDailyBonusDate;
  @override
  @JsonKey()
  final int totalEnergyUsed;
  @override
  @JsonKey()
  final int totalEnergyEarned;

  @override
  String toString() {
    return 'EnergyData(currentEnergy: $currentEnergy, maxEnergy: $maxEnergy, lastUpdateTime: $lastUpdateTime, lastDailyBonusDate: $lastDailyBonusDate, totalEnergyUsed: $totalEnergyUsed, totalEnergyEarned: $totalEnergyEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnergyDataImpl &&
            (identical(other.currentEnergy, currentEnergy) ||
                other.currentEnergy == currentEnergy) &&
            (identical(other.maxEnergy, maxEnergy) ||
                other.maxEnergy == maxEnergy) &&
            (identical(other.lastUpdateTime, lastUpdateTime) ||
                other.lastUpdateTime == lastUpdateTime) &&
            (identical(other.lastDailyBonusDate, lastDailyBonusDate) ||
                other.lastDailyBonusDate == lastDailyBonusDate) &&
            (identical(other.totalEnergyUsed, totalEnergyUsed) ||
                other.totalEnergyUsed == totalEnergyUsed) &&
            (identical(other.totalEnergyEarned, totalEnergyEarned) ||
                other.totalEnergyEarned == totalEnergyEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentEnergy, maxEnergy,
      lastUpdateTime, lastDailyBonusDate, totalEnergyUsed, totalEnergyEarned);

  /// Create a copy of EnergyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnergyDataImplCopyWith<_$EnergyDataImpl> get copyWith =>
      __$$EnergyDataImplCopyWithImpl<_$EnergyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnergyDataImplToJson(
      this,
    );
  }
}

abstract class _EnergyData implements EnergyData {
  const factory _EnergyData(
      {required final int currentEnergy,
      required final int maxEnergy,
      @TimestampConverter() required final DateTime lastUpdateTime,
      required final String lastDailyBonusDate,
      final int totalEnergyUsed,
      final int totalEnergyEarned}) = _$EnergyDataImpl;

  factory _EnergyData.fromJson(Map<String, dynamic> json) =
      _$EnergyDataImpl.fromJson;

  @override
  int get currentEnergy;
  @override
  int get maxEnergy;
  @override
  @TimestampConverter()
  DateTime get lastUpdateTime;
  @override
  String get lastDailyBonusDate;
  @override
  int get totalEnergyUsed;
  @override
  int get totalEnergyEarned;

  /// Create a copy of EnergyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnergyDataImplCopyWith<_$EnergyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionData _$SubscriptionDataFromJson(Map<String, dynamic> json) {
  return _SubscriptionData.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionData {
  String get plan => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  bool get autoRenew => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionDataCopyWith<SubscriptionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionDataCopyWith<$Res> {
  factory $SubscriptionDataCopyWith(
          SubscriptionData value, $Res Function(SubscriptionData) then) =
      _$SubscriptionDataCopyWithImpl<$Res, SubscriptionData>;
  @useResult
  $Res call(
      {String plan,
      bool active,
      @TimestampConverter() DateTime? startDate,
      @TimestampConverter() DateTime? expiryDate,
      bool autoRenew});
}

/// @nodoc
class _$SubscriptionDataCopyWithImpl<$Res, $Val extends SubscriptionData>
    implements $SubscriptionDataCopyWith<$Res> {
  _$SubscriptionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
    Object? active = null,
    Object? startDate = freezed,
    Object? expiryDate = freezed,
    Object? autoRenew = null,
  }) {
    return _then(_value.copyWith(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoRenew: null == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionDataImplCopyWith<$Res>
    implements $SubscriptionDataCopyWith<$Res> {
  factory _$$SubscriptionDataImplCopyWith(_$SubscriptionDataImpl value,
          $Res Function(_$SubscriptionDataImpl) then) =
      __$$SubscriptionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String plan,
      bool active,
      @TimestampConverter() DateTime? startDate,
      @TimestampConverter() DateTime? expiryDate,
      bool autoRenew});
}

/// @nodoc
class __$$SubscriptionDataImplCopyWithImpl<$Res>
    extends _$SubscriptionDataCopyWithImpl<$Res, _$SubscriptionDataImpl>
    implements _$$SubscriptionDataImplCopyWith<$Res> {
  __$$SubscriptionDataImplCopyWithImpl(_$SubscriptionDataImpl _value,
      $Res Function(_$SubscriptionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
    Object? active = null,
    Object? startDate = freezed,
    Object? expiryDate = freezed,
    Object? autoRenew = null,
  }) {
    return _then(_$SubscriptionDataImpl(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoRenew: null == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionDataImpl implements _SubscriptionData {
  const _$SubscriptionDataImpl(
      {this.plan = 'free',
      this.active = false,
      @TimestampConverter() this.startDate,
      @TimestampConverter() this.expiryDate,
      this.autoRenew = false});

  factory _$SubscriptionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionDataImplFromJson(json);

  @override
  @JsonKey()
  final String plan;
  @override
  @JsonKey()
  final bool active;
  @override
  @TimestampConverter()
  final DateTime? startDate;
  @override
  @TimestampConverter()
  final DateTime? expiryDate;
  @override
  @JsonKey()
  final bool autoRenew;

  @override
  String toString() {
    return 'SubscriptionData(plan: $plan, active: $active, startDate: $startDate, expiryDate: $expiryDate, autoRenew: $autoRenew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionDataImpl &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, plan, active, startDate, expiryDate, autoRenew);

  /// Create a copy of SubscriptionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionDataImplCopyWith<_$SubscriptionDataImpl> get copyWith =>
      __$$SubscriptionDataImplCopyWithImpl<_$SubscriptionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionDataImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionData implements SubscriptionData {
  const factory _SubscriptionData(
      {final String plan,
      final bool active,
      @TimestampConverter() final DateTime? startDate,
      @TimestampConverter() final DateTime? expiryDate,
      final bool autoRenew}) = _$SubscriptionDataImpl;

  factory _SubscriptionData.fromJson(Map<String, dynamic> json) =
      _$SubscriptionDataImpl.fromJson;

  @override
  String get plan;
  @override
  bool get active;
  @override
  @TimestampConverter()
  DateTime? get startDate;
  @override
  @TimestampConverter()
  DateTime? get expiryDate;
  @override
  bool get autoRenew;

  /// Create a copy of SubscriptionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionDataImplCopyWith<_$SubscriptionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyStats _$DailyStatsFromJson(Map<String, dynamic> json) {
  return _DailyStats.fromJson(json);
}

/// @nodoc
mixin _$DailyStats {
  String get lastLoginDate => throw _privateConstructorUsedError;
  int get loginStreak => throw _privateConstructorUsedError;
  int get longestLoginStreak => throw _privateConstructorUsedError;
  int get totalLoginDays => throw _privateConstructorUsedError;

  /// Serializes this DailyStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyStatsCopyWith<DailyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStatsCopyWith<$Res> {
  factory $DailyStatsCopyWith(
          DailyStats value, $Res Function(DailyStats) then) =
      _$DailyStatsCopyWithImpl<$Res, DailyStats>;
  @useResult
  $Res call(
      {String lastLoginDate,
      int loginStreak,
      int longestLoginStreak,
      int totalLoginDays});
}

/// @nodoc
class _$DailyStatsCopyWithImpl<$Res, $Val extends DailyStats>
    implements $DailyStatsCopyWith<$Res> {
  _$DailyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastLoginDate = null,
    Object? loginStreak = null,
    Object? longestLoginStreak = null,
    Object? totalLoginDays = null,
  }) {
    return _then(_value.copyWith(
      lastLoginDate: null == lastLoginDate
          ? _value.lastLoginDate
          : lastLoginDate // ignore: cast_nullable_to_non_nullable
              as String,
      loginStreak: null == loginStreak
          ? _value.loginStreak
          : loginStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestLoginStreak: null == longestLoginStreak
          ? _value.longestLoginStreak
          : longestLoginStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalLoginDays: null == totalLoginDays
          ? _value.totalLoginDays
          : totalLoginDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyStatsImplCopyWith<$Res>
    implements $DailyStatsCopyWith<$Res> {
  factory _$$DailyStatsImplCopyWith(
          _$DailyStatsImpl value, $Res Function(_$DailyStatsImpl) then) =
      __$$DailyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String lastLoginDate,
      int loginStreak,
      int longestLoginStreak,
      int totalLoginDays});
}

/// @nodoc
class __$$DailyStatsImplCopyWithImpl<$Res>
    extends _$DailyStatsCopyWithImpl<$Res, _$DailyStatsImpl>
    implements _$$DailyStatsImplCopyWith<$Res> {
  __$$DailyStatsImplCopyWithImpl(
      _$DailyStatsImpl _value, $Res Function(_$DailyStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastLoginDate = null,
    Object? loginStreak = null,
    Object? longestLoginStreak = null,
    Object? totalLoginDays = null,
  }) {
    return _then(_$DailyStatsImpl(
      lastLoginDate: null == lastLoginDate
          ? _value.lastLoginDate
          : lastLoginDate // ignore: cast_nullable_to_non_nullable
              as String,
      loginStreak: null == loginStreak
          ? _value.loginStreak
          : loginStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestLoginStreak: null == longestLoginStreak
          ? _value.longestLoginStreak
          : longestLoginStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalLoginDays: null == totalLoginDays
          ? _value.totalLoginDays
          : totalLoginDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStatsImpl implements _DailyStats {
  const _$DailyStatsImpl(
      {required this.lastLoginDate,
      this.loginStreak = 0,
      this.longestLoginStreak = 0,
      this.totalLoginDays = 0});

  factory _$DailyStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStatsImplFromJson(json);

  @override
  final String lastLoginDate;
  @override
  @JsonKey()
  final int loginStreak;
  @override
  @JsonKey()
  final int longestLoginStreak;
  @override
  @JsonKey()
  final int totalLoginDays;

  @override
  String toString() {
    return 'DailyStats(lastLoginDate: $lastLoginDate, loginStreak: $loginStreak, longestLoginStreak: $longestLoginStreak, totalLoginDays: $totalLoginDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStatsImpl &&
            (identical(other.lastLoginDate, lastLoginDate) ||
                other.lastLoginDate == lastLoginDate) &&
            (identical(other.loginStreak, loginStreak) ||
                other.loginStreak == loginStreak) &&
            (identical(other.longestLoginStreak, longestLoginStreak) ||
                other.longestLoginStreak == longestLoginStreak) &&
            (identical(other.totalLoginDays, totalLoginDays) ||
                other.totalLoginDays == totalLoginDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastLoginDate, loginStreak,
      longestLoginStreak, totalLoginDays);

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      __$$DailyStatsImplCopyWithImpl<_$DailyStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStatsImplToJson(
      this,
    );
  }
}

abstract class _DailyStats implements DailyStats {
  const factory _DailyStats(
      {required final String lastLoginDate,
      final int loginStreak,
      final int longestLoginStreak,
      final int totalLoginDays}) = _$DailyStatsImpl;

  factory _DailyStats.fromJson(Map<String, dynamic> json) =
      _$DailyStatsImpl.fromJson;

  @override
  String get lastLoginDate;
  @override
  int get loginStreak;
  @override
  int get longestLoginStreak;
  @override
  int get totalLoginDays;

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdTracking _$AdTrackingFromJson(Map<String, dynamic> json) {
  return _AdTracking.fromJson(json);
}

/// @nodoc
mixin _$AdTracking {
  int get adsWatchedToday => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastAdWatchedTime => throw _privateConstructorUsedError;
  String get lastAdResetDate => throw _privateConstructorUsedError;
  int get totalAdsWatched => throw _privateConstructorUsedError;

  /// Serializes this AdTracking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdTrackingCopyWith<AdTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdTrackingCopyWith<$Res> {
  factory $AdTrackingCopyWith(
          AdTracking value, $Res Function(AdTracking) then) =
      _$AdTrackingCopyWithImpl<$Res, AdTracking>;
  @useResult
  $Res call(
      {int adsWatchedToday,
      @TimestampConverter() DateTime? lastAdWatchedTime,
      String lastAdResetDate,
      int totalAdsWatched});
}

/// @nodoc
class _$AdTrackingCopyWithImpl<$Res, $Val extends AdTracking>
    implements $AdTrackingCopyWith<$Res> {
  _$AdTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adsWatchedToday = null,
    Object? lastAdWatchedTime = freezed,
    Object? lastAdResetDate = null,
    Object? totalAdsWatched = null,
  }) {
    return _then(_value.copyWith(
      adsWatchedToday: null == adsWatchedToday
          ? _value.adsWatchedToday
          : adsWatchedToday // ignore: cast_nullable_to_non_nullable
              as int,
      lastAdWatchedTime: freezed == lastAdWatchedTime
          ? _value.lastAdWatchedTime
          : lastAdWatchedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAdResetDate: null == lastAdResetDate
          ? _value.lastAdResetDate
          : lastAdResetDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalAdsWatched: null == totalAdsWatched
          ? _value.totalAdsWatched
          : totalAdsWatched // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdTrackingImplCopyWith<$Res>
    implements $AdTrackingCopyWith<$Res> {
  factory _$$AdTrackingImplCopyWith(
          _$AdTrackingImpl value, $Res Function(_$AdTrackingImpl) then) =
      __$$AdTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int adsWatchedToday,
      @TimestampConverter() DateTime? lastAdWatchedTime,
      String lastAdResetDate,
      int totalAdsWatched});
}

/// @nodoc
class __$$AdTrackingImplCopyWithImpl<$Res>
    extends _$AdTrackingCopyWithImpl<$Res, _$AdTrackingImpl>
    implements _$$AdTrackingImplCopyWith<$Res> {
  __$$AdTrackingImplCopyWithImpl(
      _$AdTrackingImpl _value, $Res Function(_$AdTrackingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adsWatchedToday = null,
    Object? lastAdWatchedTime = freezed,
    Object? lastAdResetDate = null,
    Object? totalAdsWatched = null,
  }) {
    return _then(_$AdTrackingImpl(
      adsWatchedToday: null == adsWatchedToday
          ? _value.adsWatchedToday
          : adsWatchedToday // ignore: cast_nullable_to_non_nullable
              as int,
      lastAdWatchedTime: freezed == lastAdWatchedTime
          ? _value.lastAdWatchedTime
          : lastAdWatchedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAdResetDate: null == lastAdResetDate
          ? _value.lastAdResetDate
          : lastAdResetDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalAdsWatched: null == totalAdsWatched
          ? _value.totalAdsWatched
          : totalAdsWatched // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdTrackingImpl implements _AdTracking {
  const _$AdTrackingImpl(
      {this.adsWatchedToday = 0,
      @TimestampConverter() this.lastAdWatchedTime,
      required this.lastAdResetDate,
      this.totalAdsWatched = 0});

  factory _$AdTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdTrackingImplFromJson(json);

  @override
  @JsonKey()
  final int adsWatchedToday;
  @override
  @TimestampConverter()
  final DateTime? lastAdWatchedTime;
  @override
  final String lastAdResetDate;
  @override
  @JsonKey()
  final int totalAdsWatched;

  @override
  String toString() {
    return 'AdTracking(adsWatchedToday: $adsWatchedToday, lastAdWatchedTime: $lastAdWatchedTime, lastAdResetDate: $lastAdResetDate, totalAdsWatched: $totalAdsWatched)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdTrackingImpl &&
            (identical(other.adsWatchedToday, adsWatchedToday) ||
                other.adsWatchedToday == adsWatchedToday) &&
            (identical(other.lastAdWatchedTime, lastAdWatchedTime) ||
                other.lastAdWatchedTime == lastAdWatchedTime) &&
            (identical(other.lastAdResetDate, lastAdResetDate) ||
                other.lastAdResetDate == lastAdResetDate) &&
            (identical(other.totalAdsWatched, totalAdsWatched) ||
                other.totalAdsWatched == totalAdsWatched));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, adsWatchedToday,
      lastAdWatchedTime, lastAdResetDate, totalAdsWatched);

  /// Create a copy of AdTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdTrackingImplCopyWith<_$AdTrackingImpl> get copyWith =>
      __$$AdTrackingImplCopyWithImpl<_$AdTrackingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdTrackingImplToJson(
      this,
    );
  }
}

abstract class _AdTracking implements AdTracking {
  const factory _AdTracking(
      {final int adsWatchedToday,
      @TimestampConverter() final DateTime? lastAdWatchedTime,
      required final String lastAdResetDate,
      final int totalAdsWatched}) = _$AdTrackingImpl;

  factory _AdTracking.fromJson(Map<String, dynamic> json) =
      _$AdTrackingImpl.fromJson;

  @override
  int get adsWatchedToday;
  @override
  @TimestampConverter()
  DateTime? get lastAdWatchedTime;
  @override
  String get lastAdResetDate;
  @override
  int get totalAdsWatched;

  /// Create a copy of AdTracking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdTrackingImplCopyWith<_$AdTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DifficultyProgress _$DifficultyProgressFromJson(Map<String, dynamic> json) {
  return _DifficultyProgress.fromJson(json);
}

/// @nodoc
mixin _$DifficultyProgress {
  int get answered => throw _privateConstructorUsedError;
  int get correct => throw _privateConstructorUsedError;

  /// Serializes this DifficultyProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DifficultyProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DifficultyProgressCopyWith<DifficultyProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DifficultyProgressCopyWith<$Res> {
  factory $DifficultyProgressCopyWith(
          DifficultyProgress value, $Res Function(DifficultyProgress) then) =
      _$DifficultyProgressCopyWithImpl<$Res, DifficultyProgress>;
  @useResult
  $Res call({int answered, int correct});
}

/// @nodoc
class _$DifficultyProgressCopyWithImpl<$Res, $Val extends DifficultyProgress>
    implements $DifficultyProgressCopyWith<$Res> {
  _$DifficultyProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DifficultyProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answered = null,
    Object? correct = null,
  }) {
    return _then(_value.copyWith(
      answered: null == answered
          ? _value.answered
          : answered // ignore: cast_nullable_to_non_nullable
              as int,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DifficultyProgressImplCopyWith<$Res>
    implements $DifficultyProgressCopyWith<$Res> {
  factory _$$DifficultyProgressImplCopyWith(_$DifficultyProgressImpl value,
          $Res Function(_$DifficultyProgressImpl) then) =
      __$$DifficultyProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int answered, int correct});
}

/// @nodoc
class __$$DifficultyProgressImplCopyWithImpl<$Res>
    extends _$DifficultyProgressCopyWithImpl<$Res, _$DifficultyProgressImpl>
    implements _$$DifficultyProgressImplCopyWith<$Res> {
  __$$DifficultyProgressImplCopyWithImpl(_$DifficultyProgressImpl _value,
      $Res Function(_$DifficultyProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of DifficultyProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answered = null,
    Object? correct = null,
  }) {
    return _then(_$DifficultyProgressImpl(
      answered: null == answered
          ? _value.answered
          : answered // ignore: cast_nullable_to_non_nullable
              as int,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DifficultyProgressImpl implements _DifficultyProgress {
  const _$DifficultyProgressImpl({this.answered = 0, this.correct = 0});

  factory _$DifficultyProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$DifficultyProgressImplFromJson(json);

  @override
  @JsonKey()
  final int answered;
  @override
  @JsonKey()
  final int correct;

  @override
  String toString() {
    return 'DifficultyProgress(answered: $answered, correct: $correct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DifficultyProgressImpl &&
            (identical(other.answered, answered) ||
                other.answered == answered) &&
            (identical(other.correct, correct) || other.correct == correct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, answered, correct);

  /// Create a copy of DifficultyProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DifficultyProgressImplCopyWith<_$DifficultyProgressImpl> get copyWith =>
      __$$DifficultyProgressImplCopyWithImpl<_$DifficultyProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DifficultyProgressImplToJson(
      this,
    );
  }
}

abstract class _DifficultyProgress implements DifficultyProgress {
  const factory _DifficultyProgress({final int answered, final int correct}) =
      _$DifficultyProgressImpl;

  factory _DifficultyProgress.fromJson(Map<String, dynamic> json) =
      _$DifficultyProgressImpl.fromJson;

  @override
  int get answered;
  @override
  int get correct;

  /// Create a copy of DifficultyProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DifficultyProgressImplCopyWith<_$DifficultyProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryProgress _$CategoryProgressFromJson(Map<String, dynamic> json) {
  return _CategoryProgress.fromJson(json);
}

/// @nodoc
mixin _$CategoryProgress {
  int get answered => throw _privateConstructorUsedError;
  int get correct => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  /// Serializes this CategoryProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryProgressCopyWith<CategoryProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryProgressCopyWith<$Res> {
  factory $CategoryProgressCopyWith(
          CategoryProgress value, $Res Function(CategoryProgress) then) =
      _$CategoryProgressCopyWithImpl<$Res, CategoryProgress>;
  @useResult
  $Res call({int answered, int correct, int points});
}

/// @nodoc
class _$CategoryProgressCopyWithImpl<$Res, $Val extends CategoryProgress>
    implements $CategoryProgressCopyWith<$Res> {
  _$CategoryProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answered = null,
    Object? correct = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      answered: null == answered
          ? _value.answered
          : answered // ignore: cast_nullable_to_non_nullable
              as int,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryProgressImplCopyWith<$Res>
    implements $CategoryProgressCopyWith<$Res> {
  factory _$$CategoryProgressImplCopyWith(_$CategoryProgressImpl value,
          $Res Function(_$CategoryProgressImpl) then) =
      __$$CategoryProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int answered, int correct, int points});
}

/// @nodoc
class __$$CategoryProgressImplCopyWithImpl<$Res>
    extends _$CategoryProgressCopyWithImpl<$Res, _$CategoryProgressImpl>
    implements _$$CategoryProgressImplCopyWith<$Res> {
  __$$CategoryProgressImplCopyWithImpl(_$CategoryProgressImpl _value,
      $Res Function(_$CategoryProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answered = null,
    Object? correct = null,
    Object? points = null,
  }) {
    return _then(_$CategoryProgressImpl(
      answered: null == answered
          ? _value.answered
          : answered // ignore: cast_nullable_to_non_nullable
              as int,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryProgressImpl implements _CategoryProgress {
  const _$CategoryProgressImpl(
      {this.answered = 0, this.correct = 0, this.points = 0});

  factory _$CategoryProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryProgressImplFromJson(json);

  @override
  @JsonKey()
  final int answered;
  @override
  @JsonKey()
  final int correct;
  @override
  @JsonKey()
  final int points;

  @override
  String toString() {
    return 'CategoryProgress(answered: $answered, correct: $correct, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryProgressImpl &&
            (identical(other.answered, answered) ||
                other.answered == answered) &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, answered, correct, points);

  /// Create a copy of CategoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryProgressImplCopyWith<_$CategoryProgressImpl> get copyWith =>
      __$$CategoryProgressImplCopyWithImpl<_$CategoryProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryProgressImplToJson(
      this,
    );
  }
}

abstract class _CategoryProgress implements CategoryProgress {
  const factory _CategoryProgress(
      {final int answered,
      final int correct,
      final int points}) = _$CategoryProgressImpl;

  factory _CategoryProgress.fromJson(Map<String, dynamic> json) =
      _$CategoryProgressImpl.fromJson;

  @override
  int get answered;
  @override
  int get correct;
  @override
  int get points;

  /// Create a copy of CategoryProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryProgressImplCopyWith<_$CategoryProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizProgress _$QuizProgressFromJson(Map<String, dynamic> json) {
  return _QuizProgress.fromJson(json);
}

/// @nodoc
mixin _$QuizProgress {
  int get totalQuestionsAnswered => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get wrongAnswers => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  Map<String, CategoryProgress> get categoryProgress =>
      throw _privateConstructorUsedError;
  DifficultyProgress get basic => throw _privateConstructorUsedError;
  DifficultyProgress get intermediate => throw _privateConstructorUsedError;
  DifficultyProgress get advanced => throw _privateConstructorUsedError;
  DifficultyProgress get expert => throw _privateConstructorUsedError;

  /// Serializes this QuizProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizProgressCopyWith<QuizProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizProgressCopyWith<$Res> {
  factory $QuizProgressCopyWith(
          QuizProgress value, $Res Function(QuizProgress) then) =
      _$QuizProgressCopyWithImpl<$Res, QuizProgress>;
  @useResult
  $Res call(
      {int totalQuestionsAnswered,
      int correctAnswers,
      int wrongAnswers,
      int currentStreak,
      int longestStreak,
      int totalPoints,
      Map<String, CategoryProgress> categoryProgress,
      DifficultyProgress basic,
      DifficultyProgress intermediate,
      DifficultyProgress advanced,
      DifficultyProgress expert});

  $DifficultyProgressCopyWith<$Res> get basic;
  $DifficultyProgressCopyWith<$Res> get intermediate;
  $DifficultyProgressCopyWith<$Res> get advanced;
  $DifficultyProgressCopyWith<$Res> get expert;
}

/// @nodoc
class _$QuizProgressCopyWithImpl<$Res, $Val extends QuizProgress>
    implements $QuizProgressCopyWith<$Res> {
  _$QuizProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestionsAnswered = null,
    Object? correctAnswers = null,
    Object? wrongAnswers = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalPoints = null,
    Object? categoryProgress = null,
    Object? basic = null,
    Object? intermediate = null,
    Object? advanced = null,
    Object? expert = null,
  }) {
    return _then(_value.copyWith(
      totalQuestionsAnswered: null == totalQuestionsAnswered
          ? _value.totalQuestionsAnswered
          : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      wrongAnswers: null == wrongAnswers
          ? _value.wrongAnswers
          : wrongAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      categoryProgress: null == categoryProgress
          ? _value.categoryProgress
          : categoryProgress // ignore: cast_nullable_to_non_nullable
              as Map<String, CategoryProgress>,
      basic: null == basic
          ? _value.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
      intermediate: null == intermediate
          ? _value.intermediate
          : intermediate // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
      advanced: null == advanced
          ? _value.advanced
          : advanced // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
      expert: null == expert
          ? _value.expert
          : expert // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
    ) as $Val);
  }

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DifficultyProgressCopyWith<$Res> get basic {
    return $DifficultyProgressCopyWith<$Res>(_value.basic, (value) {
      return _then(_value.copyWith(basic: value) as $Val);
    });
  }

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DifficultyProgressCopyWith<$Res> get intermediate {
    return $DifficultyProgressCopyWith<$Res>(_value.intermediate, (value) {
      return _then(_value.copyWith(intermediate: value) as $Val);
    });
  }

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DifficultyProgressCopyWith<$Res> get advanced {
    return $DifficultyProgressCopyWith<$Res>(_value.advanced, (value) {
      return _then(_value.copyWith(advanced: value) as $Val);
    });
  }

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DifficultyProgressCopyWith<$Res> get expert {
    return $DifficultyProgressCopyWith<$Res>(_value.expert, (value) {
      return _then(_value.copyWith(expert: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuizProgressImplCopyWith<$Res>
    implements $QuizProgressCopyWith<$Res> {
  factory _$$QuizProgressImplCopyWith(
          _$QuizProgressImpl value, $Res Function(_$QuizProgressImpl) then) =
      __$$QuizProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalQuestionsAnswered,
      int correctAnswers,
      int wrongAnswers,
      int currentStreak,
      int longestStreak,
      int totalPoints,
      Map<String, CategoryProgress> categoryProgress,
      DifficultyProgress basic,
      DifficultyProgress intermediate,
      DifficultyProgress advanced,
      DifficultyProgress expert});

  @override
  $DifficultyProgressCopyWith<$Res> get basic;
  @override
  $DifficultyProgressCopyWith<$Res> get intermediate;
  @override
  $DifficultyProgressCopyWith<$Res> get advanced;
  @override
  $DifficultyProgressCopyWith<$Res> get expert;
}

/// @nodoc
class __$$QuizProgressImplCopyWithImpl<$Res>
    extends _$QuizProgressCopyWithImpl<$Res, _$QuizProgressImpl>
    implements _$$QuizProgressImplCopyWith<$Res> {
  __$$QuizProgressImplCopyWithImpl(
      _$QuizProgressImpl _value, $Res Function(_$QuizProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestionsAnswered = null,
    Object? correctAnswers = null,
    Object? wrongAnswers = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalPoints = null,
    Object? categoryProgress = null,
    Object? basic = null,
    Object? intermediate = null,
    Object? advanced = null,
    Object? expert = null,
  }) {
    return _then(_$QuizProgressImpl(
      totalQuestionsAnswered: null == totalQuestionsAnswered
          ? _value.totalQuestionsAnswered
          : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      wrongAnswers: null == wrongAnswers
          ? _value.wrongAnswers
          : wrongAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      categoryProgress: null == categoryProgress
          ? _value._categoryProgress
          : categoryProgress // ignore: cast_nullable_to_non_nullable
              as Map<String, CategoryProgress>,
      basic: null == basic
          ? _value.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
      intermediate: null == intermediate
          ? _value.intermediate
          : intermediate // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
      advanced: null == advanced
          ? _value.advanced
          : advanced // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
      expert: null == expert
          ? _value.expert
          : expert // ignore: cast_nullable_to_non_nullable
              as DifficultyProgress,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizProgressImpl implements _QuizProgress {
  const _$QuizProgressImpl(
      {this.totalQuestionsAnswered = 0,
      this.correctAnswers = 0,
      this.wrongAnswers = 0,
      this.currentStreak = 0,
      this.longestStreak = 0,
      this.totalPoints = 0,
      final Map<String, CategoryProgress> categoryProgress = const {},
      required this.basic,
      required this.intermediate,
      required this.advanced,
      required this.expert})
      : _categoryProgress = categoryProgress;

  factory _$QuizProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizProgressImplFromJson(json);

  @override
  @JsonKey()
  final int totalQuestionsAnswered;
  @override
  @JsonKey()
  final int correctAnswers;
  @override
  @JsonKey()
  final int wrongAnswers;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  @JsonKey()
  final int totalPoints;
  final Map<String, CategoryProgress> _categoryProgress;
  @override
  @JsonKey()
  Map<String, CategoryProgress> get categoryProgress {
    if (_categoryProgress is EqualUnmodifiableMapView) return _categoryProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryProgress);
  }

  @override
  final DifficultyProgress basic;
  @override
  final DifficultyProgress intermediate;
  @override
  final DifficultyProgress advanced;
  @override
  final DifficultyProgress expert;

  @override
  String toString() {
    return 'QuizProgress(totalQuestionsAnswered: $totalQuestionsAnswered, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, currentStreak: $currentStreak, longestStreak: $longestStreak, totalPoints: $totalPoints, categoryProgress: $categoryProgress, basic: $basic, intermediate: $intermediate, advanced: $advanced, expert: $expert)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizProgressImpl &&
            (identical(other.totalQuestionsAnswered, totalQuestionsAnswered) ||
                other.totalQuestionsAnswered == totalQuestionsAnswered) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.wrongAnswers, wrongAnswers) ||
                other.wrongAnswers == wrongAnswers) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            const DeepCollectionEquality()
                .equals(other._categoryProgress, _categoryProgress) &&
            (identical(other.basic, basic) || other.basic == basic) &&
            (identical(other.intermediate, intermediate) ||
                other.intermediate == intermediate) &&
            (identical(other.advanced, advanced) ||
                other.advanced == advanced) &&
            (identical(other.expert, expert) || other.expert == expert));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalQuestionsAnswered,
      correctAnswers,
      wrongAnswers,
      currentStreak,
      longestStreak,
      totalPoints,
      const DeepCollectionEquality().hash(_categoryProgress),
      basic,
      intermediate,
      advanced,
      expert);

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizProgressImplCopyWith<_$QuizProgressImpl> get copyWith =>
      __$$QuizProgressImplCopyWithImpl<_$QuizProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizProgressImplToJson(
      this,
    );
  }
}

abstract class _QuizProgress implements QuizProgress {
  const factory _QuizProgress(
      {final int totalQuestionsAnswered,
      final int correctAnswers,
      final int wrongAnswers,
      final int currentStreak,
      final int longestStreak,
      final int totalPoints,
      final Map<String, CategoryProgress> categoryProgress,
      required final DifficultyProgress basic,
      required final DifficultyProgress intermediate,
      required final DifficultyProgress advanced,
      required final DifficultyProgress expert}) = _$QuizProgressImpl;

  factory _QuizProgress.fromJson(Map<String, dynamic> json) =
      _$QuizProgressImpl.fromJson;

  @override
  int get totalQuestionsAnswered;
  @override
  int get correctAnswers;
  @override
  int get wrongAnswers;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  int get totalPoints;
  @override
  Map<String, CategoryProgress> get categoryProgress;
  @override
  DifficultyProgress get basic;
  @override
  DifficultyProgress get intermediate;
  @override
  DifficultyProgress get advanced;
  @override
  DifficultyProgress get expert;

  /// Create a copy of QuizProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizProgressImplCopyWith<_$QuizProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get uid => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  bool get phoneVerified => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  List<String> get providers => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get lastActive => throw _privateConstructorUsedError;
  AccountStatus get accountStatus => throw _privateConstructorUsedError;
  bool get profileComplete => throw _privateConstructorUsedError;
  EnergyData get energy => throw _privateConstructorUsedError;
  SubscriptionData get subscription => throw _privateConstructorUsedError;
  QuizProgress get quizProgress => throw _privateConstructorUsedError;
  DailyStats get dailyStats => throw _privateConstructorUsedError;
  AdTracking get adTracking => throw _privateConstructorUsedError;
  UserSettings get settings => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String uid,
      String? email,
      String? displayName,
      String? photoURL,
      String? phoneNumber,
      String language,
      bool emailVerified,
      bool phoneVerified,
      String provider,
      List<String> providers,
      UserRole role,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastActive,
      AccountStatus accountStatus,
      bool profileComplete,
      EnergyData energy,
      SubscriptionData subscription,
      QuizProgress quizProgress,
      DailyStats dailyStats,
      AdTracking adTracking,
      UserSettings settings});

  $EnergyDataCopyWith<$Res> get energy;
  $SubscriptionDataCopyWith<$Res> get subscription;
  $QuizProgressCopyWith<$Res> get quizProgress;
  $DailyStatsCopyWith<$Res> get dailyStats;
  $AdTrackingCopyWith<$Res> get adTracking;
  $UserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? phoneNumber = freezed,
    Object? language = null,
    Object? emailVerified = null,
    Object? phoneVerified = null,
    Object? provider = null,
    Object? providers = null,
    Object? role = null,
    Object? createdAt = null,
    Object? lastActive = null,
    Object? accountStatus = null,
    Object? profileComplete = null,
    Object? energy = null,
    Object? subscription = null,
    Object? quizProgress = null,
    Object? dailyStats = null,
    Object? adTracking = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneVerified: null == phoneVerified
          ? _value.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      providers: null == providers
          ? _value.providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActive: null == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accountStatus: null == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as AccountStatus,
      profileComplete: null == profileComplete
          ? _value.profileComplete
          : profileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as EnergyData,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as SubscriptionData,
      quizProgress: null == quizProgress
          ? _value.quizProgress
          : quizProgress // ignore: cast_nullable_to_non_nullable
              as QuizProgress,
      dailyStats: null == dailyStats
          ? _value.dailyStats
          : dailyStats // ignore: cast_nullable_to_non_nullable
              as DailyStats,
      adTracking: null == adTracking
          ? _value.adTracking
          : adTracking // ignore: cast_nullable_to_non_nullable
              as AdTracking,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as UserSettings,
    ) as $Val);
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EnergyDataCopyWith<$Res> get energy {
    return $EnergyDataCopyWith<$Res>(_value.energy, (value) {
      return _then(_value.copyWith(energy: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionDataCopyWith<$Res> get subscription {
    return $SubscriptionDataCopyWith<$Res>(_value.subscription, (value) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuizProgressCopyWith<$Res> get quizProgress {
    return $QuizProgressCopyWith<$Res>(_value.quizProgress, (value) {
      return _then(_value.copyWith(quizProgress: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyStatsCopyWith<$Res> get dailyStats {
    return $DailyStatsCopyWith<$Res>(_value.dailyStats, (value) {
      return _then(_value.copyWith(dailyStats: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdTrackingCopyWith<$Res> get adTracking {
    return $AdTrackingCopyWith<$Res>(_value.adTracking, (value) {
      return _then(_value.copyWith(adTracking: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res> get settings {
    return $UserSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String? email,
      String? displayName,
      String? photoURL,
      String? phoneNumber,
      String language,
      bool emailVerified,
      bool phoneVerified,
      String provider,
      List<String> providers,
      UserRole role,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastActive,
      AccountStatus accountStatus,
      bool profileComplete,
      EnergyData energy,
      SubscriptionData subscription,
      QuizProgress quizProgress,
      DailyStats dailyStats,
      AdTracking adTracking,
      UserSettings settings});

  @override
  $EnergyDataCopyWith<$Res> get energy;
  @override
  $SubscriptionDataCopyWith<$Res> get subscription;
  @override
  $QuizProgressCopyWith<$Res> get quizProgress;
  @override
  $DailyStatsCopyWith<$Res> get dailyStats;
  @override
  $AdTrackingCopyWith<$Res> get adTracking;
  @override
  $UserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? phoneNumber = freezed,
    Object? language = null,
    Object? emailVerified = null,
    Object? phoneVerified = null,
    Object? provider = null,
    Object? providers = null,
    Object? role = null,
    Object? createdAt = null,
    Object? lastActive = null,
    Object? accountStatus = null,
    Object? profileComplete = null,
    Object? energy = null,
    Object? subscription = null,
    Object? quizProgress = null,
    Object? dailyStats = null,
    Object? adTracking = null,
    Object? settings = null,
  }) {
    return _then(_$UserProfileImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneVerified: null == phoneVerified
          ? _value.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      providers: null == providers
          ? _value._providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActive: null == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accountStatus: null == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as AccountStatus,
      profileComplete: null == profileComplete
          ? _value.profileComplete
          : profileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as EnergyData,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as SubscriptionData,
      quizProgress: null == quizProgress
          ? _value.quizProgress
          : quizProgress // ignore: cast_nullable_to_non_nullable
              as QuizProgress,
      dailyStats: null == dailyStats
          ? _value.dailyStats
          : dailyStats // ignore: cast_nullable_to_non_nullable
              as DailyStats,
      adTracking: null == adTracking
          ? _value.adTracking
          : adTracking // ignore: cast_nullable_to_non_nullable
              as AdTracking,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as UserSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl extends _UserProfile {
  const _$UserProfileImpl(
      {required this.uid,
      this.email,
      this.displayName,
      this.photoURL,
      this.phoneNumber,
      this.language = 'en',
      this.emailVerified = false,
      this.phoneVerified = false,
      required this.provider,
      final List<String> providers = const [],
      this.role = UserRole.user,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.lastActive,
      this.accountStatus = AccountStatus.active,
      this.profileComplete = false,
      required this.energy,
      required this.subscription,
      required this.quizProgress,
      required this.dailyStats,
      required this.adTracking,
      required this.settings})
      : _providers = providers,
        super._();

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  final String? phoneNumber;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final bool emailVerified;
  @override
  @JsonKey()
  final bool phoneVerified;
  @override
  final String provider;
  final List<String> _providers;
  @override
  @JsonKey()
  List<String> get providers {
    if (_providers is EqualUnmodifiableListView) return _providers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_providers);
  }

  @override
  @JsonKey()
  final UserRole role;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime lastActive;
  @override
  @JsonKey()
  final AccountStatus accountStatus;
  @override
  @JsonKey()
  final bool profileComplete;
  @override
  final EnergyData energy;
  @override
  final SubscriptionData subscription;
  @override
  final QuizProgress quizProgress;
  @override
  final DailyStats dailyStats;
  @override
  final AdTracking adTracking;
  @override
  final UserSettings settings;

  @override
  String toString() {
    return 'UserProfile(uid: $uid, email: $email, displayName: $displayName, photoURL: $photoURL, phoneNumber: $phoneNumber, language: $language, emailVerified: $emailVerified, phoneVerified: $phoneVerified, provider: $provider, providers: $providers, role: $role, createdAt: $createdAt, lastActive: $lastActive, accountStatus: $accountStatus, profileComplete: $profileComplete, energy: $energy, subscription: $subscription, quizProgress: $quizProgress, dailyStats: $dailyStats, adTracking: $adTracking, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.phoneVerified, phoneVerified) ||
                other.phoneVerified == phoneVerified) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality()
                .equals(other._providers, _providers) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.accountStatus, accountStatus) ||
                other.accountStatus == accountStatus) &&
            (identical(other.profileComplete, profileComplete) ||
                other.profileComplete == profileComplete) &&
            (identical(other.energy, energy) || other.energy == energy) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.quizProgress, quizProgress) ||
                other.quizProgress == quizProgress) &&
            (identical(other.dailyStats, dailyStats) ||
                other.dailyStats == dailyStats) &&
            (identical(other.adTracking, adTracking) ||
                other.adTracking == adTracking) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        email,
        displayName,
        photoURL,
        phoneNumber,
        language,
        emailVerified,
        phoneVerified,
        provider,
        const DeepCollectionEquality().hash(_providers),
        role,
        createdAt,
        lastActive,
        accountStatus,
        profileComplete,
        energy,
        subscription,
        quizProgress,
        dailyStats,
        adTracking,
        settings
      ]);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile extends UserProfile {
  const factory _UserProfile(
      {required final String uid,
      final String? email,
      final String? displayName,
      final String? photoURL,
      final String? phoneNumber,
      final String language,
      final bool emailVerified,
      final bool phoneVerified,
      required final String provider,
      final List<String> providers,
      final UserRole role,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() required final DateTime lastActive,
      final AccountStatus accountStatus,
      final bool profileComplete,
      required final EnergyData energy,
      required final SubscriptionData subscription,
      required final QuizProgress quizProgress,
      required final DailyStats dailyStats,
      required final AdTracking adTracking,
      required final UserSettings settings}) = _$UserProfileImpl;
  const _UserProfile._() : super._();

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get uid;
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  String? get phoneNumber;
  @override
  String get language;
  @override
  bool get emailVerified;
  @override
  bool get phoneVerified;
  @override
  String get provider;
  @override
  List<String> get providers;
  @override
  UserRole get role;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get lastActive;
  @override
  AccountStatus get accountStatus;
  @override
  bool get profileComplete;
  @override
  EnergyData get energy;
  @override
  SubscriptionData get subscription;
  @override
  QuizProgress get quizProgress;
  @override
  DailyStats get dailyStats;
  @override
  AdTracking get adTracking;
  @override
  UserSettings get settings;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
