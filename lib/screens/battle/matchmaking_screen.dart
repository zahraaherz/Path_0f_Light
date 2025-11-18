import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../models/battle/battle_models.dart';
import '../../providers/battle_providers.dart';
import '../../l10n/app_localizations.dart';
import 'live_battle_screen.dart';

class MatchmakingScreen extends ConsumerStatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  ConsumerState<MatchmakingScreen> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends ConsumerState<MatchmakingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _searchTimer;
  int _searchSeconds = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Start matchmaking automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startMatchmaking();
    });

    // Timer for search duration
    _searchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _searchSeconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  Future<void> _startMatchmaking() async {
    final config = ref.read(battleConfigProvider);

    try {
      await ref.read(matchmakingProvider.notifier).startMatchmaking(config);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start matchmaking: $e')),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _cancelMatchmaking() async {
    await ref.read(matchmakingProvider.notifier).cancelMatchmaking();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final matchmakingState = ref.watch(matchmakingProvider);

    // Listen for active battles and navigate when match is found
    ref.listen<AsyncValue<List<Battle>>>(activeBattlesProvider, (previous, next) {
      next.whenData((battles) {
        if (battles.isNotEmpty && matchmakingState.isSearching) {
          // Match found! Navigate to battle
          ref.read(matchmakingProvider.notifier).matchFound(battles.first.id);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LiveBattleScreen(battleId: battles.first.id),
            ),
          );
        }
      });
    });

    return WillPopScope(
      onWillPop: () async {
        await _cancelMatchmaking();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(l10n.findingOpponent ?? 'Finding Opponent'),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _cancelMatchmaking,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(r.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated searching indicator
                RotationTransition(
                  turns: _animationController,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryTeal.withOpacity(0.3),
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        size: 60,
                        color: AppTheme.primaryTeal,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: r.spaceLarge),

                // Status text
                Text(
                  l10n.searchingForOpponent ?? 'Searching for opponent...',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryTeal,
                      ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: r.spaceMedium),

                // Search duration
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.paddingMedium,
                    vertical: r.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTeal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(r.radiusSmall),
                  ),
                  child: Text(
                    '${_formatDuration(_searchSeconds)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryTeal,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),

                SizedBox(height: r.spaceLarge),

                // Battle config info
                Container(
                  padding: EdgeInsets.all(r.paddingLarge),
                  decoration: BoxDecoration(
                    color: AppTheme.islamicGreen.withOpacity(0.05),
                    border: Border.all(
                      color: AppTheme.islamicGreen.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(r.radiusMedium),
                  ),
                  child: Column(
                    children: [
                      Text(
                        l10n.battleSettings ?? 'Battle Settings',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(height: r.spaceMedium),
                      _buildSettingRow(
                        context,
                        r,
                        Icons.quiz,
                        'Questions',
                        '${matchmakingState.config?.questionCount ?? 10}',
                      ),
                      _buildSettingRow(
                        context,
                        r,
                        Icons.timer,
                        'Time per question',
                        '${matchmakingState.config?.timePerQuestion ?? 30}s',
                      ),
                      if (matchmakingState.config?.difficulty != null)
                        _buildSettingRow(
                          context,
                          r,
                          Icons.trending_up,
                          'Difficulty',
                          matchmakingState.config!.difficulty!,
                        ),
                      if (matchmakingState.config?.category != null)
                        _buildSettingRow(
                          context,
                          r,
                          Icons.category,
                          'Category',
                          matchmakingState.config!.category!,
                        ),
                    ],
                  ),
                ),

                SizedBox(height: r.spaceLarge),

                // Tips
                Container(
                  padding: EdgeInsets.all(r.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(r.radiusMedium),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppTheme.accentGold,
                      ),
                      SizedBox(width: r.spaceMedium),
                      Expanded(
                        child: Text(
                          l10n.matchmakingTip ??
                              'Tip: Speed matters! Answer quickly for bonus points.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: r.spaceLarge),

                // Cancel button
                OutlinedButton(
                  onPressed: _cancelMatchmaking,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(
                      horizontal: r.paddingLarge,
                      vertical: r.paddingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(r.radiusSmall),
                    ),
                  ),
                  child: Text(l10n.cancelSearch ?? 'Cancel Search'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow(
    BuildContext context,
    Responsive r,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.spaceSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.textSecondary),
              SizedBox(width: r.spaceSmall),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
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

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
