# Path of Light - Firebase Functions API Reference

## USER MANAGEMENT FUNCTIONS

### Authentication Triggers (Automatic)

#### onUserCreated
**Trigger:** Runs automatically when user registers
**Creates:** Complete user document in Firestore
```typescript
// Automatic - no Flutter call needed
// Triggered by: FirebaseAuth.instance.createUserWithEmailAndPassword()
```

**Example registration flow:**
```dart
// Step 1: Create auth account
final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
// Step 2: onUserCreated() runs automatically
// Step 3: Call completeUserProfile() to set displayName and language
```

---

### User Profile Functions

#### completeUserProfile
**Purpose:** Finish registration after auth account creation
**Callable from:** Authenticated users only
**Parameters:**
- `displayName` (string, required)
- `language` (string, required: "en" | "ar")
- `photoURL` (string, optional)

**Flutter Example:**
```dart
Future<void> completeUserProfile({
  required String displayName,
  required String language,
  String? photoURL,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('completeUserProfile');
  final result = await callable.call({
    'displayName': displayName,
    'language': language,
    if (photoURL != null) 'photoURL': photoURL,
  });
  
  return result.data['profile']; // Returns updated profile
}
```

**Response:**
```json
{
  "success": true,
  "message": "Profile completed successfully",
  "profile": {
    "displayName": "Ahmed Ali",
    "language": "en",
    "photoURL": "url_or_null"
  }
}
```

---

#### getUserProfile
**Purpose:** Get user profile (with privacy controls)
**Callable from:** Authenticated users only
**Parameters:**
- `userId` (string, optional - if not provided, returns own profile)

**Flutter Example:**
```dart
Future<Map<String, dynamic>> getUserProfile({String? userId}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('getUserProfile');
  final result = await callable.call(
    userId != null ? {'userId': userId} : {},
  );
  
  return {
    'profile': result.data['profile'],
    'energy': result.data['energy'],
    'quizProgress': result.data['quizProgress'],
    'settings': result.data['settings'],
  };
}
```

**Response (Own Profile):**
```json
{
  "success": true,
  "profile": {
    "uid": "user123",
    "email": "user@example.com",
    "displayName": "Ahmed Ali",
    "language": "en",
    "role": "user"
  },
  "energy": {
    "currentEnergy": 80,
    "maxEnergy": 100,
    "canPlayQuiz": true
  },
  "quizProgress": { /* ... */ },
  "settings": { /* ... */ }
}
```

---

#### updateUserProfile
**Purpose:** Update profile information
**Callable from:** Authenticated users only
**Parameters:**
- `displayName` (string, optional)
- `photoURL` (string, optional)
- `language` (string, optional)

**Flutter Example:**
```dart
Future<void> updateUserProfile({
  String? displayName,
  String? photoURL,
  String? language,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('updateUserProfile');
  final result = await callable.call({
    if (displayName != null) 'displayName': displayName,
    if (photoURL != null) 'photoURL': photoURL,
    if (language != null) 'language': language,
  });
  
  return result.data['success'];
}
```

---

#### updateUserSettings
**Purpose:** Update notifications, privacy, and preference settings
**Callable from:** Authenticated users only
**Parameters:**
```dart
{
  'notifications': {
    'enabled': bool,
    'prayerTimes': bool,
    'quizReminders': bool,
    'achievementUnlocked': bool,
  },
  'privacy': {
    'profileVisible': bool,
    'showInLeaderboard': bool,
    'allowFriendRequests': bool,
  },
  'preferences': {
    'theme': 'light' | 'dark',
    'fontSize': 'small' | 'medium' | 'large',
    'autoPlayAudio': bool,
  }
}
```

**Flutter Example:**
```dart
Future<void> updateUserSettings({
  Map<String, dynamic>? notifications,
  Map<String, dynamic>? privacy,
  Map<String, dynamic>? preferences,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('updateUserSettings');
  final result = await callable.call({
    if (notifications != null) 'notifications': notifications,
    if (privacy != null) 'privacy': privacy,
    if (preferences != null) 'preferences': preferences,
  });
  
  return result.data['success'];
}
```

---

#### updateLastActive
**Purpose:** Track login activity and update login streaks
**Callable from:** Authenticated users only
**Parameters:** None

**Flutter Example:**
```dart
Future<int> updateLastActive() async {
  final callable = FirebaseFunctions.instance.httpsCallable('updateLastActive');
  final result = await callable.call();
  
  return result.data['loginStreak']; // Returns updated streak
}
```

