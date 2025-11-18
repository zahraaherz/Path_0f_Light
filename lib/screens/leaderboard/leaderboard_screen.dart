import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/theme/app_theme.dart';
import '../../models/leaderboard/leaderboard_entry.dart';
import '../../providers/leaderboard_providers.dart';
import '../../providers/auth_providers.dart';
import '../../l10n/app_localizations.dart';
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
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final currentUserId = ref.watch(currentUserIdProvider);
    final leaderboardAsync = ref.watch(currentLeaderboardProvider);
    final userRankAsync = ref.watch(userRankByPointsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: r.constrainWidth(
          child: CustomScrollView(
            slivers: [
              // Header with border (matching explore page)
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppTheme.primaryTeal.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(r.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.leaderboard,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: r.spaceSmall),
                        Text(
                          l10n.competeFriends,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Tab selector (border-based)
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(r.paddingMedium),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.primaryTeal.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(r.radiusMedium),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: AppTheme.primaryTeal,
                    indicatorWeight: 3,
                    labelColor: AppTheme.primaryTeal,
                    unselectedLabelColor: AppTheme.textSecondary,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: l10n.points),
                      Tab(text: l10n.streak),
                      Tab(text: l10n.accuracy),
                      Tab(text: l10n.questions),
                    ],
                  ),
                ),
              ),

              // User's Rank Card (border-based)
              if (currentUserId != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                    child: userRankAsync.when(
                      data: (rank) => _buildUserRankCard(rank, l10n),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Leaderboard List
              leaderboardAsync.when(
                data: (entries) {
                  if (entries.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(r.paddingLarge),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: r.iconLarge * 2,
                                color: AppTheme.textSecondary.withOpacity(0.5),
                              ),
                              SizedBox(height: r.spaceMedium),
                              Text(
                                l10n.noLeadersYet,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                              ),
                              SizedBox(height: r.spaceSmall),
                              Text(
                                l10n.startQuizToCompete,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.textSecondary.withOpacity(0.7),
                                    ),
                              ),
                            ],
                          ),
                        ),
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
                          l10n,
                        );
                      },
                      childCount: entries.length,
                    ),
                  );
                },
                loading: () => SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(r.paddingXLarge),
                      child: const CircularProgressIndicator(
                        color: AppTheme.primaryTeal,
                      ),
                    ),
                  ),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(r.paddingLarge),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: r.iconLarge * 1.5,
                            color: AppTheme.error,
                          ),
                          SizedBox(height: r.spaceMedium),
                          Text(
                            l10n.failedLoadLeaderboard,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                          SizedBox(height: r.spaceSmall),
                          ElevatedButton(
                            onPressed: () => ref.invalidate(currentLeaderboardProvider),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryTeal,
                            ),
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Invite Friends Section (border-based)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(r.paddingMedium),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.goldAccent.withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(r.radiusMedium),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(r.paddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(r.paddingSmall),
                                decoration: BoxDecoration(
                                  color: AppTheme.goldAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(r.radiusSmall),
                                ),
                                child: Icon(
                                  Icons.card_giftcard,
                                  color: AppTheme.goldAccent,
                                  size: r.iconMedium,
                                ),
                              ),
                              SizedBox(width: r.spaceSmall),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.inviteFriends,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.primaryTeal,
                                          ),
                                    ),
                                    SizedBox(height: r.spaceXSmall),
                                    Text(
                                      l10n.inviteFriendsGetEnergy,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppTheme.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: r.spaceMedium),
                          Container(
                            height: 1,
                            color: AppTheme.primaryTeal.withOpacity(0.1),
                          ),
                          SizedBox(height: r.spaceMedium),
                          Row(
                            children: [
                              Icon(
                                Icons.bolt,
                                color: AppTheme.goldAccent,
                                size: r.iconSmall,
                              ),
                              SizedBox(width: r.spaceXSmall),
                              Text(
                                l10n.energyPerInvite,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: r.spaceSmall),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: AppTheme.primaryTeal,
                                size: r.iconSmall,
                              ),
                              SizedBox(width: r.spaceXSmall),
                              Text(
                                l10n.buildLearningCommunity,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: r.spaceMedium),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () => _showInviteDialog(context, l10n, r),
                              icon: const Icon(Icons.share),
                              label: Text(l10n.shareInviteLink),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppTheme.primaryTeal,
                                  width: 1.5,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: r.paddingMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserRankCard(int rank, AppLocalizations l10n) {
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
        color: AppTheme.primaryTeal.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.yourRank,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                rank == -1 ? l10n.unranked : '#$rank',
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
    );
  }

  Widget _buildLeaderboardEntry(
    LeaderboardEntry entry,
    bool isCurrentUser,
    AppLocalizations l10n,
  ) {
    final r = context.responsive;
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
      margin: EdgeInsets.symmetric(
        horizontal: r.paddingMedium,
        vertical: r.spaceXSmall,
      ),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppTheme.primaryTeal.withOpacity(0.05)
            : Colors.transparent,
        border: Border.all(
          color: isCurrentUser
              ? AppTheme.primaryTeal.withOpacity(0.3)
              : AppTheme.primaryTeal.withOpacity(0.1),
          width: isCurrentUser ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
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
            SizedBox(width: r.spaceSmall),

            // Avatar
            Container(
              width: r.iconLarge * 1.5,
              height: r.iconLarge * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryTeal.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: entry.photoURL != null
                    ? CachedNetworkImage(
                        imageUrl: entry.photoURL!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              entry.displayName[0].toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryTeal,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              entry.displayName[0].toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryTeal,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: AppTheme.primaryTeal.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            entry.displayName[0].toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryTeal,
                            ),
                          ),
                        ),
                      ),
              ),
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
          '${entry.totalQuestionsAnswered} ${l10n.questions.toLowerCase()} • ${entry.accuracy.toStringAsFixed(1)}% ${l10n.accuracy.toLowerCase()}',
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

  void _showInviteDialog(BuildContext context, AppLocalizations l10n, dynamic r) {
    final currentUser = ref.read(currentAuthUserProvider);
    final inviteCode = currentUser?.uid.substring(0, 8).toUpperCase() ?? 'INVITE';
    final inviteLink = 'https://pathoflight.app/invite/$inviteCode';
    final shareText = l10n.inviteMessage(inviteLink);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.card_giftcard, color: AppTheme.goldAccent),
            SizedBox(width: r.spaceSmall),
            Text(l10n.inviteFriends),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.shareInviteDesc),
            SizedBox(height: r.spaceMedium),
            Container(
              padding: EdgeInsets.all(r.paddingMedium),
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal.withOpacity(0.05),
                border: Border.all(
                  color: AppTheme.primaryTeal.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(r.radiusSmall),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      inviteCode,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryTeal,
                            letterSpacing: 2,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: inviteCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.copiedToClipboard),
                          backgroundColor: AppTheme.success,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    color: AppTheme.primaryTeal,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              Share.share(
                shareText,
                subject: l10n.joinPathOfLight,
              );
            },
            icon: const Icon(Icons.share),
            label: Text(l10n.share),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryTeal,
            ),
          ),
        ],
      ),
    );
  }
}
