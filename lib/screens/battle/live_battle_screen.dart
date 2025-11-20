import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../models/battle/battle_models.dart';
import '../../models/quiz/quiz_models.dart';
import '../../providers/battle_providers.dart';
import '../../l10n/app_localizations.dart';
import 'battle_results_screen.dart';

class LiveBattleScreen extends ConsumerStatefulWidget {
  final String battleId;

  const LiveBattleScreen({
    required this.battleId,
    super.key,
  });

  @override
  ConsumerState<LiveBattleScreen> createState() => _LiveBattleScreenState();
}

class _LiveBattleScreenState extends ConsumerState<LiveBattleScreen> {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _isSubmitting = false;
  Timer? _questionTimer;
  int _remainingSeconds = 30;

  @override
  void initState() {
    super.initState();
    _startQuestionTimer();
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _remainingSeconds = 30; // Reset to 30 seconds for each question

    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _remainingSeconds--;
        });

        if (_remainingSeconds <= 0) {
          timer.cancel();
          // Auto-submit with no answer
          _submitAnswer('');
        }
      }
    });
  }

  Future<void> _submitAnswer(String answer) async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    _questionTimer?.cancel();

    final battleAsync = ref.read(battleProvider(widget.battleId));
    final battle = battleAsync.value;

    if (battle == null) return;

    try {
      // Get current question ID
      final questionId = battle.questionIds[_currentQuestionIndex];

      // Submit answer
      await ref.read(battleRepositoryProvider).submitBattleAnswer(
            battleId: widget.battleId,
            questionId: questionId,
            answer: answer,
          );

      // Wait a moment to show the result
      await Future.delayed(const Duration(milliseconds: 500));

      // Move to next question or finish
      if (_currentQuestionIndex < battle.questionIds.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
          _isSubmitting = false;
        });
        _startQuestionTimer();
      } else {
        // Battle completed, navigate to results
        final result = await ref
            .read(battleRepositoryProvider)
            .completeBattle(widget.battleId);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BattleResultsScreen(result: result),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorMessage(e.toString()))),
        );
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final battleAsync = ref.watch(battleProvider(widget.battleId));
    final questionsAsync = ref.watch(battleQuestionsProvider(widget.battleId));

    return WillPopScope(
      onWillPop: () async {
        // Warn before leaving
        final shouldLeave = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.leaveBattle),
            content: Text(l10n.leaveBattleWarning ?? l10n.leaveBattleWarningFallback),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text(l10n.leave),
              ),
            ],
          ),
        );

        if (shouldLeave == true) {
          await ref.read(battleRepositoryProvider).leaveBattle(widget.battleId);
          return true;
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: battleAsync.when(
          data: (battle) {
            return questionsAsync.when(
              data: (questions) {
                if (questions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.orange),
                        const SizedBox(height: 16),
                        Text(l10n.noQuestionsAvailable),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(l10n.goBack),
                        ),
                      ],
                    ),
                  );
                }
                return _buildBattleContent(context, r, l10n, battle, questions);
              },
              loading: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(l10n.loadingQuestions),
                  ],
                ),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(l10n.failedToLoadQuestions ?? l10n.errorMessage(error.toString())),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.goBack),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(l10n.errorMessage(error.toString())),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.goBack),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBattleContent(
    BuildContext context,
    Responsive r,
    AppLocalizations l10n,
    Battle battle,
    List<QuizQuestion> questions,
  ) {
    // Validate question index
    if (_currentQuestionIndex >= questions.length) {
      return Center(
        child: Text(l10n.invalidQuestionIndex),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];

    return SafeArea(
      child: Column(
        children: [
          // Header with scores
          _buildBattleHeader(context, r, battle),

          // Progress indicator
          _buildProgressIndicator(context, r, battle),

          // Timer
          _buildTimer(context, r),

          // Question content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(r.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Question number
                  Text(
                    l10n.questionNumber(
                      _currentQuestionIndex + 1,
                      battle.config.questionCount,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: r.spaceMedium),

                  // Question text
                  Container(
                    padding: EdgeInsets.all(r.paddingLarge),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withOpacity(0.05),
                      border: Border.all(
                        color: AppTheme.primaryTeal.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(r.radiusMedium),
                    ),
                    child: Text(
                      currentQuestion.question,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: r.spaceLarge),

                  // Answer options
                  ...currentQuestion.options.entries
                      .map((entry) => _buildAnswerOption(
                            context,
                            r,
                            entry.key,
                            entry.value,
                          )),

                  SizedBox(height: r.spaceLarge),

                  // Submit button
                  ElevatedButton(
                    onPressed: _selectedAnswer != null && !_isSubmitting
                        ? () => _submitAnswer(_selectedAnswer!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            l10n.submitAnswer,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleHeader(
      BuildContext context, Responsive r, Battle battle) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = battle.player1; // Simplified, should check actual user
    final opponent = battle.player2 ?? BattlePlayer(userId: '', displayName: l10n.waiting);

    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryTeal.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Player 1
          _buildPlayerScore(
            context,
            r,
            currentUser.displayName,
            currentUser.score,
            currentUser.photoURL,
            true,
          ),

          // VS
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.paddingMedium,
              vertical: r.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal,
              borderRadius: BorderRadius.circular(r.radiusSmall),
            ),
            child: Text(
              l10n.versus,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Player 2
          _buildPlayerScore(
            context,
            r,
            opponent.displayName,
            opponent.score,
            opponent.photoURL,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerScore(
    BuildContext context,
    Responsive r,
    String name,
    int score,
    String? photoUrl,
    bool isCurrentUser,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          child: photoUrl == null ? const Icon(Icons.person) : null,
        ),
        SizedBox(height: r.spaceSmall),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          l10n.pointsShort(score),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryTeal,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(
      BuildContext context, Responsive r, Battle battle) {
    final progress =
        (_currentQuestionIndex + 1) / battle.config.questionCount;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
        minHeight: 8,
      ),
    );
  }

  Widget _buildTimer(BuildContext context, Responsive r) {
    final l10n = AppLocalizations.of(context)!;
    final percentage = _remainingSeconds / 30;
    final color = _remainingSeconds > 10
        ? AppTheme.primaryTeal
        : _remainingSeconds > 5
            ? AppTheme.accentGold
            : Colors.red;

    return Container(
      margin: EdgeInsets.all(r.paddingMedium),
      padding: EdgeInsets.symmetric(
        horizontal: r.paddingMedium,
        vertical: r.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(r.radiusSmall),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer, color: color, size: 20),
          SizedBox(width: r.spaceSmall),
          Text(
            l10n.secondsShort(_remainingSeconds),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(
    BuildContext context,
    Responsive r,
    String option,
    String text,
  ) {
    final isSelected = _selectedAnswer == option;

    return Padding(
      padding: EdgeInsets.only(bottom: r.spaceMedium),
      child: InkWell(
        onTap: _isSubmitting
            ? null
            : () {
                setState(() {
                  _selectedAnswer = option;
                });
              },
        borderRadius: BorderRadius.circular(r.radiusMedium),
        child: Container(
          padding: EdgeInsets.all(r.paddingMedium),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryTeal.withOpacity(0.1)
                : Colors.grey[50],
            border: Border.all(
              color: isSelected ? AppTheme.primaryTeal : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(r.radiusMedium),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryTeal : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: r.spaceMedium),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
