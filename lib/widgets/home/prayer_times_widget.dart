import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/prayer/prayer_times_model.dart';
import '../../providers/prayer_providers.dart';
import 'package:intl/intl.dart';

class PrayerTimesWidget extends ConsumerWidget {
  const PrayerTimesWidget({super.key});

  String _formatTime(DateTime time) {
    return DateFormat.jm().format(time);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimesAsync = ref.watch(todayPrayerTimesProvider);
    final nextPrayerAsync = ref.watch(nextPrayerProvider);

    return prayerTimesAsync.when(
      loading: () => _buildLoadingState(context),
      error: (error, stack) => _buildErrorState(context, error),
      data: (prayerTimes) {
        return nextPrayerAsync.when(
          loading: () => _buildPrayerTimesContent(context, prayerTimes, null),
          error: (_, __) => _buildPrayerTimesContent(context, prayerTimes, null),
          data: (nextPrayer) => _buildPrayerTimesContent(context, prayerTimes, nextPrayer),
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
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
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
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
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 10),
          Text(
            'Unable to load prayer times',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 5),
          Text(
            'Please check location permissions',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesContent(
    BuildContext context,
    PrayerTimesModel prayerTimes,
    ({PrayerName name, DateTime time})? nextPrayer,
  ) {
    final now = DateTime.now();
    final prayers = [
      (name: PrayerName.fajr, time: prayerTimes.fajr, arabicName: 'الفجر'),
      (name: PrayerName.dhuhr, time: prayerTimes.dhuhr, arabicName: 'الظهر'),
      (name: PrayerName.asr, time: prayerTimes.asr, arabicName: 'العصر'),
      (name: PrayerName.maghrib, time: prayerTimes.maghrib, arabicName: 'المغرب'),
      (name: PrayerName.isha, time: prayerTimes.isha, arabicName: 'العشاء'),
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
              if (nextPrayer != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.goldAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    nextPrayer.name.displayNameEn,
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
          ...prayers.map((prayer) => _PrayerTimeRow(
                name: prayer.name.displayNameEn,
                arabicName: prayer.arabicName,
                time: _formatTime(prayer.time),
                isPassed: prayer.time.isBefore(now),
              )),

          const SizedBox(height: 12),

          // Next prayer countdown
          if (nextPrayer != null)
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
                    'Next prayer: ${nextPrayer.name.displayNameEn} at ${_formatTime(nextPrayer.time)}',
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
  final String name;
  final String arabicName;
  final String time;
  final bool isPassed;

  const _PrayerTimeRow({
    required this.name,
    required this.arabicName,
    required this.time,
    required this.isPassed,
  });

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
                    color: isPassed ? AppTheme.textSecondary : AppTheme.primaryTeal,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isPassed ? AppTheme.textSecondary : AppTheme.textPrimary,
                          ),
                    ),
                    Text(
                      arabicName,
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
              time,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPassed ? AppTheme.textSecondary : AppTheme.primaryTeal,
                  ),
              textAlign: TextAlign.center,
            ),
          ),

          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
