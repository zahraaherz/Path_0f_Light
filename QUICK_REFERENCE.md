# Path of Light - Quick Reference Guide

## 1. FIREBASE FUNCTIONS QUICK REFERENCE

### User Authentication Functions
| Function | Auth Required | Purpose | Returns |
|----------|---------------|---------|---------|
| onUserCreated | N/A (trigger) | Initialize user on registration | User doc created |
| onUserDeleted | N/A (trigger) | Clean up on account deletion | All data deleted |
| completeUserProfile | Yes | Finish registration | Profile complete flag |
| getUserProfile | Yes | Fetch profile | Public or full profile |
| updateUserProfile | Yes | Modify profile | Success status |
| updateUserSettings | Yes | Update preferences | Success status |
| deleteUserAccount | Yes | Delete account | Account marked deleted |
| updateLastActive | Yes | Track activity | Login streak updated |
| checkUsernameAvailability | No | Check username | Available: true/false |

### Social & Email Functions
| Function | Auth Required | Purpose |
|----------|---------------|---------|
| linkSocialProvider | Yes | Add Google/Apple/Facebook |
| unlinkSocialProvider | Yes | Remove linked provider |
| sendEmailVerification | Yes | Send verification email |
| verifyEmailCode | Yes | Mark email verified |
| sendPasswordResetEmail | No | Send reset link |

### Admin Functions (Admin Only)
| Function | Purpose |
|----------|---------|
| setUserRole | Assign user role (user/scholar/moderator/admin) |
| suspendUser | Disable account |
| unsuspendUser | Re-enable account |

### Energy System Functions
| Function | Auth Required | Purpose |
|----------|---------------|---------|
| getEnergyStatus | Yes | Get current energy + refill calculation |
| consumeEnergy | Yes | Use energy for question |
| rewardQuizCompletion | Yes | Award bonus energy |
| rewardAdWatch | Yes | Award energy from ad |
| updateSubscription | Yes | Activate subscription |
| checkSubscriptionStatus | Yes | Check subscription validity |

### Quiz Functions
| Function | Auth Required | Purpose |
|----------|---------------|---------|
| getQuizQuestions | Yes | Get 10 random questions |
| submitQuizAnswer | Yes | Submit + validate answer |
| getQuizProgress | Yes | Get user statistics |
| endQuizSession | Yes | Complete quiz |
| getQuestionSource | Yes | Get book reference |

---

## 2. USER DATA STRUCTURE

```
users/{userId} Document Structure:
├── profile
│   ├── uid, email, displayName, photoURL, phoneNumber
│   ├── language: "en" | "ar"
│   ├── emailVerified, phoneVerified
│   ├── provider, providers[]
│   ├── role: "user" | "scholar" | "moderator" | "admin"
│   ├── createdAt, lastActive
│   ├── accountStatus: "active" | "suspended" | "deleted"
│   └── profileComplete: boolean
├── energy
│   ├── currentEnergy: 0-100 (or 0-200 if premium)
│   ├── maxEnergy: 100 (or 200)
│   ├── lastUpdateTime
│   ├── lastDailyBonusDate
│   ├── totalEnergyUsed, totalEnergyEarned
├── subscription
│   ├── plan: "free" | "monthly" | "yearly" | "lifetime"
│   ├── active: boolean
│   ├── startDate, expiryDate
│   └── autoRenew: boolean
├── quizProgress
│   ├── totalQuestionsAnswered, correctAnswers, wrongAnswers
│   ├── currentStreak, longestStreak
│   ├── totalPoints
│   ├── categoryProgress: { [category]: { answered, correct, points } }
│   └── difficultyProgress: { basic, intermediate, advanced, expert }
├── dailyStats
│   ├── lastLoginDate
│   ├── loginStreak, longestLoginStreak
│   └── totalLoginDays
├── adTracking
│   ├── adsWatchedToday, totalAdsWatched
│   ├── lastAdWatchedTime
│   └── lastAdResetDate
└── settings
    ├── notifications: { enabled, prayerTimes, quizReminders, achievementUnlocked }
    ├── privacy: { profileVisible, showInLeaderboard, allowFriendRequests }
    └── preferences: { theme: "light"|"dark", fontSize, autoPlayAudio }
```

---

## 3. ENERGY SYSTEM DETAILS

**Energy Costs & Rewards:**
- Energy per question: 10
- Bonus on quiz completion: 20
- Daily login bonus: 50
- Ad watch reward: 15

**Energy Refill:**
- Natural refill: 5 per hour (1 point every 12 minutes)
- Calculation: On-demand (no scheduled functions)
- Cap: 100 (free), 200 (premium)

**Premium Benefits:**
- Max energy: 200 (vs 100)
- Refill rate: 10 per hour (vs 5)
- No ads needed
- Optional unlimited energy

---

## 4. QUIZ SYSTEM DETAILS

**Point Values:**
- Basic: 10 points
- Intermediate: 15 points
- Advanced: 20 points
- Expert: 25 points

**Streak Bonus:**
- Multiplier: 1.1× per correct answer
- Max multiplier: 2.0×
- Questions per session: 10

