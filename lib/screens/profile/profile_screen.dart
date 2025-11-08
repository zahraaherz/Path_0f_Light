import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/auth_providers.dart';
import '../../providers/auth_controller.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showSignOutDialog(context, ref),
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(
              child: Text('No profile data available'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header
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
                  child: Column(
                    children: [
                      // Profile Photo
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: ClipOval(
                          child: profile.photoURL != null
                              ? CachedNetworkImage(
                                  imageUrl: profile.photoURL!,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => const CircularProgressIndicator(),
                                  errorWidget: (_, __, ___) => const Icon(Icons.person, size: 50, color: Colors.white),
                                )
                              : Container(
                                  color: Colors.white.withOpacity(0.2),
                                  child: const Icon(Icons.person, size: 50, color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Display Name
                      Text(
                        profile.displayName ?? 'No Name',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),

                      // Email
                      Text(
                        profile.email ?? 'No Email',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                      ),
                      const SizedBox(height: 8),

                      // Role Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.goldAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          profile.role.value.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.bolt,
                          label: 'Energy',
                          value: '${profile.energy.currentEnergy}/${profile.energy.maxEnergy}',
                          color: AppTheme.goldAccent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.stars,
                          label: 'Points',
                          value: '${profile.quizProgress.totalPoints}',
                          color: AppTheme.primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.local_fire_department,
                          label: 'Streak',
                          value: '${profile.dailyStats.loginStreak}',
                          color: AppTheme.error,
                        ),
                      ),
                    ],
                  ),
                ),

                // Quiz Progress
                _SectionCard(
                  title: 'Quiz Progress',
                  icon: Icons.quiz,
                  children: [
                    _InfoRow('Total Questions', '${profile.quizProgress.totalQuestionsAnswered}'),
                    _InfoRow('Correct Answers', '${profile.quizProgress.correctAnswers}'),
                    _InfoRow('Wrong Answers', '${profile.quizProgress.wrongAnswers}'),
                    _InfoRow(
                      'Accuracy',
                      profile.quizProgress.totalQuestionsAnswered > 0
                          ? '${((profile.quizProgress.correctAnswers / profile.quizProgress.totalQuestionsAnswered) * 100).toStringAsFixed(1)}%'
                          : '0%',
                    ),
                    _InfoRow('Current Streak', '${profile.quizProgress.currentStreak}'),
                    _InfoRow('Longest Streak', '${profile.quizProgress.longestStreak}'),
                  ],
                ),

                // Account Info
                _SectionCard(
                  title: 'Account Information',
                  icon: Icons.info_outline,
                  children: [
                    _InfoRow('Language', profile.language.toUpperCase()),
                    _InfoRow('Email Verified', profile.emailVerified ? 'Yes' : 'No'),
                    _InfoRow('Phone Verified', profile.phoneVerified ? 'Yes' : 'No'),
                    _InfoRow('Provider', profile.provider),
                    _InfoRow('Account Status', profile.accountStatus.name.toUpperCase()),
                    _InfoRow('Member Since', _formatDate(profile.createdAt)),
                    _InfoRow('Last Active', _formatDate(profile.lastActive)),
                  ],
                ),

                // Subscription Info
                _SectionCard(
                  title: 'Subscription',
                  icon: Icons.workspace_premium,
                  children: [
                    _InfoRow('Plan', profile.subscription.plan.toUpperCase()),
                    _InfoRow('Status', profile.subscription.active ? 'Active' : 'Inactive'),
                    if (profile.subscription.expiryDate != null)
                      _InfoRow('Expires', _formatDate(profile.subscription.expiryDate!)),
                  ],
                ),

                // Settings Section
                _SectionCard(
                  title: 'Settings',
                  icon: Icons.settings,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications, color: AppTheme.primaryTeal),
                      title: const Text('Notifications'),
                      subtitle: Text(profile.settings.notifications.enabled ? 'Enabled' : 'Disabled'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to notification settings
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip, color: AppTheme.primaryTeal),
                      title: const Text('Privacy'),
                      subtitle: Text(profile.settings.privacy.profileVisible ? 'Public' : 'Private'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to privacy settings
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.palette, color: AppTheme.primaryTeal),
                      title: const Text('Theme'),
                      subtitle: Text(profile.settings.preferences.theme.toUpperCase()),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to theme settings
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Sign Out Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showSignOutDialog(context, ref),
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.error,
                        side: const BorderSide(color: AppTheme.error),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
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
              Text('Error loading profile', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(error.toString(), style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(authControllerProvider.notifier).signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: AppTheme.primaryTeal),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
}
