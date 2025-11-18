import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Centralized validation utilities for form fields
/// Provides consistent validation across the application
class Validators {
  /// Email validation with proper regex
  /// Returns null if valid, error message if invalid
  static String? email(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterEmail;
    }

    // RFC 5322 compliant email regex (simplified)
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return l10n.pleaseEnterValidEmail;
    }

    return null;
  }

  /// Password validation with strength requirements
  /// Minimum 6 characters (can be customized)
  static String? password(String? value, AppLocalizations l10n,
      {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterPassword;
    }

    if (value.length < minLength) {
      return l10n.passwordTooShort;
    }

    return null;
  }

  /// Strong password validation
  /// Requires: minimum 8 chars, 1 uppercase, 1 lowercase, 1 number, 1 special char
  static String? strongPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterPassword;
    }

    if (value.length < 8) {
      return l10n.passwordMinLength;
    }

    // Check for uppercase
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return l10n.passwordRequiresUppercase;
    }

    // Check for lowercase
    if (!value.contains(RegExp(r'[a-z]'))) {
      return l10n.passwordRequiresLowercase;
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return l10n.passwordRequiresNumber;
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return l10n.passwordRequiresSpecialChar;
    }

    return null;
  }

  /// Password confirmation validation
  /// Checks if passwords match
  static String? confirmPassword(
      String? value, String? originalPassword, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseConfirmPassword;
    }

    if (value != originalPassword) {
      return l10n.passwordsDoNotMatch;
    }

    return null;
  }

  /// Phone number validation (basic)
  /// Accepts various formats including international
  static String? phone(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return null; // Phone is often optional
    }

    // Remove common formatting characters
    final digitsOnly = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    // Check if it contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(digitsOnly)) {
      return l10n.pleaseEnterValidPhone;
    }

    // Check length (typically 10-15 digits for international numbers)
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return l10n.phoneLengthInvalid;
    }

    return null;
  }

  /// Display name validation
  /// Minimum 2 characters, maximum 50 characters
  static String? displayName(String? value, AppLocalizations l10n,
      {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterName;
    }

    final trimmed = value.trim();

    if (trimmed.length < minLength) {
      return l10n.nameMinLength;
    }

    if (trimmed.length > maxLength) {
      return l10n.nameMaxLength;
    }

    // Check for valid characters (letters, spaces, some special chars)
    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s\-\.]+$').hasMatch(trimmed)) {
      return l10n.nameInvalidCharacters;
    }

    return null;
  }

  /// Username validation
  /// Alphanumeric with underscores, 3-20 characters
  static String? username(String? value, AppLocalizations l10n,
      {int minLength = 3, int maxLength = 20}) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterUsername;
    }

    if (value.length < minLength || value.length > maxLength) {
      return l10n.usernameLength;
    }

    // Alphanumeric and underscores only
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return l10n.usernameInvalidCharacters;
    }

    // Must start with a letter
    if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
      return l10n.usernameMustStartWithLetter;
    }

    return null;
  }

  /// URL validation
  static String? url(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return null; // URL is often optional
    }

    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return l10n.pleaseEnterValidUrl;
      }
      return null;
    } catch (e) {
      return l10n.pleaseEnterValidUrl;
    }
  }

  /// Required field validation
  /// Generic validator for non-empty fields
  static String? required(String? value, AppLocalizations l10n,
      {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? l10n.fieldRequired
          : l10n.thisFieldIsRequired;
    }
    return null;
  }

  /// Number validation
  /// Checks if value is a valid number within optional min/max range
  static String? number(String? value, AppLocalizations l10n,
      {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterNumber;
    }

    final number = double.tryParse(value);
    if (number == null) {
      return l10n.pleaseEnterValidNumber;
    }

    if (min != null && number < min) {
      return l10n.numberTooSmall;
    }

    if (max != null && number > max) {
      return l10n.numberTooLarge;
    }

    return null;
  }

  /// Age validation
  /// Checks if age is within valid range (typically 13-120)
  static String? age(String? value, AppLocalizations l10n,
      {int minAge = 13, int maxAge = 120}) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterAge;
    }

    final ageValue = int.tryParse(value);
    if (ageValue == null) {
      return l10n.pleaseEnterValidAge;
    }

    if (ageValue < minAge) {
      return l10n.ageTooYoung;
    }

    if (ageValue > maxAge) {
      return l10n.ageTooOld;
    }

    return null;
  }

  /// Arabic text validation
  /// Ensures text contains Arabic characters
  static String? arabicText(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterText;
    }

    // Check if contains at least some Arabic characters
    if (!RegExp(r'[\u0600-\u06FF]').hasMatch(value)) {
      return l10n.pleaseEnterArabicText;
    }

    return null;
  }

  /// Minimum length validation
  static String? minLength(String? value, int min, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.thisFieldIsRequired;
    }

    if (value.length < min) {
      return l10n.fieldTooShort;
    }

    return null;
  }

  /// Maximum length validation
  static String? maxLength(String? value, int max, AppLocalizations l10n) {
    if (value != null && value.length > max) {
      return l10n.fieldTooLong;
    }

    return null;
  }
}
