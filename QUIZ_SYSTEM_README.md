# Enhanced Quiz System - Path of Light

## Overview

A comprehensive, Duolingo-style quiz system with multiple question types, bilingual support (Arabic/English), book source references, and multiplayer challenge mode.

## Features

### ✨ Multiple Question Types
1. **Multiple Choice** - Traditional 4-option questions
2. **True/False** - Simple binary choice questions
3. **Fill in the Blank** - Complete the sentence questions
4. **Matching** - Match items from two columns

### 📚 Book Source Integration
- Every question shows its source book and page number
- Displays exact quote from the book in Arabic
- **Save Book** - Add book to your collection without leaving the quiz
- **Go to Book** - Navigate to the book (with warning that game will end)

### 🎮 Challenge Mode
Three ways to play against others:
1. **Random Match** - Find a player with similar skill level
2. **Friends** - Challenge friends from your list (with online status)
3. **Top Players** - Challenge leaderboard champions

### 🌍 Bilingual Support
- Full Arabic and English support
- Questions available in both languages
- RTL layout for Arabic text
- Proper font handling (Amiri for Arabic, Cairo for UI)

### 🎨 Beautiful Design
- Islamic-inspired color scheme (Teal, Gold, Sage Green)
- Smooth animations and transitions
- Clean, minimalist interface
- Responsive layout

## Files Created

### Models
- `lib/models/quiz/quiz_models.dart` - Updated with:
  - `EnhancedQuestion` - New question model matching JSON structure
  - `QuestionSource` - Book source information
  - `QuestionType` enum - Different question formats
  - Updated `AnswerResult` and `AnswerSource` with Arabic support

### Screens
1. `lib/screens/quiz/enhanced_quiz_screen.dart`
   - Main quiz screen with bilingual support
   - Book source display
   - Save/redirect functionality
   - Answer validation and feedback

2. `lib/screens/quiz/challenge_mode_screen.dart`
   - Random matching
   - Friends list with search
   - Top players leaderboard
   - Online status indicators

### Widgets
- `lib/widgets/quiz/question_type_widgets.dart`
  - `TrueFalseQuestion` - Binary choice widget
  - `FillInBlankQuestion` - Sentence completion widget
  - `MatchingQuestion` - Matching pairs widget

### Data
- `lib/data/mock_questions.json` - 8 sample questions demonstrating:
  - Different difficulty levels (basic, intermediate, advanced, expert)
  - Various categories (Prophet Muhammad, Imam Ali, Quran, Hadith, etc.)
  - Both multiple choice and true/false types
  - Complete book source information

## JSON Structure

### Question Format
```json
{
  "q_001": {
    "id": "q_001",
    "category": "prophet_muhammad",
    "difficulty": "basic",
    "question_type": "multiple_choice",
    "question_ar": "في أي عام وُلد النبي محمد؟",
    "question_en": "In which year was Prophet Muhammad born?",
    "options": {
      "A": {
        "text_ar": "عام الفيل",
        "text_en": "Year of the Elephant"
      },
      "B": {
        "text_ar": "عام الحزن",
        "text_en": "Year of Sorrow"
      }
    },
    "correct_answer": "A",
    "source": {
      "paragraph_id": "para_001",
      "book_id": "book_001",
      "book_title_ar": "السيرة النبوية",
      "book_title_en": "The Life of Prophet Muhammad",
      "exact_quote_ar": "وُلد محمد بن عبد الله...",
      "page_number": 15
    },
    "explanation_ar": "وُلد النبي محمد...",
    "explanation_en": "Prophet Muhammad was born...",
    "points": 10,
    "verified": true
  }
}
```

## Setup Instructions

### 1. Run Code Generation

**IMPORTANT:** You must run this command to generate the freezed and JSON serialization code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `quiz_models.freezed.dart`
- `quiz_models.g.dart`

### 2. Import Required Packages

Ensure your `pubspec.yaml` has:
```yaml
dependencies:
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  flutter_riverpod: ^2.4.9
  google_fonts: ^6.1.0

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

### 3. Update Imports

Add these screens to your navigation:

```dart
// For enhanced quiz
import 'package:path_of_light/screens/quiz/enhanced_quiz_screen.dart';

// For challenge mode
import 'package:path_of_light/screens/quiz/challenge_mode_screen.dart';

// For question type widgets
import 'package:path_of_light/widgets/quiz/question_type_widgets.dart';
```

## Usage Examples

### Display Enhanced Quiz Screen

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => EnhancedQuizScreen(
      question: enhancedQuestion,
      currentIndex: 0,
      totalQuestions: 10,
      languageCode: 'en', // or 'ar' for Arabic
    ),
  ),
);
```

### Open Challenge Mode

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const ChallengeModeScreen(),
  ),
);
```

### Use Different Question Types

```dart
// True/False Question
TrueFalseQuestion(
  question: 'The Quran was revealed on Laylat al-Qadr',
  selectedAnswer: selectedAnswer,
  onAnswerSelected: (answer) => setState(() => selectedAnswer = answer),
  showResult: showResult,
  correctAnswer: 'A',
  isArabic: false,
)

