# 🔥 Firebase Cloud Functions - Path of Light (UPDATED)

## 🆕 Major Updates - Cost-Optimized Energy System

This is the **revised and optimized** Firebase Functions implementation with:

✅ **Energy System** (instead of hearts/battery)
✅ **Lower Costs** (no scheduled functions)
✅ **Subscription Plans** (free with ads, premium)
✅ **Ad Rewards** (watch ads for free energy)
✅ **Content Management** (insert books, sections, paragraphs, questions)

---

## 📁 Project Structure

```
functions/
├── src/
│   ├── index.ts                # Main entry point
│   ├── energySystem.ts         # ⚡ NEW: Energy & subscription system
│   ├── quizManagement.ts       # 🎯 UPDATED: Quiz with energy integration
│   ├── contentManagement.ts    # 📚 NEW: Book/question insertion
│   └── types.ts                # TypeScript type definitions
├── package.json
├── tsconfig.json
├── .eslintrc.js
└── .gitignore
```

---

## ⚡ Energy System Functions (6 Functions)

### Why Energy Instead of Hearts?

**Old System (Hearts):**
- ❌ Scheduled functions running every hour = **expensive**
- ❌ Only lost hearts on wrong answers
- ❌ Fixed refill schedule

**New System (Energy):**
- ✅ On-demand calculations = **much cheaper**
- ✅ Energy consumed per question answered
- ✅ Energy refilled naturally (calculated when user opens app)
- ✅ Bonus energy for completing quizzes
- ✅ Ad rewards for free users
- ✅ Premium subscription benefits

### Energy Configuration

```typescript
MAX_ENERGY: 100 (free) / 200 (premium)
ENERGY_PER_QUESTION: 10 points
ENERGY_BONUS_ON_COMPLETION: 20 points
REFILL_RATE: 5 points/hour (free) / 10 points/hour (premium)
DAILY_LOGIN_BONUS: 50 points
AD_REWARD_ENERGY: 15 points per ad
MAX_ADS_PER_DAY: 10 ads
AD_COOLDOWN: 5 minutes between ads
```

---

### 1. `getEnergyStatus` ⚡

**Type:** HTTP Callable
**When to call:** When user opens quiz section or app

**What it does:**
- Calculates natural energy refill based on time elapsed (NO SCHEDULED FUNCTIONS!)
- Checks for daily bonus
- Updates energy automatically
- Returns current energy status

**Request:**
```typescript
// No parameters needed
```

**Response:**
```typescript
{
  currentEnergy: number;
  maxEnergy: number;
  canPlayQuiz: boolean;
  isPremium: boolean;
  dailyBonusAvailable: boolean;
  energyPerQuestion: number;
  adRewardEnergy: number;
}
```

**Flutter Example:**
```dart
final energy = await FirebaseFunctions.instance
  .httpsCallable('getEnergyStatus')
  .call();

print('Energy: ${energy.data['currentEnergy']}/${energy.data['maxEnergy']}');
```

---

### 2. `consumeEnergy` 🔋

**Type:** HTTP Callable
**When to call:** When user answers a question

**What it does:**
- Deducts 10 energy points per question
- Premium unlimited users bypass this
- Returns updated energy status

**Request:**
```typescript
{
  sessionId: string;
}
```

**Response:**
```typescript
{
  success: boolean;
  currentEnergy: number;
  energyConsumed: number;
  message: string;
}
```

---

### 3. `rewardQuizCompletion` 🎁

**Type:** HTTP Callable
**When to call:** After user completes a full quiz

**What it does:**
- Awards 20 bonus energy points
- Rewards users for finishing quizzes
- Logs completion for analytics

**Request:**
```typescript
{
  sessionId: string;
  questionsCompleted: number;
}
```

**Response:**
```typescript
{
  success: boolean;
  currentEnergy: number;
  energyRewarded: number;
  message: string;
}
```

---

### 4. `rewardAdWatch` 📺

**Type:** HTTP Callable
**When to call:** After user watches an ad

