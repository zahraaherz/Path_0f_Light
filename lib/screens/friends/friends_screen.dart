import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../models/friends/friend_models.dart';
import '../../providers/friends_providers.dart';
import '../../providers/auth_providers.dart';
import '../auth/login_screen.dart';
import '../../utils/responsive.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    final authUser = ref.watch(currentAuthUserProvider);

    // Require authentication for friends feature
    if (authUser == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            l10n.friends,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: AppTheme.primaryTeal,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(r.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: r.iconLarge * 2.5,
                  color: AppTheme.textSecondary.withValues(alpha: 0.5),
                ),
                SizedBox(height: r.spaceLarge),
                Text(
                  l10n.signInToConnectFriends,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: r.spaceSmall),
                Text(
                  l10n.buildYourLearningCommunity,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: r.spaceXLarge),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.login),
                  label: Text(l10n.signIn),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                    padding: EdgeInsets.symmetric(horizontal: r.paddingXLarge, vertical: r.paddingMedium),
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
          l10n.friends,
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
          unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
          tabs: [
            Tab(text: l10n.friends, icon: const Icon(Icons.people)),
            Tab(text: l10n.requests, icon: const Icon(Icons.person_add)),
            Tab(text: l10n.search, icon: const Icon(Icons.search)),
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
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
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
                  size: r.iconLarge * 2,
                  color: AppTheme.textSecondary.withValues(alpha: 0.5),
                ),
                SizedBox(height: r.spaceMedium),
                Text(
                  l10n.noFriendsYet,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
                SizedBox(height: r.spaceSmall),
                Text(
                  l10n.searchForUsersToAdd,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary.withValues(alpha: 0.7),
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
            padding: EdgeInsets.all(r.paddingMedium),
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return _FriendCard(friend: friends[index]);
            },
          ),
        );
      },
      loading: () => const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryTeal),
          ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: r.iconLarge * 1.5, color: AppTheme.error),
            SizedBox(height: r.spaceMedium),
            Text(
              l10n.failedToLoadFriends,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            SizedBox(height: r.spaceSmall),
            ElevatedButton(
              onPressed: () => ref.invalidate(friendsListProvider),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryTeal),
              child: Text(l10n.retry),
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
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
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
                Icon(Icons.inbox, size: r.iconLarge * 2, color: AppTheme.textSecondary.withValues(alpha: 0.5)),
                SizedBox(height: r.spaceMedium),
                Text(
                  l10n.noPendingRequests,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
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
            padding: EdgeInsets.all(r.paddingMedium),
            children: [
              if (received.isNotEmpty) ...[
                Text(
                  l10n.receivedRequests,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: r.spaceSmall),
                ...received.map((friend) => _FriendRequestCard(
                      friend: friend,
                      isReceived: true,
                    )),
                SizedBox(height: r.spaceLarge),
              ],
              if (sent.isNotEmpty) ...[
                Text(
                  l10n.sentRequests,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: r.spaceSmall),
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
            Icon(Icons.error_outline, size: r.iconLarge * 1.5, color: AppTheme.error),
            SizedBox(height: r.spaceMedium),
            Text(l10n.failedToLoadRequests, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textSecondary,
                )),
            SizedBox(height: r.spaceSmall),
            ElevatedButton(
              onPressed: () => ref.invalidate(pendingRequestsProvider),
              child: Text(l10n.retry),
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
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    final searchQuery = ref.watch(friendSearchQueryProvider);
    final resultsAsync = ref.watch(friendSearchResultsProvider);

    return Column(
      children: [
        // Search input
        Padding(
          padding: EdgeInsets.all(r.paddingMedium),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchByUsernameOrCode,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(r.radiusMedium),
                borderSide: BorderSide(color: AppTheme.primaryTeal.withOpacity(0.3)),
              ),
              filled: true,
              fillColor: AppTheme.primaryTeal.withOpacity(0.05),
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
                      Icon(Icons.search, size: r.iconLarge * 2, color: AppTheme.textSecondary.withValues(alpha: 0.5)),
                      SizedBox(height: r.spaceMedium),
                      Text(
                        l10n.search,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                      SizedBox(height: r.spaceSmall),
                      Text(
                        l10n.enterUsernameOrCode,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary.withValues(alpha: 0.7),
                            ),
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
                            Icon(Icons.search_off, size: r.iconLarge * 2, color: AppTheme.textSecondary.withValues(alpha: 0.5)),
                            SizedBox(height: r.spaceMedium),
                            Text(
                              l10n.noUsersFound,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(r.paddingMedium),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return _UserSearchResultCard(user: results[index]);
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text(
                      '${l10n.error}: ${error.toString()}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

// Border-based Friend Card (matching explore page pattern)
class _FriendCard extends ConsumerWidget {
  final Friend friend;

  const _FriendCard({required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spaceSmall),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Row(
          children: [
            // Avatar
            Container(
              width: r.iconLarge * 1.75,
              height: r.iconLarge * 1.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3), width: 1),
              ),
              child: ClipOval(
                child: friend.friendPhotoURL != null
                    ? CachedNetworkImage(
                        imageUrl: friend.friendPhotoURL!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Container(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              (friend.friendUsername ?? 'U')[0].toUpperCase(),
                              style: TextStyle(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: r.fontLarge,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: AppTheme.primaryTeal.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            (friend.friendUsername ?? 'U')[0].toUpperCase(),
                            style: TextStyle(
                              color: AppTheme.primaryTeal,
                              fontWeight: FontWeight.bold,
                              fontSize: r.fontLarge,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(width: r.spaceSmall),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.displayText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (friend.friendTotalPoints != null) ...[
                    SizedBox(height: r.spaceXSmall),
                    Row(
                      children: [
                        Icon(Icons.star, size: r.fontSmall, color: Colors.amber),
                        SizedBox(width: r.spaceXSmall),
                        Text('${friend.friendTotalPoints} ${l10n.points.toLowerCase()}'),
                        SizedBox(width: r.spaceSmall),
                        Icon(Icons.menu_book, size: r.fontSmall, color: Colors.blue),
                        SizedBox(width: r.spaceXSmall),
                        Text('${friend.friendBooksRead ?? 0} ${l10n.books.toLowerCase()}'),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Menu
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'remove',
                  child: Row(
                    children: [
                      const Icon(Icons.person_remove, color: Colors.red),
                      SizedBox(width: r.spaceSmall),
                      Text(l10n.removeFriend, style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'block',
                  child: Row(
                    children: [
                      const Icon(Icons.block, color: Colors.red),
                      SizedBox(width: r.spaceSmall),
                      Text(l10n.blocked, style: const TextStyle(color: Colors.red)),
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
          ],
        ),
      ),
    );
  }
}

// Border-based Friend Request Card (matching explore page pattern)
class _FriendRequestCard extends ConsumerWidget {
  final Friend friend;
  final bool isReceived;

  const _FriendRequestCard({
    required this.friend,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spaceSmall),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Row(
          children: [
            // Avatar
            Container(
              width: r.iconLarge * 1.75,
              height: r.iconLarge * 1.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3), width: 1),
              ),
              child: ClipOval(
                child: friend.friendPhotoURL != null
                    ? CachedNetworkImage(
                        imageUrl: friend.friendPhotoURL!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Container(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              (friend.friendUsername ?? 'U')[0].toUpperCase(),
                              style: TextStyle(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: r.fontLarge,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: AppTheme.primaryTeal.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            (friend.friendUsername ?? 'U')[0].toUpperCase(),
                            style: TextStyle(
                              color: AppTheme.primaryTeal,
                              fontWeight: FontWeight.bold,
                              fontSize: r.fontLarge,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(width: r.spaceSmall),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.displayText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isReceived ? l10n.wantsToBeYourFriend : l10n.requestSent,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),

            // Actions
            if (isReceived)
              Row(
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
                            backgroundColor: result.success ? Colors.green : Colors.red,
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
            else
              const Icon(Icons.schedule, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

// Border-based User Search Result Card (matching explore page pattern)
class _UserSearchResultCard extends ConsumerWidget {
  final UserSearchResult user;

  const _UserSearchResultCard({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spaceSmall),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Row(
          children: [
            // Avatar
            Container(
              width: r.iconLarge * 1.75,
              height: r.iconLarge * 1.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3), width: 1),
              ),
              child: ClipOval(
                child: user.photoURL != null
                    ? CachedNetworkImage(
                        imageUrl: user.photoURL!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Container(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              user.username[0].toUpperCase(),
                              style: TextStyle(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: r.fontLarge,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: AppTheme.primaryTeal.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            user.username[0].toUpperCase(),
                            style: TextStyle(
                              color: AppTheme.primaryTeal,
                              fontWeight: FontWeight.bold,
                              fontSize: r.fontLarge,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(width: r.spaceSmall),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName ?? user.username,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${user.username}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  if (user.userCode != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${l10n.code}: ${user.userCode}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ],
              ),
            ),

            // Action button
            _buildActionButton(context, ref, l10n, r),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref, AppLocalizations l10n, dynamic r) {
    if (user.isBlocked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          border: Border.all(color: Colors.red.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          l10n.blocked,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    }

    if (user.isFriend) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          border: Border.all(color: Colors.green.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          l10n.friends,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    }

    if (user.hasPendingRequest) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          l10n.pending,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    }

    return OutlinedButton(
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
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppTheme.primaryTeal, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(l10n.add),
    );
  }
}
