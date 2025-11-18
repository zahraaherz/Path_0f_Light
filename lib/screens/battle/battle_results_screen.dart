import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../models/battle/battle_models.dart';
import '../../l10n/app_localizations.dart';

class BattleResultsScreen extends ConsumerStatefulWidget {
  final BattleResult result;

  const BattleResultsScreen({
    required this.result,
    super.key,
  });

  @override
  ConsumerState<BattleResultsScreen> createState() =>
      _BattleResultsScreenState();
}

class _BattleResultsScreenState extends ConsumerState<BattleResultsScreen> {
  late ConfettiController _confettiController;
  bool _isWinner = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    // Check if current user is winner and show confetti
    _isWinner = true; // Simplified - should check actual user ID
    if (_isWinner) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(r.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Result header
                  Container(
                    padding: EdgeInsets.all(r.paddingLarge),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isWinner
                            ? [AppTheme.primaryTeal, AppTheme.islamicGreen]
                            : [Colors.grey[400]!, Colors.grey[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(r.radiusMedium),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _isWinner ? Icons.emoji_events : Icons.handshake,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(height: r.spaceMedium),
                        Text(
                          _isWinner
                              ? (l10n.victory ?? 'Victory!')
                              : (l10n.defeat ?? 'Defeat'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (_isWinner) ...[
                          SizedBox(height: r.spaceSmall),
                          Text(
                            l10n.congratulations ?? 'Congratulations!',
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: r.spaceLarge),

                  // Score comparison
                  _buildScoreComparison(context, r),

                  SizedBox(height: r.spaceLarge),

                  // Battle stats
                  _buildBattleStats(context, r),

                  SizedBox(height: r.spaceLarge),

                  // Action buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                    ),
                    child: Text(
                      l10n.playAgain ?? 'Play Again',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: r.spaceMedium),

                  OutlinedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textSecondary,
                      side: BorderSide(color: Colors.grey[300]!),
                      padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                    ),
                    child: Text(l10n.backToHome ?? 'Back to Home'),
                  ),
                ],
              ),
            ),
          ),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              shouldLoop: false,
              colors: const [
                AppTheme.primaryTeal,
                AppTheme.islamicGreen,
                AppTheme.accentGold,
                Colors.blue,
                Colors.pink,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreComparison(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Winner
          _buildPlayerResult(
            context,
            r,
            widget.result.player1.displayName,
            widget.result.winnerScore,
            widget.result.player1.photoURL,
            true,
          ),

          // VS
          Column(
            children: [
              Text(
                'VS',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                '${widget.result.scoreDifference} pts',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),

          // Loser
          _buildPlayerResult(
            context,
            r,
            widget.result.player2.displayName,
            widget.result.loserScore,
            widget.result.player2.photoURL,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerResult(
    BuildContext context,
    Responsive r,
    String name,
    int score,
    String? photoUrl,
    bool isWinner,
  ) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
              child: photoUrl == null ? const Icon(Icons.person, size: 40) : null,
            ),
            if (isWinner)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGold,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
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
          '$score pts',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: isWinner ? AppTheme.primaryTeal : AppTheme.textSecondary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildBattleStats(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal.withOpacity(0.05),
        border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Battle Statistics',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spaceMedium),
          _buildStatRow(
            context,
            r,
            Icons.quiz,
            'Questions',
            '10',
          ),
          _buildStatRow(
            context,
            r,
            Icons.timer,
            'Duration',
            '${widget.result.durationSeconds ~/ 60}:${(widget.result.durationSeconds % 60).toString().padLeft(2, '0')}',
          ),
          _buildStatRow(
            context,
            r,
            Icons.check_circle,
            'Correct Answers',
            '${widget.result.player1.correctAnswers}',
          ),
          _buildStatRow(
            context,
            r,
            Icons.cancel,
            'Wrong Answers',
            '${widget.result.player1.wrongAnswers}',
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    Responsive r,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.spaceMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.primaryTeal),
              SizedBox(width: r.spaceSmall),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
