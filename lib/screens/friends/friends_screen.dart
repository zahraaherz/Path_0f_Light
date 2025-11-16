import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme/app_theme.dart';
import '../../models/friends/friend_models.dart';
import '../../providers/friends_providers.dart';
import '../../providers/auth_providers.dart';
import '../auth/login_screen.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(currentAuthUserProvider);

    // Require authentication for friends feature
    if (authUser == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Friends',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: AppTheme.primaryTeal,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 80,
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 24),
                Text(
                  'Sign in to connect with friends',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Search for friends, send requests, and build your learning community',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Friends',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: AppTheme.primaryTeal,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Friends', icon: Icon(Icons.people)),
            Tab(text: 'Requests', icon: Icon(Icons.person_add)),
            Tab(text: 'Search', icon: Icon(Icons.search)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _FriendsListTab(),
          _PendingRequestsTab(),
          _SearchTab(),
        ],
      ),
    );
  }
}

// Friends List Tab
class _FriendsListTab extends ConsumerWidget {
  const _FriendsListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsListProvider);

    return friendsAsync.when(
      data: (friends) {
        if (friends.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 64,
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No friends yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Search for users to add as friends',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(friendsListProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return _FriendCard(friend: friends[index]);
            },
          ),
        );
      },
      loading: () => Center(
            child: CircularProgressIndicator(color: AppTheme.primaryTeal),
          ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
            const SizedBox(height: 16),
            Text(
              'Failed to load friends',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.invalidate(friendsListProvider),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryTeal),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pending Requests Tab
class _PendingRequestsTab extends ConsumerWidget {
  const _PendingRequestsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingRequestsProvider);

    return requestsAsync.when(
      data: (requests) {
        final received = requests['received'] ?? [];
        final sent = requests['sent'] ?? [];

        if (received.isEmpty && sent.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No pending requests',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(pendingRequestsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (received.isNotEmpty) ...[
                const Text(
                  'Received Requests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...received.map((friend) => _FriendRequestCard(
                      friend: friend,
                      isReceived: true,
                    )),
                const SizedBox(height: 24),
              ],
              if (sent.isNotEmpty) ...[
                const Text(
                  'Sent Requests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...sent.map((friend) => _FriendRequestCard(
                      friend: friend,
                      isReceived: false,
                    )),
              ],
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Failed to load requests', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.invalidate(pendingRequestsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// Search Tab
class _SearchTab extends ConsumerStatefulWidget {
  const _SearchTab();

  @override
  ConsumerState<_SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<_SearchTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(friendSearchQueryProvider);
    final resultsAsync = ref.watch(friendSearchResultsProvider);

    return Column(
      children: [
        // Search input
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by username or user code...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(friendSearchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onChanged: (value) {
              ref.read(friendSearchQueryProvider.notifier).state = value;
            },
          ),
        ),

        // Search results
        Expanded(
          child: searchQuery.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Search for friends',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter a username or user code',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
              : resultsAsync.when(
                  data: (results) {
                    if (results.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No users found',
                              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return _UserSearchResultCard(user: results[index]);
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text(
                      'Search failed: ${error.toString()}',
                      style: TextStyle(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

// Friend Card
class _FriendCard extends ConsumerWidget {
  final Friend friend;

  const _FriendCard({required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: friend.friendPhotoURL != null
              ? CachedNetworkImageProvider(friend.friendPhotoURL!)
              : null,
          backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
          child: friend.friendPhotoURL == null
              ? Text(
                  (friend.friendUsername ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : null,
        ),
        title: Text(
          friend.displayText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (friend.friendTotalPoints != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('${friend.friendTotalPoints} points'),
                  const SizedBox(width: 12),
                  const Icon(Icons.menu_book, size: 14, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text('${friend.friendBooksRead ?? 0} books'),
                ],
              ),
            ],
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.person_remove, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Remove Friend', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'block',
              child: Row(
                children: [
                  Icon(Icons.block, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Block', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) async {
            if (value == 'remove') {
              final removeFriend = ref.read(removeFriendProvider);
              final result = await removeFriend(friend.friendId);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.message),
                    backgroundColor: result.success ? AppTheme.success : AppTheme.error,
                  ),
                );
              }
            } else if (value == 'block') {
              final blockUser = ref.read(blockUserProvider);
              final result = await blockUser(friend.friendId);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.message),
                    backgroundColor: result.success ? AppTheme.success : AppTheme.error,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

// Friend Request Card
class _FriendRequestCard extends ConsumerWidget {
  final Friend friend;
  final bool isReceived;

  const _FriendRequestCard({
    required this.friend,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: friend.friendPhotoURL != null
              ? CachedNetworkImageProvider(friend.friendPhotoURL!)
              : null,
          backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
          child: friend.friendPhotoURL == null
              ? Text(
                  (friend.friendUsername ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : null,
        ),
        title: Text(
          friend.displayText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(isReceived ? 'Wants to be your friend' : 'Request sent'),
        trailing: isReceived
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () async {
                      final accept = ref.read(acceptFriendRequestProvider);
                      final result = await accept(friend.friendId);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result.message),
                            backgroundColor:
                                result.success ? Colors.green : Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () async {
                      final reject = ref.read(rejectFriendRequestProvider);
                      final result = await reject(friend.friendId);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message)),
                        );
                      }
                    },
                  ),
                ],
              )
            : const Icon(Icons.schedule, color: Colors.orange),
      ),
    );
  }
}

// User Search Result Card
class _UserSearchResultCard extends ConsumerWidget {
  final UserSearchResult user;

  const _UserSearchResultCard({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage:
              user.photoURL != null ? CachedNetworkImageProvider(user.photoURL!) : null,
          backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
          child: user.photoURL == null
              ? Text(
                  user.username[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : null,
        ),
        title: Text(
          user.displayName ?? user.username,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('@${user.username}'),
            if (user.userCode != null) ...[
              const SizedBox(height: 2),
              Text(
                'Code: ${user.userCode}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
        trailing: _buildActionButton(context, ref),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref) {
    if (user.isBlocked) {
      return const Chip(
        label: Text('Blocked', style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.red,
        labelStyle: TextStyle(color: Colors.white),
      );
    }

    if (user.isFriend) {
      return const Chip(
        label: Text('Friends', style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.green,
        labelStyle: TextStyle(color: Colors.white),
      );
    }

    if (user.hasPendingRequest) {
      return const Chip(
        label: Text('Pending', style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.orange,
        labelStyle: TextStyle(color: Colors.white),
      );
    }

    return ElevatedButton(
      onPressed: () async {
        final sendRequest = ref.read(sendFriendRequestProvider);
        final result = await sendRequest(user.uid);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.message),
              backgroundColor: result.success ? Colors.green : Colors.red,
            ),
          );
        }
      },
      child: const Text('Add'),
    );
  }
}
