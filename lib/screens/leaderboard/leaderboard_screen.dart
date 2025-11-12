import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme/app_theme.dart';
import '../../models/leaderboard/leaderboard_entry.dart';
import '../../providers/leaderboard_providers.dart';
import '../../providers/auth_providers.dart';
import 'user_comparison_screen.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Update selected leaderboard type when tab changes
        final types = [
          LeaderboardType.points,
          LeaderboardType.streak,
          LeaderboardType.accuracy,
          LeaderboardType.questions,
        ];
        ref.read(selectedLeaderboardTypeProvider.notifier).state =
            types[_tabController.index];
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(currentUserIdProvider);
    final leaderboardAsync = ref.watch(currentLeaderboardProvider);
    final userRankAsync = ref.watch(userRankByPointsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Leaderboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryTeal, AppTheme.islamicGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Icon(
                      Icons.emoji_events,
                      size: 64,
                      color: AppTheme.goldAccent,
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppTheme.goldAccent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: 'Points'),
                Tab(text: 'Streak'),
                Tab(text: 'Accuracy'),
                Tab(text: 'Questions'),
              ],
            ),
          ),

          // User's Rank Card
          if (currentUserId != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: userRankAsync.when(
                  data: (rank) => _buildUserRankCard(rank),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ),

          // Leaderboard List
          leaderboardAsync.when(
            data: (entries) {
              if (entries.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No data available'),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final entry = entries[index];
                    final isCurrentUser = entry.uid == currentUserId;

                    return _buildLeaderboardEntry(
                      entry,
                      isCurrentUser,
                    );
                  },
                  childCount: entries.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: AppTheme.error),
                    const SizedBox(height: 16),
                    Text('Error loading leaderboard',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(error.toString(),
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(currentLeaderboardProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRankCard(int rank) {
    return Card(
      elevation: 4,
      color: AppTheme.primaryTeal.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.primaryTeal, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Rank',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  rank == -1 ? 'Unranked' : '#$rank',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryTeal,
                      ),
                ),
              ],
            ),
            Icon(
              rank <= 10
                  ? Icons.emoji_events
                  : rank <= 50
                      ? Icons.workspace_premium
                      : Icons.military_tech,
              size: 48,
              color: rank <= 10
                  ? AppTheme.goldAccent
                  : rank <= 50
                      ? AppTheme.primaryTeal
                      : AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardEntry(LeaderboardEntry entry, bool isCurrentUser) {
    final selectedType = ref.watch(selectedLeaderboardTypeProvider);

    // Determine the value to display based on leaderboard type
    String valueText;
    IconData valueIcon;
    Color valueColor;

    switch (selectedType) {
      case LeaderboardType.points:
        valueText = '${entry.points}';
        valueIcon = Icons.stars;
        valueColor = AppTheme.goldAccent;
        break;
      case LeaderboardType.streak:
        valueText = '${entry.currentStreak}';
        valueIcon = Icons.local_fire_department;
        valueColor = AppTheme.error;
        break;
      case LeaderboardType.accuracy:
        valueText = '${entry.accuracy.toStringAsFixed(1)}%';
        valueIcon = Icons.check_circle;
        valueColor = AppTheme.success;
        break;
      case LeaderboardType.questions:
        valueText = '${entry.totalQuestionsAnswered}';
        valueIcon = Icons.quiz;
        valueColor = AppTheme.info;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppTheme.primaryTeal.withOpacity(0.1)
            : Colors.transparent,
        border: isCurrentUser
            ? Border.all(color: AppTheme.primaryTeal, width: 2)
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Rank
            SizedBox(
              width: 40,
              child: Center(
                child: entry.rank <= 3
                    ? Icon(
                        Icons.emoji_events,
                        size: 32,
                        color: entry.rank == 1
                            ? AppTheme.goldAccent
                            : entry.rank == 2
                                ? Colors.grey[400]
                                : Colors.brown[300],
                      )
                    : Text(
                        '${entry.rank}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textSecondary,
                            ),
                      ),
              ),
            ),
            const SizedBox(width: 8),

            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.primaryTeal.withOpacity(0.2),
              backgroundImage: entry.photoURL != null
                  ? CachedNetworkImageProvider(entry.photoURL!)
                  : null,
              child: entry.photoURL == null
                  ? Text(
                      entry.displayName[0].toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryTeal,
                      ),
                    )
                  : null,
            ),
          ],
        ),
        title: Text(
          entry.displayName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          '${entry.totalQuestionsAnswered} questions • ${entry.accuracy.toStringAsFixed(1)}% accuracy',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(valueIcon, color: valueColor, size: 20),
            const SizedBox(width: 4),
            Text(
              valueText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to user comparison or profile
          final currentUserId = ref.read(currentUserIdProvider);
          if (currentUserId != null && entry.uid != currentUserId) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => UserComparisonScreen(
                  userId1: currentUserId,
                  userId2: entry.uid,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