**Difficulty Levels:**
- basic (easy)
- intermediate (medium)
- advanced (hard)
- expert (very hard)

---

## 5. AUTHENTICATION METHODS

| Method | Provider ID | Setup Complexity |
|--------|------------|------------------|
| Email/Password | "password" | Simple |
| Google Sign-In | "google.com" | Medium |
| Apple Sign-In | "apple.com" | Medium |
| Facebook Sign-In | "facebook.com" | Medium |
| Phone Number | "phone" | Medium |

---

## 6. CONTENT HIERARCHY

```
Books
├── Sections (with difficulty level)
│   └── Paragraphs (with entities: people, places, events, dates)
│       └── Questions (4 options, with explanations)
```

**Language Support:** All content bilingual (Arabic/English)

---

## 7. FIRESTORE COLLECTIONS STRUCTURE

```
root/
├── users/
│   └── {userId}/
│       ├── profile, energy, subscription, etc.
│       └── quizProgress/ (subcollection)
│           └── current (answered questions list)
├── questions/
│   └── {questionId}
├── books/
│   └── {bookId}
│       ├── sections/
│       │   └── {sectionId}
│       │       └── paragraphs/
│       │           └── {paragraphId}
├── analytics/
│   └── {eventId}
└── subscriptions/ (if tracking purchases)
```

---

## 8. CALLING FIREBASE FUNCTIONS FROM FLUTTER

**Basic Pattern:**
```dart
import 'package:cloud_functions/cloud_functions.dart';

// Call a function
final callable = FirebaseFunctions.instance.httpsCallable('functionName');
final result = await callable.call({
  'param1': value1,
  'param2': value2,
});

// Access data
print(result.data['key']);
```

**Example - Get Energy Status:**
```dart
Future<Map> getEnergy() async {
  final callable = FirebaseFunctions.instance.httpsCallable('getEnergyStatus');
  final result = await callable.call();
  return {
    'currentEnergy': result.data['currentEnergy'],
    'maxEnergy': result.data['maxEnergy'],
    'canPlayQuiz': result.data['canPlayQuiz'],
  };
}
```

---

## 9. ERROR HANDLING IN CLOUD FUNCTIONS

Common error codes returned:
- **unauthenticated** - User not logged in
- **permission-denied** - User lacks permissions
- **not-found** - Resource not found
- **failed-precondition** - Insufficient energy, etc.
- **invalid-argument** - Bad parameters
- **internal** - Server error

---

## 10. FRONTEND TODO CHECKLIST

### Phase 1: Foundation
- [ ] Update pubspec.yaml with required packages
- [ ] Set up Firebase initialization in main()
- [ ] Implement Riverpod state management
- [ ] Create auth state provider
- [ ] Set up go_router for navigation

### Phase 2: Authentication
- [ ] Build login screen
- [ ] Build registration screen
- [ ] Build profile completion screen
- [ ] Implement Firebase Auth methods
- [ ] Add social login (Google, Apple)

### Phase 3: Core Features
- [ ] Build home/dashboard screen
- [ ] Implement energy status widget
- [ ] Build quiz screen
- [ ] Implement quiz question display
- [ ] Add answer submission logic

### Phase 4: User Features
- [ ] Settings screen (theme, language, notifications)
- [ ] User profile screen
- [ ] Quiz progress/statistics
- [ ] Books/collection screen
- [ ] Challenges screen

### Phase 5: Polish
- [ ] Theme system (light/dark)
- [ ] Localization (en/ar)
- [ ] Error handling & user feedback
- [ ] Loading states
- [ ] Offline support

---

## 11. KEY FILE LOCATIONS

**Backend:**
- Main index: `/home/user/Path_0f_Light/functions/src/index.ts`
- User management: `/home/user/Path_0f_Light/functions/src/userManagement.ts` (1085 lines)
- Energy system: `/home/user/Path_0f_Light/functions/src/energySystem.ts` (705 lines)
- Quiz: `/home/user/Path_0f_Light/functions/src/quizManagement.ts` (637 lines)
- Types: `/home/user/Path_0f_Light/functions/src/types.ts` (305 lines)

**Frontend:**
- Main app: `/home/user/Path_0f_Light/lib/main.dart`
- Screens: `/home/user/Path_0f_Light/lib/screens/`

**Documentation:**
- Auth guide: `/home/user/Path_0f_Light/functions/AUTHENTICATION_GUIDE.md`
- Integration guide: `/home/user/Path_0f_Light/functions/INTEGRATION_GUIDE.md`

---

## 12. IMPORTANT NOTES

1. **Energy is consumed per question** (not just on wrong answers)
2. **Energy refill is calculated on-demand** (no scheduled functions needed)
3. **Profile completion happens AFTER Firebase Auth** (2-step process)
4. **All quiz questions must be marked as verified** before appearing
5. **Privacy settings affect what data is returned** in getUserProfile
6. **Admin functions check user role** before execution
7. **Multiple auth providers can be linked** to same account
8. **Daily bonus is given once per day** (tracked by date)
9. **Ad cooldown is 5 minutes** between each ad reward
10. **Subscription plans auto-renew** except LIFETIME

