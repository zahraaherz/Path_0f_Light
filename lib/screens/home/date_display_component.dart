import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import '../../utils/responsive.dart';

class DateDisplayComponent extends StatelessWidget {
  const DateDisplayComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final DateTime now = DateTime.now();
    final HijriCalendar hijriDate = HijriCalendar.fromDate(now);

    // Format English date
    final String englishDate = DateFormat('EEEE, MMMM d, yyyy').format(now);

    // Format Arabic/Hijri date
    final String hijriDateStr = '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear} هـ';

    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(r.radiusSmall),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // English date
          Text(
            englishDate,
            style: TextStyle(
              fontSize: r.fontMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Arabic date
          Text(
            hijriDateStr,
            style: TextStyle(
              fontSize: r.fontMedium,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri',
            ),
            // textDirection: TextDirection.RTL,
          ),
        ],
      ),
    );
  }
}