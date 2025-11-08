import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/language_providers.dart';
import '../../providers/auth_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final currentLanguage = ref.watch(languageProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // General Settings Section
          _buildSectionHeader(l10n.generalSettings, theme),
          const SizedBox(height: 12),
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

              // Theme (placeholder for future dark mode toggle)
              ListTile(
                leading: const Icon(Icons.palette, color: AppTheme.primaryTeal),
                title: Text(l10n.theme),
                subtitle: Text(l10n.lightMode),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implement theme switcher
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.comingSoon)),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Notifications Section
          _buildSectionHeader(l10n.notifications, theme),
          const SizedBox(height: 12),
          _buildSettingsCard(
            context,
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.mosque, color: AppTheme.primaryTeal),
                title: Text(l10n.prayerNotifications),
                subtitle: Text('Receive notifications for prayer times'),
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
                subtitle: Text('Daily quiz reminders'),
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
                subtitle: Text('Keep your streak going'),
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
                subtitle: Text('New achievements unlocked'),
                value: _achievementNotifications,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _achievementNotifications = value);
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Sound & Vibration Section
          _buildSectionHeader('Sound & Vibration', theme),
          const SizedBox(height: 12),
          _buildSettingsCard(
            context,
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.volume_up, color: AppTheme.primaryTeal),
                title: Text(l10n.soundEffects),
                subtitle: Text('Play sound effects in app'),
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
                subtitle: Text('Haptic feedback'),
                value: _vibration,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) {
                  setState(() => _vibration = value);
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Account Section
          _buildSectionHeader(l10n.accountSettings, theme),
          const SizedBox(height: 12),
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

          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader(l10n.aboutApp, theme),
          const SizedBox(height: 12),
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
                leading: const Icon(Icons.star, color: AppTheme.warningYellow),
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

          const SizedBox(height: 32),
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  /// Show language selection dialog
  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: const Text('Are you sure you want to logout?'),
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
