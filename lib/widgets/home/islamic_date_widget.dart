import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme/app_theme.dart';
import '../../data/mock_data.dart';

class IslamicDateWidget extends StatelessWidget {
  const IslamicDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final gregorianDate = DateFormat('EEEE, MMMM d, yyyy').format(now);
    final hijriDate = MockData.formattedHijriDate;
    final arabicHijriDate = MockData.formattedArabicHijriDate;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
          // Hijri Date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppTheme.islamicGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    arabicHijriDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.islamicGreen,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hijriDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Divider
          Container(
            height: 1,
            color: AppTheme.islamicGreen.withOpacity(0.2),
          ),

          const SizedBox(height: 12),

          // Gregorian Date
          Text(
            gregorianDate,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
