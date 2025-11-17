# Path of Light - Comprehensive Codebase Analysis

## Project Overview
**Path of Light** is a cross-platform Islamic educational app built with:
- **Frontend**: Flutter (supports Android, iOS, Web, Windows, macOS, Linux)
- **Backend**: Firebase Cloud Functions (TypeScript/Node.js v18)
- **Database**: Firestore
- **Authentication**: Firebase Authentication (supports email, Google, Apple, Facebook)

---

## 1. BACKEND FIREBASE FUNCTIONS

### Architecture
- **Framework**: Firebase Cloud Functions v4.5.0
- **Runtime**: Node.js 18
- **Language**: TypeScript 5.0
- **Database**: Firestore Admin SDK
- **Main Export File**: `/home/user/Path_0f_Light/functions/src/index.ts`

### Core Function Modules

#### A. User Management Functions (17 total) - `/functions/src/userManagement.ts`

**Automatic Triggers (2):**
- `onUserCreated` - Triggers when user registers, initializes complete user profile
- `onUserDeleted` - Triggers when user deleted, cleans up all user data and subcollections

**User Profile Functions (6):**
1. `completeUserProfile` - Complete registration (displayName, language, photoURL)
2. `getUserProfile` - Retrieve user profile (public/private data based on privacy settings)
3. `updateUserProfile` - Update profile information
4. `checkUsernameAvailability` - Check if username is available
5. `updateLastActive` - Track login activity and maintain login streaks
6. `updateUserSettings` - Update notification, privacy, and theme preferences

**Email/Password Functions (3):**
1. `sendEmailVerification` - Generate email verification link
2. `verifyEmailCode` - Mark email as verified
3. `sendPasswordResetEmail` - Generate password reset link

**Social Authentication (2):**
1. `linkSocialProvider` - Link additional auth provider (Google/Apple/Facebook)
2. `unlinkSocialProvider` - Remove linked auth provider

**Admin Functions (3):**
1. `setUserRole` - Assign roles (user, scholar, moderator, admin) - ADMIN ONLY
2. `suspendUser` - Disable user account - ADMIN ONLY
3. `unsuspendUser` - Re-enable user account - ADMIN ONLY

**User Roles:**
```typescript
enum UserRole {
  USER = "user",
  SCHOLAR = "scholar",
  ADMIN = "admin",
  MODERATOR = "moderator"
}
```

**User Profile Data Structure:**
```typescript
users/{userId} = {
  profile: {
    uid, email, displayName, photoURL, phoneNumber,
    language: "en" | "ar",
    emailVerified, phoneVerified,
    provider: "password" | "google.com" | "apple.com" | "facebook.com",
    providers: string[], // Multiple auth providers
    role: UserRole,
    createdAt: Timestamp,
    lastActive: Timestamp,
    accountStatus: "active" | "suspended" | "deleted",
    profileComplete: boolean
  },
  energy: { /* see Energy System */ },
  subscription: { /* see Energy System */ },
  quizProgress: { /* see Quiz Progress */ },
  dailyStats: {
    lastLoginDate: string,
    loginStreak: number,
    longestLoginStreak: number,
    totalLoginDays: number
  },
  adTracking: {
    adsWatchedToday: number,
    lastAdWatchedTime: Timestamp | null,
    lastAdResetDate: string,
    totalAdsWatched: number
  },
  settings: {
    notifications: {
      enabled: boolean,
      prayerTimes: boolean,
      quizReminders: boolean,
      achievementUnlocked: boolean
    },
    privacy: {
      profileVisible: boolean,
      showInLeaderboard: boolean,
      allowFriendRequests: boolean
    },
    preferences: {
      theme: "light" | "dark",
      fontSize: "small" | "medium" | "large",
      autoPlayAudio: boolean
    }
  }
}
```

#### B. Energy System Functions (6 total) - `/functions/src/energySystem.ts`

**System Philosophy:**
- Cost-optimized (no scheduled functions = lower costs)
- Energy consumed per question answered
- Natural refill calculated on-demand
- Ad rewards for free users
- Premium subscription for unlimited benefits