---

#### checkUsernameAvailability
**Purpose:** Check if username is already taken
**Callable from:** Anyone (no auth required)
**Parameters:**
- `username` (string, required)

**Flutter Example:**
```dart
Future<bool> checkUsernameAvailability(String username) async {
  final callable = FirebaseFunctions.instance.httpsCallable('checkUsernameAvailability');
  final result = await callable.call({'username': username});
  
  return result.data['available'] as bool;
}
```

---

#### deleteUserAccount
**Purpose:** Delete user account
**Callable from:** Authenticated users only
**Parameters:**
- `password` (string, optional - for email/password users)

**Flutter Example:**
```dart
Future<void> deleteUserAccount({String? password}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('deleteUserAccount');
  final result = await callable.call(
    password != null ? {'password': password} : {},
  );
  
  return result.data['success'];
}
```

---

### Email/Password Functions

#### sendEmailVerification
**Purpose:** Send email verification link
**Callable from:** Authenticated users only
**Parameters:** None

**Flutter Example:**
```dart
Future<String> sendEmailVerification() async {
  final callable = FirebaseFunctions.instance.httpsCallable('sendEmailVerification');
  final result = await callable.call();
  
  return result.data['link']; // In production, user receives via email
}
```

---

#### verifyEmailCode
**Purpose:** Mark email as verified after user clicks link
**Callable from:** Authenticated users only
**Parameters:**
- `code` (string, optional)

**Flutter Example:**
```dart
Future<void> verifyEmailCode({String? code}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('verifyEmailCode');
  final result = await callable.call(
    code != null ? {'code': code} : {},
  );
  
  return result.data['success'];
}
```

---

#### sendPasswordResetEmail
**Purpose:** Send password reset email
**Callable from:** Anyone (no auth required)
**Parameters:**
- `email` (string, required)

**Flutter Example:**
```dart
Future<void> sendPasswordResetEmail(String email) async {
  final callable = FirebaseFunctions.instance.httpsCallable('sendPasswordResetEmail');
  final result = await callable.call({'email': email});
  
  return result.data['link']; // In production, sent via email
}
```

---

### Social Authentication Functions

#### linkSocialProvider
**Purpose:** Link additional auth provider (Google/Apple/Facebook)
**Callable from:** Authenticated users only
**Parameters:**
- `provider` (string, required: "google.com" | "apple.com" | "facebook.com")

**Flutter Example:**
```dart
Future<void> linkSocialProvider(String provider) async {
  // Note: Linking is primarily done client-side with Firebase Auth
  // This function updates Firestore record
  final callable = FirebaseFunctions.instance.httpsCallable('linkSocialProvider');
  final result = await callable.call({'provider': provider});
  
  return result.data['success'];
}
```

---

#### unlinkSocialProvider
**Purpose:** Remove linked auth provider
**Callable from:** Authenticated users only
**Parameters:**
- `provider` (string, required)

**Flutter Example:**
```dart
Future<void> unlinkSocialProvider(String provider) async {
  final callable = FirebaseFunctions.instance.httpsCallable('unlinkSocialProvider');
  final result = await callable.call({'provider': provider});
  
  return result.data['success'];
}
```

---

### Admin-Only Functions

#### setUserRole
**Purpose:** Assign user role (ADMIN ONLY)
**Callable from:** Admin users only
**Parameters:**
- `userId` (string, required)
- `role` (string, required: "user" | "scholar" | "moderator" | "admin")

**Flutter Example:**
```dart
Future<void> setUserRole({
  required String userId,
  required String role,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('setUserRole');
  final result = await callable.call({
    'userId': userId,
    'role': role,
  });
  
  return result.data['success'];
}
```

---

#### suspendUser
**Purpose:** Disable user account (ADMIN ONLY)
**Callable from:** Admin users only
**Parameters:**
- `userId` (string, required)
- `reason` (string, optional)

**Flutter Example:**
```dart
Future<void> suspendUser({
  required String userId,
  String? reason,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('suspendUser');
  final result = await callable.call({
    'userId': userId,
    if (reason != null) 'reason': reason,
  });
  
  return result.data['success'];
}
```

---

#### unsuspendUser
**Purpose:** Re-enable user account (ADMIN ONLY)
**Callable from:** Admin users only
**Parameters:**
- `userId` (string, required)

