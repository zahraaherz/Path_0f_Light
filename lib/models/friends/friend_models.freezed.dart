// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Friend _$FriendFromJson(Map<String, dynamic> json) {
  return _Friend.fromJson(json);
}

/// @nodoc
mixin _$Friend {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get friendId => throw _privateConstructorUsedError;
  FriendStatus get status => throw _privateConstructorUsedError;
  String get requestedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get acceptedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastInteraction =>
      throw _privateConstructorUsedError; // Friend's public profile data (denormalized for performance)
  String? get friendUsername => throw _privateConstructorUsedError;
  String? get friendDisplayName => throw _privateConstructorUsedError;
  String? get friendPhotoURL => throw _privateConstructorUsedError;
  int? get friendTotalPoints => throw _privateConstructorUsedError;
  int? get friendBooksRead => throw _privateConstructorUsedError;

  /// Serializes this Friend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendCopyWith<Friend> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendCopyWith<$Res> {
  factory $FriendCopyWith(Friend value, $Res Function(Friend) then) =
      _$FriendCopyWithImpl<$Res, Friend>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String friendId,
      FriendStatus status,
      String requestedBy,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? acceptedAt,
      @TimestampConverter() DateTime? lastInteraction,
      String? friendUsername,
      String? friendDisplayName,
      String? friendPhotoURL,
      int? friendTotalPoints,
      int? friendBooksRead});
}

/// @nodoc
class _$FriendCopyWithImpl<$Res, $Val extends Friend>
    implements $FriendCopyWith<$Res> {
  _$FriendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? friendId = null,
    Object? status = null,
    Object? requestedBy = null,
    Object? createdAt = null,
    Object? acceptedAt = freezed,
    Object? lastInteraction = freezed,
    Object? friendUsername = freezed,
    Object? friendDisplayName = freezed,
    Object? friendPhotoURL = freezed,
    Object? friendTotalPoints = freezed,
    Object? friendBooksRead = freezed,
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
      friendId: null == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FriendStatus,
      requestedBy: null == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastInteraction: freezed == lastInteraction
          ? _value.lastInteraction
          : lastInteraction // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      friendUsername: freezed == friendUsername
          ? _value.friendUsername
          : friendUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      friendDisplayName: freezed == friendDisplayName
          ? _value.friendDisplayName
          : friendDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      friendPhotoURL: freezed == friendPhotoURL
          ? _value.friendPhotoURL
          : friendPhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      friendTotalPoints: freezed == friendTotalPoints
          ? _value.friendTotalPoints
          : friendTotalPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      friendBooksRead: freezed == friendBooksRead
          ? _value.friendBooksRead
          : friendBooksRead // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendImplCopyWith<$Res> implements $FriendCopyWith<$Res> {
  factory _$$FriendImplCopyWith(
          _$FriendImpl value, $Res Function(_$FriendImpl) then) =
      __$$FriendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String friendId,
      FriendStatus status,
      String requestedBy,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? acceptedAt,
      @TimestampConverter() DateTime? lastInteraction,
      String? friendUsername,
      String? friendDisplayName,
      String? friendPhotoURL,
      int? friendTotalPoints,
      int? friendBooksRead});
}

