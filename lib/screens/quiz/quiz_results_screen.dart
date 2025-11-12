import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/quiz/quiz_models.dart';
import '../../providers/quiz_providers.dart';
import '../../widgets/energy_display.dart';
import 'quiz_start_screen.dart';

class QuizResultsScreen extends ConsumerStatefulWidget {
  const QuizResultsScreen({super.key});

  @override
  ConsumerState<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends ConsumerState<QuizResultsScreen> {
  QuizSummary? _summary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final notifier = ref.read(quizSessionProvider.notifier);
    final summary = await notifier.completeQuiz();

    if (mounted) {
      setState(() {
        _summary = summary;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizSessionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: EnergyDisplay(showLabel: false),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _summary == null
              ? _buildErrorView(quizState)
              : _buildResultsView(_summary!),
    );
  }

  Widget _buildErrorView(quizState) {
    final localSummary = QuizSummary(
      sessionId: quizState.session?.sessionId ?? '',
      totalQuestions: quizState.session?.totalQuestions ?? 0,
      correctAnswers: quizState.correctAnswersCount,
      wrongAnswers: quizState.answers.length - quizState.correctAnswersCount,
      totalPoints: quizState.totalPoints,
      accuracy: quizState.accuracy,
      energyConsumed: quizState.answers.length * (quizState.session?.energyPerQuestion ?? 10),
      durationSeconds: 0,
    );

    return _buildResultsView(localSummary);
  }

  Widget _buildResultsView(QuizSummary summary) {
    final accuracy = summary.accuracy;
    final isPerfect = summary.correctAnswers == summary.totalQuestions;
    final isGood = accuracy >= 70;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Celebration Header with Arabic
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isPerfect
                  ? AppTheme.goldAccent.withOpacity(0.1)
                  : isGood
                      ? AppTheme.success.withOpacity(0.1)
                      : AppTheme.primaryTeal.withOpacity(0.1),
              border: Border.all(
                color: isPerfect
                    ? AppTheme.goldAccent.withOpacity(0.3)
                    : isGood
                        ? AppTheme.success.withOpacity(0.3)
                        : AppTheme.primaryTeal.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  isPerfect
                      ? Icons.emoji_events
                      : isGood
                          ? Icons.check_circle
                          : Icons.done,
                  size: 64,
                  color: isPerfect
                      ? AppTheme.goldAccent
                      : isGood
                          ? AppTheme.success
                          : AppTheme.primaryTeal,
                ),
                const SizedBox(height: 16),
                Text(
                  isPerfect
                      ? 'الحَمدُ لِلّٰه'
                      : isGood
                          ? 'مَاشَاءَ ٱللّٰه'
                          : 'أَحسَنتَ',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: isPerfect
                            ? AppTheme.goldAccent
                            : isGood
                                ? AppTheme.success
                                : AppTheme.primaryTeal,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  isPerfect
                      ? 'Perfect Score!'
                      : isGood
                          ? 'Great Job!'
                          : 'Quiz Complete!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  isPerfect
                      ? 'Alhamdulillah! You got all questions correct!'
                      : isGood
                          ? 'MashaAllah! Keep up the good work!'
                          : 'Keep learning and improving!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Score Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Your Score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatCard(
                      icon: Icons.stars,
                      color: AppTheme.goldAccent,
                      label: 'Points',
                      value: summary.totalPoints.toString(),
                    ),
                    _StatCard(
                      icon: Icons.percent,
                      color: AppTheme.primaryTeal,
                      label: 'Accuracy',
                      value: '${accuracy.toStringAsFixed(1)}%',
                    ),
                    _StatCard(
                      icon: Icons.timer,
                      color: AppTheme.info,
                      label: 'Time',
                      value: _formatDuration(summary.durationSeconds),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Detailed Stats
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _DetailRow(
                  icon: Icons.quiz,
                  color: AppTheme.primaryTeal,
                  label: 'Total Questions',
                  value: summary.totalQuestions.toString(),
                ),
                const Divider(height: 24),
                _DetailRow(
                  icon: Icons.check_circle_outline,
                  color: AppTheme.success,
                  label: 'Correct Answers',
                  value: summary.correctAnswers.toString(),
                ),
                const Divider(height: 24),
                _DetailRow(
                  icon: Icons.cancel_outlined,
                  color: AppTheme.error,
                  label: 'Wrong Answers',
                  value: summary.wrongAnswers.toString(),
                ),
                const Divider(height: 24),
                _DetailRow(
                  icon: Icons.bolt_outlined,
                  color: AppTheme.warning,
                  label: 'Energy Consumed',
                  value: summary.energyConsumed.toString(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Progress Breakdown
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Answer Breakdown',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LinearProgressIndicator(
                      value: summary.totalQuestions > 0
                          ? summary.correctAnswers / summary.totalQuestions
                          : 0,
                      backgroundColor: AppTheme.error.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.success),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppTheme.success,
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Correct (${summary.correctAnswers})',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppTheme.error.withOpacity(0.2),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Wrong (${summary.wrongAnswers})',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Action Buttons
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _startNewQuiz,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Start New Quiz',
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

          const SizedBox(height: 12),

          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: _returnToHome,
              icon: const Icon(Icons.home),
              label: const Text(
                'Return to Home',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    if (seconds < 60) {
      return '${seconds}s';
    }
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  void _startNewQuiz() {
    ref.read(quizSessionProvider.notifier).resetQuiz();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const QuizStartScreen()),
    );
  }

  void _returnToHome() {
    ref.read(quizSessionProvider.notifier).resetQuiz();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
