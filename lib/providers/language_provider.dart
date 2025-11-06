import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en', '');
  bool _isLoading = true;

  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';
  bool get isLoading => _isLoading;

  LanguageProvider() {
    _loadLanguagePreference();
  }

  // Load language preference from SharedPreferences
  Future<void> _loadLanguagePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('languageCode') ?? 'en';
      _locale = Locale(languageCode, '');
    } catch (e) {
      _locale = const Locale('en', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Change language
  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode, '');
    notifyListeners();

    // Save preference
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', languageCode);
    } catch (e) {
      debugPrint('Failed to save language preference: $e');
    }
  }

  // Toggle between English and Arabic
  Future<void> toggleLanguage() async {
    final newLanguageCode = isArabic ? 'en' : 'ar';
    await changeLanguage(newLanguageCode);
  }

  // Get text based on current language
  String getText(String englishText, String arabicText) {
    return isArabic ? arabicText : englishText;
  }
}
