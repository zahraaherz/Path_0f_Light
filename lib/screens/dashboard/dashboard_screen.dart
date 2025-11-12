import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/prayer_providers.dart';
import '../../widgets/dashboard/prayer_times_widget.dart';
import '../../widgets/dashboard/islamic_calendar_widget.dart';
import '../../widgets/dashboard/dua_carousel_widget.dart';
import '../../widgets/dashboard/spiritual_checklist_widget.dart';

/// Dashboard screen with Prayer times, Islamic calendar, Du'a, and spiritual goals
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final hasPermission = await ref.read(locationPermissionProvider.future);
    if (!hasPermission && mounted) {
      _showLocationPermissionDialog();
    }
  }

  void _showLocationPermissionDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Permission'),
        content: Text(
          'We need your location to calculate accurate prayer times for your area.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final service = ref.read(prayerTimeServiceProvider);
              final granted = await service.requestLocationPermission();
              if (granted && mounted) {
                ref.invalidate(todayPrayerTimesProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Location permission granted')),
                );
              }
            },
            child: Text('Allow'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(todayPrayerTimesProvider);
          ref.invalidate(nextPrayerProvider);
        },
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  l10n.dashboard,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3.0,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryTeal, AppTheme.islamicGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.mosque,
                    size: 64,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),

            // Islamic Calendar Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IslamicCalendarWidget(),
              ),
            ),

            // Prayer Times Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrayerTimesWidget(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Du'a of the Day
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DuaCarouselWidget(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Spiritual Checklist
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SpiritualChecklistWidget(),
              ),
            ),

            // Quick Actions
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Quick Actions',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryTeal,
                              ),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.library_books, color: AppTheme.primaryTeal),
                        title: const Text('Quran & Tafsir'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.comingSoon)),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.headphones, color: AppTheme.islamicGreen),
                        title: Text(l10n.audioLibrary),
                        subtitle: const Text('Du\'a Kumayl, Ziyarat Ashura'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.comingSoon)),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.mosque, color: AppTheme.goldAccent),
                        title: const Text('Nearby Mosques'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.comingSoon)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}
