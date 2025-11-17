# Flutter Integration Guide for Firebase Functions

This guide explains how to call the Firebase Cloud Functions from your Flutter app.

## 📦 Prerequisites

Add Firebase Functions to your Flutter app:

```yaml
# pubspec.yaml
dependencies:
  cloud_functions: ^4.5.0
  firebase_core: ^2.24.0
```

## 🔧 Setup

Initialize Firebase Functions in your Flutter app:

```dart
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

## 🎮 Battery System Integration

### 1. Get Battery Status

```dart
import 'package:cloud_functions/cloud_functions.dart';

Future<Map<String, dynamic>> getBatteryStatus() async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('getBatteryStatus');
    final result = await callable.call();

    return {
      'currentHearts': result.data['currentHearts'],
      'maxHearts': result.data['maxHearts'],
      'nextRefillTime': result.data['nextRefillTime'],
      'canPlayQuiz': result.data['canPlayQuiz'],
      'totalHeartsUsed': result.data['totalHeartsUsed'],
    };
  } catch (e) {
    print('Error getting battery status: $e');
    rethrow;
  }
}

// Usage Example
Widget buildBatteryWidget() {
  return FutureBuilder<Map<String, dynamic>>(
    future: getBatteryStatus(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      final battery = snapshot.data!;
      return Row(
        children: [
          Icon(Icons.favorite, color: Colors.red),
          Text('${battery['currentHearts']}/${battery['maxHearts']}'),
        ],
      );
    },
  );
}
```

### 2. Consume Heart (on wrong answer)

```dart
Future<Map<String, dynamic>> consumeHeart(String questionId) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('consumeHeart');
    final result = await callable.call({
      'questionId': questionId,
    });

    return {
      'success': result.data['success'],
      'currentHearts': result.data['currentHearts'],
      'message': result.data['message'],
    };
  } catch (e) {
    print('Error consuming heart: $e');
    rethrow;
  }
}
```

### 3. Restore Hearts (watch ad or premium)

```dart
Future<Map<String, dynamic>> restoreHearts({
  required String method, // 'ad', 'premium', or 'purchase'
  required int heartsToAdd,
}) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('restoreHearts');
    final result = await callable.call({
      'method': method,
      'heartsToAdd': heartsToAdd,
    });

    return {
      'success': result.data['success'],
      'currentHearts': result.data['currentHearts'],
      'message': result.data['message'],
    };
  } catch (e) {
    print('Error restoring hearts: $e');
    rethrow;
  }
}

// Example: After user watches ad
void onAdWatched() async {
  final result = await restoreHearts(
    method: 'ad',
    heartsToAdd: 1,
  );

  if (result['success']) {
    showSnackBar('Heart restored! You now have ${result['currentHearts']} hearts');
  }
}
```

## ❓ Quiz Integration

### 1. Start Quiz Session - Get Questions

```dart
Future<Map<String, dynamic>> getQuizQuestions({
  String? category,
  String? difficulty,
  String language = 'en',
  int count = 10,
}) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('getQuizQuestions');
    final result = await callable.call({
      if (category != null) 'category': category,
      if (difficulty != null) 'difficulty': difficulty,
      'language': language,
      'count': count,
    });

    return {
      'sessionId': result.data['sessionId'],
      'questions': result.data['questions'],
      'totalQuestions': result.data['totalQuestions'],
    };
  } on FirebaseFunctionsException catch (e) {
    if (e.code == 'failed-precondition') {
      // No hearts available
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Hearts Available'),
          content: Text('Watch an ad or wait for refill'),
          actions: [
            TextButton(
              onPressed: () => showAdForHearts(),
              child: Text('Watch Ad'),
            ),
          ],
        ),
      );
    }
    rethrow;
  }
}

