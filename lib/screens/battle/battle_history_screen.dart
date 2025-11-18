import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../providers/battle_providers.dart';
import '../../l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class BattleHistoryScreen extends ConsumerWidget {
  const BattleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final historyAsync = ref.watch(battleHistoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(l10n.battleHistory ?? 'Battle History'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: historyAsync.when(
        data: (history) {
          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: r.spaceMedium),
                  Text(
                    l10n.noBattlesYet ?? 'No battles yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: r.spaceSmall),
                  Text(
                    l10n.startBattleToSeeHistory ?? 'Start a battle to see your history',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(r.paddingMedium),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final battle = history[index];
              return Card(
                margin: EdgeInsets.only(bottom: r.spaceMedium),
                child: Padding(
                  padding: EdgeInsets.all(r.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: battle.opponentPhoto != null
                                ? NetworkImage(battle.opponentPhoto!)
                                : null,
                            child: battle.opponentPhoto == null
                                ? const Icon(Icons.person)
                                : null,
                          ),
                          SizedBox(width: r.spaceMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'vs ${battle.opponentName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  DateFormat('MMM dd, yyyy • HH:mm')
                                      .format(battle.completedAt),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // Result badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: r.paddingMedium,
                              vertical: r.paddingSmall,
                            ),
                            decoration: BoxDecoration(
                              color: battle.isWinner
                                  ? AppTheme.primaryTeal.withOpacity(0.1)
                                  : Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(r.radiusSmall),
                            ),
                            child: Text(
                              battle.isWinner
                                  ? (l10n.won ?? 'Won')
                                  : (l10n.lost ?? 'Lost'),
                              style: TextStyle(
                                color: battle.isWinner
                                    ? AppTheme.primaryTeal
                                    : AppTheme.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: r.spaceMedium),

                      // Score
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildScoreItem(
                            context,
                            r,
                            'You',
                            battle.myScore,
                            battle.isWinner,
                          ),
                          Text(
                            '-',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey[400],
                            ),
                          ),
                          _buildScoreItem(
                            context,
                            r,
                            battle.opponentName,
                            battle.opponentScore,
                            !battle.isWinner,
                          ),
                        ],
                      ),

                      SizedBox(height: r.spaceMedium),

                      // Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatChip(
                            context,
                            r,
                            Icons.emoji_events,
                            '+${battle.pointsEarned} pts',
                            AppTheme.accentGold,
                          ),
                          if (battle.ratingChange != 0)
                            _buildStatChip(
                              context,
                              r,
                              battle.ratingChange > 0
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              '${battle.ratingChange > 0 ? '+' : ''}${battle.ratingChange}',
                              battle.ratingChange > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          _buildStatChip(
                            context,
                            r,
                            Icons.category,
                            battle.battleType,
                            AppTheme.primaryTeal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }

  Widget _buildScoreItem(
    BuildContext context,
    Responsive r,
    String label,
    int score,
    bool isWinner,
  ) {
    return Column(
      children: [
        Text(
          '$score',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: isWinner ? AppTheme.primaryTeal : AppTheme.textSecondary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatChip(
    BuildContext context,
    Responsive r,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.paddingSmall,
        vertical: r.paddingSmall / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(r.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: r.spaceSmall / 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
