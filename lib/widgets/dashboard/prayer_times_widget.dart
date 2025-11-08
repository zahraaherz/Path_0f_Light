import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/prayer_providers.dart';
import '../../providers/language_providers.dart';
import '../../models/prayer/prayer_times_model.dart';

class PrayerTimesWidget extends ConsumerWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final prayerTimesAsync = ref.watch(todayPrayerTimesProvider);
    final nextPrayerAsync = ref.watch(nextPrayerProvider);
    final isRTL = ref.watch(isRTLProvider);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryTeal.withOpacity(0.1), Colors.transparent],
                begin: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                end: isRTL ? Alignment.centerLeft : Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.mosque, color: AppTheme.primaryTeal, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.todaysPrayers,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryTeal,
                            ),
                      ),
                      prayerTimesAsync.when(
                        data: (times) => Text(
                          times.locationName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Next Prayer Indicator
          nextPrayerAsync.when(
            data: (nextPrayer) {
              final now = DateTime.now();
              final timeUntil = nextPrayer.time.difference(now);
              final hours = timeUntil.inHours;
              final minutes = timeUntil.inMinutes % 60;

              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.islamicGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.islamicGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.islamicGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Prayer',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isRTL
                                ? nextPrayer.name.displayNameAr
                                : nextPrayer.name.displayNameEn,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.islamicGreen,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'in $hours:${minutes.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          DateFormat.jm().format(nextPrayer.time),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.islamicGreen,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Prayer Times List
          prayerTimesAsync.when(
            data: (times) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildPrayerTimeRow(context, l10n.fajr, 'الفجر', times.fajr, isRTL),
                  _buildPrayerTimeRow(context, l10n.sunrise, 'الشروق', times.sunrise, isRTL),
                  _buildPrayerTimeRow(context, l10n.dhuhr, 'الظهر', times.dhuhr, isRTL),
                  _buildPrayerTimeRow(context, l10n.asr, 'العصر', times.asr, isRTL),
                  _buildPrayerTimeRow(context, l10n.maghrib, 'المغرب', times.maghrib, isRTL),
                  _buildPrayerTimeRow(context, l10n.isha, 'العشاء', times.isha, isRTL),
                  _buildPrayerTimeRow(context, l10n.midnight, 'منتصف الليل', times.midnight, isRTL, isLast: true),
                ],
              ),
            ),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: AppTheme.primaryTeal),
              ),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
                  const SizedBox(height: 8),
                  Text(
                    'Unable to load prayer times',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please check your location settings',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeRow(
    BuildContext context,
    String nameEn,
    String nameAr,
    DateTime time,
    bool isRTL, {
    bool isLast = false,
  }) {
    final name = isRTL ? nameAr : nameEn;
    final formattedTime = DateFormat.jm().format(time);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Text(
                formattedTime,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }
}
