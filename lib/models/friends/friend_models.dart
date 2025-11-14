import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'friend_models.freezed.dart';
part 'friend_models.g.dart';

/// Friend request/relationship status
enum FriendStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('blocked')
  blocked,
  @JsonValue('rejected')
  rejected,
}

/// Friend model representing a friendship relationship
@freezed
class Friend with _$Friend {
  const factory Friend({
    required String id,
    required String userId,
    required String friendId,
    required FriendStatus status,
    required String requestedBy,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? acceptedAt,
    @TimestampConverter() DateTime? lastInteraction,
    // Friend's public profile data (denormalized for performance)
    String? friendUsername,
    String? friendDisplayName,
    String? friendPhotoURL,
    int? friendTotalPoints,
    int? friendBooksRead,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}

/// User search result model
@freezed
class UserSearchResult with _$UserSearchResult {
  const factory UserSearchResult({
    required String uid,
    required String username,
    String? displayName,
    String? photoURL,
    String? userCode,
    int? totalPoints,
    int? booksRead,
    @Default(false) bool isFriend,
    @Default(false) bool hasPendingRequest,
    @Default(false) bool isBlocked,
  }) = _UserSearchResult;

  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultFromJson(json);
}

/// Friend request action result
@freezed
class FriendRequestResult with _$FriendRequestResult {
  const factory FriendRequestResult({
    required bool success,
    required String message,
    Friend? friend,
    String? error,
  }) = _FriendRequestResult;

  factory FriendRequestResult.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestResultFromJson(json);
}

/// Friends list response
@freezed
class FriendsList with _$FriendsList {
  const factory FriendsList({
    @Default([]) List<Friend> friends,
    @Default([]) List<Friend> pendingRequests,
    @Default([]) List<Friend> sentRequests,
    required int totalFriends,
    required int pendingCount,
  }) = _FriendsList;

  factory FriendsList.fromJson(Map<String, dynamic> json) =>
      _$FriendsListFromJson(json);
}

/// User code model for easy search
@freezed
class UserCode with _$UserCode {
  const factory UserCode({
    required String userCode,
    required String userId,
    required String username,
    String? displayName,
    String? photoURL,
    @TimestampConverter() required DateTime createdAt,
    @Default(true) bool isActive,
  }) = _UserCode;

  factory UserCode.fromJson(Map<String, dynamic> json) =>
      _$UserCodeFromJson(json);
}

/// Timestamp converter for Freezed
class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}

/// Extension methods for Friend
extension FriendExtensions on Friend {
  /// Check if request is from current user
  bool isRequestedByMe(String currentUserId) => requestedBy == currentUserId;

  /// Check if pending request
  bool get isPending => status == FriendStatus.pending;

  /// Check if accepted
  bool get isAccepted => status == FriendStatus.accepted;

  /// Check if blocked
  bool get isBlocked => status == FriendStatus.blocked;

  /// Get the other user's ID (not the current user)
  String getOtherUserId(String currentUserId) {
    return userId == currentUserId ? friendId : userId;
  }

  /// Get display name or username
  String get displayText => friendDisplayName ?? friendUsername ?? 'User';
}
