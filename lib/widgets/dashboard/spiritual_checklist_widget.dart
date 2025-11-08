import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/language_providers.dart';

// Checklist items state provider
final checklistItemsProvider =
    StateNotifierProvider<ChecklistNotifier, Map<String, bool>>((ref) {
  return ChecklistNotifier();
});

class ChecklistNotifier extends StateNotifier<Map<String, bool>> {
  ChecklistNotifier() : super({}) {
    _loadChecklist();
  }

  static const String _checklistKey = 'daily_checklist';

  Future<void> _loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('${_checklistKey}_date');
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Reset checklist if it's a new day
    if (savedDate != today) {
      state = {};
      await prefs.setString('${_checklistKey}_date', today);
    } else {
      // Load saved checklist
      final Map<String, bool> checklist = {};
      for (final key in _getDefaultItems().keys) {
        checklist[key] = prefs.getBool('${_checklistKey}_$key') ?? false;
      }
      state = checklist;
    }
  }

  Map<String, bool> _getDefaultItems() {
    return {
      'fajr': false,
      'quran': false,
      'dua': false,
      'dhikr': false,
      'charity': false,
    };
  }

  Future<void> toggleItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !(state[key] ?? false);
    state = {...state, key: newValue};
    await prefs.setBool('${_checklistKey}_$key', newValue);
  }

  int get completedCount {
    return state.values.where((v) => v == true).length;
  }

  int get totalCount {
    return _getDefaultItems().length;
  }

  double get progress {
    if (totalCount == 0) return 0.0;
    return completedCount / totalCount;
  }
}

class SpiritualChecklistWidget extends ConsumerWidget {
  const SpiritualChecklistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final checklist = ref.watch(checklistItemsProvider);
    final checklistNotifier = ref.read(checklistItemsProvider.notifier);
    final isRTL = ref.watch(isRTLProvider);

    final items = [
      ChecklistItem(
        key: 'fajr',
        titleEn: l10n.performSalah,
        titleAr: 'أداء الصلاة',
        icon: Icons.mosque,
        color: AppTheme.primaryTeal,
      ),
      ChecklistItem(
        key: 'quran',
        titleEn: l10n.reciteQuran,
        titleAr: 'تلاوة القرآن',
        icon: Icons.menu_book,
        color: AppTheme.islamicGreen,
      ),
      ChecklistItem(
        key: 'dua',
        titleEn: l10n.makeDua,
        titleAr: 'الدعاء',
        icon: Icons.auto_awesome,
        color: AppTheme.goldAccent,
      ),
      ChecklistItem(
        key: 'dhikr',
        titleEn: 'Make Dhikr',
        titleAr: 'الذكر',
        icon: Icons.favorite,
        color: AppTheme.error,
      ),
      ChecklistItem(
        key: 'charity',
        titleEn: l10n.giveCharity,
        titleAr: 'التصدق',
        icon: Icons.volunteer_activism,
        color: AppTheme.warning,
      ),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTeal.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.checklist,
                    color: AppTheme.primaryTeal,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.dailyChecklist,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryTeal,
                            ),
                      ),
                      Text(
                        '${checklistNotifier.completedCount}/${checklistNotifier.totalCount} completed',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: checklistNotifier.progress,
                backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
                minHeight: 8,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Checklist Items
          ...items.map((item) {
            final isChecked = checklist[item.key] ?? false;
            return _buildChecklistItem(
              context,
              item,
              isChecked,
              isRTL,
              () => checklistNotifier.toggleItem(item.key),
            );
          }),

          // Motivation Message
          if (checklistNotifier.progress == 1.0)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.islamicGreen.withOpacity(0.2),
                      AppTheme.goldAccent.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.celebration,
                      color: AppTheme.goldAccent,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isRTL ? 'ما شاء الله!' : 'Masha Allah!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.islamicGreen,
                                ),
                          ),
                          Text(
                            isRTL
                                ? 'لقد أكملت جميع أهدافك اليوم!'
                                : 'You completed all your goals today!',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(
    BuildContext context,
    ChecklistItem item,
    bool isChecked,
    bool isRTL,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isChecked ? item.color : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: isChecked ? item.color : Colors.transparent,
                ),
                child: isChecked
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Icon(
                item.icon,
                color: isChecked ? item.color : Colors.grey.shade400,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isRTL ? item.titleAr : item.titleEn,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: isChecked ? item.color : AppTheme.textPrimary,
                        fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
                        decoration: isChecked ? TextDecoration.lineThrough : null,
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

class ChecklistItem {
  final String key;
  final String titleEn;
  final String titleAr;
  final IconData icon;
  final Color color;

  const ChecklistItem({
    required this.key,
    required this.titleEn,
    required this.titleAr,
    required this.icon,
    required this.color,
  });
}
