# Path of Light - Setup Guide

Quick start guide for setting up the Path of Light development environment.

## Prerequisites

- Flutter SDK (>=3.2.3)
- Dart SDK (>=3.2.3)
- Firebase CLI
- Node.js (for Cloud Functions)
- Android Studio / Xcode (for mobile development)

## 1. Clone the Repository

```bash
git clone https://github.com/zahraaherz/Path_0f_Light.git
cd Path_0f_Light
```

## 2. Install Dependencies

### Flutter Dependencies

```bash
flutter pub get
```

### Cloud Functions Dependencies

```bash
cd functions
npm install
cd ..
```

## 3. Firebase Configuration

### Configure Firebase

```bash
# Install Firebase CLI if not already installed
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase for this project
flutterfire configure
```

This will create:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

**Note:** These files are gitignored for security.

### Cloud Functions Environment Variables

```bash
cd functions
cp .env.example .env
# Edit .env and fill in your values
cd ..
```

## 4. Environment Configuration

### Copy the environment configuration template:

```bash
cp lib/config/env_config.example.dart lib/config/env_config.dart
```

### Edit `lib/config/env_config.dart` and configure:

1. **RevenueCat API Keys** (required for in-app purchases)
   - iOS key (starts with `appl_`)
   - Android key (starts with `goog_`)

2. **AdMob Configuration** (required if ads are enabled)
   - App IDs for iOS and Android
   - Ad unit IDs for banners, interstitials, and rewarded ads

3. **Feature Flags**
   - Enable/disable features as needed for your environment

### Where to get API keys:

#### RevenueCat
1. Go to [RevenueCat Dashboard](https://app.revenuecat.com/)
2. Settings > API Keys
3. Copy iOS and Android keys

#### AdMob
1. Go to [AdMob Console](https://apps.admob.com/)
2. Select your app
3. Navigate to Ad Units
4. Copy ad unit IDs

## 5. Firestore Setup

### Deploy Security Rules

```bash
firebase deploy --only firestore:rules
```

### Initialize Data (Optional)

If you have seed data:

```bash
# Import questions, books, etc.
# Run your data import scripts here
```

## 6. Cloud Functions Deployment

### Deploy Functions

```bash
cd functions
npm run build
firebase deploy --only functions
cd ..
```

**Important Functions:**
- `submitBattleAnswer` - Server-side answer validation
- `getQuizQuestions` - Question fetching
- `joinMatchmaking` - Battle matchmaking

## 7. Run the App

### iOS

```bash
flutter run -d ios
```

### Android

```bash
flutter run -d android
```

### Debug Mode

```bash
# Run with debug logging
flutter run --debug
```

## 8. Verify Configuration

The app will validate configuration on startup:

- ✅ Green checkmarks = all good
- ⚠️ Yellow warnings = missing non-critical config (development only)
- ❌ Red errors = missing critical config (production)

Check the console output for any warnings.

## 9. Testing

### Run Unit Tests

```bash
flutter test
```

### Run Widget Tests

```bash
flutter test test/widget_test.dart
```

### Test In-App Purchases

1. Use RevenueCat's test mode
2. Configure test accounts in App Store Connect / Google Play Console
3. Test purchase flows

## 10. Build for Production

### iOS

```bash
flutter build ios --release
# Then use Xcode to upload to App Store
```

### Android

```bash
flutter build appbundle --release
# Upload to Google Play Console
```

## Troubleshooting

### "API key not configured" errors

- Check that `lib/config/env_config.dart` exists and contains your keys
- Make sure you didn't commit placeholder values (e.g., `YOUR_API_KEY`)

### Firebase configuration issues

```bash
# Reconfigure Firebase
flutterfire configure --force
```

### Cloud Functions deployment fails

```bash
# Check your .env file in functions directory
cd functions
cat .env

# Rebuild TypeScript
npm run build

# Deploy with verbose logging
firebase deploy --only functions --debug
```

### RevenueCat initialization fails

- Verify API keys are correct
- Check that you're using the right key for the platform (iOS vs Android)
- Ensure RevenueCat SDK is configured in dashboard

## Project Structure

```
lib/
├── config/
│   ├── env_config.dart         # Your API keys (gitignored)
│   └── env_config.example.dart # Template
├── models/                     # Data models
├── providers/                  # Riverpod providers
├── repositories/               # Data access layer
├── screens/                    # UI screens
├── services/                   # Business logic services
└── widgets/                    # Reusable widgets

functions/
├── src/
│   ├── battleManagement.ts    # Battle system Cloud Functions
│   ├── quizManagement.ts      # Quiz system Cloud Functions
│   └── index.ts               # Function exports
└── .env                       # Function environment variables (gitignored)
```

## Security Notes

- **Never commit** `env_config.dart` or `.env` files
- **Never log** API keys in production
- **Always use** server-side validation for critical operations
- **Review** `SECURITY.md` for detailed security guidelines

## Next Steps

1. Read `SECURITY.md` for security best practices
2. Configure RevenueCat offerings and entitlements
3. Set up AdMob ad units
4. Import your question bank
5. Test all features thoroughly

## Support

For issues and questions:
- GitHub Issues: [Path_0f_Light/issues](https://github.com/zahraaherz/Path_0f_Light/issues)
- Documentation: See `docs/` folder

---

**Happy Coding! 🌟**