// Fill in the Blank
FillInBlankQuestion(
  question: 'Prophet Muhammad was born in the year of _____',
  blankText: '_____',
  options: ['Elephant', 'Sorrow', 'Conquest', 'Hijra'],
  selectedAnswer: selectedAnswer,
  onAnswerSelected: (answer) => setState(() => selectedAnswer = answer),
)

// Matching Question
MatchingQuestion(
  leftItems: {'A': 'Imam Ali', 'B': 'Imam Hassan'},
  rightItems: {'1': 'First Imam', '2': 'Second Imam'},
  selectedMatches: selectedMatches,
  onMatchSelected: (left, right) {
    setState(() => selectedMatches[left] = right);
  },
)
```

## Design Patterns

### Theme Colors
- **Primary Teal**: `#0D9488` - Main actions, selected states
- **Gold Accent**: `#C9A961` - Points, rewards, highlights
- **Islamic Green**: `#7C9C8E` - Success, correct answers
- **Error Red**: `#DC2626` - Wrong answers, warnings
- **Info Blue**: `#0EA5E9` - Information, difficulty badges

### Typography
- **Arabic Text**: Amiri font family (elegant, traditional)
- **UI Text**: Cairo font family (modern, clean)
- **Titles**: Bold, size 22-28
- **Body**: Regular, size 14-16

### Layout
- **Padding**: 16-24px around containers
- **Border Radius**: 12-16px for cards and buttons
- **Spacing**: 12-20px between elements
- **Elevation**: Subtle shadows (2-4dp)

## Features in Detail

### Book Source Display

When a user answers a question, they see:
1. **Whether they're correct or wrong** with visual feedback
2. **Detailed explanation** in their chosen language
3. **Book source card** showing:
   - Book title (Arabic & English)
   - Page number
   - Exact quote from the book (Arabic)
   - Two action buttons:
     - **Save Book**: Adds to collection, continues game
     - **Go to Book**: Shows warning, then navigates (ends game)

### Challenge Mode Flow

1. **Select Match Type**:
   - Random: Algorithm matches similar skill levels
   - Friends: Search and select from friends list
   - Top Players: Challenge leaderboard champions

2. **Configure Match**:
   - Choose difficulty level
   - Select category/topic
   - Set number of questions

3. **Match Found**:
   - Shows opponent details
   - Displays their stats (level, wins, score)
   - Countdown before start

4. **Play**:
   - Take turns or simultaneous play
   - Live score tracking
   - Winner determined by points

### Difficulty Levels

- **Basic** (10 points): Simple facts, basic knowledge
- **Intermediate** (15 points): Moderate complexity
- **Advanced** (20 points): Detailed knowledge required
- **Expert** (25 points): Scholars and advanced students

### Categories

1. Prophet Muhammad (prophet_muhammad)
2. Imam Ali (imam_ali)
3. Imam Hussain (imam_hussain)
4. Imam Mahdi (imam_mahdi)
5. Holy Quran (quran)
6. Hadith (hadith)
7. Fiqh/Jurisprudence (fiqh)
8. Islamic History (history)

## Integration with Existing System

### Energy System
The quiz consumes energy per question. The enhanced screens integrate with the existing `EnergyDisplay` widget shown in the app bar.

### Points & Rewards
Points are awarded based on:
- Difficulty level (10-25 points)
- Streak bonus (multiplier)
- Speed bonus (optional)

### Book Collection
When users save a book:
1. Book is added to Firestore user collection
2. Notification shown
3. Game continues without interruption

### Navigation to Books
When users go to book:
1. Warning dialog shows (game will end)
2. User confirms
3. Navigate to book reading screen
4. Quiz progress is saved

## Mock Data

The `mock_questions.json` file contains 8 questions covering:
- ✅ Multiple choice questions (6)
- ✅ True/False questions (2)
- ✅ Different difficulty levels
- ✅ Various Islamic topics
- ✅ Complete book source info
- ✅ Bilingual text (Arabic/English)

## Next Steps

### Backend Integration
1. Create Firestore collections for:
   - Enhanced questions
   - Challenge matches
   - User statistics

2. Firebase Functions for:
   - Random player matching
   - Challenge invitations
   - Score calculation

### Additional Features
1. **Timer**: Add countdown for each question
2. **Lifelines**: 50/50, Skip, Ask Community
3. **Achievements**: Unlock badges for milestones
4. **Streaks**: Daily quiz streaks with rewards
5. **Tournaments**: Weekly/monthly competitions
6. **Practice Mode**: Review wrong answers

### Analytics
Track:
- Question difficulty vs success rate
- Most challenging categories
- Average completion time
- Popular challenge opponents

## Troubleshooting

### Build Runner Issues
If code generation fails:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Import Errors
Ensure all paths are correct:
- Models: `lib/models/quiz/`
- Screens: `lib/screens/quiz/`
- Widgets: `lib/widgets/quiz/`
- Theme: `lib/config/theme/`

### JSON Parsing
If questions don't load:
1. Validate JSON syntax
2. Check field names match model
3. Ensure all required fields present

## Contributing

When adding new question types:
1. Update `QuestionType` enum in `quiz_models.dart`
2. Create widget in `question_type_widgets.dart`
3. Add example to `mock_questions.json`
4. Update this README

## License

Part of the Path of Light Islamic Education App.

---

**Built with ❤️ for Islamic education**
