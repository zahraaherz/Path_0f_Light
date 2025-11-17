import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/leaderboard_providers.dart';
import '../../utils/responsive.dart';

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
    final r = context.responsive;
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
                  padding: EdgeInsets.all(r.paddingLarge),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildUserAvatar(
                        r,
                        user1['displayName'] as String,
                        user1['photoURL'] as String?,
                      ),
                      Icon(
                        Icons.flash_on,
                        size: r.iconLarge,
                        color: AppTheme.goldAccent,
                      ),
                      _buildUserAvatar(
                        r,
                        user2['displayName'] as String,
                        user2['photoURL'] as String?,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: r.spaceLarge),

                // Comparison stats
                _buildComparisonStat(
                  context,
                  r,
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
                  r,
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
                  r,
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
                  r,
                  'Current Streak',
                  user1['currentStreak'] as int,
                  user2['currentStreak'] as int,
                  user1['displayName'] as String,
                  user2['displayName'] as String,
                  Icons.local_fire_department,
                  AppTheme.error,
                ),

                // Accuracy comparison
                _buildAccuracyComparison(context, r, user1, user2),

                SizedBox(height: r.spaceLarge),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          final r = context.responsive;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: r.iconXLarge, color: AppTheme.error),
                SizedBox(height: r.spaceMedium),
                Text('Error loading comparison',
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: r.spaceSmall),
                Text(error.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserAvatar(Responsive r, String displayName, String? photoURL) {
    return Column(
      children: [
        Container(
          width: r.iconXLarge + 16,
          height: r.iconXLarge + 16,
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
                        Icon(Icons.person, size: r.iconLarge, color: Colors.white),
                  )
                : Container(
                    color: Colors.white.withOpacity(0.2),
                    child: Icon(Icons.person, size: r.iconLarge, color: Colors.white),
                  ),
          ),
        ),
        SizedBox(height: r.spaceSmall),
        Text(
          displayName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: r.fontMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildComparisonStat(
    BuildContext context,
    Responsive r,
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
      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium, vertical: r.spaceSmall),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(r.paddingMedium),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: r.iconMedium),
                  SizedBox(width: r.spaceSmall),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              SizedBox(height: r.spaceMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildStatValue(
                      context,
                      r,
                      value1,
                      name1,
                      winner == 1,
                      color,
                    ),
                  ),
                  SizedBox(width: r.spaceMedium),
                  Expanded(
                    child: _buildStatValue(
                      context,
                      r,
                      value2,
                      name2,
                      winner == 2,
                      color,
                    ),
                  ),
                ],
              ),
              if (winner != 0) ...[
                SizedBox(height: r.spaceSmall),
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
    Responsive r,
    int value,
    String name,
    bool isWinner,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(r.paddingSmall),
      decoration: BoxDecoration(
        color: isWinner ? color.withOpacity(0.1) : Colors.transparent,
        border: Border.all(
          color: isWinner ? color : AppTheme.textSecondary.withOpacity(0.3),
          width: isWinner ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          if (isWinner)
            Icon(Icons.emoji_events, color: AppTheme.goldAccent, size: r.iconSmall),
          if (isWinner) SizedBox(height: r.spaceSmall / 2),
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
    Responsive r,
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
      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium, vertical: r.spaceSmall),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(r.paddingMedium),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.percent, color: AppTheme.success, size: r.iconMedium),
                  SizedBox(width: r.spaceSmall),
                  Text(
                    'Accuracy',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              SizedBox(height: r.spaceMedium),
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
                        SizedBox(height: r.spaceSmall),
                        LinearProgressIndicator(
                          value: accuracy1 / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            winner == 1 ? AppTheme.success : AppTheme.info,
                          ),
                        ),
                        SizedBox(height: r.spaceSmall / 2),
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
                  SizedBox(width: r.spaceLarge),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          user2['displayName'] as String,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: r.spaceSmall),
                        LinearProgressIndicator(
                          value: accuracy2 / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            winner == 2 ? AppTheme.success : AppTheme.info,
                          ),
                        ),
                        SizedBox(height: r.spaceSmall / 2),
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
                SizedBox(height: r.spaceSmall),
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
