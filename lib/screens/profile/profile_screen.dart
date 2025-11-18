import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/auth_providers.dart';
import '../../providers/auth_controller.dart';
import '../../data/mock_data.dart';
import '../auth/login_screen.dart';
import '../premium/premium_screen.dart';
import '../../utils/responsive.dart';
import '../../l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final userProfileAsync = ref.watch(currentUserProfileProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: r.constrainWidth(
          child: userProfileAsync.when(
            data: (profile) {
              // Use mock profile if no real data is available
              final displayProfile = profile ?? MockData.mockUserProfile;

              return CustomScrollView(
                slivers: [
                  // Header with border (matching explore page)
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.primaryTeal.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(r.paddingMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.profile,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.primaryTeal,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.logout),
                              onPressed: () => _showSignOutDialog(context, ref, l10n),
                              color: AppTheme.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Profile Info Section (border-based, no gradient)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                      child: Container(
                        padding: EdgeInsets.all(r.paddingLarge),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.primaryTeal.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(r.radiusMedium),
                        ),
                        child: Column(
                          children: [
                            // Profile Photo
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.primaryTeal.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: displayProfile.photoURL != null
                                    ? CachedNetworkImage(
                                        imageUrl: displayProfile.photoURL!,
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) => const CircularProgressIndicator(),
                                        errorWidget: (_, __, ___) => Icon(
                                          Icons.person,
                                          size: 50,
                                          color: AppTheme.primaryTeal,
                                        ),
                                      )
                                    : Container(
                                        color: AppTheme.primaryTeal.withOpacity(0.1),
                                        child: Icon(
                                          Icons.person,
                                          size: 50,
                                          color: AppTheme.primaryTeal,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: r.spaceMedium),

                            // Display Name
                            Text(
                              displayProfile.displayName ?? 'No Name',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: AppTheme.primaryTeal,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),

                            // Email
                            Text(
                              displayProfile.email ?? 'No Email',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                            ),
                            SizedBox(height: r.spaceSmall),

                            // Role Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.goldAccent.withOpacity(0.1),
                                border: Border.all(
                                  color: AppTheme.goldAccent.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                displayProfile.role.value.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppTheme.goldAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  // Stats Section (border-based cards)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.bolt,
                              label: l10n.energy,
                              value: '${displayProfile.energy.currentEnergy}/${displayProfile.energy.maxEnergy}',
                              color: AppTheme.goldAccent,
                            ),
                          ),
                          SizedBox(width: r.spaceSmall),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.stars,
                              label: l10n.points,
                              value: '${displayProfile.quizProgress.totalPoints}',
                              color: AppTheme.primaryTeal,
                            ),
                          ),
                          SizedBox(width: r.spaceSmall),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.local_fire_department,
                              label: l10n.streak,
                              value: '${displayProfile.dailyStats.loginStreak}',
                              color: AppTheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  // Quiz Progress Section
                  SliverToBoxAdapter(
                    child: _SectionContainer(
                      title: l10n.quizProgress,
                      icon: Icons.quiz,
                      children: [
                        _InfoRow(l10n.totalQuestions, '${displayProfile.quizProgress.totalQuestionsAnswered}'),
                        _InfoRow(l10n.correctAnswers, '${displayProfile.quizProgress.correctAnswers}'),
                        _InfoRow(l10n.wrongAnswers, '${displayProfile.quizProgress.wrongAnswers}'),
                        _InfoRow(
                          l10n.accuracy,
                          displayProfile.quizProgress.totalQuestionsAnswered > 0
                              ? '${((displayProfile.quizProgress.correctAnswers / displayProfile.quizProgress.totalQuestionsAnswered) * 100).toStringAsFixed(1)}%'
                              : '0%',
                        ),
                        _InfoRow(l10n.currentStreak, '${displayProfile.quizProgress.currentStreak}'),
                        _InfoRow(l10n.longestStreak, '${displayProfile.quizProgress.longestStreak}'),
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Account Info Section
                  SliverToBoxAdapter(
                    child: _SectionContainer(
                      title: l10n.accountInformation,
                      icon: Icons.info_outline,
                      children: [
                        _InfoRow(l10n.language, displayProfile.language.toUpperCase()),
                        _InfoRow(l10n.emailVerified, displayProfile.emailVerified ? l10n.yes : l10n.no),
                        _InfoRow(l10n.phoneVerified, displayProfile.phoneVerified ? l10n.yes : l10n.no),
                        _InfoRow(l10n.provider, displayProfile.provider),
                        _InfoRow(l10n.accountStatus, displayProfile.accountStatus.name.toUpperCase()),
                        _InfoRow(l10n.memberSince, _formatDate(displayProfile.createdAt)),
                        _InfoRow(l10n.lastActive, _formatDate(displayProfile.lastActive)),
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Subscription Info Section
                  SliverToBoxAdapter(
                    child: _SectionContainer(
                      title: l10n.subscription,
                      icon: Icons.workspace_premium,
                      children: [
                        _InfoRow(l10n.plan, displayProfile.subscription.plan.toUpperCase()),
                        _InfoRow(l10n.status, displayProfile.subscription.active ? l10n.active : l10n.inactive),
                        if (displayProfile.subscription.expiryDate != null)
                          _InfoRow(l10n.expires, _formatDate(displayProfile.subscription.expiryDate!)),
                        // Show upgrade button for free users
                        if (displayProfile.subscription.plan.toLowerCase() == 'free')
                          Padding(
                            padding: EdgeInsets.all(r.paddingMedium),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppTheme.goldAccent, AppTheme.goldAccent.withOpacity(0.7)],
                                ),
                                borderRadius: BorderRadius.circular(r.radiusMedium),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const PremiumScreen(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(r.radiusMedium),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: r.paddingMedium,
                                      horizontal: r.paddingLarge,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.workspace_premium,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: r.spaceSmall),
                                        Text(
                                          l10n.upgradeToPremium,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Settings Section
                  SliverToBoxAdapter(
                    child: _SectionContainer(
                      title: l10n.settings,
                      icon: Icons.settings,
                      children: [
                        _SettingsTile(
                          icon: Icons.notifications,
                          title: l10n.notifications,
                          subtitle: displayProfile.settings.notifications.enabled ? l10n.enabled : l10n.disabled,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          icon: Icons.privacy_tip,
                          title: l10n.privacyPolicy,
                          subtitle: displayProfile.settings.privacy.profileVisible ? l10n.public : l10n.private,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          icon: Icons.palette,
                          title: l10n.theme,
                          subtitle: displayProfile.settings.preferences.theme.toUpperCase(),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32)),

                  // Sign Out Button
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.error, width: 1.5),
                          borderRadius: BorderRadius.circular(r.radiusMedium),
                        ),
                        child: InkWell(
                          onTap: () => _showSignOutDialog(context, ref, l10n),
                          borderRadius: BorderRadius.circular(r.radiusMedium),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.logout, color: AppTheme.error),
                                SizedBox(width: r.spaceSmall),
                                Text(
                                  l10n.signOut,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppTheme.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              );
            },
            loading: () {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.primaryTeal.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(r.paddingMedium),
                        child: Text(
                          l10n.profile,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stack) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.primaryTeal.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(r.paddingMedium),
                        child: Text(
                          l10n.profile,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(r.paddingLarge),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
                          SizedBox(height: r.spaceMedium),
                          Text(
                            l10n.previewMode,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: r.spaceSmall),
                          Text(
                            l10n.signInToViewProfile,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: r.spaceLarge),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                              padding: EdgeInsets.symmetric(
                                horizontal: r.paddingLarge,
                                vertical: r.paddingMedium,
                              ),
                            ),
                            child: Text(l10n.signIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.signOut),
        content: Text(l10n.confirmSignOut),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
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
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Border-based Stat Card (matching explore page pattern)
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
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: r.iconSmall),
          SizedBox(height: r.spaceSmall),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Border-based Section Container (matching explore page pattern)
class _SectionContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionContainer({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.primaryTeal.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(r.radiusMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(r.paddingMedium),
              child: Row(
                children: [
                  Icon(icon, color: AppTheme.primaryTeal, size: r.iconSmall),
                  SizedBox(width: r.spaceSmall),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: AppTheme.primaryTeal.withOpacity(0.1),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

// Info Row
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium, vertical: 12),
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

// Settings Tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.paddingMedium, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryTeal, size: r.iconSmall),
            SizedBox(width: r.spaceSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
