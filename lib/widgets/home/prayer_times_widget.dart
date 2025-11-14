import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/prayer/prayer_times.dart';
import '../../data/mock_data.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final prayerTimes = MockData.todayPrayerTimes;
    final prayers = [
      prayerTimes.fajr,
      prayerTimes.dhuhr,
      prayerTimes.asr,
      prayerTimes.maghrib,
      prayerTimes.isha,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryTeal.withOpacity(0.1), AppTheme.islamicGreen.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.3),
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
                  color: AppTheme.primaryTeal.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.access_time,
                  color: AppTheme.primaryTeal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prayer Times',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'أوقات الصلاة',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              if (prayerTimes.nextPrayer != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.goldAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${prayerTimes.nextPrayer}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Prayer times list
          ...prayers.map((prayer) => _PrayerTimeRow(prayer: prayer)),

          const SizedBox(height: 12),

          // Next prayer countdown
          if (prayerTimes.timeUntilNext != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_active,
                    color: AppTheme.primaryTeal,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Next prayer in ${prayerTimes.timeUntilNext}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryTeal,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _PrayerTimeRow extends StatelessWidget {
  final PrayerTime prayer;

  const _PrayerTimeRow({required this.prayer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Prayer name
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: prayer.isPassed ? AppTheme.textSecondary : AppTheme.primaryTeal,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayer.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: prayer.isPassed ? AppTheme.textSecondary : AppTheme.textPrimary,
                          ),
                    ),
                    Text(
                      prayer.arabicName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Prayer time
          Expanded(
            child: Text(
              prayer.time,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: prayer.isPassed ? AppTheme.textSecondary : AppTheme.primaryTeal,
                  ),
              textAlign: TextAlign.center,
            ),
          ),

          // Iqama time (if available)
          if (prayer.iqamaTime != null)
            Expanded(
              child: Text(
                prayer.iqamaTime!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                textAlign: TextAlign.right,
              ),
            )
          else
            const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
