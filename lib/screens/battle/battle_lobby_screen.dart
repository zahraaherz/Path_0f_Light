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
              l10n: l10n,
              title: l10n.quickMatch,
              description: l10n.quickMatchDesc,
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
              l10n: l10n,
              title: l10n.friendChallenge,
              description: l10n.friendChallengeDesc,
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
              l10n: l10n,
              title: l10n.tournament,
              description: l10n.tournamentDesc,
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
    final l10n = AppLocalizations.of(context)!;
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
                l10n.yourBattleStats,
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
              _buildStatItem(context, r, l10n.battles, '${stats.totalBattles}'),
              _buildStatItem(context, r, l10n.wins, '${stats.wins}'),
              _buildStatItem(context, r, l10n.winRate, '$winRate%'),
              _buildStatItem(context, r, l10n.streak, '${stats.winStreak}'),
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
    final l10n = AppLocalizations.of(context)!;
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
          l10n.challengedYouByUser(userName: invitation.fromUserName),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          l10n.challengeDetails(count: invitation.config.questionCount, difficulty: invitation.config.difficulty ?? l10n.all),
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
                      SnackBar(content: Text(l10n.challengeAccepted)),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.errorMessage(error: e.toString()))),
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
                      SnackBar(content: Text(l10n.challengeRejected)),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.errorMessage(error: e.toString()))),
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
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      child: ListTile(
        leading: const Icon(Icons.sports_esports, color: AppTheme.primaryTeal),
        title: Text(
          l10n.battleVersus(opponentName: battle.player2?.displayName ?? l10n.waiting),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          battle.status.displayName,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to battle
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.navigatingToBattle)),
          );
        },
      ),
    );
  }

  Widget _buildBattleModeCard({
    required BuildContext context,
    required Responsive r,
    required AppLocalizations l10n,
    required String title,
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
                        l10n.energyCost(cost: energyCost),
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
    final l10n = AppLocalizations.of(context)!;
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
                l10n.howToPlay,
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
            l10n.battleStep1Title,
            l10n.battleStep1Desc,
          ),
          _buildHowToPlayItem(
            context,
            r,
            '2',
            l10n.battleStep2Title,
            l10n.battleStep2Desc,
          ),
          _buildHowToPlayItem(
            context,
            r,
            '3',
            l10n.battleStep3Title,
            l10n.battleStep3Desc,
          ),
          _buildHowToPlayItem(
            context,
            r,
            '4',
            l10n.battleStep4Title,
            l10n.battleStep4Desc,
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
