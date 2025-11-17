import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/auth_providers.dart';
import '../../providers/streak_providers.dart';
import '../../widgets/streak_celebration_dialog.dart';
import '../../widgets/home/islamic_date_widget.dart';
import '../../widgets/home/prayer_times_widget.dart';
import '../../widgets/home/islamic_events_widget.dart';
import '../../widgets/home/dua_slider_widget.dart';
import '../../widgets/home/spiritual_checklist_widget.dart';
import '../../widgets/home/audio_library_widget.dart';
import '../../data/mock_data.dart';
import '../profile/profile_screen.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../quiz/quiz_start_screen.dart';
import '../auth/login_screen.dart';
import '../masoomeen/masoomeen_browse_screen.dart';
import '../library/library_screen.dart';
import '../quran/quran_screen.dart';
import 'collection_screen.dart';
import '../../utils/responsive.dart';
import '../../l10n/app_localizations.dart';
import "../../widgets/halal_banner_ad.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  bool _hasShownCelebration = false;

  final List<Widget> _pages = const [
    HomePage(),
    LibraryScreen(),
    CollectionScreen(),
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDailyLogin();
    });
  }

  void _checkDailyLogin() {
    final dailyLoginAsync = ref.read(dailyLoginTrackingProvider);
    dailyLoginAsync.whenData((result) {
      if (result != null && !_hasShownCelebration && mounted) {
        _hasShownCelebration = true;
        if (result.streakIncreased || result.isNewStreak) {
          final milestones = [3, 7, 14, 30, 60, 100];
          final isMilestone = milestones.contains(result.loginStreak);
          if (isMilestone) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                final l10n = AppLocalizations.of(context)!;
                StreakCelebrationDialog.show(
                  context,
                  StreakCelebration(
                    type: StreakType.login,
                    streak: result.loginStreak,
                    isMilestone: true,
                    message: l10n.loginStreakMilestone(result.loginStreak),
                    timestamp: DateTime.now(),
                  ),
                );
              }
            });
          } else if (result.loginStreak >= 3) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                StreakNotification.show(
                  context,
                  type: StreakType.login,
                  streak: result.loginStreak,
                );
              }
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorColor: AppTheme.primaryTeal.withOpacity(0.1),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.explore_outlined, size: 24),
              selectedIcon: const Icon(Icons.explore, color: AppTheme.primaryTeal, size: 24),
              label: l10n.explore,
            ),
            NavigationDestination(
              icon: const Icon(Icons.library_books_outlined, size: 24),
              selectedIcon: const Icon(Icons.library_books, color: AppTheme.primaryTeal, size: 24),
              label: l10n.library,
            ),
            NavigationDestination(
              icon: const Icon(Icons.collections_bookmark_outlined, size: 24),
              selectedIcon: const Icon(Icons.collections_bookmark, color: AppTheme.primaryTeal, size: 24),
              label: l10n.collection,
            ),
            NavigationDestination(
              icon: const Icon(Icons.leaderboard_outlined, size: 24),
              selectedIcon: const Icon(Icons.leaderboard, color: AppTheme.primaryTeal, size: 24),
              label: l10n.leaderboard,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline, size: 24),
              selectedIcon: const Icon(Icons.person, color: AppTheme.primaryTeal, size: 24),
              label: l10n.profile,
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(currentAuthUserProvider);
    final userProfileAsync = ref.watch(currentUserProfileProvider);
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: r.constrainWidth(
          child: CustomScrollView(
            slivers: [
            // Minimalist Header with Islamic Border
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppTheme.islamicGreen.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(r.paddingMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // App Title with Arabic
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.lightOfKnowledge,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppTheme.primaryTeal,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.pathOfLight,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.textSecondary,
                                  letterSpacing: 1,
                                ),
                          ),
                        ],
                      ),
                      // Login or Profile
                      if (authUser == null)
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text(l10n.signIn),
                        )
                      else
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined),
                          color: AppTheme.textSecondary,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Islamic Greeting with Pattern
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(r.paddingMedium),
                padding: EdgeInsets.all(r.paddingLarge),
                decoration: BoxDecoration(
                  color: AppTheme.islamicGreen.withOpacity(0.05),
                  border: Border.all(
                    color: AppTheme.islamicGreen.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(r.radiusMedium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bismillah in Arabic calligraphy style
                    Center(
                      child: Text(
                        l10n.bismillah,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.islamicGreen,
                              fontWeight: FontWeight.w600,
                              height: 1.8,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: r.spaceSmall),
                    Center(
                      child: Text(
                        l10n.bismillahTranslation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Islamic Date Display
            const SliverToBoxAdapter(child: IslamicDateWidget()),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Prayer Times
            const SliverToBoxAdapter(child: PrayerTimesWidget()),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Dashboard Stats
            SliverToBoxAdapter(
              child: userProfileAsync.when(
                data: (profile) {
                  if (profile == null) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.yourProgress,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: r.spaceMedium),
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.auto_stories,
                                value: '${profile.quizProgress.totalQuestionsAnswered}',
                                label: l10n.questionsAnswered,
                                color: AppTheme.primaryTeal,
                              ),
                            ),
                            SizedBox(width: r.spaceSmall),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.local_fire_department,
                                value: '${profile.quizProgress.currentStreak}',
                                label: l10n.dayStreak(profile.quizProgress.currentStreak),
                                color: AppTheme.goldAccent,
                              ),
                            ),
                            SizedBox(width: r.spaceSmall),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.stars,
                                value: '${profile.quizProgress.totalPoints}',
                                label: l10n.points,
                                color: AppTheme.islamicGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Islamic Events
            const SliverToBoxAdapter(child: IslamicEventsWidget()),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Daily Du'as Slider
            const SliverToBoxAdapter(child: DuaSliderWidget()),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Spiritual Checklist
            const SliverToBoxAdapter(child: SpiritualChecklistWidget()),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Featured: The 14 Masoomeen
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: _FeaturedMasoomeenCard(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MasoomeenBrowseScreen()),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Browse Content Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.browseByTopic,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            l10n.viewAll,
                            style: TextStyle(
                              color: AppTheme.primaryTeal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Content Categories Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: r.valueWhen(mobile: 2, tablet: 3, desktop: 4),
                  crossAxisSpacing: r.spaceSmall,
                  mainAxisSpacing: r.spaceSmall,
                  childAspectRatio: 1.3,
                ),
                delegate: SliverChildListDelegate([
                  _TopicCard(
                    title: l10n.quran,
                    icon: Icons.menu_book,
                    color: AppTheme.primaryTeal,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const QuranScreen()),
                      );
                    },
                  ),
                  _TopicCard(
                    title: l10n.hadith,
                    icon: Icons.format_quote,
                    color: AppTheme.islamicGreen,
                    onTap: () {},
                  ),
                  _TopicCard(
                    title: l10n.fiqh,
                    icon: Icons.account_balance,
                    color: AppTheme.goldAccent,
                    onTap: () {},
                  ),
                  _TopicCard(
                    title: l10n.history,
                    icon: Icons.history_edu,
                    color: const Color(0xFF8B7355),
                    onTap: () {},
                  ),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Continue Learning
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: Text(
                  l10n.continueLearning,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Quiz Card
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: _LearningCard(
                  title: l10n.dailyQuizChallenge,
                  subtitle: l10n.testYourKnowledge,
                  icon: Icons.quiz,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const QuizStartScreen()),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Islamic Quote of the Day
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                child: Builder(
                  builder: (context) {
                    final quote = MockData.getRandomQuote();
                    return Container(
                      padding: EdgeInsets.all(r.paddingMedium),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.goldAccent.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(r.radiusMedium),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.goldAccent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.auto_awesome,
                                  color: AppTheme.goldAccent,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: r.spaceSmall),
                              Text(
                                l10n.quoteOfTheDay,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: r.spaceMedium),
                          Text(
                            quote['quote']!,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                ),
                          ),
                          SizedBox(height: r.spaceSmall),
                          Text(
                            '— ${quote['author']!}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.islamicGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Audio Library
            const SliverToBoxAdapter(child: AudioLibraryWidget()),

            // Banner Ad
            const SliverToBoxAdapter(child: HalalBannerAd()),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    ),
    );
  }
}

// Minimalist Stat Card
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: r.iconSmall),
          SizedBox(height: r.spaceSmall),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Topic Browse Card
class _TopicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TopicCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.radiusMedium),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3), width: 1),
          borderRadius: BorderRadius.circular(r.radiusMedium),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: r.iconMedium),
            SizedBox(height: r.spaceSmall),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Learning Card
