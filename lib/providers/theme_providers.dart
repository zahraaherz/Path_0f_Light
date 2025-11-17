import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported theme modes in the app
enum AppThemeMode {
  light('light', 'Light Mode', ThemeMode.light),
  dark('dark', 'Dark Mode', ThemeMode.dark),
  system('system', 'System Default', ThemeMode.system);

  const AppThemeMode(this.code, this.displayName, this.themeMode);

  final String code;
  final String displayName;
  final ThemeMode themeMode;
}

/// Theme state notifier
class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.system) {
    _loadSavedTheme();
  }

  static const String _themeKey = 'selected_theme_mode';

  /// Load saved theme from shared preferences
  Future<void> _loadSavedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeCode = prefs.getString(_themeKey);

      if (savedThemeCode != null) {
        final theme = AppThemeMode.values.firstWhere(
          (mode) => mode.code == savedThemeCode,
          orElse: () => AppThemeMode.system,
        );
        state = theme;
      }
    } catch (e) {
      // If loading fails, default to system theme
      state = AppThemeMode.system;
    }
  }

  /// Change the app theme mode
  Future<void> setTheme(AppThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeMode.code);
      state = themeMode;
    } catch (e) {
      // Handle error silently or log it
      debugPrint('Error saving theme preference: $e');
    }
  }

  /// Toggle between light and dark modes
  Future<void> toggleTheme() async {
    final newTheme = state == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light;
    await setTheme(newTheme);
  }
}

/// Provider for managing app theme mode
final themeProvider =
    StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

/// Provider for current ThemeMode
final themeModeProvider = Provider<ThemeMode>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode.themeMode;
});
