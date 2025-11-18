import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../models/battle/battle_models.dart';
import '../../providers/battle_providers.dart';
import '../../providers/energy_providers.dart';
import '../../widgets/energy_display.dart';
import '../../l10n/app_localizations.dart';
import 'matchmaking_screen.dart';
import 'friend_challenge_screen.dart';
import 'tournament_list_screen.dart';
import 'battle_history_screen.dart';

class BattleLobbyScreen extends ConsumerWidget {
  const BattleLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final battleStatsAsync = ref.watch(battleStatsProvider);
    final activeBattlesAsync = ref.watch(activeBattlesProvider);
    final pendingInvitationsAsync = ref.watch(pendingInvitationsProvider);
    final energyStatus = ref.watch(energyStatusProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.sports_esports, color: AppTheme.primaryTeal),
            SizedBox(width: r.spaceSmall),
            Text(l10n.battleArena ?? 'Battle Arena'),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: AppTheme.primaryTeal),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BattleHistoryScreen(),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: EnergyDisplay(showLabel: false),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Battle Stats Card
            battleStatsAsync.when(
              data: (stats) => _buildStatsCard(context, r, stats),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox(),
            ),

            SizedBox(height: r.spaceLarge),

            // Pending Invitations
            pendingInvitationsAsync.when(
              data: (invitations) {
                if (invitations.isEmpty) return const SizedBox();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.pendingChallenges ?? 'Pending Challenges',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: r.spaceMedium),
                    ...invitations.map((invitation) =>
                        _buildInvitationCard(context, r, ref, invitation)),
                    SizedBox(height: r.spaceLarge),
                  ],
                );
              },
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),

            // Active Battles
            activeBattlesAsync.when(
              data: (battles) {
                if (battles.isEmpty) return const SizedBox();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.activeBattles ?? 'Active Battles',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: r.spaceMedium),
                    ...battles.map((battle) =>
                        _buildActiveBattleCard(context, r, battle)),
                    SizedBox(height: r.spaceLarge),
                  ],
                );
              },
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),

            // Battle Mode Selection
            Text(
              l10n.chooseBattleMode ?? 'Choose Battle Mode',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: r.spaceMedium),

            // Quick Match
            _buildBattleModeCard(
              context: context,
              r: r,
              title: l10n.quickMatch ?? 'Quick Match',
              titleAr: 'مباراة سريعة',
              description:
                  l10n.quickMatchDesc ?? 'Random opponent, start immediately',
              icon: Icons.flash_on,
              color: AppTheme.primaryTeal,
              energyCost: 5,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MatchmakingScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: r.spaceMedium),

            // Friend Challenge
            _buildBattleModeCard(
              context: context,
              r: r,
              title: l10n.friendChallenge ?? 'Friend Challenge',
              titleAr: 'تحدي صديق',
              description:
                  l10n.friendChallengeDesc ?? 'Challenge a specific friend',
              icon: Icons.people,
              color: AppTheme.islamicGreen,
              energyCost: 5,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FriendChallengeScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: r.spaceMedium),

            // Tournament
            _buildBattleModeCard(
              context: context,
              r: r,
              title: l10n.tournament ?? 'Tournament',
              titleAr: 'بطولة',
              description:
                  l10n.tournamentDesc ?? 'Compete in brackets for prizes',
              icon: Icons.emoji_events,
              color: AppTheme.accentGold,
              energyCost: 10,
              isPremium: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TournamentListScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: r.spaceLarge),

            // How to Play
            _buildHowToPlayCard(context, r),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, Responsive r, BattleStats stats) {
    final winRate = stats.totalBattles > 0
        ? (stats.wins / stats.totalBattles * 100).toStringAsFixed(1)
        : '0.0';

    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryTeal,
            AppTheme.primaryTeal.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryTeal.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Battle Stats',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.paddingMedium,
                  vertical: r.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(r.radiusSmall),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppTheme.accentGold, size: 20),
                    SizedBox(width: r.spaceSmall),
                    Text(
                      '${stats.rating}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: r.spaceMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(context, r, 'Battles', '${stats.totalBattles}'),
              _buildStatItem(context, r, 'Wins', '${stats.wins}'),
              _buildStatItem(context, r, 'Win Rate', '$winRate%'),
              _buildStatItem(context, r, 'Streak', '${stats.winStreak}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, Responsive r, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: r.spaceSmall),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildInvitationCard(BuildContext context, Responsive r,
      WidgetRef ref, BattleInvitation invitation) {
    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: invitation.fromUserPhoto != null
              ? NetworkImage(invitation.fromUserPhoto!)
              : null,
          child: invitation.fromUserPhoto == null
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(
          '${invitation.fromUserName} challenged you!',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${invitation.config.questionCount} questions • ${invitation.config.difficulty ?? "Mixed"} difficulty',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () async {
                try {
                  final battleId = await ref
                      .read(battleRepositoryProvider)
                      .acceptBattleChallenge(invitation.id);
                  if (context.mounted) {
                    // Navigate to battle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Challenge accepted!')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () async {
                try {
                  await ref
                      .read(battleRepositoryProvider)
                      .rejectBattleChallenge(invitation.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Challenge rejected')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
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

  Widget _buildActiveBattleCard(
      BuildContext context, Responsive r, Battle battle) {
    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      child: ListTile(
        leading: const Icon(Icons.sports_esports, color: AppTheme.primaryTeal),
        title: Text(
          'Battle vs ${battle.player2?.displayName ?? "Waiting..."}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          battle.status.displayName,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to battle
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigating to battle...')),
          );
        },
      ),
    );
  }

  Widget _buildBattleModeCard({
    required BuildContext context,
    required Responsive r,
    required String title,
    required String titleAr,
    required String description,
    required IconData icon,
    required Color color,
    required int energyCost,
    bool isPremium = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.radiusMedium),
      child: Container(
        padding: EdgeInsets.all(r.paddingLarge),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(r.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(r.paddingMedium),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(r.radiusSmall),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            SizedBox(width: r.spaceMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                      ),
                      if (isPremium) ...[
                        SizedBox(width: r.spaceSmall),
                        Icon(
                          Icons.workspace_premium,
                          color: AppTheme.accentGold,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                  Text(
                    titleAr,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  SizedBox(height: r.spaceSmall),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  SizedBox(height: r.spaceSmall),
                  Row(
                    children: [
                      Icon(Icons.bolt, color: color, size: 16),
                      SizedBox(width: r.spaceSmall),
                      Text(
                        '$energyCost Energy',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToPlayCard(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.islamicGreen.withOpacity(0.05),
        border: Border.all(
          color: AppTheme.islamicGreen.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: AppTheme.islamicGreen),
              SizedBox(width: r.spaceSmall),
              Text(
                'How to Play',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.islamicGreen,
                    ),
              ),
            ],
          ),
          SizedBox(height: r.spaceMedium),
          _buildHowToPlayItem(
            context,
            r,
            '1',
            'Choose a battle mode',
            'Quick match, friend challenge, or tournament',
          ),
          _buildHowToPlayItem(
            context,
            r,
            '2',
            'Answer questions',
            'Race against your opponent to answer correctly',
          ),
          _buildHowToPlayItem(
            context,
            r,
            '3',
            'Earn points',
            'Higher difficulty = more points. Build streaks for bonuses!',
          ),
          _buildHowToPlayItem(
            context,
            r,
            '4',
            'Win the battle',
            'Highest score wins. Draw if tied!',
          ),
        ],
      ),
    );
  }

  Widget _buildHowToPlayItem(
    BuildContext context,
    Responsive r,
    String number,
    String title,
    String description,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.spaceMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.islamicGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: r.spaceMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
