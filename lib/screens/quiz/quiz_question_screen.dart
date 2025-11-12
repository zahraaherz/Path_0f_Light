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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Question ${quizState.currentQuestionIndex + 1}/${quizState.session!.totalQuestions}'),
        backgroundColor: Colors.white,
        elevation: 0,
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
          Container(
            height: 4,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: LinearProgressIndicator(
              value: (quizState.currentQuestionIndex + (showingResult ? 1 : 0)) /
                  quizState.session!.totalQuestions,
              backgroundColor: Colors.grey.shade100,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Current Streak (if available)
                  if (quizState.answers.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.goldAccent.withOpacity(0.05),
                        border: Border.all(
                          color: AppTheme.goldAccent.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.local_fire_department, color: AppTheme.goldAccent, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Current Streak: ${quizState.answers.last.currentStreak}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldAccent,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Question Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.islamicGreen.withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.goldAccent.withOpacity(0.1),
                                border: Border.all(
                                  color: AppTheme.goldAccent.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.stars, size: 14, color: AppTheme.goldAccent),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${currentQuestion.points} pts',
                                    style: const TextStyle(
                                      fontSize: 12,
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
                                color: AppTheme.info.withOpacity(0.1),
                                border: Border.all(
                                  color: AppTheme.info.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
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
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Answer Options
                  ...currentQuestion.options.entries.map((option) {
                    final isSelected = selectedAnswer == option.key;
                    Color? backgroundColor;
                    Color? borderColor;
                    IconData? iconData;

                    if (showingResult && currentResult != null) {
                      if (option.key == currentResult!.correctAnswer) {
                        backgroundColor = AppTheme.success.withOpacity(0.05);
                        borderColor = AppTheme.success;
                        iconData = Icons.check_circle;
                      } else if (isSelected && !currentResult!.isCorrect) {
                        backgroundColor = AppTheme.error.withOpacity(0.05);
                        borderColor = AppTheme.error;
                        iconData = Icons.cancel;
                      }
                    } else if (isSelected) {
                      backgroundColor = AppTheme.primaryTeal.withOpacity(0.05);
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
                        icon: iconData,
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryTeal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),

                  // Result Card
                  if (showingResult && currentResult != null) ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: currentResult!.isCorrect
                            ? AppTheme.success.withOpacity(0.05)
                            : AppTheme.error.withOpacity(0.05),
                        border: Border.all(
                          color: currentResult!.isCorrect
                              ? AppTheme.success.withOpacity(0.3)
                              : AppTheme.error.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.goldAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Divider(color: Colors.grey.shade300),
                          const SizedBox(height: 12),
                          Text(
                            'Explanation:',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentResult!.explanation,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.5,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _nextQuestion,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text(
                          'Next Question',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryTeal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
  final IconData? icon;
  final VoidCallback? onTap;

  const _AnswerOption({
    required this.option,
    required this.text,
    required this.selected,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? (selected ? AppTheme.primaryTeal : Colors.grey.shade300),
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
                color: borderColor?.withOpacity(0.1) ??
                    (selected ? AppTheme.primaryTeal.withOpacity(0.1) : Colors.grey.shade100),
                border: Border.all(
                  color: borderColor ??
                      (selected ? AppTheme.primaryTeal : Colors.grey.shade300),
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: icon != null
                    ? Icon(icon, color: borderColor, size: 20)
                    : Text(
                        option,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: borderColor ?? (selected ? AppTheme.primaryTeal : AppTheme.textPrimary),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
