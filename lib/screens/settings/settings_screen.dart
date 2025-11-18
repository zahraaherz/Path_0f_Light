import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/language_providers.dart';
import '../../providers/theme_providers.dart';
import '../../providers/auth_controller.dart';
import '../../providers/calendar_providers.dart';
import '../../l10n/app_localizations.dart';

/// Settings screen with language switcher, theme options, and more
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Settings state
  bool _prayerNotifications = true;
  bool _quizReminders = true;
  bool _streakReminders = true;
  bool _achievementNotifications = true;
  bool _soundEffects = true;
  bool _vibration = true;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final currentLanguage = ref.watch(languageProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(r.paddingMedium),
        children: [
          // General Settings Section
          _buildSectionHeader(l10n.generalSettings, theme),
          SizedBox(height: r.spaceSmall),
          _buildSettingsCard(
            context,
            children: [
              // Language Switcher
              ListTile(
                leading: const Icon(Icons.language, color: AppTheme.primaryTeal),
                title: Text(l10n.language),
                subtitle: Text(currentLanguage.nativeName),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLanguageDialog(context),
              ),
              const Divider(),

              // Theme switcher
              ListTile(
                leading: const Icon(Icons.palette, color: AppTheme.primaryTeal),
                title: Text(l10n.theme),
                subtitle: Text(_getThemeDisplayName(ref.watch(themeProvider))),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showThemeDialog(context),
              ),
            ],
          ),

          SizedBox(height: r.spaceLarge),

          // Notifications Section
          _buildSectionHeader(l10n.notifications, theme),
          SizedBox(height: r.spaceSmall),
          _buildSettingsCard(
            context,
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.mosque, color: AppTheme.primaryTeal),
                title: Text(l10n.prayerNotifications),
                subtitle: Text(l10n.receivePrayerNotifications),
                value: _prayerNotifications,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _prayerNotifications = value);
                },
              ),
              const Divider(),
              SwitchListTile(
                secondary: const Icon(Icons.quiz, color: AppTheme.primaryTeal),
                title: Text(l10n.quizReminders),
                subtitle: Text(l10n.dailyQuizReminders),
                value: _quizReminders,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _quizReminders = value);
                },
              ),
              const Divider(),
              SwitchListTile(
                secondary: const Icon(Icons.local_fire_department, color: AppTheme.primaryTeal),
                title: Text(l10n.streakReminders),
                subtitle: Text(l10n.keepStreakGoing),
                value: _streakReminders,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _streakReminders = value);
                },
              ),
              const Divider(),
              SwitchListTile(
                secondary: const Icon(Icons.emoji_events, color: AppTheme.primaryTeal),
                title: Text(l10n.achievementNotifications),
                subtitle: Text(l10n.newAchievementsUnlocked),
                value: _achievementNotifications,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _achievementNotifications = value);
                },
              ),
            ],
          ),

          SizedBox(height: r.spaceLarge),

          // Islamic Events Notifications Section
          _buildSectionHeader(l10n.islamicEvents, theme),
          SizedBox(height: r.spaceSmall),
          _buildEventNotificationsCard(context, r, theme, l10n),

          SizedBox(height: r.spaceLarge),

          // Sound & Vibration Section
          _buildSectionHeader(l10n.soundAndVibration, theme),
          SizedBox(height: r.spaceSmall),
          _buildSettingsCard(
            context,
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.volume_up, color: AppTheme.primaryTeal),
                title: Text(l10n.soundEffects),
                subtitle: Text(l10n.playSoundEffects),
                value: _soundEffects,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _soundEffects = value);
                },
              ),
              const Divider(),
              SwitchListTile(
                secondary: const Icon(Icons.vibration, color: AppTheme.primaryTeal),
                title: Text(l10n.vibration),
                subtitle: Text(l10n.hapticFeedback),
                value: _vibration,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _vibration = value);
                },
              ),
            ],
          ),

          SizedBox(height: r.spaceLarge),

          // Account Section
          _buildSectionHeader(l10n.accountSettings, theme),
          SizedBox(height: r.spaceSmall),
          _buildSettingsCard(
            context,
            children: [
              ListTile(
                leading: const Icon(Icons.lock, color: AppTheme.primaryTeal),
                title: Text(l10n.changePassword),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.comingSoon)),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: AppTheme.error),
                title: Text(l10n.logout),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),

          SizedBox(height: r.spaceLarge),

          // About Section
          _buildSectionHeader(l10n.aboutApp, theme),
          SizedBox(height: r.spaceSmall),
          _buildSettingsCard(
            context,
            children: [
              ListTile(
                leading: const Icon(Icons.info, color: AppTheme.primaryTeal),
                title: Text(l10n.version),
                subtitle: const Text('1.0.0'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip, color: AppTheme.primaryTeal),
                title: Text(l10n.privacyPolicy),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.comingSoon)),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.description, color: AppTheme.primaryTeal),
                title: Text(l10n.termsOfService),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.comingSoon)),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.email, color: AppTheme.primaryTeal),
                title: Text(l10n.contactUs),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.comingSoon)),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.star, color: AppTheme.warning),
                title: Text(l10n.rateApp),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.comingSoon)),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: r.spaceLarge),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: AppTheme.primaryTeal,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Build settings card
  Widget _buildSettingsCard(BuildContext context, {required List<Widget> children}) {
    final r = context.responsive;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  /// Show language selection dialog
  void _showLanguageDialog(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final currentLanguage = ref.read(languageProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppLanguage.values.map((language) {
            return RadioListTile<AppLanguage>(
              title: Text(language.nativeName),
              subtitle: Text(language.englishName),
              value: language,
              groupValue: currentLanguage,
              activeColor: AppTheme.primaryTeal,
              onChanged: (value) {
                if (value != null) {
                  ref.read(languageProvider.notifier).setLanguage(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  /// Get theme display name
  String _getThemeDisplayName(AppThemeMode themeMode) {
    return themeMode.displayName;
  }

  /// Show theme selection dialog
  void _showThemeDialog(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final currentTheme = ref.read(themeProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values.map((themeMode) {
            IconData icon;
            switch (themeMode) {
              case AppThemeMode.light:
                icon = Icons.light_mode;
                break;
              case AppThemeMode.dark:
                icon = Icons.dark_mode;
                break;
              case AppThemeMode.system:
                icon = Icons.brightness_auto;
                break;
            }

            return RadioListTile<AppThemeMode>(
              title: Row(
                children: [
                  Icon(icon, size: 20, color: AppTheme.primaryTeal),
                  const SizedBox(width: 8),
                  Text(themeMode.displayName),
                ],
              ),
              value: themeMode,
              groupValue: currentTheme,
              activeColor: AppTheme.primaryTeal,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeProvider.notifier).setTheme(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  /// Build event notifications card with settings
  Widget _buildEventNotificationsCard(BuildContext context, Responsive r, ThemeData theme, AppLocalizations l10n) {
    final eventNotificationsAsync = ref.watch(eventNotificationsEnabledProvider);
    final daysBeforeAsync = ref.watch(notificationDaysBeforeProvider);

    return _buildSettingsCard(
      context,
      children: [
        // Enable/Disable Event Notifications
        eventNotificationsAsync.when(
          data: (enabled) => SwitchListTile(
            secondary: const Icon(Icons.event, color: AppTheme.primaryTeal),
            title: Text(l10n.eventNotifications),
            subtitle: Text(l10n.notifyAboutCelebrations),
            value: enabled,
            activeColor: AppTheme.primaryTeal,
            onChanged: (value) async {
              await ref
                  .read(eventNotificationSettingsProvider.notifier)
                  .toggleNotifications(value);
              // Refresh the providers
              ref.invalidate(eventNotificationsEnabledProvider);
            },
          ),
          loading: () => ListTile(
            leading: const CircularProgressIndicator(),
            title: Text(l10n.loading),
          ),
          error: (_, __) => ListTile(
            leading: const Icon(Icons.error),
            title: Text(l10n.errorLoadingData),
          ),
        ),
        const Divider(),

        // Days Before Notification Setting
        daysBeforeAsync.when(
          data: (days) => ListTile(
            leading: const Icon(Icons.notifications_active, color: AppTheme.primaryTeal),
            title: Text(l10n.notificationTiming),
            subtitle: Text(l10n.notifyDaysBefore(days, days == 1 ? l10n.day : l10n.days)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showDaysBeforeDialog(context, days),
          ),
          loading: () => ListTile(
            leading: const CircularProgressIndicator(),
            title: Text(l10n.loading),
          ),
          error: (_, __) => ListTile(
            leading: const Icon(Icons.error),
            title: Text(l10n.errorLoadingData),
          ),
        ),
        const Divider(),

        // View All Events
        ListTile(
          leading: const Icon(Icons.calendar_month, color: AppTheme.primaryTeal),
          title: Text(l10n.viewAllEvents),
          subtitle: Text(l10n.browseAllCelebrations),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Navigate to events calendar screen (to be implemented)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.calendarViewComingSoon)),
            );
          },
        ),
      ],
    );
  }

  /// Show days before notification dialog
  void _showDaysBeforeDialog(BuildContext context, int currentDays) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.notificationTiming),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chooseNotificationTime),
            const SizedBox(height: 16),
            ...List.generate(8, (index) {
              final days = [0, 1, 2, 3, 5, 7, 14, 30][index];
              String label;
              if (days == 0) {
                label = l10n.onTheDay;
              } else if (days == 1) {
                label = l10n.oneDayBefore;
              } else if (days == 7) {
                label = l10n.oneWeekBefore;
              } else if (days == 14) {
                label = l10n.twoWeeksBefore;
              } else if (days == 30) {
                label = l10n.oneMonthBefore;
              } else {
                label = l10n.notifyDaysBefore(days, l10n.days);
              }

              return RadioListTile<int>(
                title: Text(label),
                value: days,
                groupValue: currentDays,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) async {
                  if (value != null) {
                    await ref
                        .read(eventNotificationSettingsProvider.notifier)
                        .updateDaysBefore(value);
                    // Refresh the provider
                    ref.invalidate(notificationDaysBeforeProvider);
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.confirmLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authControllerProvider.notifier).signOut();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.error,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
