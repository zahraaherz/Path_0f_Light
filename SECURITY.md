# Security & Configuration Guide

This document outlines the security measures implemented in Path of Light and provides guidance on proper configuration.

## Table of Contents

- [Environment Configuration](#environment-configuration)
- [API Key Management](#api-key-management)
- [Server-Side Validation](#server-side-validation)
- [Anti-Cheat Measures](#anti-cheat-measures)
- [Firebase Security Rules](#firebase-security-rules)
- [Best Practices](#best-practices)

---

## Environment Configuration

### Setup Instructions

1. **Copy the example configuration file:**
   ```bash
   cp lib/config/env_config.example.dart lib/config/env_config.dart
   ```

2. **Fill in your actual API keys** in `lib/config/env_config.dart`

3. **NEVER commit `env_config.dart`** - it is gitignored for security

### Configuration Files

- **`lib/config/env_config.dart`** - Your actual API keys (gitignored)
- **`lib/config/env_config.example.dart`** - Template with documentation
- **`.env.example`** - Alternative dot-env format (for reference)

### Validation

The configuration system includes built-in validation:

- In **development**: Warnings are logged for missing API keys
- In **production**: App will throw an error if API keys are not configured

Call `EnvConfig.validate()` during app initialization to check configuration.

---

## API Key Management

### RevenueCat API Keys

**Location:** `lib/config/env_config.dart`

```dart
static const String revenueCatIosApiKey = 'appl_YOUR_IOS_API_KEY';
static const String revenueCatAndroidApiKey = 'goog_YOUR_ANDROID_API_KEY';
```

**How to get:**
1. Go to [RevenueCat Dashboard](https://app.revenuecat.com/)
2. Navigate to Settings > API Keys
3. Copy the iOS key (starts with `appl_`)
4. Copy the Android key (starts with `goog_`)

**Usage:** Keys are automatically loaded by `RevenueCatService`

### AdMob Configuration

**Location:** `lib/config/env_config.dart`

Configure the following:
- `adMobIosAppId` / `adMobAndroidAppId` - App IDs
- `adMobBanner*` - Banner ad unit IDs
- `adMobInterstitial*` - Interstitial ad unit IDs
- `adMobRewarded*` - Rewarded ad unit IDs

**How to get:**
1. Go to [AdMob Console](https://apps.admob.com/)
2. Select your app
3. Navigate to Ad Units
4. Copy the relevant ad unit IDs

### Firebase Configuration

**Files (gitignored):**
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

**Setup:**
```bash
flutterfire configure
```

---

## Server-Side Validation

### Battle Answer Validation

**Critical:** All battle answers are validated **server-side only**.

#### How it Works

1. **Client submits answer** to Cloud Function
   ```dart
   await battleRepository.submitBattleAnswer(
     battleId: battleId,
     questionId: questionId,
     answer: answer, // Just the answer letter (A, B, C, D)
   );
   ```

2. **Server validates** (Cloud Function)
   - Fetches the question from Firestore
   - Compares submitted answer with `correctAnswer` field
   - Calculates points based on correctness
   - Updates battle state

3. **Client receives result**
   ```json
   {
     "isCorrect": true,
     "pointsEarned": 15,
     "currentStreak": 3,
     "correctAnswer": "A",
     "explanation": "..."
   }
   ```

#### Why This is Secure

- **Client never knows the correct answer** before submitting
- **Scores are calculated server-side** - client cannot manipulate
- **Question data with answers is protected** in Firestore security rules

**File:** `functions/src/battleManagement.ts` - `submitBattleAnswer()`

---

## Anti-Cheat Measures

### Battle System Protections

The battle system implements multiple anti-cheat measures:

#### 1. Server-Side Answer Validation
- Correct answers are **never sent to the client**
- All validation happens on the server
- Client only receives "correct/incorrect" result

#### 2. Participant Verification
```typescript
// Only battle participants can submit answers
if (!isPlayer1 && !isPlayer2) {
  throw new HttpsError("permission-denied", "Not a battle participant");
}
```

#### 3. Battle Status Validation
```typescript
// Can only submit answers in active battles
if (battleData?.status !== "in_progress") {
  throw new HttpsError("failed-precondition", "Battle is not in progress");
}
```

#### 4. Question Validation
```typescript
// Question must be part of this battle
const questionIds = battleData?.questionIds || [];
if (!questionIds.includes(questionId)) {
  throw new HttpsError("invalid-argument", "Question is not part of this battle");
}
```

#### 5. Duplicate Answer Prevention
```typescript
// Can't answer the same question twice
if (lastAnswer?.questionId === questionId) {
  throw new HttpsError("already-exists", "Question already answered");
}
```

#### 6. Rate Limiting
- Implemented via `rateLimiter.ts` middleware
- Prevents spamming API endpoints
- Configurable limits per endpoint

### Future Enhancements (Optional)

**Time-Based Validation:**
```typescript
// Validate answer submission time
const battleStartTime = battleData?.startedAt?.toDate();
const questionTimeLimit = battleData?.config?.timePerQuestion || 30;
const currentTime = new Date();

// Check if answer submitted too quickly (potential bot)
const timeSinceStart = (currentTime - battleStartTime) / 1000;
if (timeSinceStart < 2) { // Less than 2 seconds = suspicious
  console.warn(`Suspicious fast answer from user ${userId}`);
  // Could flag for review or apply penalties
}
```

---

## Firebase Security Rules

### Questions Collection

```javascript
// Questions with correct answers are read-only
match /questions/{questionId} {
  // Admins can write
  allow write: if isAdmin();

  // Users can read questions but correct answer is protected
  allow read: if request.auth != null;

  // In production, use Cloud Functions to fetch questions
  // without exposing correct answers to clients
}
```

### Battles Collection

```javascript
match /battles/{battleId} {
  // Players can read their own battles
  allow read: if isOwner(resource.data.player1.userId) ||
                 isOwner(resource.data.player2.userId);

  // Only server can write
  allow write: if false; // Use Cloud Functions only
}
```

**File:** `firestore.rules`

---

## Best Practices

### For Developers

1. **Never log API keys** in production code
2. **Use `EnvConfig.validate()`** during app initialization
3. **Test with placeholder keys** in development
4. **Use Cloud Functions** for sensitive operations
5. **Implement rate limiting** on all API endpoints

### For Deployment

1. **Configure all API keys** before production build
2. **Test in-app purchases** with RevenueCat test mode
3. **Enable ProGuard/R8** for Android (obfuscation)
4. **Enable bitcode** for iOS (optimization)
5. **Monitor for suspicious activity** via Firebase Analytics

### API Key Rotation

If an API key is compromised:

1. **Immediately revoke** the key in the provider dashboard
2. **Generate a new key**
3. **Update `env_config.dart`**
4. **Build and deploy** new version
5. **Force update** old app versions if necessary

### Security Checklist

Before going to production:

- [ ] All API keys configured in `env_config.dart`
- [ ] `env_config.dart` is gitignored
- [ ] Firebase security rules are restrictive
- [ ] Server-side validation for all critical operations
- [ ] Rate limiting enabled
- [ ] SSL/TLS certificate pinning (optional)
- [ ] Code obfuscation enabled
- [ ] ProGuard/R8 configured for Android
- [ ] Bitcode enabled for iOS
- [ ] No debug print statements in release builds
- [ ] Analytics and crash reporting configured

---

## Contact

For security concerns, please do not open public issues. Contact the development team directly.

---

**Last Updated:** 2025-11-19
**Version:** 1.0.0
