import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported languages in the app
enum AppLanguage {
  english('en', 'English', 'English'),
  arabic('ar', 'العربية', 'Arabic');

  const AppLanguage(this.code, this.nativeName, this.englishName);

  final String code;
  final String nativeName;
  final String englishName;

  Locale get locale => Locale(code);

  bool get isRTL => code == 'ar';
}

/// Language state notifier
class LanguageNotifier extends StateNotifier<AppLanguage> {
  LanguageNotifier() : super(AppLanguage.english) {
    _loadSavedLanguage();
  }

  static const String _languageKey = 'selected_language';

  /// Load saved language from shared preferences
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString(_languageKey);

      if (savedLanguageCode != null) {
        final language = AppLanguage.values.firstWhere(
          (lang) => lang.code == savedLanguageCode,
          orElse: () => AppLanguage.english,
        );
        state = language;
      }
    } catch (e) {
      // If loading fails, default to English
      state = AppLanguage.english;
    }
  }

  /// Change the app language
  Future<void> setLanguage(AppLanguage language) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, language.code);
      state = language;
    } catch (e) {
      // Handle error silently or log it
      debugPrint('Error saving language preference: $e');
    }
  }

  /// Toggle between English and Arabic
  Future<void> toggleLanguage() async {
    final newLanguage = state == AppLanguage.english
        ? AppLanguage.arabic
        : AppLanguage.english;
    await setLanguage(newLanguage);
  }
}

/// Provider for managing app language
final languageProvider =
    StateNotifierProvider<LanguageNotifier, AppLanguage>((ref) {
  return LanguageNotifier();
});

/// Provider for current locale
final localeProvider = Provider<Locale>((ref) {
  final language = ref.watch(languageProvider);
  return language.locale;
});

/// Provider for checking if current language is RTL
final isRTLProvider = Provider<bool>((ref) {
  final language = ref.watch(languageProvider);
  return language.isRTL;
});

/// Provider for text direction
final textDirectionProvider = Provider<TextDirection>((ref) {
  final isRTL = ref.watch(isRTLProvider);
  return isRTL ? TextDirection.rtl : TextDirection.ltr;
});

/// Supported locales for the app
final supportedLocalesProvider = Provider<List<Locale>>((ref) {
  return AppLanguage.values.map((lang) => lang.locale).toList();
});
