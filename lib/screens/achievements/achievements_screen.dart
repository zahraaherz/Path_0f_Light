import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/auth_providers.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final userProfileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        centerTitle: true,
      ),
      body: userProfileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('No profile data'));
          }

          // Calculate achievements based on user stats
          final achievements = _calculateAchievements(profile.quizProgress.toJson(), profile.dailyStats.toJson(), profile.energy.toJson());

          return SingleChildScrollView(
            padding: EdgeInsets.all(r.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(r.paddingLarge),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryTeal, AppTheme.islamicGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(r.radiusMedium),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.emoji_events, size: 64, color: AppTheme.goldAccent),
                      SizedBox(height: r.spaceSmall),
                      Text(
                        'Your Achievements',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: r.spaceSmall),
                      Text(
                        '${achievements.where((a) => a['unlocked'] == true).length} / ${achievements.length} Unlocked',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: r.spaceLarge),

                // Achievement Categories
                _buildAchievementCategory(
                  context,
                  'Points Milestones',
                  achievements.where((a) => a['category'] == 'points').toList(),
                ),
                _buildAchievementCategory(
                  context,
                  'Quiz Master',
                  achievements.where((a) => a['category'] == 'quiz').toList(),
                ),
                _buildAchievementCategory(
                  context,
                  'Streak Warrior',
                  achievements.where((a) => a['category'] == 'streak').toList(),
                ),
                _buildAchievementCategory(
                  context,
                  'Dedication',
                  achievements.where((a) => a['category'] == 'dedication').toList(),
                ),
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
              SizedBox(height: r.spaceMedium),
              Text('Error loading achievements',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCategory(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> achievements,
  ) {
    if (achievements.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...achievements.map((achievement) => _buildAchievementCard(context, achievement)),
        SizedBox(height: r.spaceMedium),
      ],
    );
  }

  Widget _buildAchievementCard(BuildContext context, Map<String, dynamic> achievement) {
    final isUnlocked = achievement['unlocked'] as bool;
    final progress = achievement['progress'] as int;
    final required = achievement['required'] as int;
    final progressPercent = (progress / required).clamp(0.0, 1.0);

    return Card(
      elevation: isUnlocked ? 4 : 1,
      color: isUnlocked ? null : Colors.grey[200],
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Row(
          children: [
            // Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isUnlocked
                    ? AppTheme.goldAccent.withOpacity(0.2)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(r.radiusMedium),
              ),
              child: Icon(
                _getIconForCategory(achievement['category'] as String),
                size: 32,
                color: isUnlocked ? AppTheme.goldAccent : Colors.grey[500],
              ),
            ),
            SizedBox(width: r.spaceMedium),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement['title'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isUnlocked ? AppTheme.textPrimary : Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement['description'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isUnlocked ? AppTheme.textSecondary : Colors.grey[500],
                        ),
                  ),
                  if (!isUnlocked) ...[
                    SizedBox(height: r.spaceSmall),
                    LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$progress / $required',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),

            // Checkmark if unlocked
            if (isUnlocked)
              const Icon(Icons.check_circle, color: AppTheme.success, size: 32),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'points':
        return Icons.stars;
      case 'quiz':
        return Icons.quiz;
      case 'streak':
        return Icons.local_fire_department;
      case 'dedication':
        return Icons.favorite;
      default:
        return Icons.emoji_events;
    }
  }

  List<Map<String, dynamic>> _calculateAchievements(
    Map<String, dynamic> quizProgress,
    Map<String, dynamic> dailyStats,
    Map<String, dynamic> energy,
  ) {
    final points = (quizProgress['totalPoints'] as num?)?.toInt() ?? 0;
    final totalQuestions = (quizProgress['totalQuestionsAnswered'] as num?)?.toInt() ?? 0;
    final correctAnswers = (quizProgress['correctAnswers'] as num?)?.toInt() ?? 0;
    final currentStreak = (quizProgress['currentStreak'] as num?)?.toInt() ?? 0;
    final loginStreak = (dailyStats['loginStreak'] as num?)?.toInt() ?? 0;

    return [
      // Points Milestones
      {
        'category': 'points',
        'title': 'First Steps',
        'description': 'Earn your first 100 points',
        'required': 100,
        'progress': points,
        'unlocked': points >= 100,
      },
      {
        'category': 'points',
        'title': 'Rising Scholar',
        'description': 'Earn 500 points',
        'required': 500,
        'progress': points,
        'unlocked': points >= 500,
      },
      {
        'category': 'points',
        'title': 'Knowledge Seeker',
        'description': 'Earn 1,000 points',
        'required': 1000,
        'progress': points,
        'unlocked': points >= 1000,
      },
      {
        'category': 'points',
        'title': 'Master of Knowledge',
        'description': 'Earn 5,000 points',
        'required': 5000,
        'progress': points,
        'unlocked': points >= 5000,
      },

      // Quiz Achievements
      {
        'category': 'quiz',
        'title': 'Quiz Novice',
        'description': 'Answer 10 questions',
        'required': 10,
        'progress': totalQuestions,
        'unlocked': totalQuestions >= 10,
      },
      {
        'category': 'quiz',
        'title': 'Quiz Enthusiast',
        'description': 'Answer 50 questions',
        'required': 50,
        'progress': totalQuestions,
        'unlocked': totalQuestions >= 50,
      },
      {
        'category': 'quiz',
        'title': 'Quiz Expert',
        'description': 'Answer 100 questions',
        'required': 100,
        'progress': totalQuestions,
        'unlocked': totalQuestions >= 100,
      },
      {
        'category': 'quiz',
        'title': 'Perfect Start',
        'description': 'Get 10 questions correct',
        'required': 10,
        'progress': correctAnswers,
        'unlocked': correctAnswers >= 10,
      },

      // Streak Achievements
      {
        'category': 'streak',
        'title': 'On Fire',
        'description': 'Achieve a 5-question streak',
        'required': 5,
        'progress': currentStreak,
        'unlocked': currentStreak >= 5,
      },
      {
        'category': 'streak',
        'title': 'Unstoppable',
        'description': 'Achieve a 10-question streak',
        'required': 10,
        'progress': currentStreak,
        'unlocked': currentStreak >= 10,
      },
      {
        'category': 'streak',
        'title': 'Legendary Streak',
        'description': 'Achieve a 20-question streak',
        'required': 20,
        'progress': currentStreak,
        'unlocked': currentStreak >= 20,
      },

      // Dedication Achievements
      {
        'category': 'dedication',
        'title': 'Coming Back',
        'description': 'Login for 3 days in a row',
        'required': 3,
        'progress': loginStreak,
        'unlocked': loginStreak >= 3,
      },
      {
        'category': 'dedication',
        'title': 'Weekly Warrior',
        'description': 'Login for 7 days in a row',
        'required': 7,
        'progress': loginStreak,
        'unlocked': loginStreak >= 7,
      },
      {
        'category': 'dedication',
        'title': 'Monthly Champion',
        'description': 'Login for 30 days in a row',
        'required': 30,
        'progress': loginStreak,
        'unlocked': loginStreak >= 30,
      },
    ];
  }
}
