# Firebase Setup Instructions

## Overview
This project uses Firebase for backend services. The Firebase configuration files have been removed from version control for security reasons.

## Setup Steps

### Method 1: Using FlutterFire CLI (Recommended)

1. Install the FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

2. Run the configuration command:
   ```bash
   flutterfire configure
   ```

3. Select your Firebase project and platforms (Android/iOS)

4. The CLI will automatically generate all necessary configuration files

### Method 2: Manual Setup

If you prefer to set up manually:

#### For Android:
1. Download `google-services.json` from your Firebase Console
2. Place it in `android/app/google-services.json`

#### For iOS:
1. Download `GoogleService-Info.plist` from your Firebase Console
2. Place it in `ios/Runner/GoogleService-Info.plist`

#### For Dart/Flutter:
1. Copy `lib/firebase_options.dart.example` to `lib/firebase_options.dart`
2. Fill in your Firebase configuration values from the Firebase Console

## Required Files

The following files must be present for the app to work (but are not tracked in git):

- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

## Security Note

Never commit these files to version control as they contain sensitive API keys. The `.gitignore` file has been configured to exclude them.
