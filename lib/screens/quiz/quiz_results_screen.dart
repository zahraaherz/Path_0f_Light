import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/quiz/quiz_models.dart';
import '../../providers/quiz_providers.dart';
import '../../widgets/energy_display.dart';
import '../../utils/responsive.dart';
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
    final r = context.responsive;
    final quizState = ref.watch(quizSessionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: r.spaceSmall),
            child: const EnergyDisplay(showLabel: false),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _summary == null
              ? _buildErrorView(quizState, r)
              : _buildResultsView(_summary!, r),
    );
  }

  Widget _buildErrorView(quizState, Responsive r) {
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

    return _buildResultsView(localSummary, r);
  }

  Widget _buildResultsView(QuizSummary summary, Responsive r) {
    final accuracy = summary.accuracy;
    final isPerfect = summary.correctAnswers == summary.totalQuestions;
    final isGood = accuracy >= 70;

    return SingleChildScrollView(
      padding: EdgeInsets.all(r.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Celebration Header with Arabic
          Container(
            padding: EdgeInsets.all(r.paddingLarge * 1.5),
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
              borderRadius: BorderRadius.circular(r.radiusMedium),
            ),
            child: Column(
              children: [
                Icon(
                  isPerfect
                      ? Icons.emoji_events
                      : isGood
                          ? Icons.check_circle
                          : Icons.done,
                  size: r.iconXLarge,
                  color: isPerfect
                      ? AppTheme.goldAccent
                      : isGood
                          ? AppTheme.success
                          : AppTheme.primaryTeal,
                ),
                SizedBox(height: r.spaceMedium),
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
                SizedBox(height: r.spaceSmall),
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
                SizedBox(height: r.spaceSmall),
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

          SizedBox(height: r.spaceLarge),

          // Score Overview
          Container(
            padding: EdgeInsets.all(r.paddingLarge),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(r.radiusMedium),
            ),
            child: Column(
              children: [
                Text(
                  'Your Score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: r.spaceLarge),
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

          SizedBox(height: r.spaceMedium),

          // Detailed Stats
          Container(
            padding: EdgeInsets.all(r.paddingLarge),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(r.radiusMedium),
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
                SizedBox(height: r.spaceMedium),
                _DetailRow(
                  icon: Icons.quiz,
                  color: AppTheme.primaryTeal,
                  label: 'Total Questions',
                  value: summary.totalQuestions.toString(),
                ),
                Divider(height: r.spaceLarge),
                _DetailRow(
                  icon: Icons.check_circle_outline,
                  color: AppTheme.success,
                  label: 'Correct Answers',
                  value: summary.correctAnswers.toString(),
                ),
                Divider(height: r.spaceLarge),
                _DetailRow(
                  icon: Icons.cancel_outlined,
                  color: AppTheme.error,
                  label: 'Wrong Answers',
                  value: summary.wrongAnswers.toString(),
                ),
                Divider(height: r.spaceLarge),
                _DetailRow(
                  icon: Icons.bolt_outlined,
                  color: AppTheme.warning,
                  label: 'Energy Consumed',
                  value: summary.energyConsumed.toString(),
                ),
              ],
            ),
          ),

          SizedBox(height: r.spaceMedium),

          // Progress Breakdown
          Container(
            padding: EdgeInsets.all(r.paddingLarge),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(r.radiusMedium),
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
                SizedBox(height: r.spaceMedium),
                ClipRRect(
                  borderRadius: BorderRadius.circular(r.radiusSmall),
                  child: Container(
                    height: r.spaceLarge,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(r.radiusSmall),
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
                SizedBox(height: r.paddingSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: r.spaceMedium,
                          height: r.spaceMedium,
                          decoration: BoxDecoration(
                            color: AppTheme.success,
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: r.spaceSmall),
                        Text(
                          'Correct (${summary.correctAnswers})',
                          style: TextStyle(fontSize: r.fontSmall),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: r.spaceMedium,
                          height: r.spaceMedium,
                          decoration: BoxDecoration(
                            color: AppTheme.error.withOpacity(0.2),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: r.spaceSmall),
                        Text(
                          'Wrong (${summary.wrongAnswers})',
                          style: TextStyle(fontSize: r.fontSmall),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: r.paddingLarge * 1.5),

          // Action Buttons
          SizedBox(
            height: r.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: _startNewQuiz,
              icon: const Icon(Icons.refresh),
              label: Text(
                'Start New Quiz',
                style: TextStyle(fontSize: r.fontMedium, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium),
                ),
              ),
            ),
          ),

          SizedBox(height: r.paddingSmall),

          SizedBox(
            height: r.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: _returnToHome,
              icon: const Icon(Icons.home),
              label: Text(
                'Return to Home',
                style: TextStyle(fontSize: r.fontMedium, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium),
                ),
              ),
            ),
          ),

          SizedBox(height: r.spaceMedium),
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
    final r = context.responsive;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(r.paddingSmall),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: r.iconMedium),
        ),
        SizedBox(height: r.spaceSmall),
        Text(
          value,
          style: TextStyle(
            fontSize: r.fontXLarge,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: r.fontSmall,
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
    final r = context.responsive;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(r.spaceSmall),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(r.radiusSmall),
          ),
          child: Icon(icon, color: color, size: r.iconSmall),
        ),
        SizedBox(width: r.spaceMedium),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: r.fontMedium),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: r.fontLarge,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
