import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../providers/battle_providers.dart';
import '../../l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class TournamentListScreen extends ConsumerWidget {
  const TournamentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final tournamentsAsync = ref.watch(availableTournamentsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: AppTheme.accentGold),
            SizedBox(width: r.spaceSmall),
            Text(l10n.tournaments ?? 'Tournaments'),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: tournamentsAsync.when(
        data: (tournaments) {
          if (tournaments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: r.spaceMedium),
                  Text(
                    l10n.noTournamentsAvailable ?? 'No tournaments available',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: r.spaceSmall),
                  Text(
                    l10n.checkBackLater ?? 'Check back later for upcoming tournaments',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(r.paddingMedium),
            itemCount: tournaments.length,
            itemBuilder: (context, index) {
              final tournament = tournaments[index];
              return _buildTournamentCard(context, r, ref, tournament);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: r.spaceMedium),
              Text('Error: ${error.toString()}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentCard(
    BuildContext context,
    Responsive r,
    WidgetRef ref,
    tournament,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final isRegistrationOpen = tournament.status.value == 'registration';
    final spotsLeft = tournament.maxParticipants - tournament.participants.length;

    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium),
        side: BorderSide(
          color: AppTheme.accentGold.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(r.paddingMedium),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.accentGold.withOpacity(0.8),
                  AppTheme.accentGold,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(r.radiusMedium),
                topRight: Radius.circular(r.radiusMedium),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.white, size: 32),
                SizedBox(width: r.spaceMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournament.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        tournament.titleAr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.paddingSmall,
                    vertical: r.paddingSmall / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(r.radiusSmall),
                  ),
                  child: Text(
                    tournament.status.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(r.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                if (tournament.description != null) ...[
                  Text(
                    tournament.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: r.spaceMedium),
                ],

                // Details
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        r,
                        Icons.people,
                        '${tournament.participants.length}/${tournament.maxParticipants}',
                        'Participants',
                      ),
                    ),
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        r,
                        Icons.category,
                        tournament.bracketType.displayName,
                        'Format',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: r.spaceSmall),

                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        r,
                        Icons.quiz,
                        '${tournament.battleConfig.questionCount} questions',
                        'Battle',
                      ),
                    ),
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        r,
                        Icons.bolt,
                        '${tournament.entryEnergyCost} energy',
                        'Entry',
                      ),
                    ),
                  ],
                ),

                if (isRegistrationOpen) ...[
                  SizedBox(height: r.spaceMedium),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppTheme.textSecondary,
                      ),
                      SizedBox(width: r.spaceSmall),
                      Text(
                        'Registration ends: ${DateFormat('MMM dd, HH:mm').format(tournament.registrationDeadline)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: r.spaceMedium),

                // Action button
                if (isRegistrationOpen)
                  ElevatedButton(
                    onPressed: spotsLeft > 0
                        ? () async {
                            await _registerForTournament(
                                context, ref, tournament.id);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentGold,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      padding:
                          EdgeInsets.symmetric(vertical: r.paddingMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                    ),
                    child: Text(
                      spotsLeft > 0
                          ? (l10n.joinTournament ?? 'Join Tournament')
                          : (l10n.tournamentFull ?? 'Tournament Full'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  OutlinedButton(
                    onPressed: () {
                      // Navigate to tournament details
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Tournament details coming soon!')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.accentGold,
                      side: BorderSide(color: AppTheme.accentGold),
                      padding:
                          EdgeInsets.symmetric(vertical: r.paddingMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                    ),
                    child: Text(
                      l10n.viewTournament ?? 'View Tournament',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    Responsive r,
    IconData icon,
    String value,
    String label,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryTeal),
        SizedBox(width: r.spaceSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _registerForTournament(
    BuildContext context,
    WidgetRef ref,
    String tournamentId,
  ) async {
    try {
      await ref
          .read(battleRepositoryProvider)
          .registerForTournament(tournamentId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully registered for tournament!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
}