/// @nodoc
class __$$FriendImplCopyWithImpl<$Res>
    extends _$FriendCopyWithImpl<$Res, _$FriendImpl>
    implements _$$FriendImplCopyWith<$Res> {
  __$$FriendImplCopyWithImpl(
      _$FriendImpl _value, $Res Function(_$FriendImpl) _then)
      : super(_value, _then);

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? friendId = null,
    Object? status = null,
    Object? requestedBy = null,
    Object? createdAt = null,
    Object? acceptedAt = freezed,
    Object? lastInteraction = freezed,
    Object? friendUsername = freezed,
    Object? friendDisplayName = freezed,
    Object? friendPhotoURL = freezed,
    Object? friendTotalPoints = freezed,
    Object? friendBooksRead = freezed,
  }) {
    return _then(_$FriendImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      friendId: null == friendId
          ? _value.friendId
          : friendId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FriendStatus,
      requestedBy: null == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastInteraction: freezed == lastInteraction
          ? _value.lastInteraction
          : lastInteraction // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      friendUsername: freezed == friendUsername
          ? _value.friendUsername
          : friendUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      friendDisplayName: freezed == friendDisplayName
          ? _value.friendDisplayName
          : friendDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      friendPhotoURL: freezed == friendPhotoURL
          ? _value.friendPhotoURL
          : friendPhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      friendTotalPoints: freezed == friendTotalPoints
          ? _value.friendTotalPoints
          : friendTotalPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      friendBooksRead: freezed == friendBooksRead
          ? _value.friendBooksRead
          : friendBooksRead // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendImpl implements _Friend {
  const _$FriendImpl(
      {required this.id,
      required this.userId,
      required this.friendId,
      required this.status,
      required this.requestedBy,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() this.acceptedAt,
      @TimestampConverter() this.lastInteraction,
      this.friendUsername,
      this.friendDisplayName,
      this.friendPhotoURL,
      this.friendTotalPoints,
      this.friendBooksRead});

  factory _$FriendImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String friendId;
  @override
  final FriendStatus status;
  @override
  final String requestedBy;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? acceptedAt;
  @override
  @TimestampConverter()
  final DateTime? lastInteraction;
// Friend's public profile data (denormalized for performance)
  @override
  final String? friendUsername;
  @override
  final String? friendDisplayName;
  @override
  final String? friendPhotoURL;
  @override
  final int? friendTotalPoints;
  @override
  final int? friendBooksRead;

  @override
  String toString() {
    return 'Friend(id: $id, userId: $userId, friendId: $friendId, status: $status, requestedBy: $requestedBy, createdAt: $createdAt, acceptedAt: $acceptedAt, lastInteraction: $lastInteraction, friendUsername: $friendUsername, friendDisplayName: $friendDisplayName, friendPhotoURL: $friendPhotoURL, friendTotalPoints: $friendTotalPoints, friendBooksRead: $friendBooksRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.friendId, friendId) ||
                other.friendId == friendId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestedBy, requestedBy) ||
                other.requestedBy == requestedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.lastInteraction, lastInteraction) ||
                other.lastInteraction == lastInteraction) &&
            (identical(other.friendUsername, friendUsername) ||
                other.friendUsername == friendUsername) &&
            (identical(other.friendDisplayName, friendDisplayName) ||
                other.friendDisplayName == friendDisplayName) &&
            (identical(other.friendPhotoURL, friendPhotoURL) ||
                other.friendPhotoURL == friendPhotoURL) &&
            (identical(other.friendTotalPoints, friendTotalPoints) ||
                other.friendTotalPoints == friendTotalPoints) &&
            (identical(other.friendBooksRead, friendBooksRead) ||
                other.friendBooksRead == friendBooksRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      friendId,
      status,
      requestedBy,
      createdAt,
      acceptedAt,
      lastInteraction,
      friendUsername,
      friendDisplayName,
      friendPhotoURL,
      friendTotalPoints,
      friendBooksRead);

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      __$$FriendImplCopyWithImpl<_$FriendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendImplToJson(
      this,
    );
  }
}

abstract class _Friend implements Friend {
  const factory _Friend(
      {required final String id,
      required final String userId,
      required final String friendId,
      required final FriendStatus status,
      required final String requestedBy,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() final DateTime? acceptedAt,
      @TimestampConverter() final DateTime? lastInteraction,
      final String? friendUsername,
      final String? friendDisplayName,
      final String? friendPhotoURL,
      final int? friendTotalPoints,
      final int? friendBooksRead}) = _$FriendImpl;

