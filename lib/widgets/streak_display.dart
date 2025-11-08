import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme/app_theme.dart';
import '../providers/streak_providers.dart';

/// Compact streak indicator
class StreakIndicator extends ConsumerWidget {
  final StreakType type;
  final bool compact;
  final VoidCallback? onTap;

  const StreakIndicator({
    super.key,
    required this.type,
    this.compact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = type == StreakType.login
        ? ref.watch(currentLoginStreakProvider)
        : ref.watch(currentQuizStreakProvider).currentStreak;

    final color = type == StreakType.login ? AppTheme.islamicGreen : AppTheme.error;

    if (compact) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type == StreakType.login
                    ? Icons.calendar_today
                    : Icons.local_fire_department,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                '$streak',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  type == StreakType.login
                      ? Icons.calendar_today
                      : Icons.local_fire_department,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.displayName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '$streak',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          streak == 1 ? 'day' : 'days',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (streak >= 3)
                Text(
                  type.icon,
                  style: const TextStyle(fontSize: 32),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Streak card with progress to next milestone
class StreakCard extends ConsumerWidget {
  final StreakType type;

  const StreakCard({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestones = ref.watch(streakMilestonesProvider);
    final milestone = milestones.firstWhere((m) => m.type == type);

    final color = type == StreakType.login ? AppTheme.islamicGreen : AppTheme.error;
    final nextMilestone = milestone.nextMilestone;

    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    type == StreakType.login
                        ? Icons.calendar_today
                        : Icons.local_fire_department,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type.displayName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${milestone.current} ${milestone.current == 1 ? 'day' : 'days'}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
                if (milestone.current >= 5)
                  Text(
                    type.icon,
                    style: const TextStyle(fontSize: 40),
                  ),
              ],
            ),
            if (nextMilestone != null) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next milestone',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Text(
                        '$nextMilestone days',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: milestone.progressToNext,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${nextMilestone - milestone.current} more ${nextMilestone - milestone.current == 1 ? 'day' : 'days'} to go!',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.goldAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emoji_events, color: AppTheme.goldAccent, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'All milestones achieved!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.goldAccent.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Streak milestones view
class StreakMilestonesView extends ConsumerWidget {
  final StreakType type;

  const StreakMilestonesView({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestones = ref.watch(streakMilestonesProvider);
    final milestone = milestones.firstWhere((m) => m.type == type);

    final color = type == StreakType.login ? AppTheme.islamicGreen : AppTheme.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Milestones',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: milestone.milestones.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final milestoneValue = milestone.milestones[index];
            final isAchieved = milestone.current >= milestoneValue;
            final isCurrent = milestone.current == milestoneValue;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isAchieved
                    ? color.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCurrent
                      ? color
                      : isAchieved
                          ? color.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                  width: isCurrent ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isAchieved ? color : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isAchieved ? Icons.check : Icons.lock,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$milestoneValue ${milestoneValue == 1 ? 'Day' : 'Days'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isAchieved ? color : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getMilestoneReward(milestoneValue),
                          style: TextStyle(
                            fontSize: 12,
                            color: isAchieved
                                ? AppTheme.textSecondary
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isAchieved)
                    const Icon(
                      Icons.emoji_events,
                      color: AppTheme.goldAccent,
                      size: 28,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String _getMilestoneReward(int days) {
    if (days <= 3) return '🎁 Beginner Badge';
    if (days <= 7) return '🎁 Dedicated Learner';
    if (days <= 14) return '🎁 Two Week Warrior';
    if (days <= 30) return '🎁 Monthly Master';
    if (days <= 60) return '🎁 Persistent Scholar';
    return '🎁 Legendary Seeker';
  }
}

/// Streak flame animation widget
class StreakFlame extends StatefulWidget {
  final int streak;
  final double size;

  const StreakFlame({
    super.key,
    required this.streak,
    this.size = 32,
  });

  @override
  State<StreakFlame> createState() => _StreakFlameState();
}

class _StreakFlameState extends State<StreakFlame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only animate for hot streaks
    if (widget.streak < 5) {
      return Icon(
        Icons.local_fire_department,
        size: widget.size,
        color: AppTheme.error,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Icon(
            Icons.local_fire_department,
            size: widget.size,
            color: widget.streak >= 10
                ? AppTheme.goldAccent
                : AppTheme.error,
          ),
        );
      },
    );
  }
}
