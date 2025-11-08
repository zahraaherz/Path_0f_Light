import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/streak_providers.dart';
import '../../widgets/streak_display.dart';

class StreakDetailsScreen extends ConsumerWidget {
  const StreakDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStreak = ref.watch(currentLoginStreakProvider);
    final longestLoginStreak = ref.watch(longestLoginStreakProvider);
    final quizStreak = ref.watch(currentQuizStreakProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Streak Statistics'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryTeal, AppTheme.islamicGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    size: 80,
                    color: AppTheme.goldAccent,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Keep Your Streak Alive!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Consistency is the key to knowledge',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Current Streaks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Streaks',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  const StreakCard(type: StreakType.login),
                  const SizedBox(height: 12),
                  const StreakCard(type: StreakType.quiz),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Best Records
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Records',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _RecordCard(
                          icon: Icons.calendar_today,
                          color: AppTheme.islamicGreen,
                          label: 'Longest Login Streak',
                          value: '$longestLoginStreak',
                          subtitle: longestLoginStreak == 1 ? 'day' : 'days',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _RecordCard(
                          icon: Icons.local_fire_department,
                          color: AppTheme.error,
                          label: 'Longest Quiz Streak',
                          value: '${quizStreak.longestStreak}',
                          subtitle: quizStreak.longestStreak == 1 ? 'answer' : 'answers',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Login Streak Milestones
            const StreakMilestonesView(type: StreakType.login),

            const SizedBox(height: 24),

            // Quiz Streak Milestones
            const StreakMilestonesView(type: StreakType.quiz),

            const SizedBox(height: 32),

            // Tips Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                color: AppTheme.info.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppTheme.info.withOpacity(0.3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.lightbulb, color: AppTheme.info, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'Streak Tips',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.info,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _TipItem(
                        icon: Icons.schedule,
                        text: 'Set a daily reminder to maintain your login streak',
                      ),
                      const SizedBox(height: 12),
                      _TipItem(
                        icon: Icons.quiz,
                        text: 'Answer at least one question daily to build your quiz streak',
                      ),
                      const SizedBox(height: 12),
                      _TipItem(
                        icon: Icons.emoji_events,
                        text: 'Reach milestones to earn special achievements',
                      ),
                      const SizedBox(height: 12),
                      _TipItem(
                        icon: Icons.favorite,
                        text: 'Consistency leads to better learning and retention',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String subtitle;

  const _RecordCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TipItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.info),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