**Energy Configuration:**
```typescript
const ENERGY_CONFIG = {
  MAX_ENERGY: 100,
  ENERGY_PER_QUESTION: 10,
  ENERGY_BONUS_ON_COMPLETION: 20,
  
  // Natural refill (on-demand, no scheduled functions)
  REFILL_RATE_PER_HOUR: 5,
  REFILL_RATE_MS: 12 * 60 * 1000, // 12 minutes per point
  
  // Daily bonuses
  DAILY_LOGIN_BONUS: 50,
  
  // Ad rewards
  AD_REWARD_ENERGY: 15,
  AD_COOLDOWN_MINUTES: 5,
  MAX_ADS_PER_DAY: 10,
  
  // Premium benefits
  PREMIUM_MAX_ENERGY: 200, // Double energy
  PREMIUM_REFILL_RATE_PER_HOUR: 10, // 1.5x faster
  PREMIUM_UNLIMITED: false // Can be enabled for unlimited energy
}
```

**Energy System Functions:**
1. `getEnergyStatus` - Get current energy, calculate refill, check daily bonus
2. `consumeEnergy` - Consume energy when user answers question
3. `rewardQuizCompletion` - Award bonus energy for completing quiz
4. `rewardAdWatch` - Award energy for watching ads (includes cooldown/daily limits)
5. `updateSubscription` - Activate subscription plan
6. `checkSubscriptionStatus` - Check and update subscription validity

**Subscription Plans:**
```typescript
enum SubscriptionPlan {
  FREE = "free",
  MONTHLY = "monthly",
  YEARLY = "yearly",
  LIFETIME = "lifetime"
}
```

**Energy Data Structure:**
```typescript
{
  currentEnergy: number,
  maxEnergy: number,
  lastUpdateTime: Timestamp,
  lastDailyBonusDate: string,
  totalEnergyUsed: number,
  totalEnergyEarned: number
}
```

#### C. Quiz Management Functions (5 total) - `/functions/src/quizManagement.ts`

**Quiz Configuration:**
```typescript
const QUIZ_CONFIG = {
  POINTS: {
    basic: 10,
    intermediate: 15,
    advanced: 20,
    expert: 25
  },
  QUESTIONS_PER_SESSION: 10,
  STREAK_BONUS_MULTIPLIER: 1.1,
  MAX_STREAK_BONUS: 2.0
}
```

**Quiz Functions:**
1. `getQuizQuestions` - Get random questions for session (supports filters: category, difficulty, language)
2. `submitQuizAnswer` - Submit answer, verify correctness, consume energy
3. `getQuizProgress` - Get user's quiz statistics and progress
4. `endQuizSession` - Complete quiz session and award bonuses
5. `getQuestionSource` - Get book/paragraph reference for question

**Question Data Structure:**
```typescript
{
  id: string,
  category: string,
  difficulty: "basic" | "intermediate" | "advanced" | "expert",
  question_ar: string, // Arabic
  question_en: string, // English
  options: {
    A: { text_ar, text_en },
    B: { text_ar, text_en },
    C: { text_ar, text_en },
    D: { text_ar, text_en }
  },
  correct_answer: "A" | "B" | "C" | "D",
  source: {
    paragraph_id: string,
    book_id: string,
    exact_quote_ar: string,
    page_number: number
  },
  explanation_ar: string,
  explanation_en: string,
  points: number,
  verified: boolean
}
```

**Quiz Progress Data:**
```typescript
{
  totalQuestionsAnswered: number,
  correctAnswers: number,
  wrongAnswers: number,
  currentStreak: number,
  longestStreak: number,
  totalPoints: number,
  categoryProgress: {
    [category]: { answered, correct, points }
  },
  difficultyProgress: {
    basic: { answered, correct },
    intermediate: { answered, correct },
    advanced: { answered, correct },
    expert: { answered, correct }
  }
}
```

#### D. Content Management Functions (10 total) - `/functions/src/contentManagement.ts`

**Functions:**
1. `insertBook` - Add new book/course
2. `insertSection` - Add section to book
3. `insertParagraph` - Add paragraph to section
4. `bulkInsertParagraphs` - Batch insert paragraphs
5. `insertQuestion` - Add question linked to paragraph
6. `bulkInsertQuestions` - Batch insert questions
7. `verifyContent` - Mark content as verified
8. `publishBook` - Publish book for users
9. `searchBooks` - Search books by title/author
10. `getBookDetails` - Get full book details with content