**What it does:**
- Awards 15 energy points
- Enforces 5-minute cooldown
- Limits to 10 ads per day
- Only for free users (premium users don't need ads)
- Logs ad views for analytics

**Request:**
```typescript
{
  adId: string;         // From ad provider
  adProvider: string;   // e.g., "AdMob", "Unity Ads"
}
```

**Response:**
```typescript
{
  success: boolean;
  currentEnergy: number;
  energyRewarded: number;
  adsRemaining: number;  // Ads left today
  message: string;
}
```

**Error Responses:**
- Daily limit reached
- Cooldown active (returns remaining seconds)
- Premium users don't need ads

---

### 5. `updateSubscription` 💳

**Type:** HTTP Callable
**When to call:** After successful payment/purchase

**What it does:**
- Activates premium subscription
- Updates energy limits (100 → 200)
- Sets expiry date based on plan
- Removes ads for premium users

**Subscription Plans:**
- `free`: Default, 100 energy, ads enabled
- `monthly`: 30 days, 200 energy, no ads
- `yearly`: 365 days, 200 energy, no ads
- `lifetime`: Forever, 200 energy, no ads

**Request:**
```typescript
{
  plan: "free" | "monthly" | "yearly" | "lifetime";
  purchaseToken: string;  // From payment verification
}
```

**Response:**
```typescript
{
  success: boolean;
  subscription: {
    plan: string;
    active: boolean;
    startDate: string;
    expiryDate: string | null;
    autoRenew: boolean;
  };
  message: string;
}
```

---

### 6. `checkSubscriptionStatus` 🔍

**Type:** HTTP Callable
**When to call:** On app startup, periodically

**What it does:**
- Checks if subscription is still active
- Auto-expires subscriptions past expiry date
- Downgrades energy limits if expired

**Request:**
```typescript
// No parameters needed
```

**Response:**
```typescript
{
  active: boolean;
  plan: string;
  expiryDate?: string;
  autoRenew: boolean;
  message: string;
}
```

---

## 🎯 Quiz Management Functions (5 Functions)

All quiz functions now integrate with the **energy system**.

### Changes from Old Version:
- ✅ Check energy before starting quiz
- ✅ Consume energy per question (not per wrong answer)
- ✅ Return energy status in all responses
- ✅ Only show verified questions

### 1. `getQuizQuestions`

**Request:**
```typescript
{
  category?: string;
  difficulty?: "basic" | "intermediate" | "advanced" | "expert";
  language?: "en" | "ar";
  count?: number;  // Default: 10
}
```

**Response:**
```typescript
{
  sessionId: string;
  questions: Question[];
  totalQuestions: number;
  energyPerQuestion: number;      // NEW
  totalEnergyNeeded: number;      // NEW
}
```

**Energy Check:**
- Verifies user has enough energy for full quiz
- If user has 50 energy but quiz needs 100 (10 questions × 10 energy), throws error

---

### 2. `submitQuizAnswer`

**Request:**
```typescript
{
  questionId: string;
  answer: "A" | "B" | "C" | "D";
  sessionId: string;
  language?: "en" | "ar";
}
```

**Response:**
```typescript
{
  isCorrect: boolean;
  correctAnswer: string;
  explanation: string;
  pointsEarned: number;
  currentStreak: number;
  energyConsumed: number;        // NEW: Always 10
  energyRemaining: number;       // NEW
  source: {...};
}
```

**Energy Mechanics:**
- Consumes 10 energy per question
- Consumes energy regardless of correct/wrong answer
- Returns remaining energy so UI can update

---

### 3. `getQuizProgress`
### 4. `endQuizSession`
### 5. `getQuestionSource`

*(Same as before, see main README.md for details)*

---

## 📚 Content Management Functions (10 Functions)

Brand new functions for managing Islamic educational content.

### 1. `insertBook` 📖

Insert a new Islamic book into the database.

**Request:**
```typescript
{
  title_ar: string;
  title_en: string;
  author_ar: string;
  author_en: string;
  language: string;        // "arabic", "english", etc.
  pdf_url?: string;
  version?: string;        // Default: "1.0"
}
```

**Response:**
```typescript
{
  success: boolean;
  bookId: string;
  message: string;
  book: BookData;
}
```

**Example:**
```dart
final result = await FirebaseFunctions.instance
  .httpsCallable('insertBook')
  .call({
    'title_ar': 'السيرة النبوية لابن هشام',
    'title_en': 'Sirat Ibn Hisham',
    'author_ar': 'ابن هشام',
    'author_en': 'Ibn Hisham',
    'language': 'arabic',
    'version': '1.0',
  });

print('Book ID: ${result.data['bookId']}');
```

---

### 2. `insertSection` 📑

Insert a section/chapter within a book.

**Request:**
```typescript
{
  book_id: string;
  section_number: number;
  title_ar: string;
  title_en: string;
  page_range?: string;      // e.g., "15-25"
  difficulty_level?: "basic" | "intermediate" | "advanced" | "expert";
  topics?: string[];
}
```

**Response:**
```typescript
{
  success: boolean;
  sectionId: string;
  message: string;
  section: SectionData;
}
```

---

### 3. `insertParagraph` 📝

Insert a single paragraph.

**Request:**
```typescript
{
  book_id: string;
  section_id: string;
  paragraph_number: number;
  page_number: number;
  text_ar: string;
  text_en?: string;
  entities?: {
    people?: string[];
    places?: string[];
    events?: string[];
    dates?: string[];
  };
  keywords_ar?: string[];
  keywords_en?: string[];
  difficulty?: "basic" | "intermediate" | "advanced" | "expert";
  content_priority?: "high" | "medium" | "low";
}
```

---

### 4. `bulkInsertParagraphs` 📚

Insert multiple paragraphs at once (more efficient).

**Request:**
```typescript
{
  book_id: string;
  section_id: string;
  paragraphs: Array<{
    paragraph_number: number;
    page_number: number;
    text_ar: string;
    text_en?: string;
    entities?: {...};
    search_data?: {...};
    metadata?: {...};
  }>;
}
```

**Response:**
```typescript
{
  success: boolean;
  paragraphsInserted: number;
  message: string;
}
```

**Batch Limit:** Max 450 paragraphs per call (Firestore limit is 500 operations)

---

### 5. `insertQuestion` ❓

Insert a single quiz question.

**Request:**
```typescript
{
  category: string;
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  question_ar: string;
  question_en: string;
  options: {
    A: {text_ar: string; text_en: string};
    B: {text_ar: string; text_en: string};
    C: {text_ar: string; text_en: string};
    D: {text_ar: string; text_en: string};
  };
  correct_answer: "A" | "B" | "C" | "D";
  source: {
    paragraph_id: string;
    book_id: string;
    exact_quote_ar: string;
    page_number: number;
  };
  explanation_ar: string;
  explanation_en: string;
}
```

**Response:**
```typescript
{
  success: boolean;
  questionId: string;
  message: string;
}
```

**Auto-calculated:**
- `points`: Based on difficulty (10/15/20/25)
- `verified`: Set to false (needs scholar verification)

---

### 6. `bulkInsertQuestions` 📋

Insert multiple questions at once.

**Request:**
```typescript
{
  questions: Array<QuestionData>;
}
```

**Response:**
```typescript
{
  success: boolean;
  questionsInserted: number;
  message: string;
}
```

**Batch Limit:** Max 450 questions per call

---

### 7. `verifyContent` ✅

Mark content as verified by an Islamic scholar.

**Request:**
```typescript
{
  contentType: "book" | "question";
  contentId: string;
}
```

**Response:**
```typescript
{
  success: boolean;
  message: string;
}
```

**What it does:**
- For books: Sets `content_status` to "verified"
- For questions: Sets `verified` to true
- Records who verified it and when

---

### 8. `publishBook` 🚀

Make a verified book available to all users.

**Request:**
```typescript
{
  bookId: string;
}
```

**Response:**
```typescript
{
  success: boolean;
  message: string;
}
```

**Requirements:**
- Book must be verified first
- Changes status from "verified" to "published"
- Only published books appear in search results

---

### 9. `searchBooks` 🔍

Search for books by title.

**Request:**
```typescript
{
  searchTerm?: string;
  language?: "en" | "ar";
  status?: "draft" | "verified" | "published";  // Default: "published"
  limit?: number;  // Default: 20
}
```

**Response:**
```typescript
{
  success: boolean;
  books: Array<Book>;
  count: number;
}
```

**Note:** For better search, consider integrating Algolia or Elasticsearch in production.

---

### 10. `getBookDetails` 📖

Get complete book information with all sections.

**Request:**
```typescript
{
  bookId: string;
}
```

**Response:**
```typescript
{
  success: boolean;
  book: Book;
  sections: Array<Section>;
}
```

---

## 💰 Monetization Strategy

### Free Users
- 100 energy max
- 5 energy refill per hour
- Can watch ads (15 energy per ad, max 10/day)
- Ads shown during quiz
- 50 energy daily login bonus

### Premium Users (Monthly/Yearly/Lifetime)
- 200 energy max
- 10 energy refill per hour (2x faster)
- No ads
- 50 energy daily login bonus
- Exclusive content (future)

---

## 📊 Cost Optimization

### Old System (Expensive):
```
scheduledHeartRefill: Runs every 1 hour for all users
dailyBatteryReset: Runs every day for all users

With 10,000 users:
- 24 scheduled runs/day (heart refill)
- 1 scheduled run/day (daily reset)
- Each run queries all users
- Cost: ~$50-100/month in Cloud Functions
```

### New System (Cheap):
```
All calculations done on-demand when user opens app
No scheduled functions at all

With 10,000 users:
- 0 scheduled runs
- Energy calculated in getEnergyStatus (only when called)
- Cost: ~$5-10/month in Cloud Functions
```

**Savings: 80-90% reduction in Cloud Functions costs! 💰**

---

## 🚀 Deployment

### 1. Install Dependencies
```bash
cd functions
npm install
```

### 2. Build TypeScript
```bash
npm run build
```

### 3. Test Locally (Optional)
```bash
npm run serve
```

### 4. Deploy to Firebase
```bash
npm run deploy
```

---

## 📱 Flutter Integration

### Setup
```yaml
# pubspec.yaml
dependencies:
  cloud_functions: ^4.5.0
  firebase_core: ^2.24.0
```

### Example: Complete Quiz Flow with Energy

```dart
class QuizFlow {
  Future<void> playQuiz() async {
    // 1. Check energy
    final energyStatus = await FirebaseFunctions.instance
      .httpsCallable('getEnergyStatus')
      .call();

    final currentEnergy = energyStatus.data['currentEnergy'];
    final energyPerQuestion = energyStatus.data['energyPerQuestion'];

    if (currentEnergy < energyPerQuestion * 10) {
      // Not enough energy
      showEnergyDialog();
      return;
    }

    // 2. Get questions
    final quiz = await FirebaseFunctions.instance
      .httpsCallable('getQuizQuestions')
      .call({'category': 'prophet_muhammad', 'count': 10});

    final sessionId = quiz.data['sessionId'];
    final questions = quiz.data['questions'];

    // 3. Answer each question
    for (var question in questions) {
      final answer = await showQuestionDialog(question);

      final result = await FirebaseFunctions.instance
        .httpsCallable('submitQuizAnswer')
        .call({
          'questionId': question['id'],
          'answer': answer,
          'sessionId': sessionId,
        });

      // Show result
      showResultDialog(result.data);

      // Update UI with remaining energy
      updateEnergyDisplay(result.data['energyRemaining']);
    }

    // 4. End quiz and get completion bonus
    final summary = await FirebaseFunctions.instance
      .httpsCallable('endQuizSession')
      .call({'sessionId': sessionId});

    final reward = await FirebaseFunctions.instance
      .httpsCallable('rewardQuizCompletion')
      .call({
        'sessionId': sessionId,
        'questionsCompleted': questions.length,
      });

    // Show summary with energy reward
    showSummaryDialog(summary.data, reward.data);
  }

  void showEnergyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Not Enough Energy'),
        content: Text('Watch an ad to get more energy or wait for refill'),
        actions: [
          TextButton(
            onPressed: () => watchAd(),
            child: Text('Watch Ad (+15 Energy)'),
          ),
          TextButton(
            onPressed: () => upgradeToPremium(),
            child: Text('Get Premium'),
          ),
        ],
      ),
    );
  }

  Future<void> watchAd() async {
    // Show ad from AdMob/Unity Ads
    await showRewardedAd();

    // Reward user with energy
    final result = await FirebaseFunctions.instance
      .httpsCallable('rewardAdWatch')
      .call({
        'adId': adId,
        'adProvider': 'AdMob',
      });

    if (result.data['success']) {
      showSnackBar('You got +15 energy!');
      updateEnergyDisplay(result.data['currentEnergy']);
    }
  }
}
```

---

## 🗃️ Firestore Structure

### Users Collection
```typescript
users/{userId}
  - energy: {
      currentEnergy: number;
      maxEnergy: number;
      lastUpdateTime: Timestamp;
      lastDailyBonusDate: string;
      totalEnergyUsed: number;
      totalEnergyEarned: number;
    }
  - subscription: {
      plan: "free" | "monthly" | "yearly" | "lifetime";
      active: boolean;
      startDate: Timestamp | null;
      expiryDate: Timestamp | null;
      autoRenew: boolean;
    }
  - adTracking: {
      adsWatchedToday: number;
      lastAdWatchedTime: Timestamp | null;
      lastAdResetDate: string;
      totalAdsWatched: number;
    }
  - quizProgress: {...}
```

---

## 📈 Analytics Events

All functions log important events to `analytics` collection:

- `ad_watched`: Ad view tracking
- `quiz_completion`: Quiz completion with energy reward
- `subscription_activated`: Premium subscription purchases
- `heart_restore`: Energy restoration events

---

## ✅ Summary

**Total Functions: 21**

- ⚡ Energy System: 6 functions
- 🎯 Quiz Management: 5 functions
- 📚 Content Management: 10 functions

**Key Improvements:**
- 80-90% cost reduction (no scheduled functions!)
- Better user engagement (energy rewards for completion)
- Monetization ready (ads + subscriptions)
- Content management system for easy book/question insertion
- Fully integrated with subscription plans

---

## 🎯 Next Steps

1. Deploy functions to Firebase
2. Set up subscription plans in App Store / Play Store
3. Integrate ad provider (AdMob, Unity Ads)
4. Add Firestore security rules
5. Create admin panel for content management
6. Test energy system with real users

**Ready to deploy without deployment - as requested! 🚀**
