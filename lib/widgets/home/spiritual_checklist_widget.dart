import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/dua/dua_model.dart';
import '../../data/mock_data.dart';

class SpiritualChecklistWidget extends StatefulWidget {
  const SpiritualChecklistWidget({super.key});

  @override
  State<SpiritualChecklistWidget> createState() => _SpiritualChecklistWidgetState();
}

class _SpiritualChecklistWidgetState extends State<SpiritualChecklistWidget> {
  late List<SpiritualChecklistItem> items;

  @override
  void initState() {
    super.initState();
    items = MockData.todayChecklist;
  }

  void _toggleItem(int index) {
    setState(() {
      items[index] = items[index].copyWith(
        isCompleted: !items[index].isCompleted,
        completedAt: !items[index].isCompleted ? DateTime.now() : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = items.where((item) => item.isCompleted).length;
    final progress = items.isEmpty ? 0.0 : completedCount / items.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.goldAccent.withOpacity(0.05),
        border: Border.all(
          color: AppTheme.goldAccent.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.checklist_rtl,
                  color: AppTheme.goldAccent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Spiritual Checklist',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '$completedCount of ${items.length} completed',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              // Progress circle
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.goldAccent),
                      strokeWidth: 4,
                    ),
                    Center(
                      child: Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.goldAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Checklist items
          ...List.generate(
            items.length,
            (index) => _ChecklistItem(
              item: items[index],
              onToggle: () => _toggleItem(index),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final SpiritualChecklistItem item;
  final VoidCallback onToggle;

  const _ChecklistItem({
    required this.item,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item.isCompleted
              ? AppTheme.success.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: item.isCompleted
                ? AppTheme.success.withOpacity(0.3)
                : Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item.isCompleted ? AppTheme.success : Colors.transparent,
                border: Border.all(
                  color: item.isCompleted ? AppTheme.success : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: item.isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),

            const SizedBox(width: 12),

            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: item.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: item.isCompleted
                              ? AppTheme.textSecondary
                              : AppTheme.textPrimary,
                        ),
                  ),
                  Text(
                    item.arabicTitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),

            // Count indicator (if applicable)
            if (item.targetCount != null && item.currentCount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${item.currentCount}/${item.targetCount}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTeal,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