// Complete Quiz Screen Example
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String sessionId;
  late List<dynamic> questions;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    startQuiz();
  }

  Future<void> startQuiz() async {
    final quizData = await getQuizQuestions(
      category: 'prophet_muhammad',
      difficulty: 'basic',
      language: 'en',
      count: 10,
    );

    setState(() {
      sessionId = quizData['sessionId'];
      questions = quizData['questions'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return CircularProgressIndicator();
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${currentQuestionIndex + 1}/${questions.length}'),
      ),
      body: QuestionWidget(
        question: question,
        onAnswerSelected: (answer) => submitAnswer(question['id'], answer),
      ),
    );
  }

  Future<void> submitAnswer(String questionId, String answer) async {
    final result = await submitQuizAnswer(
      questionId: questionId,
      answer: answer,
      sessionId: sessionId,
    );

    // Show result dialog
    showDialog(
      context: context,
      builder: (context) => AnswerResultDialog(
        isCorrect: result['isCorrect'],
        explanation: result['explanation'],
        pointsEarned: result['pointsEarned'],
        currentStreak: result['currentStreak'],
        source: result['source'],
      ),
    );

    // Update hearts display
    setState(() {
      // Update UI with result['heartsRemaining']
    });
  }
}
```

### 2. Submit Answer

```dart
Future<Map<String, dynamic>> submitQuizAnswer({
  required String questionId,
  required String answer,
  required String sessionId,
  String language = 'en',
}) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('submitQuizAnswer');
    final result = await callable.call({
      'questionId': questionId,
      'answer': answer,
      'sessionId': sessionId,
      'language': language,
    });

    return {
      'isCorrect': result.data['isCorrect'],
      'correctAnswer': result.data['correctAnswer'],
      'explanation': result.data['explanation'],
      'pointsEarned': result.data['pointsEarned'],
      'currentStreak': result.data['currentStreak'],
      'source': result.data['source'],
      'heartsRemaining': result.data['heartsRemaining'],
    };
  } catch (e) {
    print('Error submitting answer: $e');
    rethrow;
  }
}

// Answer Result Dialog Widget
class AnswerResultDialog extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final int pointsEarned;
  final int currentStreak;
  final Map<String, dynamic> source;

  const AnswerResultDialog({
    required this.isCorrect,
    required this.explanation,
    required this.pointsEarned,
    required this.currentStreak,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red,
          ),
          SizedBox(width: 8),
          Text(isCorrect ? 'Correct!' : 'Wrong Answer'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(explanation),
          SizedBox(height: 16),
          if (isCorrect) ...[
            Text('Points Earned: +$pointsEarned',
              style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Current Streak: $currentStreak 🔥'),
          ],
          SizedBox(height: 16),
          Text('Source:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Page ${source['pageNumber']}'),
          TextButton(
            onPressed: () => viewSource(source),
            child: Text('View Full Source'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Continue'),
        ),
      ],
    );
  }
}
```

### 3. Get Quiz Progress/Statistics

```dart
Future<Map<String, dynamic>> getQuizProgress() async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('getQuizProgress');
    final result = await callable.call();

    return {
      'totalQuestionsAnswered': result.data['totalQuestionsAnswered'],
      'correctAnswers': result.data['correctAnswers'],
      'wrongAnswers': result.data['wrongAnswers'],
      'currentStreak': result.data['currentStreak'],
      'longestStreak': result.data['longestStreak'],
      'totalPoints': result.data['totalPoints'],
      'accuracy': result.data['accuracy'],
      'categoryProgress': result.data['categoryProgress'],
      'difficultyProgress': result.data['difficultyProgress'],
    };
  } catch (e) {
    print('Error getting quiz progress: $e');
    rethrow;
  }
}

// Progress Screen Widget
class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getQuizProgress(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        final progress = snapshot.data!;

        return ListView(
          children: [
            StatCard(
              title: 'Total Questions',
              value: '${progress['totalQuestionsAnswered']}',
              icon: Icons.question_answer,
            ),
            StatCard(
              title: 'Accuracy',
              value: '${progress['accuracy']}%',
              icon: Icons.analytics,
            ),
            StatCard(
              title: 'Total Points',
              value: '${progress['totalPoints']}',
              icon: Icons.stars,
            ),
            StatCard(
              title: 'Current Streak',
              value: '${progress['currentStreak']} 🔥',
              icon: Icons.local_fire_department,
            ),
            // Category breakdown
            CategoryProgressWidget(
              categoryProgress: progress['categoryProgress'],
            ),
          ],
        );
      },
    );
  }
}
```

### 4. End Quiz Session

```dart
Future<Map<String, dynamic>> endQuizSession(String sessionId) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('endQuizSession');
    final result = await callable.call({
      'sessionId': sessionId,
    });

    return {
      'totalQuestions': result.data['totalQuestions'],
      'correctAnswers': result.data['correctAnswers'],
      'wrongAnswers': result.data['wrongAnswers'],
      'totalPoints': result.data['totalPoints'],
      'accuracy': result.data['accuracy'],
      'duration': result.data['duration'],
    };
  } catch (e) {
    print('Error ending quiz session: $e');
    rethrow;
  }
}

