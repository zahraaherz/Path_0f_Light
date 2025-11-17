# Firebase Cloud Functions - Path of Light

This directory contains Firebase Cloud Functions for the Shia Islamic Educational App.

## 📁 Project Structure

```
functions/
├── src/
│   ├── index.ts              # Main entry point, exports all functions
│   ├── batterySystem.ts      # Heart/energy management functions
│   └── quizManagement.ts     # Quiz game logic functions
├── lib/                      # Compiled JavaScript (auto-generated)
├── package.json              # Node.js dependencies
├── tsconfig.json             # TypeScript configuration
└── README.md                 # This file
```

## 🚀 Setup Instructions

### Prerequisites
- Node.js 18 or higher
- Firebase CLI installed: `npm install -g firebase-tools`
- Firebase project configured

### Installation

1. Navigate to the functions directory:
```bash
cd functions
```

2. Install dependencies:
```bash
npm install
```

3. Build TypeScript:
```bash
npm run build
```

## 🎮 Battery/Energy System Functions

### 1. `scheduledHeartRefill` (Scheduled)
**Trigger:** Runs every 1 hour via Cloud Scheduler
**Purpose:** Automatically refills hearts for users based on the 2-hour interval rule

**Configuration:**
- Max Hearts: 5
- Refill Interval: 2 hours
- Refill Amount: 1 heart per interval

**How it works:**
- Queries users with less than max hearts
- Calculates elapsed time since last refill
- Adds appropriate number of hearts (up to max)
- Updates user records in batches

### 2. `dailyBatteryReset` (Scheduled)
**Trigger:** Runs daily at midnight UTC
**Purpose:** Daily reset and bonus distribution

**Features:**
- Resets hearts to 5 for all users
- Updates daily login streaks
- Tracks daily statistics

### 3. `getBatteryStatus` (HTTP Callable)
**Called from:** App when user opens quiz section
**Purpose:** Get current heart count and refill time

**Request:**
```typescript
// No parameters needed (uses authenticated user ID)
```

**Response:**
```typescript
{
  currentHearts: number;
  maxHearts: number;
  nextRefillTime: string; // ISO timestamp
  canPlayQuiz: boolean;
  totalHeartsUsed: number;
}
```

### 4. `consumeHeart` (HTTP Callable)
**Called from:** App when user answers incorrectly
**Purpose:** Deduct one heart from user's battery

**Request:**
```typescript
{
  questionId: string;
}
```

**Response:**
```typescript
{
  success: boolean;
  currentHearts: number;
  message: string;
}
```

### 5. `restoreHearts` (HTTP Callable)
**Called from:** App when user watches ad or uses premium feature
**Purpose:** Add hearts through ads or premium subscription

**Request:**
```typescript
{
  method: 'ad' | 'premium' | 'purchase';
  heartsToAdd: number;
}
```

**Response:**
```typescript
{
  success: boolean;
  currentHearts: number;
  message: string;
}
```

## ❓ Quiz Management Functions

### 1. `getQuizQuestions` (HTTP Callable)
**Called from:** App when starting a quiz session
**Purpose:** Get random questions based on filters

**Request:**
```typescript
{
  category?: string; // e.g., 'prophet_muhammad', 'imam_ali'
  difficulty?: 'basic' | 'intermediate' | 'advanced' | 'expert';
  language?: 'en' | 'ar'; // Default: 'en'
  count?: number; // Default: 10
}
```

**Response:**
```typescript
{
  sessionId: string;
  questions: Array<{
    id: string;
    category: string;
    difficulty: string;
    question: string; // In requested language
    options: {
      A: string;
      B: string;
      C: string;
      D: string;
    };
    points: number;
  }>;
  totalQuestions: number;
}
```

**Features:**
- Checks user has available hearts
- Avoids previously answered questions
- Creates quiz session for tracking
- Returns questions in requested language

### 2. `submitQuizAnswer` (HTTP Callable)
**Called from:** App when user submits an answer
**Purpose:** Validate answer and update progress

**Request:**
```typescript
{
  questionId: string;
  answer: 'A' | 'B' | 'C' | 'D';
  sessionId: string;
  language?: 'en' | 'ar';
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
  source: {
    bookId: string;
    paragraphId: string;
    pageNumber: number;
    quote: string;
  };
  heartsRemaining: number;
}
```

**Features:**
- Validates answer against correct answer
- Updates user points and streaks
- Applies streak bonus multiplier (up to 2x)
- Consumes heart if answer is wrong
- Records answer in session
- Returns detailed explanation and source

