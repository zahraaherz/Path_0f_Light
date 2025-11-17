import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class IslamicContentComponent extends StatefulWidget {
  const IslamicContentComponent({Key? key}) : super(key: key);

  @override
  State<IslamicContentComponent> createState() => _IslamicContentComponentState();
}

class _IslamicContentComponentState extends State<IslamicContentComponent> {
  int _currentContentIndex = 0;

  // Islamic content for rotation (duas and sayings)
  final List<Map<String, String>> _islamicContent = [
    {
      'type': 'Hadith',
      'content': 'إنما الأعمال بالنيات وإنما لكل امرئ ما نوى',
      'source': 'صحيح البخاري',
      'translation': 'Deeds are judged by intentions, and each person will be rewarded according to their intentions.'
    },
    {
      'type': 'Dua',
      'content': 'اللهم إني أسألك العفو والعافية في الدنيا والآخرة',
      'source': 'سنن ابن ماجه',
      'translation': 'O Allah, I ask You for pardon and well-being in this life and the next.'
    },
    {
      'type': 'Saying of Imam Ali (AS)',
      'content': 'لا غنى كالعقل، ولا فقر كالجهل، ولا ميراث كالأدب',
      'source': 'نهج البلاغة',
      'translation': 'There is no wealth like intellect, no poverty like ignorance, and no inheritance like good manners.'
    },
    {
      'type': 'Dua from Imam Hussain (AS)',
      'content': 'اللهم اجعل نفسي مطمئنة بقدرك، راضية بقضائك',
      'source': 'الصحيفة الحسينية',
      'translation': 'O Allah, make my soul content with Your decree and pleased with Your judgment.'
    },
  ];

  void _nextContent() {
    setState(() {
      _currentContentIndex = (_currentContentIndex + 1) % _islamicContent.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final content = _islamicContent[_currentContentIndex];

    return Card(
      margin: EdgeInsets.all(r.paddingSmall),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  content['type'] ?? '',
                  style: TextStyle(
                    fontSize: r.fontLarge,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, size: r.iconMedium),
                  onPressed: _nextContent,
                  tooltip: 'Next',
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Arabic content
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(r.paddingMedium),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                      child: Text(
                        content['content'] ?? '',
                        style: TextStyle(
                          fontSize: r.fontXLarge,
                          fontFamily: 'Amiri',
                          height: 1.5,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: r.spaceMedium),
                    // Translation
                    Text(
                      content['translation'] ?? '',
                      style: TextStyle(
                        fontSize: r.fontMedium,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: r.spaceMedium),
                    // Source
                    Text(
                      'Source: ${content['source']}',
                      style: TextStyle(
                        fontSize: r.fontMedium,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.end,
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
}

// Component 3: Prayer Times Widget
class PrayerTimesComponent extends StatelessWidget {
  const PrayerTimesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    // Prayer times (static for demo)
    final Map<String, String> prayerTimes = {
      'Fajr': '04:15',
      'Sunrise': '05:42',
      'Dhuhr': '11:45',
      'Asr': '15:20',
      'Maghrib': '18:48',
      'Isha': '20:15',
    };

    return Card(
      margin: EdgeInsets.all(r.paddingSmall),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shia Prayer Times',
              style: TextStyle(
                fontSize: r.fontLarge,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: prayerTimes.length,
                itemBuilder: (context, index) {
                  final prayerName = prayerTimes.keys.elementAt(index);
                  final prayerTime = prayerTimes.values.elementAt(index);

                  // Calculate if it's the current prayer time
                  final now = TimeOfDay.now();
                  final List<String> timeComponents = prayerTime.split(':');
                  final prayerHour = int.parse(timeComponents[0]);
                  final prayerMinute = int.parse(timeComponents[1]);

                  // Simple comparison - more sophisticated logic needed for real app
                  final bool isCurrentPrayer =
                      (now.hour == prayerHour && now.minute >= prayerMinute) ||
                          (now.hour > prayerHour &&
                              (index == prayerTimes.length - 1 ||
                                  now.hour < int.parse(prayerTimes.values.elementAt(index + 1).split(':')[0])));

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: r.spaceSmall / 2),
                    padding: EdgeInsets.all(r.paddingSmall),
                    decoration: BoxDecoration(
                      color: isCurrentPrayer ? Colors.green.withOpacity(0.2) : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(r.radiusSmall),
                      border: isCurrentPrayer
                          ? Border.all(color: Colors.green, width: 2.0)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: isCurrentPrayer ? Colors.green : Colors.grey,
                              size: r.iconSmall,
                            ),
                            SizedBox(width: r.spaceSmall),
                            Text(
                              prayerName,
                              style: TextStyle(
                                fontSize: r.fontMedium,
                                fontWeight: isCurrentPrayer ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          prayerTime,
                          style: TextStyle(
                            fontSize: r.fontMedium,
                            fontWeight: isCurrentPrayer ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}