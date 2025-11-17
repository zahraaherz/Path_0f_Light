# 🌐 Multi-Language Setup Guide

## Overview

The app now supports **Arabic and English** with RTL (Right-to-Left) support for Arabic.

## Setup Instructions

### 1. Install Dependencies

Run the following command to install the required packages:

```bash
flutter pub get
```

### 2. Generate Localization Files

After installing dependencies, run this command to generate the localization code:

```bash
flutter gen-l10n
```

This will generate the `AppLocalizations` class from the ARB files located in `lib/l10n/`.

### 3. Build the App

```bash
flutter run
```

## Files Added

### Configuration Files
- `l10n.yaml` - Localization configuration
- `lib/l10n/app_en.arb` - English translations (390+ strings)
- `lib/l10n/app_ar.arb` - Arabic translations (390+ strings)

### Providers
- `lib/providers/language_providers.dart` - Language state management

### Screens
- `lib/screens/settings/settings_screen.dart` - Settings screen with language switcher

### Updates
- `pubspec.yaml` - Added `flutter_localizations` dependency and `generate: true`
- `lib/main.dart` - Added localization delegates and RTL support

## Features Implemented

### ✅ Language Support
- **English (en)** - Default language
- **Arabic (ar)** - Full RTL support

### ✅ Language Switcher
- Navigate to **Settings** from the home screen (gear icon in app bar)
- Tap on **Language** option
- Select your preferred language (English or Arabic)
- App automatically switches language and text direction

### ✅ RTL Support
- Automatic text direction change when Arabic is selected
- All UI elements properly aligned for RTL
- Native Arabic font support

### ✅ Translations Included
- **Authentication**: Login, register, password recovery
- **Navigation**: All menu items and screens
- **Quiz**: Questions, answers, results, categories
- **Energy System**: Hearts, refills, notifications
- **Streak System**: Login streaks, quiz streaks, celebrations
- **Leaderboard**: Rankings, sorting, user comparison
- **Profile**: User stats, achievements, friends
- **Dashboard**: Prayer times, Islamic calendar, daily du'as
- **Library**: Books, bookmarks, notes, reading progress
- **Settings**: All settings options and preferences
- **Islamic Terms**: Bismillah, Alhamdulillah, Salah, etc.

## Usage in Code

### Access Translations

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// In any widget with BuildContext:
final l10n = AppLocalizations.of(context)!;

// Use translations:
Text(l10n.appName)  // "Path of Light" or "طريق النور"
Text(l10n.quiz)     // "Quiz" or "الاختبار"
```

### Change Language Programmatically

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_of_light/providers/language_providers.dart';

// In any ConsumerWidget:
ref.read(languageProvider.notifier).setLanguage(AppLanguage.arabic);

// Or toggle:
ref.read(languageProvider.notifier).toggleLanguage();
```

### Check Current Language

```dart
final currentLanguage = ref.watch(languageProvider);
final isRTL = ref.watch(isRTLProvider);
final textDirection = ref.watch(textDirectionProvider);
```

## Adding New Translations

1. **Add to English ARB** (`lib/l10n/app_en.arb`):
   ```json
   {
     "newKey": "New English Text",
     "@newKey": {
       "description": "Description of the text"
     }
   }
   ```

2. **Add to Arabic ARB** (`lib/l10n/app_ar.arb`):
   ```json
   {
     "newKey": "النص الجديد بالعربية"
   }
   ```

3. **Regenerate**:
   ```bash
   flutter gen-l10n
   ```

4. **Use in code**:
   ```dart
   Text(l10n.newKey)
   ```

## Adding More Languages

To add support for additional languages (Urdu, Farsi, etc.):

1. **Create new ARB file**: `lib/l10n/app_ur.arb` (for Urdu)

2. **Add locale to `AppLanguage` enum** in `lib/providers/language_providers.dart`:
   ```dart
   enum AppLanguage {
     english('en', 'English', 'English'),
     arabic('ar', 'العربية', 'Arabic'),
     urdu('ur', 'اردو', 'Urdu'),  // New language
   }
   ```

3. **Update supported locales** in `lib/main.dart`:
   ```dart
   supportedLocales: const [
     Locale('en'),
     Locale('ar'),
     Locale('ur'),  // New locale
   ],
   ```

4. **Run** `flutter gen-l10n`

## Troubleshooting

### Issue: Import error for `app_localizations.dart`

**Solution**: Run `flutter gen-l10n` to generate the file.

### Issue: Translations not showing

**Solution**:
1. Make sure you've run `flutter pub get`
2. Run `flutter gen-l10n`
3. Hot restart the app (not just hot reload)

### Issue: RTL not working

**Solution**: Check that the `builder` in MaterialApp is wrapping with Directionality.

## Testing

### Test English
1. Open Settings
2. Select "English"
3. Verify all text is in English
4. Verify text direction is LTR

### Test Arabic
1. Open Settings
2. Select "العربية" (Arabic)
3. Verify all text is in Arabic
4. Verify text direction is RTL
5. Verify UI elements are mirrored correctly

## Next Steps

- [ ] Add more languages (Urdu, Farsi, Turkish, French)
- [ ] Implement locale-specific date formatting
- [ ] Add locale-specific number formatting
- [ ] Implement prayer time calculation method names in multiple languages
- [ ] Add translated book content (Quran tafsir, hadith)

---

**Status**: ✅ Multi-language support fully implemented and ready to use!

**Last Updated**: January 2025