class _LearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _LearningCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.radiusMedium),
      child: Container(
        padding: EdgeInsets.all(r.paddingMedium),
        decoration: BoxDecoration(
          color: AppTheme.primaryTeal.withOpacity(0.05),
          border: Border.all(
            color: AppTheme.primaryTeal.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(r.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(r.paddingSmall),
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal,
                borderRadius: BorderRadius.circular(r.radiusSmall),
              ),
              child: Icon(icon, color: Colors.white, size: r.iconSmall),
            ),
            SizedBox(width: r.spaceMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.primaryTeal,
            ),
          ],
        ),
      ),
    );
  }
}

// Featured Masoomeen Card
class _FeaturedMasoomeenCard extends StatelessWidget {
  final VoidCallback onTap;

  const _FeaturedMasoomeenCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(r.paddingMedium),
        decoration: BoxDecoration(
          color: AppTheme.islamicGreen.withOpacity(0.05),
          border: Border.all(
            color: AppTheme.islamicGreen.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(r.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(r.paddingMedium),
              decoration: BoxDecoration(
                color: AppTheme.islamicGreen.withOpacity(0.1),
                border: Border.all(
                  color: AppTheme.islamicGreen.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(r.radiusMedium),
              ),
              child: const Icon(
                Icons.auto_stories,
                color: AppTheme.islamicGreen,
                size: 32,
              ),
            ),
            SizedBox(width: r.spaceMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.the14Masoomeen,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.islamicGreen,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.learnAboutInfallibles,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.islamicGreen,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}