import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme/app_theme.dart';
import '../providers/energy_providers.dart';
import '../screens/energy/energy_refill_screen.dart';

/// Energy display widget showing current energy with tap to refill
class EnergyDisplay extends ConsumerWidget {
  final bool showLabel;
  final double iconSize;
  final double fontSize;

  const EnergyDisplay({
    super.key,
    this.showLabel = true,
    this.iconSize = 24,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energyStatus = ref.watch(energyStatusProvider);

    return energyStatus.when(
      data: (status) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const EnergyRefillScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.goldAccent.withOpacity(0.1),
            border: Border.all(
              color: AppTheme.goldAccent.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bolt,
                color: AppTheme.goldAccent,
                size: iconSize,
              ),
              const SizedBox(width: 6),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${status.currentEnergy}/${status.maxEnergy}',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldAccent,
                    ),
                  ),
                  if (showLabel)
                    Text(
                      'Energy',
                      style: TextStyle(
                        fontSize: fontSize * 0.7,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => _buildLoadingState(),
      error: (_, __) => _buildErrorState(context),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.goldAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: AppTheme.goldAccent, size: iconSize),
          const SizedBox(width: 6),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: AppTheme.error, size: iconSize),
          const SizedBox(width: 6),
          Text(
            '---',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppTheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

/// Energy bar widget showing progress
class EnergyBar extends ConsumerWidget {
  final double height;
  final bool showValue;

  const EnergyBar({
    super.key,
    this.height = 24,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energyStatus = ref.watch(energyStatusProvider);

    return energyStatus.when(
      data: (status) {
        final percentage = (status.currentEnergy / status.maxEnergy).clamp(0.0, 1.0);
        final isLow = status.currentEnergy < status.energyPerQuestion;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isLow
                            ? [AppTheme.error, AppTheme.error.withOpacity(0.7)]
                            : [AppTheme.goldAccent, AppTheme.goldLight],
                      ),
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  ),
                ),
                if (showValue)
                  Container(
                    height: height,
                    alignment: Alignment.center,
                    child: Text(
                      '${status.currentEnergy}/${status.maxEnergy}',
                      style: TextStyle(
                        fontSize: height * 0.6,
                        fontWeight: FontWeight.bold,
                        color: percentage > 0.5 ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
            if (isLow) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 14,
                    color: AppTheme.error,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Low energy - Refill needed',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
      loading: () => Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(height / 2),
        ),
        alignment: Alignment.center,
        child: const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (_, __) => Container(
        height: height,
        decoration: BoxDecoration(
          color: AppTheme.error.withOpacity(0.2),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        alignment: Alignment.center,
        child: Text(
          'Error loading energy',
          style: TextStyle(
            fontSize: height * 0.5,
            color: AppTheme.error,
          ),
        ),
      ),
    );
  }
}
