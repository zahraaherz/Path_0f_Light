import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class TodayEventsComponent extends StatelessWidget {
  const TodayEventsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current Hijri date for event checking
    final HijriCalendar hijriDate = HijriCalendar.fromDate(DateTime.now());

    // Check if today has any significant Islamic events
    // This is a simple demo - you'd need a more comprehensive database
    String eventTitle = '';
    String eventDescription = '';
    bool hasEvent = false;

    // Check for major events - simplified example
    if (hijriDate.hMonth == 9 && hijriDate.hDay == 1) {
      eventTitle = 'First day of Ramadan';
      eventDescription = 'The blessed month of fasting begins today.';
      hasEvent = true;
    } else if (hijriDate.hMonth == 10 && hijriDate.hDay == 1) {
      eventTitle = 'Eid al-Fitr';
      eventDescription = 'The celebration marking the end of Ramadan.';
      hasEvent = true;
    } else if (hijriDate.hMonth == 12 && hijriDate.hDay == 10) {
      eventTitle = 'Eid al-Adha';
      eventDescription = 'The festival of sacrifice commemorating Prophet Ibrahim\'s devotion.';
      hasEvent = true;
    } else if (hijriDate.hMonth == 1 && hijriDate.hDay == 10) {
      eventTitle = 'Day of Ashura';
      eventDescription = 'The martyrdom of Imam Hussain (AS) at Karbala.';
      hasEvent = true;
    } else if (hijriDate.hMonth == 3 && hijriDate.hDay == 13) {
      eventTitle = 'Birth of Fatima al-Zahra (SA)';
      eventDescription = 'Celebrating the birth of the daughter of Prophet Muhammad (PBUH).';
      hasEvent = true;
    }

    // Random event for demo purposes (remove in production)
    if (!hasEvent) {
      // Demo event for testing
      final Random random = Random();
      if (random.nextBool()) {
        eventTitle = 'Birth of Imam Ali ibn Abi Talib (AS)';
        eventDescription = 'Celebrating the birth of the first Imam of Shia Muslims.';
        hasEvent = true;
      }
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Islamic Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Divider(),
            Expanded(
              child: hasEvent
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.celebration,
                    size: 40,
                    color: Colors.amber[700],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    eventTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    eventDescription,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  : const Center(
                child: Text(
                  'No significant events today',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