**Content Structure:**
- Books → Sections → Paragraphs → Questions
- Bilingual support (Arabic & English)
- Content status: draft → verified → published

---

## 2. FRONTEND FLUTTER STRUCTURE

### Current State
**Status**: Basic skeleton setup
- Main app file exists but is template code
- Screen files created but empty
- No state management implemented yet
- No theme configuration beyond Material 3
- No Firebase integration connected

### Directory Structure
```
lib/
├── main.dart                          # App entry point (template)
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart         # (empty)
│   │   └── register_screen.dart      # (empty)
│   └── home/
│       ├── home_screen.dart          # (empty)
│       ├── dashboard.dart            # (empty)
│       ├── books_screen.dart         # (empty)
│       ├── challanges_screen.dart    # (empty)
│       ├── collection_screen.dart    # (empty)
│       └── setting_screen.dart       # (empty)
└── firebase_options.dart.example     # Firebase config template
```

### Current Dependencies (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  firebase_core: ^2.27.0    # Firebase initialization

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

### Available Resources
- **pubspec.yaml**: Minimal setup, ready for expansion
- **Firebase Configuration**: Project ID: `path-of-light-9226e`
- **Platform Support**: Android, iOS, Web, Windows, macOS, Linux
- **Material Design**: Uses Material 3

---

## 3. CURRENT STATE MANAGEMENT

**Status**: NONE IMPLEMENTED

### Recommendations for Implementation
Consider the following state management solutions for Flutter:
- **Riverpod** (recommended for Dart/Flutter best practices)
- **Provider** (simpler, widely adopted)
- **GetX** (all-in-one solution with routing)
- **BLoC** (complex but powerful)

The app will need state for:
- User authentication state
- User profile data
- Energy/battery status
- Quiz progress
- Settings/preferences
- Theme settings

---

## 4. THEME CONFIGURATION

### Current Theme Setup (main.dart)
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
),
```

### Planned Theme Features (from settings)
Based on backend settings structure:
- **Theme Mode**: Light/Dark
- **Font Size**: Small/Medium/Large
- **Colors**: Customizable (seed color based)
- **Localization**: English/Arabic

### Theme Data in Backend
```typescript
settings: {
  preferences: {
    theme: "light", // Can be "light" or "dark"
    fontSize: "medium", // "small", "medium", "large"
    autoPlayAudio: false
  }
}
```

---

## 5. AUTHENTICATION FLOW

### Supported Methods
1. **Email/Password** - Traditional registration and login
2. **Google Sign-In** - One-tap authentication
3. **Apple Sign-In** - For iOS users
4. **Facebook Sign-In** - Social login option
5. **Phone Number** - SMS-based authentication

### Registration Flow
```
User Registration
    ↓
Firebase Auth.createUserWithEmailAndPassword()
    ↓
onUserCreated() trigger automatically runs
    ↓
Firestore Document Created with:
  - Profile data
  - Energy system initialized (100 energy)
  - Empty quiz progress
  - Settings with defaults
  - Daily stats initialized
```

### Authentication Roles & Permissions
- **User**: Standard user, can take quizzes
- **Scholar**: Can do everything + possibly create content
- **Moderator**: Can approve content and moderate
- **Admin**: Full system control

---

## 6. DATA FLOW ARCHITECTURE

### User Registration Flow
```
1. Flutter: User fills registration form
2. Firebase Auth: Create account
3. Cloud Function: onUserCreated() trigger
4. Firestore: Initialize complete user document
5. Flutter: User completes profile (displayName, language)
6. Cloud Function: completeUserProfile() updates doc
7. Ready to use!
```

### Quiz Session Flow
```
1. Flutter: User requests quiz
2. Cloud Function: getEnergyStatus() - Check energy availability
3. If energy OK:
   - Cloud Function: getQuizQuestions() - Get 10 random questions
   - Flutter: Display quiz
4. For each answer:
   - Flutter: Submit answer
   - Cloud Function: submitQuizAnswer() - Validate, consume energy
   - Update quiz progress
5. Quiz complete:
   - Cloud Function: endQuizSession() - Award bonus energy
   - Update user stats
```

### Energy Management Flow
```
User opens app
    ↓
Cloud Function: getEnergyStatus()
    ↓
