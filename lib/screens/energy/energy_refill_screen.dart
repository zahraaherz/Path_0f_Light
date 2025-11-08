import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../models/energy/energy_config.dart';
import '../../providers/energy_providers.dart';

class EnergyRefillScreen extends ConsumerStatefulWidget {
  const EnergyRefillScreen({super.key});

  @override
  ConsumerState<EnergyRefillScreen> createState() => _EnergyRefillScreenState();
}

class _EnergyRefillScreenState extends ConsumerState<EnergyRefillScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Auto-refresh every minute to show natural refill
    _refreshTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      ref.invalidate(energyStatusProvider);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final energyStatus = ref.watch(energyStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(energyStatusProvider);
            },
          ),
        ],
      ),
      body: energyStatus.when(
        data: (status) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Energy Status Card
              _buildEnergyStatusCard(status.currentEnergy, status.maxEnergy, status.isPremium),

              const SizedBox(height: 24),

              // Energy Info
              _buildEnergyInfoSection(status.isPremium),

              const SizedBox(height: 24),

              // Refill Options
              Text(
                'Refill Options',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Natural Refill
              _buildRefillOption(
                icon: Icons.schedule,
                title: 'Natural Refill',
                subtitle: status.isPremium
                    ? '10 energy per hour (Premium)'
                    : '5 energy per hour',
                value: 'Auto',
                color: AppTheme.info,
                onTap: null, // Can't trigger, happens automatically
              ),

              const SizedBox(height: 12),

              // Daily Bonus
              _buildRefillOption(
                icon: Icons.calendar_today,
                title: 'Daily Login Bonus',
                subtitle: '+${EnergyConfig.dailyLoginBonus} energy once per day',
                value: status.dailyBonusAvailable ? 'Available!' : 'Claimed',
                color: status.dailyBonusAvailable ? AppTheme.success : AppTheme.textSecondary,
                enabled: status.dailyBonusAvailable,
                onTap: status.dailyBonusAvailable
                    ? () => _claimDailyBonus()
                    : null,
              ),

              const SizedBox(height: 12),

              // Watch Ad
              _buildRefillOption(
                icon: Icons.play_circle_outline,
                title: 'Watch Ad',
                subtitle: '+${EnergyConfig.adRewardEnergy} energy • ${EnergyConfig.adCooldownMinutes} min cooldown • ${EnergyConfig.maxAdsPerDay}/day max',
                value: status.isPremium ? 'Premium' : 'Watch',
                color: status.isPremium ? AppTheme.textSecondary : AppTheme.warning,
                enabled: !status.isPremium,
                onTap: !status.isPremium ? () => _watchAd() : null,
              ),

              const SizedBox(height: 12),

              // Premium Subscription
              _buildRefillOption(
                icon: Icons.workspace_premium,
                title: 'Premium Subscription',
                subtitle: '200 max energy • 10/hour refill • No ads',
                value: status.isPremium ? 'Active' : 'Upgrade',
                color: AppTheme.goldAccent,
                onTap: () => _showPremiumDialog(),
              ),

              const SizedBox(height: 32),

              // Energy Usage Info
              _buildEnergyUsageInfo(),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppTheme.error),
              const SizedBox(height: 16),
              Text('Error loading energy',
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

  Widget _buildEnergyStatusCard(int current, int max, bool isPremium) {
    final percentage = (current / max).clamp(0.0, 1.0);

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppTheme.goldAccent, AppTheme.goldLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bolt, color: Colors.white, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      'Energy',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                if (isPremium)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.workspace_premium, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '$current / $max',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 12,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(percentage * 100).toStringAsFixed(0)}% Full',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyInfoSection(bool isPremium) {
    final refillRate = isPremium ? 10 : 5;
    final minutesPerPoint = isPremium ? 6 : 12;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.primaryTeal),
                const SizedBox(width: 8),
                Text(
                  'Energy Info',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Refill Rate', '$refillRate per hour'),
            _buildInfoRow('Time per Energy', '$minutesPerPoint minutes'),
            _buildInfoRow('Cost per Question', '${EnergyConfig.energyPerQuestion} energy'),
            _buildInfoRow('Quiz Completion Bonus', '+${EnergyConfig.energyBonusOnCompletion} energy'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefillOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required Color color,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return Card(
      color: enabled ? null : Colors.grey[200],
      child: ListTile(
        enabled: enabled,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: enabled ? AppTheme.textPrimary : AppTheme.textSecondary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: enabled ? AppTheme.textSecondary : Colors.grey[500],
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildEnergyUsageInfo() {
    return Card(
      color: AppTheme.info.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.lightbulb_outline, color: AppTheme.info),
                SizedBox(width: 8),
                Text(
                  'How Energy Works',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildBulletPoint('Each question costs ${EnergyConfig.energyPerQuestion} energy'),
            _buildBulletPoint('Energy refills naturally over time'),
            _buildBulletPoint('Complete quizzes to earn bonus energy'),
            _buildBulletPoint('Watch ads for instant energy (free users)'),
            _buildBulletPoint('Premium users get faster refill and more max energy'),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _claimDailyBonus() async {
    // Daily bonus is automatically claimed when getEnergyStatus is called
    // Just refresh to trigger it
    ref.invalidate(energyStatusProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Daily bonus claimed! +${EnergyConfig.dailyLoginBonus} energy'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  Future<void> _watchAd() async {
    // Show dialog explaining ad integration needed
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Watch Ad'),
        content: const Text(
          'Ad integration is not yet implemented. '
          'In production, this would show a rewarded ad from '
          'AdMob or another ad provider.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();

              // Simulate ad watch (for testing)
              try {
                final controller = ref.read(energyControllerProvider.notifier);
                final result = await controller.rewardAdWatch(
                  adId: 'test-ad-${DateTime.now().millisecondsSinceEpoch}',
                  adProvider: 'test',
                );

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.message ?? 'Ad reward received!'),
                      backgroundColor: result.success ? AppTheme.success : AppTheme.error,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: AppTheme.error,
                    ),
                  );
                }
              }
            },
            child: const Text('Simulate Ad (Test)'),
          ),
        ],
      ),
    );
  }

  void _showPremiumDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.workspace_premium, color: AppTheme.goldAccent),
            SizedBox(width: 8),
            Text('Premium Subscription'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upgrade to Premium for:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBulletPoint('200 max energy (2x)'),
            _buildBulletPoint('10 energy per hour (2x refill speed)'),
            _buildBulletPoint('No ads required'),
            _buildBulletPoint('Exclusive badges'),
            const SizedBox(height: 16),
            const Text(
              'Payment integration coming soon!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment integration coming soon!'),
                ),
              );
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}
