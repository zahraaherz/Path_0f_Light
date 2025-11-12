import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/quiz/quiz_models.dart';
import '../../providers/quiz_providers.dart';
import '../../providers/energy_providers.dart';
import '../../widgets/energy_display.dart';
import 'quiz_question_screen.dart';

class QuizStartScreen extends ConsumerStatefulWidget {
  const QuizStartScreen({super.key});

  @override
  ConsumerState<QuizStartScreen> createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends ConsumerState<QuizStartScreen> {
  String? selectedCategory;
  DifficultyLevel? selectedDifficulty;
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(quizCategoriesProvider);
    final energyStatus = ref.watch(energyStatusProvider);
    final quizState = ref.watch(quizSessionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Start Quiz'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Islamic Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.islamicGreen.withOpacity(0.05),
                border: Border.all(
                  color: AppTheme.islamicGreen.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.quiz,
                    size: 48,
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'اِختَبِر مَعرِفَتَك',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.islamicGreen,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Test Your Knowledge',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '10 questions • Earn points • Build streaks',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Energy Check
            energyStatus.when(
              data: (status) {
                final energyNeeded = 10 * status.energyPerQuestion;
                final hasEnough = status.currentEnergy >= energyNeeded;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: hasEnough
                        ? AppTheme.success.withOpacity(0.05)
                        : AppTheme.error.withOpacity(0.05),
                    border: Border.all(
                      color: hasEnough
                          ? AppTheme.success.withOpacity(0.3)
                          : AppTheme.error.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        hasEnough ? Icons.check_circle_outline : Icons.warning_amber_outlined,
                        color: hasEnough ? AppTheme.success : AppTheme.error,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasEnough ? 'Ready to Start' : 'Insufficient Energy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: hasEnough ? AppTheme.success : AppTheme.error,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Need: $energyNeeded • Have: ${status.currentEnergy}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

            const SizedBox(height: 32),

            // Category Selection
            Text(
              'Select Category',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Optional - Leave unselected for mixed categories',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 12),
            categoriesAsync.when(
              data: (categories) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _CategoryChip(
                      label: 'All Categories',
                      selected: selectedCategory == null,
                      onTap: () => setState(() => selectedCategory = null),
                    ),
                    ...categories.map((category) => _CategoryChip(
                          label: category,
                          selected: selectedCategory == category,
                          onTap: () => setState(() => selectedCategory = category),
                        )),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Failed to load categories'),
            ),

            const SizedBox(height: 24),

            // Difficulty Selection
            Text(
              'Select Difficulty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Optional - Leave unselected for mixed difficulty',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DifficultyChip(
                  label: 'All Levels',
                  points: null,
                  selected: selectedDifficulty == null,
                  onTap: () => setState(() => selectedDifficulty = null),
                ),
                ...DifficultyLevel.values.map((difficulty) => _DifficultyChip(
                      label: difficulty.displayName,
                      points: difficulty.basePoints,
                      selected: selectedDifficulty == difficulty,
                      onTap: () => setState(() => selectedDifficulty = difficulty),
                    )),
              ],
            ),

            const SizedBox(height: 24),

            // Language Selection
            Text(
              'Select Language',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _LanguageCard(
                    language: 'en',
                    label: 'English',
                    arabicLabel: 'إنجليزي',
                    icon: Icons.language,
                    selected: selectedLanguage == 'en',
                    onTap: () => setState(() => selectedLanguage = 'en'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _LanguageCard(
                    language: 'ar',
                    label: 'العربية',
                    arabicLabel: 'Arabic',
                    icon: Icons.translate,
                    selected: selectedLanguage == 'ar',
                    onTap: () => setState(() => selectedLanguage = 'ar'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Start Quiz Button
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: quizState.isLoading ? null : _startQuiz,
                icon: quizState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(
                  quizState.isLoading ? 'Loading...' : 'Start Quiz',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

            if (quizState.error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.05),
                  border: Border.all(
                    color: AppTheme.error.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppTheme.error, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        quizState.error!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.error,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _startQuiz() async {
    final notifier = ref.read(quizSessionProvider.notifier);

    final success = await notifier.startQuiz(
      category: selectedCategory,
      difficulty: selectedDifficulty?.value,
      language: selectedLanguage,
      count: 10,
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const QuizQuestionScreen()),
      );
    }
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryTeal.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: selected ? AppTheme.primaryTeal : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected)
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppTheme.primaryTeal,
                ),
              ),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppTheme.primaryTeal : AppTheme.textPrimary,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  final String label;
  final int? points;
  final bool selected;
  final VoidCallback onTap;

  const _DifficultyChip({
    required this.label,
    this.points,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppTheme.goldAccent.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: selected ? AppTheme.goldAccent : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected)
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppTheme.goldAccent,
                ),
              ),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppTheme.goldAccent : AppTheme.textPrimary,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (points != null) ...[
              const SizedBox(width: 4),
              Text(
                '($points pts)',
                style: TextStyle(
                  fontSize: 11,
                  color: selected ? AppTheme.goldAccent : AppTheme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String language;
  final String label;
  final String arabicLabel;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.language,
    required this.label,
    required this.arabicLabel,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryTeal.withOpacity(0.05) : Colors.transparent,
          border: Border.all(
            color: selected ? AppTheme.primaryTeal : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: selected ? AppTheme.primaryTeal : AppTheme.textSecondary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? AppTheme.primaryTeal : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              arabicLabel,
              style: TextStyle(
                fontSize: 12,
                color: selected ? AppTheme.primaryTeal : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