Calculate natural refill:
  - Time since last update × refill rate
  - Cap at max energy
    ↓
Check daily bonus available
  - If new day, award 50 energy
    ↓
Return current energy, max energy, flags
```

---

## 7. SECURITY FEATURES

### Firebase Security
- All functions require authentication (via `context.auth`)
- Admin functions check user role before executing
- User can only access/modify their own data (with exceptions for public profiles)
- Privacy settings determine what others can see

### Privacy Controls (per user settings)
```typescript
privacy: {
  profileVisible: boolean,      // Can others see profile?
  showInLeaderboard: boolean,   // Show in rankings?
  allowFriendRequests: boolean  // Accept friend requests?
}
```

### Data Deletion
- Soft delete: Account marked as deleted
- Hard delete: Firebase Auth deletion triggers onUserDeleted
- All subcollections removed
- Analytics logged

---

## 8. ANALYTICS TRACKING

All major events logged to `analytics` collection:
- User creation
- User deletion
- Quiz completions
- Ad watches
- Subscription activations
- Role changes
- Provider linking
- Account suspension

---

## 9. INTEGRATION REQUIREMENTS FOR FRONTEND

### Required Packages (to add to pubspec.yaml)
```yaml
dependencies:
  cloud_functions: ^4.5.0       # Call Cloud Functions
  firebase_auth: ^4.10.0        # Authentication
  firebase_firestore: ^4.13.0   # Database
  firebase_storage: ^11.2.0     # File storage (if needed)
  riverpod: ^2.4.0              # State management (recommended)
  flutter_riverpod: ^2.4.0      # Flutter Riverpod
  go_router: ^12.0.0            # Navigation
  intl: ^0.18.0                 # Localization (i18n)
```

### Key Implementation Points
1. Firebase initialization in main()
2. Set up state management for auth state
3. Implement auth guards for protected routes
4. Create services to call Cloud Functions
5. Set up theme provider
6. Implement localization (en/ar)
7. Add error handling for Cloud Function calls
8. Implement loading/error states for UI

---

## 10. API ENDPOINTS SUMMARY

All functions are called via Firebase Cloud Functions:

```
functions.httpsCallable('functionName').call({
  // parameters
})
```

### Common Patterns
- **Requires Auth**: All user/profile functions
- **Admin Only**: setUserRole, suspendUser, unsuspendUser
- **No Auth Needed**: checkUsernameAvailability, sendPasswordResetEmail

---

## 11. FILE LOCATIONS

**Backend Functions:**
- `/home/user/Path_0f_Light/functions/src/userManagement.ts` (1085 lines)
- `/home/user/Path_0f_Light/functions/src/energySystem.ts` (705 lines)
- `/home/user/Path_0f_Light/functions/src/quizManagement.ts` (637 lines)
- `/home/user/Path_0f_Light/functions/src/contentManagement.ts`
- `/home/user/Path_0f_Light/functions/src/types.ts` (305 lines)
- `/home/user/Path_0f_Light/functions/src/index.ts` (58 lines)

**Frontend:**
- `/home/user/Path_0f_Light/lib/main.dart` (126 lines - template)
- `/home/user/Path_0f_Light/lib/screens/` (empty screen files)

**Documentation:**
- `/home/user/Path_0f_Light/functions/AUTHENTICATION_GUIDE.md`
- `/home/user/Path_0f_Light/functions/INTEGRATION_GUIDE.md`
- `/home/user/Path_0f_Light/functions/NEW_README.md`

---

## 12. KEY NOTES FOR FRONTEND DEVELOPMENT

1. **Energy System**: 
   - Always check energy before quiz
   - Energy consumed per question (not per wrong answer)
   - Natural refill happens on-demand (no scheduled functions)

2. **Authentication**:
   - Support for multiple auth methods and linking
   - User completion of profile happens AFTER Firebase Auth
   - completeUserProfile() must be called after registration

3. **Quiz System**:
   - Bilingual support (en/ar) built-in
   - Questions filtered by category/difficulty
   - Streak bonus multiplier up to 2x

4. **User Roles**:
   - Determine what features user can access
   - Admin functions available for moderation

5. **Privacy Settings**:
   - Respect user privacy choices
   - Different data return for own profile vs others

---