  factory _Friend.fromJson(Map<String, dynamic> json) = _$FriendImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get friendId;
  @override
  FriendStatus get status;
  @override
  String get requestedBy;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get acceptedAt;
  @override
  @TimestampConverter()
  DateTime?
      get lastInteraction; // Friend's public profile data (denormalized for performance)
  @override
  String? get friendUsername;
  @override
  String? get friendDisplayName;
  @override
  String? get friendPhotoURL;
  @override
  int? get friendTotalPoints;
  @override
  int? get friendBooksRead;

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSearchResult _$UserSearchResultFromJson(Map<String, dynamic> json) {
  return _UserSearchResult.fromJson(json);
}

/// @nodoc
mixin _$UserSearchResult {
  String get uid => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get userCode => throw _privateConstructorUsedError;
  int? get totalPoints => throw _privateConstructorUsedError;
  int? get booksRead => throw _privateConstructorUsedError;
  bool get isFriend => throw _privateConstructorUsedError;
  bool get hasPendingRequest => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;

  /// Serializes this UserSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSearchResultCopyWith<UserSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSearchResultCopyWith<$Res> {
  factory $UserSearchResultCopyWith(
          UserSearchResult value, $Res Function(UserSearchResult) then) =
      _$UserSearchResultCopyWithImpl<$Res, UserSearchResult>;
  @useResult
  $Res call(
      {String uid,
      String username,
      String? displayName,
      String? photoURL,
      String? userCode,
      int? totalPoints,
      int? booksRead,
      bool isFriend,
      bool hasPendingRequest,
      bool isBlocked});
}

/// @nodoc
class _$UserSearchResultCopyWithImpl<$Res, $Val extends UserSearchResult>
    implements $UserSearchResultCopyWith<$Res> {
  _$UserSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? userCode = freezed,
    Object? totalPoints = freezed,
    Object? booksRead = freezed,
    Object? isFriend = null,
    Object? hasPendingRequest = null,
    Object? isBlocked = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      userCode: freezed == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPoints: freezed == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      booksRead: freezed == booksRead
          ? _value.booksRead
          : booksRead // ignore: cast_nullable_to_non_nullable
              as int?,
      isFriend: null == isFriend
          ? _value.isFriend
          : isFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPendingRequest: null == hasPendingRequest
          ? _value.hasPendingRequest
          : hasPendingRequest // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSearchResultImplCopyWith<$Res>
    implements $UserSearchResultCopyWith<$Res> {
  factory _$$UserSearchResultImplCopyWith(_$UserSearchResultImpl value,
          $Res Function(_$UserSearchResultImpl) then) =
      __$$UserSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String username,
      String? displayName,
      String? photoURL,
      String? userCode,
      int? totalPoints,
      int? booksRead,
      bool isFriend,
      bool hasPendingRequest,
      bool isBlocked});
}

/// @nodoc
class __$$UserSearchResultImplCopyWithImpl<$Res>
    extends _$UserSearchResultCopyWithImpl<$Res, _$UserSearchResultImpl>
    implements _$$UserSearchResultImplCopyWith<$Res> {
  __$$UserSearchResultImplCopyWithImpl(_$UserSearchResultImpl _value,
      $Res Function(_$UserSearchResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? userCode = freezed,
    Object? totalPoints = freezed,
    Object? booksRead = freezed,
    Object? isFriend = null,
    Object? hasPendingRequest = null,
    Object? isBlocked = null,
  }) {
    return _then(_$UserSearchResultImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      userCode: freezed == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPoints: freezed == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      booksRead: freezed == booksRead
          ? _value.booksRead
          : booksRead // ignore: cast_nullable_to_non_nullable
              as int?,
      isFriend: null == isFriend
          ? _value.isFriend
          : isFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPendingRequest: null == hasPendingRequest
          ? _value.hasPendingRequest
          : hasPendingRequest // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSearchResultImpl implements _UserSearchResult {
  const _$UserSearchResultImpl(
      {required this.uid,
      required this.username,
      this.displayName,
      this.photoURL,
      this.userCode,
      this.totalPoints,
      this.booksRead,
      this.isFriend = false,
      this.hasPendingRequest = false,
      this.isBlocked = false});

  factory _$UserSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSearchResultImplFromJson(json);

  @override
  final String uid;
  @override
  final String username;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  final String? userCode;
  @override
  final int? totalPoints;
  @override
  final int? booksRead;
  @override
  @JsonKey()
  final bool isFriend;
  @override
  @JsonKey()
  final bool hasPendingRequest;
  @override
  @JsonKey()
  final bool isBlocked;

  @override
  String toString() {
    return 'UserSearchResult(uid: $uid, username: $username, displayName: $displayName, photoURL: $photoURL, userCode: $userCode, totalPoints: $totalPoints, booksRead: $booksRead, isFriend: $isFriend, hasPendingRequest: $hasPendingRequest, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSearchResultImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.userCode, userCode) ||
                other.userCode == userCode) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.booksRead, booksRead) ||
                other.booksRead == booksRead) &&
            (identical(other.isFriend, isFriend) ||
                other.isFriend == isFriend) &&
            (identical(other.hasPendingRequest, hasPendingRequest) ||
                other.hasPendingRequest == hasPendingRequest) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      username,
      displayName,
      photoURL,
      userCode,
      totalPoints,
      booksRead,
      isFriend,
      hasPendingRequest,
      isBlocked);

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSearchResultImplCopyWith<_$UserSearchResultImpl> get copyWith =>
      __$$UserSearchResultImplCopyWithImpl<_$UserSearchResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSearchResultImplToJson(
      this,
    );
  }
}

