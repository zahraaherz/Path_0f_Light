import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/prayer_providers.dart';
import '../../providers/language_providers.dart';

class IslamicCalendarWidget extends ConsumerWidget {
  const IslamicCalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final hijriDate = ref.watch(todayHijriDateProvider);
    final now = DateTime.now();
    final isRTL = ref.watch(isRTLProvider);

    // Format dates
    final gregorianDate = DateFormat('EEEE, MMMM d, y').format(now);
    final hijriDateString = _formatHijriDate(hijriDate, isRTL);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.islamicGreen.withOpacity(0.1),
              AppTheme.goldAccent.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.islamicGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.islamicCalendar,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.islamicGreen,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hijri Date
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.islamicDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hijriDateString,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.islamicGreen,
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Gregorian Date
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.gregorianDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    gregorianDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),

            // Special Islamic Events (placeholder)
            if (_hasSpecialEvent(hijriDate))
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.goldAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.goldAccent.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppTheme.goldAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getSpecialEvent(hijriDate, isRTL),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.goldAccent.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatHijriDate(hijriDate, bool isRTL) {
    if (isRTL) {
      return '${hijriDate.hDay} ${_getHijriMonthNameAr(hijriDate.hMonth)} ${hijriDate.hYear} هـ';
    } else {
      return '${hijriDate.hDay} ${_getHijriMonthNameEn(hijriDate.hMonth)}, ${hijriDate.hYear} AH';
    }
  }

  String _getHijriMonthNameEn(int month) {
    const months = [
      'Muharram', 'Safar', 'Rabi\' al-Awwal', 'Rabi\' al-Thani',
      'Jumada al-Awwal', 'Jumada al-Thani', 'Rajab', 'Sha\'ban',
      'Ramadan', 'Shawwal', 'Dhu al-Qi\'dah', 'Dhu al-Hijjah'
    ];
    return months[month - 1];
  }

  String _getHijriMonthNameAr(int month) {
    const months = [
      'محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني',
      'جمادى الأولى', 'جمادى الثانية', 'رجب', 'شعبان',
      'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'
    ];
    return months[month - 1];
  }

  bool _hasSpecialEvent(hijriDate) {
    // Check for special Islamic dates
    final month = hijriDate.hMonth;
    final day = hijriDate.hDay;

    // Ramadan
    if (month == 9) return true;
    // Ashura (10th of Muharram)
    if (month == 1 && day == 10) return true;
    // Eid al-Fitr (1st of Shawwal)
    if (month == 10 && day == 1) return true;
    // Eid al-Adha (10th of Dhu al-Hijjah)
    if (month == 12 && day == 10) return true;
    // Arafa (9th of Dhu al-Hijjah)
    if (month == 12 && day == 9) return true;
    // Mawlid al-Nabi (12th of Rabi' al-Awwal)
    if (month == 3 && day == 12) return true;

    return false;
  }

  String _getSpecialEvent(hijriDate, bool isRTL) {
    final month = hijriDate.hMonth;
    final day = hijriDate.hDay;

    if (month == 9) {
      return isRTL ? '🌙 شهر رمضان المبارك' : '🌙 Holy Month of Ramadan';
    }
    if (month == 1 && day == 10) {
      return isRTL ? '☪️ يوم عاشوراء' : '☪️ Day of Ashura';
    }
    if (month == 10 && day == 1) {
      return isRTL ? '🎉 عيد الفطر المبارك' : '🎉 Eid al-Fitr';
    }
    if (month == 12 && day == 10) {
      return isRTL ? '🎉 عيد الأضحى المبارك' : '🎉 Eid al-Adha';
    }
    if (month == 12 && day == 9) {
      return isRTL ? '🕋 يوم عرفة' : '🕋 Day of Arafa';
    }
    if (month == 3 && day == 12) {
      return isRTL ? '✨ المولد النبوي الشريف' : '✨ Mawlid al-Nabi';
    }

    return '';
  }
}
