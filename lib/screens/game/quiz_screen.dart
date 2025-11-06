import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_of_light/services/auth_service.dart';
import 'package:path_of_light/services/game_service.dart';
import 'package:path_of_light/services/user_progress_service.dart';
import 'package:path_of_light/models/question.dart';
import 'package:path_of_light/constants/colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _isLoading = true;
  bool _isAnswerChecked = false;
  int _correctAnswers = 0;
  int _totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final gameService = Provider.of<GameService>(context, listen: false);

    final questions = await gameService.getRandomQuestions(
      limit: 5,
      difficulty: DifficultyLevel.basic,
    );

    if (questions.isNotEmpty) {
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No questions available yet. Please add questions to Firebase.'),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  void _checkAnswer() {
    if (_selectedAnswer == null) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    final isCorrect = _selectedAnswer!.toUpperCase() == currentQuestion.correctAnswer.toUpperCase();

    if (isCorrect) {
      _correctAnswers++;
      _totalPoints += currentQuestion.points;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    final progressService = Provider.of<UserProgressService>(context, listen: false);

    progressService.recordAnswer(
      userId: authService.currentUser!.uid,
      category: currentQuestion.category,
      isCorrect: isCorrect,
      pointsEarned: isCorrect ? currentQuestion.points : 0,
    );

    setState(() {
      _isAnswerChecked = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _isAnswerChecked = false;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, size: 64, color: AppColors.pointsColor),
            const SizedBox(height: 16),
            Text('Score: $_correctAnswers/${_questions.length}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Points: $_totalPoints',
                style: const TextStyle(fontSize: 18, color: AppColors.success)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _currentQuestionIndex = 0;
                _selectedAnswer = null;
                _isAnswerChecked = false;
                _correctAnswers = 0;
                _totalPoints = 0;
                _isLoading = true;
              });
              _loadQuestions();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}/${_questions.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: progress, backgroundColor: Colors.white24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(currentQuestion.questionEn,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    Text(currentQuestion.questionAr,
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center, textDirection: TextDirection.rtl),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: currentQuestion.options.entries.map((entry) {
                  final optionKey = entry.key;
                  final option = entry.value;
                  final isSelected = _selectedAnswer == optionKey;
                  final isCorrect = optionKey.toUpperCase() == currentQuestion.correctAnswer.toUpperCase();

                  Color? backgroundColor;
                  if (_isAnswerChecked) {
                    if (isCorrect) backgroundColor = AppColors.success.withOpacity(0.2);
                    else if (isSelected) backgroundColor = AppColors.error.withOpacity(0.2);
                  } else if (isSelected) {
                    backgroundColor = AppColors.primary.withOpacity(0.1);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: _isAnswerChecked ? null : () => setState(() => _selectedAnswer = optionKey),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: backgroundColor ?? Colors.white,
                          border: Border.all(
                            color: isSelected ? AppColors.primary : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(optionKey,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option.textEn, style: const TextStyle(fontSize: 16)),
                                  Text(option.textAr,
                                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                                      textDirection: TextDirection.rtl),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (!_isAnswerChecked)
              ElevatedButton(
                onPressed: _selectedAnswer == null ? null : _checkAnswer,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Submit Answer', style: TextStyle(fontSize: 18)),
              ),
            if (_isAnswerChecked)
              Card(
                color: AppColors.info.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info, color: AppColors.info),
                          SizedBox(width: 8),
                          Text('Explanation', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(currentQuestion.explanationEn),
                      Text(currentQuestion.explanationAr,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
