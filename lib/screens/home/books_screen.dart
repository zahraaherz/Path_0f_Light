import 'package:flutter/material.dart';

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
    final content = _islamicContent[_currentContentIndex];

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  content['type'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
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
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        content['content'] ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Amiri',
                          height: 1.5,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Translation
                    Text(
                      content['translation'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Source
                    Text(
                      'Source: ${content['source']}',
                      style: TextStyle(
                        fontSize: 14,
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
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shia Prayer Times',
              style: TextStyle(
                fontSize: 18,
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
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isCurrentPrayer ? Colors.green.withOpacity(0.2) : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8.0),
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
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              prayerName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isCurrentPrayer ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          prayerTime,
                          style: TextStyle(
                            fontSize: 16,
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