**Point System:**
- Basic: 10 points
- Intermediate: 15 points
- Advanced: 20 points
- Expert: 25 points
- Streak Bonus: +10% per streak level (max 2x)

### 3. `getQuizProgress` (HTTP Callable)
**Called from:** App profile/stats screen
**Purpose:** Get user's overall quiz statistics

**Request:**
```typescript
// No parameters needed (uses authenticated user ID)
```

**Response:**
```typescript
{
  totalQuestionsAnswered: number;
  correctAnswers: number;
  wrongAnswers: number;
  currentStreak: number;
  longestStreak: number;
  totalPoints: number;
  accuracy: string; // Percentage as string
  categoryProgress: {
    [category: string]: {
      answered: number;
      correct: number;
      points: number;
    };
  };
  difficultyProgress: {
    basic: {answered: number; correct: number};
    intermediate: {answered: number; correct: number};
    advanced: {answered: number; correct: number};
    expert: {answered: number; correct: number};
  };
}
```

### 4. `endQuizSession` (HTTP Callable)
**Called from:** App when user finishes or exits quiz
**Purpose:** Complete session and get summary

**Request:**
```typescript
{
  sessionId: string;
}
```

**Response:**
```typescript
{
  sessionId: string;
  totalQuestions: number;
  correctAnswers: number;
  wrongAnswers: number;
  totalPoints: number;
  accuracy: string;
  duration: number; // Milliseconds
}
```

### 5. `getQuestionSource` (HTTP Callable)
**Called from:** App when user wants to read source
**Purpose:** Show exact paragraph from Islamic book

**Request:**
```typescript
{
  questionId: string;
  language?: 'en' | 'ar';
}
```

**Response:**
```typescript
{
  book: {
    id: string;
    title: string;
    author: string;
  };
  paragraph: {
    content: string;
    pageNumber: number;
    sectionTitle: string;
  };
  exactQuote: string;
}
```

## 🔧 Development Commands

### Build
```bash
npm run build        # Compile TypeScript once
npm run build:watch  # Watch mode for development
```

### Test Locally
```bash
npm run serve        # Start Firebase emulators
npm run shell        # Interactive functions shell
```

### Deploy
```bash
npm run deploy       # Deploy all functions to Firebase
```

### Logs
```bash
npm run logs         # View function logs
```

## 🗃️ Required Firestore Structure

### Users Collection
```typescript
users/{userId}
  - battery: {
      currentHearts: number;
      maxHearts: number;
      lastRefillTime: Timestamp;
      lastDailyResetDate: string;
      totalHeartsUsed: number;
      totalHeartsRefilled: number;
    }
  - quizProgress: {
      totalQuestionsAnswered: number;
      correctAnswers: number;
      wrongAnswers: number;
      currentStreak: number;
      longestStreak: number;
      totalPoints: number;
      categoryProgress: {...}
      difficultyProgress: {...}
    }
  - premium: {
      active: boolean;
      expiryDate: Timestamp;
    }
```

### Questions Collection
```typescript
questions/{questionId}
  - category: string
  - difficulty: string
  - question_ar: string
  - question_en: string
  - options: {...}
  - correct_answer: string
  - source: {...}
  - explanation_ar: string
  - explanation_en: string
  - points: number
```

### Books Collection
```typescript
books/{bookId}
  - title_ar: string
  - title_en: string
  - author_ar: string
  - author_en: string
  - total_sections: number
  - total_paragraphs: number
```

### Paragraphs Collection
```typescript
paragraphs/{paragraphId}
  - book_id: string
  - section_id: string
  - content: {
      text_ar: string
      text_en: string
    }
  - entities: {...}
  - search_data: {...}
```

## 🔐 Security Notes

1. All functions verify user authentication
2. Transactions ensure atomic updates
3. Input validation on all parameters
4. Rate limiting should be configured in Firebase Console
5. Proper error handling and logging

## 📊 Monitoring

Monitor function performance in Firebase Console:
- Invocation count
- Error rate
- Execution time
- Memory usage

## 🚀 Next Steps for Phase 2

Future functions to implement:
- Friend system functions
- Leaderboard calculations
- Achievement system
- Content management
- Analytics and reporting

## 📝 Notes

- Functions are written in TypeScript for type safety
- All functions support Arabic and English
- Scheduled functions use Cloud Scheduler (requires Blaze plan)
- HTTP callable functions are authenticated by default
- Transactions prevent race conditions in concurrent updates
