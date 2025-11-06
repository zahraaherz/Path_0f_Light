import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class DateDisplayComponent extends StatelessWidget {
  const DateDisplayComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final HijriCalendar hijriDate = HijriCalendar.fromDate(now);

    // Format English date
    final String englishDate = DateFormat('EEEE, MMMM d, yyyy').format(now);

    // Format Arabic/Hijri date
    final String hijriDateStr = '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear} هـ';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // English date
          Text(
            englishDate,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Arabic date
          Text(
            hijriDateStr,
            style: const TextStyle(
              fontSize: 16,
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