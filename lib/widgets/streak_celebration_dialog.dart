import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../config/theme/app_theme.dart';
import '../providers/streak_providers.dart';

/// Celebration dialog for streak milestones
class StreakCelebrationDialog extends StatefulWidget {
  final StreakCelebration celebration;

  const StreakCelebrationDialog({
    super.key,
    required this.celebration,
  });

  @override
  State<StreakCelebrationDialog> createState() => _StreakCelebrationDialogState();

  static void show(BuildContext context, StreakCelebration celebration) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StreakCelebrationDialog(celebration: celebration),
    );
  }
}

class _StreakCelebrationDialogState extends State<StreakCelebrationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    // Auto dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.celebration.type == StreakType.login
        ? AppTheme.islamicGreen
        : AppTheme.error;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Confetti effect
                if (widget.celebration.isMilestone)
                  ...List.generate(20, (index) {
                    return _ConfettiPiece(
                      index: index,
                      animation: _controller,
                    );
                  }),

                // Main card
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: widget.celebration.isMilestone
                                ? _rotationAnimation.value
                                : 0,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.celebration.isMilestone
                                    ? Icons.emoji_events
                                    : widget.celebration.type == StreakType.login
                                        ? Icons.calendar_today
                                        : Icons.local_fire_department,
                                size: 64,
                                color: color,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Title
                      Text(
                        widget.celebration.isMilestone
                            ? 'Milestone Reached!'
                            : 'Streak Active!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      // Streak count
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withOpacity(0.7)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${widget.celebration.streak}',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              widget.celebration.streak == 1 ? 'Day' : 'Days',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Message
                      Text(
                        widget.celebration.message,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 24),

                      // Close button
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ConfettiPiece extends StatelessWidget {
  final int index;
  final Animation<double> animation;

  const _ConfettiPiece({
    required this.index,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final random = math.Random(index);
    final angle = random.nextDouble() * 2 * math.pi;
    final distance = 100 + random.nextDouble() * 100;
    final size = 6 + random.nextDouble() * 8;
    final color = _getRandomColor(random);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;
        final x = math.cos(angle) * distance * progress;
        final y = math.sin(angle) * distance * progress - (progress * 50);

        return Positioned(
          left: 150 + x,
          top: 150 + y,
          child: Opacity(
            opacity: 1 - progress,
            child: Transform.rotate(
              angle: progress * 4 * math.pi,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                  shape: random.nextBool() ? BoxShape.circle : BoxShape.rectangle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getRandomColor(math.Random random) {
    final colors = [
      AppTheme.primaryTeal,
      AppTheme.islamicGreen,
      AppTheme.goldAccent,
      AppTheme.error,
      AppTheme.info,
      AppTheme.warning,
    ];
    return colors[random.nextInt(colors.length)];
  }
}

/// Simple streak notification snackbar
class StreakNotification {
  static void show(
    BuildContext context, {
    required StreakType type,
    required int streak,
    bool isMilestone = false,
  }) {
    final color = type == StreakType.login
        ? AppTheme.islamicGreen
        : AppTheme.error;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(
              type == StreakType.login
                  ? Icons.calendar_today
                  : Icons.local_fire_department,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isMilestone ? 'Milestone!' : '${type.displayName} Streak',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$streak ${streak == 1 ? 'day' : 'days'}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isMilestone)
              const Icon(
                Icons.emoji_events,
                color: AppTheme.goldAccent,
              ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