**Flutter Example:**
```dart
Future<void> unsuspendUser(String userId) async {
  final callable = FirebaseFunctions.instance.httpsCallable('unsuspendUser');
  final result = await callable.call({'userId': userId});
  
  return result.data['success'];
}
```

---

## ENERGY SYSTEM FUNCTIONS

#### getEnergyStatus
**Purpose:** Get current energy with natural refill calculation
**Callable from:** Authenticated users only
**Parameters:** None

**Flutter Example:**
```dart
Future<EnergyStatus> getEnergyStatus() async {
  final callable = FirebaseFunctions.instance.httpsCallable('getEnergyStatus');
  final result = await callable.call();
  
  return EnergyStatus(
    currentEnergy: result.data['currentEnergy'],
    maxEnergy: result.data['maxEnergy'],
    canPlayQuiz: result.data['canPlayQuiz'],
    isPremium: result.data['isPremium'],
    dailyBonusAvailable: result.data['dailyBonusAvailable'],
    energyPerQuestion: result.data['energyPerQuestion'],
    adRewardEnergy: result.data['adRewardEnergy'],
  );
}
```

**Response:**
```json
{
  "currentEnergy": 80,
  "maxEnergy": 100,
  "canPlayQuiz": true,
  "isPremium": false,
  "dailyBonusAvailable": false,
  "energyPerQuestion": 10,
  "adRewardEnergy": 15
}
```

---

#### consumeEnergy
**Purpose:** Consume energy when answering question
**Callable from:** Authenticated users only
**Parameters:**
- `sessionId` (string, required)

**Flutter Example:**
```dart
Future<bool> consumeEnergy(String sessionId) async {
  final callable = FirebaseFunctions.instance.httpsCallable('consumeEnergy');
  final result = await callable.call({'sessionId': sessionId});
  
  if (result.data['success']) {
    print('Energy left: ${result.data['currentEnergy']}');
    return true;
  }
  
  print('Error: ${result.data['message']}');
  return false;
}
```

---

#### rewardQuizCompletion
**Purpose:** Award bonus energy for completing quiz
**Callable from:** Authenticated users only
**Parameters:**
- `sessionId` (string, required)
- `questionsCompleted` (number, required)

**Flutter Example:**
```dart
Future<int> rewardQuizCompletion({
  required String sessionId,
  required int questionsCompleted,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('rewardQuizCompletion');
  final result = await callable.call({
    'sessionId': sessionId,
    'questionsCompleted': questionsCompleted,
  });
  
  return result.data['currentEnergy'];
}
```

---

#### rewardAdWatch
**Purpose:** Award energy for watching ad
**Callable from:** Authenticated users only
**Parameters:**
- `adId` (string, optional)
- `adProvider` (string, optional)

**Flutter Example:**
```dart
Future<bool> rewardAdWatch({String? adId, String? adProvider}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('rewardAdWatch');
  final result = await callable.call({
    if (adId != null) 'adId': adId,
    if (adProvider != null) 'adProvider': adProvider,
  });
  
  return result.data['success'];
}
```

---

#### updateSubscription
**Purpose:** Activate subscription plan
**Callable from:** Authenticated users only
**Parameters:**
- `plan` (string, required: "monthly" | "yearly" | "lifetime")
- `purchaseToken` (string, optional - for verification)

**Flutter Example:**
```dart
Future<void> updateSubscription({
  required String plan,
  String? purchaseToken,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('updateSubscription');
  final result = await callable.call({
    'plan': plan,
    if (purchaseToken != null) 'purchaseToken': purchaseToken,
  });
  
  return result.data['subscription'];
}
```

---

#### checkSubscriptionStatus
**Purpose:** Check if subscription is active
**Callable from:** Authenticated users only
**Parameters:** None

**Flutter Example:**
```dart
Future<bool> checkSubscriptionStatus() async {
  final callable = FirebaseFunctions.instance.httpsCallable('checkSubscriptionStatus');
  final result = await callable.call();
  
  return result.data['active'] as bool;
}
```

---

## QUIZ FUNCTIONS

#### getQuizQuestions
**Purpose:** Get random questions for quiz session
**Callable from:** Authenticated users only
**Parameters:**
- `category` (string, optional)
- `difficulty` (string, optional: "basic" | "intermediate" | "advanced" | "expert")
- `language` (string, optional: "en" | "ar")
- `count` (number, optional - default 10)

