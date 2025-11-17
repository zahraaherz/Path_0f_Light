import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/friends/friend_models.dart';
import '../repositories/friends_repository.dart';

// Repository provider
final friendsRepositoryProvider = Provider<FriendsRepository>((ref) {
  return FriendsRepository();
});

// Search query state
final friendSearchQueryProvider = StateProvider<String>((ref) => '');

// Search results provider
final friendSearchResultsProvider =
    FutureProvider.autoDispose<List<UserSearchResult>>((ref) async {
  final query = ref.watch(friendSearchQueryProvider);

  if (query.trim().isEmpty || query.length < 2) {
    return [];
  }

  final repository = ref.watch(friendsRepositoryProvider);
  return repository.searchUsers(query);
});

// Friends list provider
final friendsListProvider = FutureProvider.autoDispose<List<Friend>>((ref) async {
  final repository = ref.watch(friendsRepositoryProvider);
  return repository.getFriendsList();
});

// Pending requests provider
final pendingRequestsProvider =
    FutureProvider.autoDispose<Map<String, List<Friend>>>((ref) async {
  final repository = ref.watch(friendsRepositoryProvider);
  return repository.getPendingRequests();
});

// Send friend request action
final sendFriendRequestProvider =
    Provider<Future<FriendRequestResult> Function(String)>((ref) {
  final repository = ref.watch(friendsRepositoryProvider);
  return (String targetUserId) async {
    final result = await repository.sendFriendRequest(targetUserId);

    // Invalidate search results to update friend status
    ref.invalidate(friendSearchResultsProvider);

    return result;
  };
});

// Accept friend request action
final acceptFriendRequestProvider =
    Provider<Future<FriendRequestResult> Function(String)>((ref) {
  final repository = ref.watch(friendsRepositoryProvider);
  return (String requesterId) async {
    final result = await repository.acceptFriendRequest(requesterId);

    // Invalidate lists to refresh
    ref.invalidate(friendsListProvider);
    ref.invalidate(pendingRequestsProvider);

    return result;
  };
});

// Reject friend request action
final rejectFriendRequestProvider =
    Provider<Future<FriendRequestResult> Function(String)>((ref) {
  final repository = ref.watch(friendsRepositoryProvider);
  return (String requesterId) async {
    final result = await repository.rejectFriendRequest(requesterId);

    // Invalidate pending requests
    ref.invalidate(pendingRequestsProvider);

    return result;
  };
});

// Remove friend action
final removeFriendProvider =
    Provider<Future<FriendRequestResult> Function(String)>((ref) {
  final repository = ref.watch(friendsRepositoryProvider);
  return (String friendId) async {
    final result = await repository.removeFriend(friendId);

    // Invalidate friends list
    ref.invalidate(friendsListProvider);

    return result;
  };
});

// Block user action
final blockUserProvider =
    Provider<Future<FriendRequestResult> Function(String)>((ref) {
  final repository = ref.watch(friendsRepositoryProvider);
  return (String targetUserId) async {
    final result = await repository.blockUser(targetUserId);

    // Invalidate all lists
    ref.invalidate(friendsListProvider);
    ref.invalidate(friendSearchResultsProvider);

    return result;
  };
});
