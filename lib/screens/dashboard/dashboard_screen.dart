import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart' as app_l10n;
import '../../config/theme/app_theme.dart';
import '../../providers/prayer_providers.dart';
import '../../widgets/dashboard/prayer_times_widget.dart';
import '../../widgets/dashboard/islamic_calendar_widget.dart';
import '../../widgets/dashboard/dua_carousel_widget.dart';
import '../../widgets/dashboard/spiritual_checklist_widget.dart';
import '../../utils/responsive.dart';

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
    final l10n = Localizations.of<app_l10n.AppLocalizations>(context, app_l10n.AppLocalizations)!;
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
    final r = context.responsive;
    final l10n = Localizations.of<app_l10n.AppLocalizations>(context, app_l10n.AppLocalizations)!;

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
                  style: TextStyle(
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
                  child: Icon(
                    Icons.mosque,
                    size: r.iconLarge * 2,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),

            // Islamic Calendar Card
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(r.paddingMedium),
                child: IslamicCalendarWidget(),
              ),
            ),

            // Prayer Times Card
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: PrayerTimesWidget(),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: r.spaceMedium)),

            // Du'a of the Day
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: DuaCarouselWidget(),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: r.spaceMedium)),

            // Spiritual Checklist
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: SpiritualChecklistWidget(),
              ),
            ),

            // Quick Actions
            SliverPadding(
              padding: EdgeInsets.all(r.paddingMedium),
              sliver: SliverToBoxAdapter(
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(r.paddingMedium),
                        child: Text(
                          'Quick Actions',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryTeal,
                              ),
                        ),
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.library_books, color: AppTheme.primaryTeal),
                        title: Text('Quran & Tafsir'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.comingSoon)),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.headphones, color: AppTheme.islamicGreen),
                        title: Text(l10n.audioLibrary),
                        subtitle: Text('Du\'a Kumayl, Ziyarat Ashura'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.comingSoon)),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.mosque, color: AppTheme.goldAccent),
                        title: Text('Nearby Mosques'),
                        trailing: Icon(Icons.chevron_right),
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

            SliverToBoxAdapter(child: SizedBox(height: r.spaceXLarge)),
          ],
        ),
      ),
    );
  }
}
