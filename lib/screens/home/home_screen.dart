import 'package:flutter/material.dart';

import 'books_screen.dart';
import 'challanges_screen.dart';
import 'dashboard.dart';
import 'date_display_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Component 1: Date Display (Arabic and English)
            const DateDisplayComponent(),

            // Component 2: Islamic Content (Duas, Sayings)
            const Expanded(
              flex: 3,
              child: IslamicContentComponent(),
            ),

            // Component 3: Prayer Times for Shia
            const Expanded(
              flex: 3,
              child: PrayerTimesComponent(),
            ),

            // Component 4: Today's Islamic Events
            const Expanded(
              flex: 2,
              child: TodayEventsComponent(),
            ),

            // Component 5: Navigation Dashboard
            const NavigationDashboardComponent(),
          ],
        ),
      ),
    );
  }
}