// Quiz Summary Dialog
void showQuizSummary(String sessionId) async {
  final summary = await endQuizSession(sessionId);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Quiz Complete! 🎉'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Score: ${summary['correctAnswers']}/${summary['totalQuestions']}'),
          Text('Accuracy: ${summary['accuracy']}%'),
          Text('Points Earned: ${summary['totalPoints']}'),
          Text('Time: ${Duration(milliseconds: summary['duration']).inMinutes}m'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Done'),
        ),
        TextButton(
          onPressed: () => startNewQuiz(),
          child: Text('Play Again'),
        ),
      ],
    ),
  );
}
```

### 5. View Question Source

```dart
Future<Map<String, dynamic>> getQuestionSource({
  required String questionId,
  String language = 'en',
}) async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('getQuestionSource');
    final result = await callable.call({
      'questionId': questionId,
      'language': language,
    });

    return {
      'book': result.data['book'],
      'paragraph': result.data['paragraph'],
      'exactQuote': result.data['exactQuote'],
    };
  } catch (e) {
    print('Error getting question source: $e');
    rethrow;
  }
}

// Source Viewer Screen
class SourceViewerScreen extends StatelessWidget {
  final String questionId;

  const SourceViewerScreen({required this.questionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Source Reference')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getQuestionSource(questionId: questionId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final source = snapshot.data!;
          final book = source['book'];
          final paragraph = source['paragraph'];

          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book['title'],
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text('by ${book['author']}'),
                SizedBox(height: 8),
                Text('Page ${paragraph['pageNumber']}'),
                SizedBox(height: 16),
                Text(
                  paragraph['sectionTitle'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(paragraph['content']),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    source['exactQuote'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

## 🎯 Best Practices

### 1. Error Handling

Always handle Firebase Functions errors properly:

```dart
try {
  final result = await callable.call(params);
  // Success
} on FirebaseFunctionsException catch (e) {
  switch (e.code) {
    case 'unauthenticated':
      // User not logged in
      navigateToLogin();
      break;
    case 'failed-precondition':
      // No hearts available
      showNoHeartsDialog();
      break;
    case 'not-found':
      // Question or user not found
      showErrorDialog('Content not found');
      break;
    default:
      showErrorDialog('An error occurred: ${e.message}');
  }
} catch (e) {
  // Other errors
  showErrorDialog('Unexpected error: $e');
}
```

### 2. Loading States

Show loading indicators while functions execute:

```dart
class QuizButton extends StatefulWidget {
  @override
  _QuizButtonState createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {
  bool _loading = false;

  Future<void> startQuiz() async {
    setState(() => _loading = true);

    try {
      final questions = await getQuizQuestions();
      // Navigate to quiz
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _loading ? null : startQuiz,
      child: _loading
        ? CircularProgressIndicator()
        : Text('Start Quiz'),
    );
  }
}
```

### 3. Caching

Cache battery status and progress to reduce function calls:

```dart
class BatteryService {
  Map<String, dynamic>? _cachedStatus;
  DateTime? _lastFetch;

  Future<Map<String, dynamic>> getBatteryStatus({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedStatus != null &&
        _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < Duration(minutes: 1)) {
      return _cachedStatus!;
    }

    _cachedStatus = await _fetchBatteryStatus();
    _lastFetch = DateTime.now();
    return _cachedStatus!;
  }
}
```

## 🧪 Testing

Test functions locally using Firebase Emulator:

```dart
// main.dart (debug mode)
if (kDebugMode) {
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
}
```

## 📱 Complete Flow Example

Here's a complete flow from starting a quiz to viewing results:

```dart
class QuizFlow {
  Future<void> playQuiz() async {
    // 1. Check battery
    final battery = await getBatteryStatus();
    if (!battery['canPlayQuiz']) {
      showNoHeartsDialog();
      return;
    }

    // 2. Get questions
    final quizData = await getQuizQuestions(
      category: 'prophet_muhammad',
      difficulty: 'basic',
    );

    // 3. For each question, submit answer
    for (var question in quizData['questions']) {
      final answer = await showQuestionDialog(question);
      final result = await submitQuizAnswer(
        questionId: question['id'],
        answer: answer,
        sessionId: quizData['sessionId'],
      );

      await showResultDialog(result);
    }

    // 4. End session and show summary
    final summary = await endQuizSession(quizData['sessionId']);
    showSummaryDialog(summary);

    // 5. Refresh progress
    final progress = await getQuizProgress();
    updateProgressUI(progress);
  }
}
```

## 🔐 Security

All functions automatically verify user authentication. Ensure users are signed in:

```dart
import 'package:firebase_auth/firebase_auth.dart';

// Check if user is authenticated
if (FirebaseAuth.instance.currentUser == null) {
  // Redirect to login
  Navigator.pushNamed(context, '/login');
}
```

---

This integration guide provides all the necessary code to connect your Flutter app with the Firebase Cloud Functions. Copy and adapt these examples to your specific needs!