abstract class _UserSearchResult implements UserSearchResult {
  const factory _UserSearchResult(
      {required final String uid,
      required final String username,
      final String? displayName,
      final String? photoURL,
      final String? userCode,
      final int? totalPoints,
      final int? booksRead,
      final bool isFriend,
      final bool hasPendingRequest,
      final bool isBlocked}) = _$UserSearchResultImpl;

  factory _UserSearchResult.fromJson(Map<String, dynamic> json) =
      _$UserSearchResultImpl.fromJson;

  @override
  String get uid;
  @override
  String get username;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  String? get userCode;
  @override
  int? get totalPoints;
  @override
  int? get booksRead;
  @override
  bool get isFriend;
  @override
  bool get hasPendingRequest;
  @override
  bool get isBlocked;

  /// Create a copy of UserSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSearchResultImplCopyWith<_$UserSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendRequestResult _$FriendRequestResultFromJson(Map<String, dynamic> json) {
  return _FriendRequestResult.fromJson(json);
}

/// @nodoc
mixin _$FriendRequestResult {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Friend? get friend => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this FriendRequestResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendRequestResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestResultCopyWith<FriendRequestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestResultCopyWith<$Res> {
  factory $FriendRequestResultCopyWith(
          FriendRequestResult value, $Res Function(FriendRequestResult) then) =
      _$FriendRequestResultCopyWithImpl<$Res, FriendRequestResult>;
  @useResult
  $Res call({bool success, String message, Friend? friend, String? error});

  $FriendCopyWith<$Res>? get friend;
}

/// @nodoc
class _$FriendRequestResultCopyWithImpl<$Res, $Val extends FriendRequestResult>
    implements $FriendRequestResultCopyWith<$Res> {
  _$FriendRequestResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequestResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? friend = freezed,
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
      friend: freezed == friend
          ? _value.friend
          : friend // ignore: cast_nullable_to_non_nullable
              as Friend?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of FriendRequestResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendCopyWith<$Res>? get friend {
    if (_value.friend == null) {
      return null;
    }

    return $FriendCopyWith<$Res>(_value.friend!, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendRequestResultImplCopyWith<$Res>
    implements $FriendRequestResultCopyWith<$Res> {
  factory _$$FriendRequestResultImplCopyWith(_$FriendRequestResultImpl value,
          $Res Function(_$FriendRequestResultImpl) then) =
      __$$FriendRequestResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, Friend? friend, String? error});

  @override
  $FriendCopyWith<$Res>? get friend;
}

/// @nodoc
class __$$FriendRequestResultImplCopyWithImpl<$Res>
    extends _$FriendRequestResultCopyWithImpl<$Res, _$FriendRequestResultImpl>
    implements _$$FriendRequestResultImplCopyWith<$Res> {
  __$$FriendRequestResultImplCopyWithImpl(_$FriendRequestResultImpl _value,
      $Res Function(_$FriendRequestResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendRequestResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? friend = freezed,
    Object? error = freezed,
  }) {
    return _then(_$FriendRequestResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      friend: freezed == friend
          ? _value.friend
          : friend // ignore: cast_nullable_to_non_nullable
              as Friend?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendRequestResultImpl implements _FriendRequestResult {
  const _$FriendRequestResultImpl(
      {required this.success, required this.message, this.friend, this.error});

  factory _$FriendRequestResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRequestResultImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final Friend? friend;
  @override
  final String? error;

  @override
  String toString() {
    return 'FriendRequestResult(success: $success, message: $message, friend: $friend, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.friend, friend) || other.friend == friend) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, friend, error);

  /// Create a copy of FriendRequestResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestResultImplCopyWith<_$FriendRequestResultImpl> get copyWith =>
      __$$FriendRequestResultImplCopyWithImpl<_$FriendRequestResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRequestResultImplToJson(
      this,
    );
  }
}

abstract class _FriendRequestResult implements FriendRequestResult {
  const factory _FriendRequestResult(
      {required final bool success,
      required final String message,
      final Friend? friend,
      final String? error}) = _$FriendRequestResultImpl;

  factory _FriendRequestResult.fromJson(Map<String, dynamic> json) =
      _$FriendRequestResultImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  Friend? get friend;
  @override
  String? get error;

  /// Create a copy of FriendRequestResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestResultImplCopyWith<_$FriendRequestResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendsList _$FriendsListFromJson(Map<String, dynamic> json) {
  return _FriendsList.fromJson(json);
}

/// @nodoc
mixin _$FriendsList {
  List<Friend> get friends => throw _privateConstructorUsedError;
  List<Friend> get pendingRequests => throw _privateConstructorUsedError;
  List<Friend> get sentRequests => throw _privateConstructorUsedError;
  int get totalFriends => throw _privateConstructorUsedError;
  int get pendingCount => throw _privateConstructorUsedError;

  /// Serializes this FriendsList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendsList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendsListCopyWith<FriendsList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendsListCopyWith<$Res> {
  factory $FriendsListCopyWith(
          FriendsList value, $Res Function(FriendsList) then) =
      _$FriendsListCopyWithImpl<$Res, FriendsList>;
  @useResult
  $Res call(
      {List<Friend> friends,
      List<Friend> pendingRequests,
      List<Friend> sentRequests,
      int totalFriends,
      int pendingCount});
}

/// @nodoc
class _$FriendsListCopyWithImpl<$Res, $Val extends FriendsList>
    implements $FriendsListCopyWith<$Res> {
  _$FriendsListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendsList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? pendingRequests = null,
    Object? sentRequests = null,
    Object? totalFriends = null,
    Object? pendingCount = null,
  }) {
    return _then(_value.copyWith(
      friends: null == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      pendingRequests: null == pendingRequests
          ? _value.pendingRequests
          : pendingRequests // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      sentRequests: null == sentRequests
          ? _value.sentRequests
          : sentRequests // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      totalFriends: null == totalFriends
          ? _value.totalFriends
          : totalFriends // ignore: cast_nullable_to_non_nullable
              as int,
      pendingCount: null == pendingCount
          ? _value.pendingCount
          : pendingCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendsListImplCopyWith<$Res>
    implements $FriendsListCopyWith<$Res> {
  factory _$$FriendsListImplCopyWith(
          _$FriendsListImpl value, $Res Function(_$FriendsListImpl) then) =
      __$$FriendsListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Friend> friends,
      List<Friend> pendingRequests,
      List<Friend> sentRequests,
      int totalFriends,
      int pendingCount});
}

/// @nodoc
class __$$FriendsListImplCopyWithImpl<$Res>
    extends _$FriendsListCopyWithImpl<$Res, _$FriendsListImpl>
    implements _$$FriendsListImplCopyWith<$Res> {
  __$$FriendsListImplCopyWithImpl(
      _$FriendsListImpl _value, $Res Function(_$FriendsListImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendsList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? pendingRequests = null,
    Object? sentRequests = null,
    Object? totalFriends = null,
    Object? pendingCount = null,
  }) {
    return _then(_$FriendsListImpl(
      friends: null == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      pendingRequests: null == pendingRequests
          ? _value._pendingRequests
          : pendingRequests // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      sentRequests: null == sentRequests
          ? _value._sentRequests
          : sentRequests // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      totalFriends: null == totalFriends
          ? _value.totalFriends
          : totalFriends // ignore: cast_nullable_to_non_nullable
              as int,
      pendingCount: null == pendingCount
          ? _value.pendingCount
          : pendingCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendsListImpl implements _FriendsList {
  const _$FriendsListImpl(
      {final List<Friend> friends = const [],
      final List<Friend> pendingRequests = const [],
      final List<Friend> sentRequests = const [],
      required this.totalFriends,
      required this.pendingCount})
      : _friends = friends,
        _pendingRequests = pendingRequests,
        _sentRequests = sentRequests;

  factory _$FriendsListImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendsListImplFromJson(json);

  final List<Friend> _friends;
  @override
  @JsonKey()
  List<Friend> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  final List<Friend> _pendingRequests;
  @override
  @JsonKey()
  List<Friend> get pendingRequests {
    if (_pendingRequests is EqualUnmodifiableListView) return _pendingRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingRequests);
  }

  final List<Friend> _sentRequests;
  @override
  @JsonKey()
  List<Friend> get sentRequests {
    if (_sentRequests is EqualUnmodifiableListView) return _sentRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentRequests);
  }

  @override
  final int totalFriends;
  @override
  final int pendingCount;

  @override
  String toString() {
    return 'FriendsList(friends: $friends, pendingRequests: $pendingRequests, sentRequests: $sentRequests, totalFriends: $totalFriends, pendingCount: $pendingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendsListImpl &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality()
                .equals(other._pendingRequests, _pendingRequests) &&
            const DeepCollectionEquality()
                .equals(other._sentRequests, _sentRequests) &&
            (identical(other.totalFriends, totalFriends) ||
                other.totalFriends == totalFriends) &&
            (identical(other.pendingCount, pendingCount) ||
                other.pendingCount == pendingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(_pendingRequests),
      const DeepCollectionEquality().hash(_sentRequests),
      totalFriends,
      pendingCount);

  /// Create a copy of FriendsList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendsListImplCopyWith<_$FriendsListImpl> get copyWith =>
      __$$FriendsListImplCopyWithImpl<_$FriendsListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendsListImplToJson(
      this,
    );
  }
}

abstract class _FriendsList implements FriendsList {
  const factory _FriendsList(
      {final List<Friend> friends,
      final List<Friend> pendingRequests,
      final List<Friend> sentRequests,
      required final int totalFriends,
      required final int pendingCount}) = _$FriendsListImpl;

  factory _FriendsList.fromJson(Map<String, dynamic> json) =
      _$FriendsListImpl.fromJson;

  @override
  List<Friend> get friends;
  @override
  List<Friend> get pendingRequests;
  @override
  List<Friend> get sentRequests;
  @override
  int get totalFriends;
  @override
  int get pendingCount;

  /// Create a copy of FriendsList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendsListImplCopyWith<_$FriendsListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserCode _$UserCodeFromJson(Map<String, dynamic> json) {
  return _UserCode.fromJson(json);
}

/// @nodoc
mixin _$UserCode {
  String get userCode => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this UserCode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCodeCopyWith<UserCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCodeCopyWith<$Res> {
  factory $UserCodeCopyWith(UserCode value, $Res Function(UserCode) then) =
      _$UserCodeCopyWithImpl<$Res, UserCode>;
  @useResult
  $Res call(
      {String userCode,
      String userId,
      String username,
      String? displayName,
      String? photoURL,
      @TimestampConverter() DateTime createdAt,
      bool isActive});
}

/// @nodoc
class _$UserCodeCopyWithImpl<$Res, $Val extends UserCode>
    implements $UserCodeCopyWith<$Res> {
  _$UserCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userCode = null,
    Object? userId = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? createdAt = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      userCode: null == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCodeImplCopyWith<$Res>
    implements $UserCodeCopyWith<$Res> {
  factory _$$UserCodeImplCopyWith(
          _$UserCodeImpl value, $Res Function(_$UserCodeImpl) then) =
      __$$UserCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userCode,
      String userId,
      String username,
      String? displayName,
      String? photoURL,
      @TimestampConverter() DateTime createdAt,
      bool isActive});
}

/// @nodoc
class __$$UserCodeImplCopyWithImpl<$Res>
    extends _$UserCodeCopyWithImpl<$Res, _$UserCodeImpl>
    implements _$$UserCodeImplCopyWith<$Res> {
  __$$UserCodeImplCopyWithImpl(
      _$UserCodeImpl _value, $Res Function(_$UserCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userCode = null,
    Object? userId = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? createdAt = null,
    Object? isActive = null,
  }) {
    return _then(_$UserCodeImpl(
      userCode: null == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCodeImpl implements _UserCode {
  const _$UserCodeImpl(
      {required this.userCode,
      required this.userId,
      required this.username,
      this.displayName,
      this.photoURL,
      @TimestampConverter() required this.createdAt,
      this.isActive = true});

  factory _$UserCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCodeImplFromJson(json);

  @override
  final String userCode;
  @override
  final String userId;
  @override
  final String username;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'UserCode(userCode: $userCode, userId: $userId, username: $username, displayName: $displayName, photoURL: $photoURL, createdAt: $createdAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCodeImpl &&
            (identical(other.userCode, userCode) ||
                other.userCode == userCode) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userCode, userId, username,
      displayName, photoURL, createdAt, isActive);

  /// Create a copy of UserCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCodeImplCopyWith<_$UserCodeImpl> get copyWith =>
      __$$UserCodeImplCopyWithImpl<_$UserCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCodeImplToJson(
      this,
    );
  }
}

abstract class _UserCode implements UserCode {
  const factory _UserCode(
      {required final String userCode,
      required final String userId,
      required final String username,
      final String? displayName,
      final String? photoURL,
      @TimestampConverter() required final DateTime createdAt,
      final bool isActive}) = _$UserCodeImpl;

  factory _UserCode.fromJson(Map<String, dynamic> json) =
      _$UserCodeImpl.fromJson;

  @override
  String get userCode;
  @override
  String get userId;
  @override
  String get username;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  bool get isActive;

  /// Create a copy of UserCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserCodeImplCopyWith<_$UserCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
