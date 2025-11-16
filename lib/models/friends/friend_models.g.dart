// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      status: $enumDecode(_$FriendStatusEnumMap, json['status']),
      requestedBy: json['requestedBy'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      acceptedAt: const TimestampConverter().fromJson(json['acceptedAt']),
      lastInteraction:
          const TimestampConverter().fromJson(json['lastInteraction']),
      friendUsername: json['friendUsername'] as String?,
      friendDisplayName: json['friendDisplayName'] as String?,
      friendPhotoURL: json['friendPhotoURL'] as String?,
      friendTotalPoints: (json['friendTotalPoints'] as num?)?.toInt(),
      friendBooksRead: (json['friendBooksRead'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'status': _$FriendStatusEnumMap[instance.status]!,
      'requestedBy': instance.requestedBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'acceptedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.acceptedAt, const TimestampConverter().toJson),
      'lastInteraction': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastInteraction, const TimestampConverter().toJson),
      'friendUsername': instance.friendUsername,
      'friendDisplayName': instance.friendDisplayName,
      'friendPhotoURL': instance.friendPhotoURL,
      'friendTotalPoints': instance.friendTotalPoints,
      'friendBooksRead': instance.friendBooksRead,
    };

const _$FriendStatusEnumMap = {
  FriendStatus.pending: 'pending',
  FriendStatus.accepted: 'accepted',
  FriendStatus.blocked: 'blocked',
  FriendStatus.rejected: 'rejected',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$UserSearchResultImpl _$$UserSearchResultImplFromJson(
        Map<String, dynamic> json) =>
    _$UserSearchResultImpl(
      uid: json['uid'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      userCode: json['userCode'] as String?,
      totalPoints: (json['totalPoints'] as num?)?.toInt(),
      booksRead: (json['booksRead'] as num?)?.toInt(),
      isFriend: json['isFriend'] as bool? ?? false,
      hasPendingRequest: json['hasPendingRequest'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserSearchResultImplToJson(
        _$UserSearchResultImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'userCode': instance.userCode,
      'totalPoints': instance.totalPoints,
      'booksRead': instance.booksRead,
      'isFriend': instance.isFriend,
      'hasPendingRequest': instance.hasPendingRequest,
      'isBlocked': instance.isBlocked,
    };

_$FriendRequestResultImpl _$$FriendRequestResultImplFromJson(
        Map<String, dynamic> json) =>
    _$FriendRequestResultImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      friend: json['friend'] == null
          ? null
          : Friend.fromJson(json['friend'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$FriendRequestResultImplToJson(
        _$FriendRequestResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'friend': instance.friend,
      'error': instance.error,
    };

_$FriendsListImpl _$$FriendsListImplFromJson(Map<String, dynamic> json) =>
    _$FriendsListImpl(
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => Friend.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pendingRequests: (json['pendingRequests'] as List<dynamic>?)
              ?.map((e) => Friend.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sentRequests: (json['sentRequests'] as List<dynamic>?)
              ?.map((e) => Friend.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalFriends: (json['totalFriends'] as num).toInt(),
      pendingCount: (json['pendingCount'] as num).toInt(),
    );

Map<String, dynamic> _$$FriendsListImplToJson(_$FriendsListImpl instance) =>
    <String, dynamic>{
      'friends': instance.friends,
      'pendingRequests': instance.pendingRequests,
      'sentRequests': instance.sentRequests,
      'totalFriends': instance.totalFriends,
      'pendingCount': instance.pendingCount,
    };

_$UserCodeImpl _$$UserCodeImplFromJson(Map<String, dynamic> json) =>
    _$UserCodeImpl(
      userCode: json['userCode'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserCodeImplToJson(_$UserCodeImpl instance) =>
    <String, dynamic>{
      'userCode': instance.userCode,
      'userId': instance.userId,
      'username': instance.username,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'isActive': instance.isActive,
    };
