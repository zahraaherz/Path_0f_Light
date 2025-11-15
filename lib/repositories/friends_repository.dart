import 'package:cloud_functions/cloud_functions.dart';
import '../models/friends/friend_models.dart';

/// Repository for managing friend relationships
class FriendsRepository {
  final FirebaseFunctions _functions;

  FriendsRepository({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  /// Search for users by username or user code
  Future<List<UserSearchResult>> searchUsers(String query) async {
    try {
      final result = await _functions.httpsCallable('searchUsers').call({
        'query': query,
      });

      if (result.data['success'] == true) {
        final results = result.data['results'] as List<dynamic>;
        return results
            .map((json) => UserSearchResult.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      print('Error searching users: $e');
      rethrow;
    }
  }

  /// Send a friend request to another user
  Future<FriendRequestResult> sendFriendRequest(String targetUserId) async {
    try {
      final result = await _functions.httpsCallable('sendFriendRequest').call({
        'targetUserId': targetUserId,
      });

      return FriendRequestResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error sending friend request: $e');
      return FriendRequestResult(
        success: false,
        message: 'Failed to send friend request',
        error: e.toString(),
      );
    }
  }

  /// Accept a friend request
  Future<FriendRequestResult> acceptFriendRequest(String requesterId) async {
    try {
      final result = await _functions.httpsCallable('acceptFriendRequest').call({
        'requesterId': requesterId,
      });

      return FriendRequestResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error accepting friend request: $e');
      return FriendRequestResult(
        success: false,
        message: 'Failed to accept friend request',
        error: e.toString(),
      );
    }
  }

  /// Reject a friend request
  Future<FriendRequestResult> rejectFriendRequest(String requesterId) async {
    try {
      final result = await _functions.httpsCallable('rejectFriendRequest').call({
        'requesterId': requesterId,
      });

      return FriendRequestResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error rejecting friend request: $e');
      return FriendRequestResult(
        success: false,
        message: 'Failed to reject friend request',
        error: e.toString(),
      );
    }
  }

  /// Remove a friend
  Future<FriendRequestResult> removeFriend(String friendId) async {
    try {
      final result = await _functions.httpsCallable('removeFriend').call({
        'friendId': friendId,
      });

      return FriendRequestResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error removing friend: $e');
      return FriendRequestResult(
        success: false,
        message: 'Failed to remove friend',
        error: e.toString(),
      );
    }
  }

  /// Block a user
  Future<FriendRequestResult> blockUser(String targetUserId) async {
    try {
      final result = await _functions.httpsCallable('blockUser').call({
        'targetUserId': targetUserId,
      });

      return FriendRequestResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error blocking user: $e');
      return FriendRequestResult(
        success: false,
        message: 'Failed to block user',
        error: e.toString(),
      );
    }
  }

  /// Get list of friends
  Future<List<Friend>> getFriendsList() async {
    try {
      final result = await _functions.httpsCallable('getFriendsList').call();

      if (result.data['success'] == true) {
        final friends = result.data['friends'] as List<dynamic>;
        return friends
            .map((json) => Friend.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      print('Error getting friends list: $e');
      rethrow;
    }
  }

  /// Get pending friend requests (received and sent)
  Future<Map<String, List<Friend>>> getPendingRequests() async {
    try {
      final result = await _functions.httpsCallable('getPendingRequests').call();

      if (result.data['success'] == true) {
        final received = (result.data['received'] as List<dynamic>)
            .map((json) => Friend.fromJson(json as Map<String, dynamic>))
            .toList();

        final sent = (result.data['sent'] as List<dynamic>)
            .map((json) => Friend.fromJson(json as Map<String, dynamic>))
            .toList();

        return {
          'received': received,
          'sent': sent,
        };
      }

      return {'received': [], 'sent': []};
    } catch (e) {
      print('Error getting pending requests: $e');
      rethrow;
    }
  }
}
