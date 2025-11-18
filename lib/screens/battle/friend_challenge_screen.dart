import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../models/battle/battle_models.dart';
import '../../providers/battle_providers.dart';
import '../../providers/friends_providers.dart';
import '../../l10n/app_localizations.dart';

class FriendChallengeScreen extends ConsumerWidget {
  const FriendChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final friendsAsync = ref.watch(friendsListProvider);
    final battleConfig = ref.watch(battleConfigProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(l10n.challengeFriend ?? 'Challenge a Friend'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Battle config
          Container(
            margin: EdgeInsets.all(r.paddingMedium),
            padding: EdgeInsets.all(r.paddingLarge),
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal.withOpacity(0.05),
              border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(r.radiusMedium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.battleSettings ?? 'Battle Settings',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: r.spaceMedium),
                Row(
                  children: [
                    Expanded(
                      child: _buildConfigChip(
                        context,
                        r,
                        Icons.quiz,
                        '${battleConfig.questionCount} Questions',
                      ),
                    ),
                    SizedBox(width: r.spaceSmall),
                    Expanded(
                      child: _buildConfigChip(
                        context,
                        r,
                        Icons.timer,
                        '${battleConfig.timePerQuestion}s',
                      ),
                    ),
                  ],
                ),
                if (battleConfig.difficulty != null) ...[
                  SizedBox(height: r.spaceSmall),
                  _buildConfigChip(
                    context,
                    r,
                    Icons.trending_up,
                    battleConfig.difficulty!,
                  ),
                ],
                SizedBox(height: r.spaceMedium),
                TextButton.icon(
                  onPressed: () {
                    _showBattleConfigDialog(context, ref);
                  },
                  icon: const Icon(Icons.settings),
                  label: Text(l10n.customizeSettings ?? 'Customize Settings'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryTeal,
                  ),
                ),
              ],
            ),
          ),

          // Friends list
          Expanded(
            child: friendsAsync.when(
              data: (friends) {
                if (friends.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: r.spaceMedium),
                        Text(
                          l10n.noFriends ?? 'No friends yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: r.spaceSmall),
                        Text(
                          l10n.addFriendsToChallenge ?? 'Add friends to challenge them',
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
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friends[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: r.spaceMedium),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: friend.friendPhotoURL != null
                              ? NetworkImage(friend.friendPhotoURL!)
                              : null,
                          child: friend.friendPhotoURL == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        title: Text(
                          friend.friendDisplayName ?? friend.friendUsername ?? 'Friend',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${friend.friendTotalPoints ?? 0} points • ${friend.friendBooksRead ?? 0} books read',
                        ),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            await _sendChallenge(context, ref, friend.userId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryTeal,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(l10n.challenge ?? 'Challenge'),
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
          ),
        ],
      ),
    );
  }

  Widget _buildConfigChip(
      BuildContext context, Responsive r, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.paddingMedium,
        vertical: r.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(r.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryTeal),
          SizedBox(width: r.spaceSmall),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChallenge(
    BuildContext context,
    WidgetRef ref,
    String friendId,
  ) async {
    try {
      final config = ref.read(battleConfigProvider);
      final invitationId = await ref
          .read(battleRepositoryProvider)
          .sendBattleChallenge(friendId: friendId, config: config);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Challenge sent!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _showBattleConfigDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Battle Settings'),
        content: const Text('Battle configuration coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
