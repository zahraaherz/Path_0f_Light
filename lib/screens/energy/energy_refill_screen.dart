import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../models/energy/energy_config.dart';
import '../../providers/energy_providers.dart';
import '../../utils/responsive.dart';
import '../premium/premium_screen.dart';

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
    final r = context.responsive;
    final energyStatus = ref.watch(energyStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Energy'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(energyStatusProvider);
            },
          ),
        ],
      ),
      body: energyStatus.when(
        data: (status) => SingleChildScrollView(
          padding: EdgeInsets.all(r.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Energy Status Card
              _buildEnergyStatusCard(status.currentEnergy, status.maxEnergy, status.isPremium),

              SizedBox(height: r.spaceLarge),

              // Energy Info
              _buildEnergyInfoSection(status.isPremium),

              SizedBox(height: r.spaceLarge),

              // Refill Options
              Text(
                'Refill Options',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: r.spaceMedium),

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

              SizedBox(height: r.spaceSmall),

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

              SizedBox(height: r.spaceSmall),

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

              SizedBox(height: r.spaceSmall),

              // Premium Subscription
              _buildRefillOption(
                icon: Icons.workspace_premium,
                title: 'Premium Subscription',
                subtitle: '200 max energy • 10/hour refill • No ads',
                value: status.isPremium ? 'Active' : 'Upgrade',
                color: AppTheme.goldAccent,
                onTap: () => _showPremiumDialog(),
              ),

              SizedBox(height: r.spaceXLarge),

              // Energy Usage Info
              _buildEnergyUsageInfo(),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: r.iconLarge * 2, color: AppTheme.error),
              SizedBox(height: r.spaceMedium),
              Text('Error loading energy',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: r.spaceSmall),
              Text(error.toString(),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnergyStatusCard(int current, int max, bool isPremium) {
    final r = context.responsive;
    final percentage = (current / max).clamp(0.0, 1.0);

    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(r.paddingLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.radiusMedium),
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
                    Icon(Icons.bolt, color: Colors.white, size: r.iconLarge),
                    SizedBox(width: r.spaceSmall),
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
                    padding: EdgeInsets.symmetric(horizontal: r.paddingSmall, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(r.radiusLarge),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.workspace_premium, color: Colors.white, size: r.paddingMedium),
                        SizedBox(width: r.spaceXSmall),
                        Text(
                          'PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: r.fontSmall,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: r.spaceLarge),
            Text(
              '$current / $max',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: r.spaceMedium),
            ClipRRect(
              borderRadius: BorderRadius.circular(r.radiusSmall),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: r.spaceSmall,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(height: r.spaceSmall),
            Text(
              '${(percentage * 100).toStringAsFixed(0)}% Full',
              style: TextStyle(
                color: Colors.white,
                fontSize: r.fontSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyInfoSection(bool isPremium) {
    final r = context.responsive;
    final refillRate = isPremium ? 10 : 5;
    final minutesPerPoint = isPremium ? 6 : 12;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.primaryTeal),
                SizedBox(width: r.spaceSmall),
                Text(
                  'Energy Info',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            SizedBox(height: r.spaceMedium),
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
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spaceXSmall),
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
    final r = context.responsive;
    return Card(
      color: enabled ? null : Colors.grey[200],
      child: ListTile(
        enabled: enabled,
        leading: Container(
          padding: EdgeInsets.all(r.paddingSmall),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(r.radiusSmall),
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
            fontSize: r.fontSmall,
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
    final r = context.responsive;
    return Card(
      color: AppTheme.info.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: AppTheme.info),
                SizedBox(width: r.spaceSmall),
                Text(
                  'How Energy Works',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: r.fontMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: r.spaceSmall),
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
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spaceXSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: r.fontMedium)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: r.fontSmall),
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
    // Navigate to the premium screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PremiumScreen(),
      ),
    );
  }
}
