# 🌙 Path of Light - درب النور

A comprehensive Shia Islamic educational quiz game app built with Flutter and Firebase.

## 📋 Overview

**Path of Light** is an interactive Islamic educational application that combines engaging gamification with authentic Shia Islamic content. The app features a quiz game system where users can learn about:

- The 14 Infallibles (Prophet Muhammad, 12 Imams, Lady Fatimah)
- Islamic Companions and Scholars
- Islamic Practices (Prayer, Fasting, Hajj, etc.)
- Quran and Islamic History
- Islamic Ethics

## ✨ Features

### 🎮 Quiz Game System
- **Multiple Categories**: Questions about the 14 Infallibles, companions, practices, and more
- **Difficulty Levels**: Basic, Intermediate, Advanced, and Expert
- **Battery System**: 5 hearts, lose 1 per wrong answer, refills naturally
- **Points & Achievements**: Earn points based on difficulty and track progress
- **Daily Streaks**: Maintain learning momentum with daily play streaks

### 📊 Progress Tracking
- Real-time progress synchronization with Firebase
- Category-specific performance tracking
- Accuracy statistics and achievement tracking
- Leaderboard ready architecture

### 🌐 Multi-language Support
- Arabic and English interface
- All questions available in both languages
- RTL (Right-to-Left) support for Arabic text

## 🏗️ Architecture

### Database Models
- **Book**: Islamic book information and metadata
- **Section**: Book sections for organized content
- **Paragraph**: Detailed paragraph content with entities and search data
- **Question**: Quiz questions with multiple choice options
- **UserProgress**: User game progress, battery system, and achievements
- **Level**: Game levels with category and difficulty

### Services
- **AuthService**: Firebase Authentication management
- **GameService**: Question fetching and game logic
- **UserProgressService**: Progress tracking and battery management

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.2.3)
- Firebase account with project set up
- Dart (comes with Flutter)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Path_0f_Light
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [https://console.firebase.google.com](https://console.firebase.google.com)
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Add your Flutter app to Firebase
   - Download and add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Run `flutterfire configure` to generate firebase_options.dart

4. **Firestore Security Rules**
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       match /user_progress/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       match /questions/{questionId} {
         allow read: if request.auth != null;
       }
       match /levels/{levelId} {
         allow read: if request.auth != null;
       }
       match /books/{bookId} {
         allow read: if request.auth != null;
       }
     }
   }
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📚 Database Structure

### Firestore Collections

#### questions
```json
{
  "category": "prophet_muhammad",
  "difficulty": "basic",
  "type": "multiple_choice",
  "question_ar": "في أي عام وُلد النبي محمد؟",
  "question_en": "In which year was Prophet Muhammad born?",
  "options": {
    "A": {"text_ar": "عام الفيل", "text_en": "Year of the Elephant"},
    "B": {"text_ar": "عام الحزن", "text_en": "Year of Sorrow"}
  },
  "correct_answer": "A",
  "explanation_ar": "وُلد النبي محمد في عام الفيل",
  "explanation_en": "Prophet Muhammad was born in the Year of the Elephant",
  "points": 10,
  "is_active": true
}
```

#### user_progress
```json
{
  "total_points": 150,
  "current_level": 1,
  "total_questions_answered": 25,
  "total_correct_answers": 20,
  "battery_system": {
    "current_hearts": 5,
    "max_hearts": 5
  },
  "daily_streak": {
    "current_streak": 3,
    "longest_streak": 7
  }
}
```

## 🎯 Adding Sample Questions

To test the app, add sample questions to Firestore:

1. Go to Firebase Console > Firestore Database
2. Create a new collection called `questions`
3. Add documents with the structure shown above
4. Start with at least 5-10 questions for testing

## 🎨 Design

The app uses a green Islamic theme with:
- Primary Color: Deep Green (#1B5E20)
- Secondary Color: Gold (#FFD700)
- Custom icons and Arabic typography support
- Material 3 design system

## 📱 Screens

1. **Login/Register**: User authentication
2. **Home Screen**: Dashboard with user stats and quick play
3. **Quiz Screen**: Main gameplay with questions and answers
4. **Results Screen**: Score display and replay options

## 🛣️ Roadmap

### Phase 1 (Current)
- ✅ Core game engine
- ✅ Authentication system
- ✅ Progress tracking
- ✅ Basic quiz gameplay

### Phase 2 (Planned)
- [ ] Social features (friends, leaderboards)
- [ ] Multiple categories and levels
- [ ] Achievement system
- [ ] Daily challenges

### Phase 3 (Future)
- [ ] Complete Islamic text library
- [ ] Audio recitations
- [ ] Virtual Ziyarah experiences
- [ ] Islamic marketplace

## 🤝 Contributing

Contributions are welcome! Please ensure:
- All Islamic content is authentic and properly sourced
- Code follows Flutter best practices
- UI/UX maintains Islamic theme and aesthetics

## 📄 License

This project is for educational purposes and should be used to spread authentic Islamic knowledge.

## 📞 Support

For questions or support, please open an issue on the repository.

---

**Built with ❤️ for the Islamic community**
