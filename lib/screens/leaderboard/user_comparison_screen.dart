import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/leaderboard_providers.dart';

class UserComparisonScreen extends ConsumerWidget {
  final String userId1;
  final String userId2;

  const UserComparisonScreen({
    super.key,
    required this.userId1,
    required this.userId2,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comparisonAsync = ref.watch(userComparisonProvider([userId1, userId2]));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Comparison'),
        centerTitle: true,
      ),
      body: comparisonAsync.when(
        data: (data) {
          final user1 = data['user1'] as Map<String, dynamic>;
          final user2 = data['user2'] as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with user avatars
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryTeal, AppTheme.islamicGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildUserAvatar(
                        user1['displayName'] as String,
                        user1['photoURL'] as String?,
                      ),
                      const Icon(
                        Icons.flash_on,
                        size: 48,
                        color: AppTheme.goldAccent,
                      ),
                      _buildUserAvatar(
                        user2['displayName'] as String,
                        user2['photoURL'] as String?,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Comparison stats
                _buildComparisonStat(
                  context,
                  'Points',
                  user1['points'] as int,
                  user2['points'] as int,
                  user1['displayName'] as String,
                  user2['displayName'] as String,
                  Icons.stars,
                  AppTheme.goldAccent,
                ),

                _buildComparisonStat(
                  context,
                  'Total Questions',
                  user1['totalQuestions'] as int,
                  user2['totalQuestions'] as int,
                  user1['displayName'] as String,
                  user2['displayName'] as String,
                  Icons.quiz,
                  AppTheme.info,
                ),

                _buildComparisonStat(
                  context,
                  'Correct Answers',
                  user1['correctAnswers'] as int,
                  user2['correctAnswers'] as int,
                  user1['displayName'] as String,
                  user2['displayName'] as String,
                  Icons.check_circle,
                  AppTheme.success,
                ),

                _buildComparisonStat(
                  context,
                  'Current Streak',
                  user1['currentStreak'] as int,
                  user2['currentStreak'] as int,
                  user1['displayName'] as String,
                  user2['displayName'] as String,
                  Icons.local_fire_department,
                  AppTheme.error,
                ),

                // Accuracy comparison
                _buildAccuracyComparison(context, user1, user2),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppTheme.error),
              const SizedBox(height: 16),
              Text('Error loading comparison',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(error.toString(),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(String displayName, String? photoURL) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: ClipOval(
            child: photoURL != null
                ? CachedNetworkImage(
                    imageUrl: photoURL,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const CircularProgressIndicator(),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.person, size: 40, color: Colors.white),
                  )
                : Container(
                    color: Colors.white.withOpacity(0.2),
                    child: const Icon(Icons.person, size: 40, color: Colors.white),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          displayName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildComparisonStat(
    BuildContext context,
    String label,
    int value1,
    int value2,
    String name1,
    String name2,
    IconData icon,
    Color color,
  ) {
    final winner = value1 > value2
        ? 1
        : value2 > value1
            ? 2
            : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildStatValue(
                      context,
                      value1,
                      name1,
                      winner == 1,
                      color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatValue(
                      context,
                      value2,
                      name2,
                      winner == 2,
                      color,
                    ),
                  ),
                ],
              ),
              if (winner != 0) ...[
                const SizedBox(height: 8),
                Text(
                  winner == 1 ? '$name1 wins!' : '$name2 wins!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.success,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatValue(
    BuildContext context,
    int value,
    String name,
    bool isWinner,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWinner ? color.withOpacity(0.1) : Colors.transparent,
        border: Border.all(
          color: isWinner ? color : AppTheme.textSecondary.withOpacity(0.3),
          width: isWinner ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (isWinner)
            Icon(Icons.emoji_events, color: AppTheme.goldAccent, size: 20),
          if (isWinner) const SizedBox(height: 4),
          Text(
            '$value',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isWinner ? color : AppTheme.textPrimary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracyComparison(
    BuildContext context,
    Map<String, dynamic> user1,
    Map<String, dynamic> user2,
  ) {
    final total1 = user1['totalQuestions'] as int;
    final correct1 = user1['correctAnswers'] as int;
    final accuracy1 = total1 > 0 ? (correct1 / total1) * 100 : 0.0;

    final total2 = user2['totalQuestions'] as int;
    final correct2 = user2['correctAnswers'] as int;
    final accuracy2 = total2 > 0 ? (correct2 / total2) * 100 : 0.0;

    final winner = accuracy1 > accuracy2
        ? 1
        : accuracy2 > accuracy1
            ? 2
            : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.percent, color: AppTheme.success),
                  const SizedBox(width: 8),
                  Text(
                    'Accuracy',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          user1['displayName'] as String,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: accuracy1 / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            winner == 1 ? AppTheme.success : AppTheme.info,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${accuracy1.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: winner == 1 ? AppTheme.success : AppTheme.textPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          user2['displayName'] as String,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: accuracy2 / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            winner == 2 ? AppTheme.success : AppTheme.info,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${accuracy2.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: winner == 2 ? AppTheme.success : AppTheme.textPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (winner != 0) ...[
                const SizedBox(height: 8),
                Text(
                  winner == 1
                      ? '${user1['displayName']} is more accurate!'
                      : '${user2['displayName']} is more accurate!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.success,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