**Flutter Example:**
```dart
Future<List<Question>> getQuizQuestions({
  String? category,
  String? difficulty,
  String language = 'en',
  int count = 10,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('getQuizQuestions');
  final result = await callable.call({
    if (category != null) 'category': category,
    if (difficulty != null) 'difficulty': difficulty,
    'language': language,
    'count': count,
  });
  
  final sessionId = result.data['sessionId'];
  final questions = (result.data['questions'] as List)
    .map((q) => Question.fromJson(q))
    .toList();
  
  return questions;
}
```

**Response:**
```json
{
  "sessionId": "session123",
  "questions": [
    {
      "id": "q1",
      "category": "history",
      "difficulty": "intermediate",
      "question": "What is...?",
      "options": {
        "A": "Option A",
        "B": "Option B",
        "C": "Option C",
        "D": "Option D"
      },
      "points": 15
    }
  ],
  "totalQuestions": 10
}
```

---

#### submitQuizAnswer
**Purpose:** Submit answer and validate
**Callable from:** Authenticated users only
**Parameters:**
- `questionId` (string, required)
- `answer` (string, required: "A" | "B" | "C" | "D")
- `sessionId` (string, required)
- `language` (string, optional)

**Flutter Example:**
```dart
Future<AnswerResult> submitQuizAnswer({
  required String questionId,
  required String answer,
  required String sessionId,
  String language = 'en',
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('submitQuizAnswer');
  final result = await callable.call({
    'questionId': questionId,
    'answer': answer,
    'sessionId': sessionId,
    'language': language,
  });
  
  return AnswerResult(
    isCorrect: result.data['isCorrect'],
    correctAnswer: result.data['correctAnswer'],
    explanation: result.data['explanation'],
    pointsEarned: result.data['pointsEarned'],
    heartsRemaining: result.data['heartsRemaining'],
  );
}
```

---

#### getQuizProgress
**Purpose:** Get user's quiz statistics
**Callable from:** Authenticated users only
**Parameters:**
- `userId` (string, optional)

**Flutter Example:**
```dart
Future<QuizProgressData> getQuizProgress() async {
  final callable = FirebaseFunctions.instance.httpsCallable('getQuizProgress');
  final result = await callable.call();
  
  return QuizProgressData.fromJson(result.data);
}
```

---

#### endQuizSession
**Purpose:** Complete quiz session and award bonuses
**Callable from:** Authenticated users only
**Parameters:**
- `sessionId` (string, required)
- `finalScore` (number, required)

**Flutter Example:**
```dart
Future<void> endQuizSession({
  required String sessionId,
  required int finalScore,
}) async {
  final callable = FirebaseFunctions.instance.httpsCallable('endQuizSession');
  final result = await callable.call({
    'sessionId': sessionId,
    'finalScore': finalScore,
  });
  
  return result.data['summary'];
}
```

---

#### getQuestionSource
**Purpose:** Get book/paragraph reference for question
**Callable from:** Authenticated users only
**Parameters:**
- `questionId` (string, required)

**Flutter Example:**
```dart
Future<QuestionSource> getQuestionSource(String questionId) async {
  final callable = FirebaseFunctions.instance.httpsCallable('getQuestionSource');
  final result = await callable.call({'questionId': questionId});
  
  return QuestionSource(
    bookId: result.data['bookId'],
    paragraphId: result.data['paragraphId'],
    pageNumber: result.data['pageNumber'],
    quote: result.data['quote'],
  );
}
```

---

## ERROR HANDLING PATTERNS

### Common Error Codes

```dart
try {
  final result = await callable.call(parameters);
  // Handle success
} on FirebaseFunctionsException catch (e) {
  final code = e.code;
  final message = e.message;
  
  switch (code) {
    case 'unauthenticated':
      // User not logged in
      break;
    case 'permission-denied':
      // User doesn't have permission
      break;
    case 'not-found':
      // Resource not found
      break;
    case 'failed-precondition':
      // Insufficient energy, etc.
      break;
    case 'invalid-argument':
      // Bad parameters
      break;
    default:
      // Generic server error
  }
}
```

---

## RESPONSE PATTERNS

Most functions follow this pattern:

**Success Response:**
```json
{
  "success": true,
  "message": "Action completed",
  "data": { /* function-specific data */ }
}
```

**Error Response:**
```json
{
  "success": false,
  "message": "Error description"
}
```

