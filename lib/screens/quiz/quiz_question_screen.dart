import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../models/quiz/quiz_models.dart';
import '../../providers/quiz_providers.dart';
import '../../widgets/energy_display.dart';
import 'quiz_results_screen.dart';

class QuizQuestionScreen extends ConsumerStatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  ConsumerState<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends ConsumerState<QuizQuestionScreen> {
  String? selectedAnswer;
  AnswerResult? currentResult;
  bool showingResult = false;
  Timer? _resultTimer;

  @override
  void dispose() {
    _resultTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizSessionProvider);
    final currentQuestion = quizState.currentQuestion;

    if (quizState.isCompleted) {
      // Navigate to results
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const QuizResultsScreen()),
        );
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (currentQuestion == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${quizState.currentQuestionIndex + 1}/${quizState.session!.totalQuestions}'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: EnergyDisplay(showLabel: false),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          LinearProgressIndicator(
            value: (quizState.currentQuestionIndex + (showingResult ? 1 : 0)) /
                quizState.session!.totalQuestions,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Current Streak
                  if (quizState.answers.isNotEmpty)
                    Card(
                      color: AppTheme.error.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.local_fire_department, color: AppTheme.error),
                            const SizedBox(width: 8),
                            Text(
                              'Current Streak: ${quizState.answers.last.currentStreak}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Question Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.goldAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.stars, size: 16, color: AppTheme.goldAccent),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${currentQuestion.points} pts',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.goldAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.info.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  currentQuestion.difficulty.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.info,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentQuestion.question,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Answer Options
                  ...currentQuestion.options.entries.map((option) {
                    final isSelected = selectedAnswer == option.key;
                    Color? backgroundColor;
                    Color? borderColor;

                    if (showingResult && currentResult != null) {
                      if (option.key == currentResult!.correctAnswer) {
                        backgroundColor = AppTheme.success.withOpacity(0.1);
                        borderColor = AppTheme.success;
                      } else if (isSelected && !currentResult!.isCorrect) {
                        backgroundColor = AppTheme.error.withOpacity(0.1);
                        borderColor = AppTheme.error;
                      }
                    } else if (isSelected) {
                      backgroundColor = AppTheme.primaryTeal.withOpacity(0.1);
                      borderColor = AppTheme.primaryTeal;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _AnswerOption(
                        option: option.key,
                        text: option.value,
                        selected: isSelected,
                        backgroundColor: backgroundColor,
                        borderColor: borderColor,
                        onTap: showingResult ? null : () {
                          setState(() => selectedAnswer = option.key);
                        },
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 24),

                  // Submit Button
                  if (!showingResult)
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: selectedAnswer == null || quizState.isLoading
                            ? null
                            : _submitAnswer,
                        child: quizState.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Submit Answer',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),

                  // Result Card
                  if (showingResult && currentResult != null) ...[
                    Card(
                      color: currentResult!.isCorrect
                          ? AppTheme.success.withOpacity(0.1)
                          : AppTheme.error.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  currentResult!.isCorrect ? Icons.check_circle : Icons.cancel,
                                  color: currentResult!.isCorrect ? AppTheme.success : AppTheme.error,
                                  size: 32,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentResult!.isCorrect ? 'Correct!' : 'Incorrect',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: currentResult!.isCorrect ? AppTheme.success : AppTheme.error,
                                        ),
                                      ),
                                      Text(
                                        '+${currentResult!.pointsEarned} points',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(),
                            const SizedBox(height: 8),
                            Text(
                              'Explanation:',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(currentResult!.explanation),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        child: const Text(
                          'Next Question',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAnswer() async {
    if (selectedAnswer == null) return;

    final notifier = ref.read(quizSessionProvider.notifier);
    final result = await notifier.submitAnswer(selectedAnswer!);

    if (result != null && mounted) {
      setState(() {
        currentResult = result;
        showingResult = true;
      });

      // Auto advance after 5 seconds
      _resultTimer = Timer(const Duration(seconds: 5), _nextQuestion);
    }
  }

  void _nextQuestion() {
    _resultTimer?.cancel();
    setState(() {
      selectedAnswer = null;
      currentResult = null;
      showingResult = false;
    });
  }
}

class _AnswerOption extends StatelessWidget {
  final String option;
  final String text;
  final bool selected;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const _AnswerOption({
    required this.option,
    required this.text,
    required this.selected,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: selected ? 4 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? (selected ? AppTheme.primaryTeal : Colors.grey[300]!),
              width: selected || borderColor != null ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: borderColor?.withOpacity(0.2) ??
                      (selected ? AppTheme.primaryTeal.withOpacity(0.2) : Colors.grey[200]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: borderColor ?? (selected ? AppTheme.primaryTeal : AppTheme.textPrimary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
