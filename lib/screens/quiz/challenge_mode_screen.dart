import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/enhanced_quiz_providers.dart';

class ChallengeModeScreen extends ConsumerStatefulWidget {
  const ChallengeModeScreen({super.key});

  @override
  ConsumerState<ChallengeModeScreen> createState() => _ChallengeModeScreenState();
}

class _ChallengeModeScreenState extends ConsumerState<ChallengeModeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  // Mock data for demonstration
  final List<Map<String, dynamic>> _friends = [
    {
      'id': '1',
      'name': 'Ahmad Ali',
      'nameAr': 'أحمد علي',
      'avatar': 'AA',
      'level': 15,
      'wins': 45,
      'status': 'online',
      'score': 2450,
    },
    {
      'id': '2',
      'name': 'Fatima Hassan',
      'nameAr': 'فاطمة حسن',
      'avatar': 'FH',
      'level': 12,
      'wins': 32,
      'status': 'online',
      'score': 1890,
    },
    {
      'id': '3',
      'name': 'Muhammad Ibrahim',
      'nameAr': 'محمد إبراهيم',
      'avatar': 'MI',
      'level': 18,
      'wins': 67,
      'status': 'offline',
      'score': 3210,
    },
    {
      'id': '4',
      'name': 'Zahra Ahmed',
      'nameAr': 'زهراء أحمد',
      'avatar': 'ZA',
      'level': 10,
      'wins': 28,
      'status': 'online',
      'score': 1650,
    },
  ];

  final List<Map<String, dynamic>> _topPlayers = [
    {
      'id': '10',
      'name': 'Hassan Al-Sadiq',
      'nameAr': 'حسن الصادق',
      'avatar': 'HS',
      'level': 25,
      'wins': 120,
      'status': 'online',
      'score': 5890,
      'rank': 1,
    },
    {
      'id': '11',
      'name': 'Maryam Kazim',
      'nameAr': 'مريم كاظم',
      'avatar': 'MK',
      'level': 23,
      'wins': 105,
      'status': 'online',
      'score': 5120,
      'rank': 2,
    },
    {
      'id': '12',
      'name': 'Ali Reza',
      'nameAr': 'علي رضا',
      'avatar': 'AR',
      'level': 22,
      'wins': 98,
      'status': 'offline',
      'score': 4850,
      'rank': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Challenge Mode'),
        backgroundColor: AppTheme.primaryTeal,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.goldAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.shuffle), text: 'Random'),
            Tab(icon: Icon(Icons.people), text: 'Friends'),
            Tab(icon: Icon(Icons.emoji_events), text: 'Top Players'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRandomMatchTab(),
          _buildFriendsTab(),
          _buildTopPlayersTab(),
        ],
      ),
    );
  }

  Widget _buildRandomMatchTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Random Match Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryTeal,
                  AppTheme.islamicGreen,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryTeal.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shuffle,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Random Match',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Challenge a random player with similar skill level',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _findRandomMatch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Find Match',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Difficulty Selection
          _buildSectionTitle('Select Difficulty'),
          const SizedBox(height: 16),
          _buildDifficultyOptions(),

          const SizedBox(height: 32),

          // Category Selection
          _buildSectionTitle('Select Category'),
          const SizedBox(height: 16),
          _buildCategoryOptions(),
        ],
      ),
    );
  }

  Widget _buildFriendsTab() {
    final filteredFriends = _friends.where((friend) {
      if (searchQuery.isEmpty) return true;
      return friend['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          friend['nameAr'].contains(searchQuery);
    }).toList();

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search friends...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => searchQuery = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),

        // Friends List
        Expanded(
          child: filteredFriends.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No friends found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredFriends.length,
                  itemBuilder: (context, index) {
                    return _buildPlayerCard(filteredFriends[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTopPlayersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _topPlayers.length,
      itemBuilder: (context, index) {
        final player = _topPlayers[index];
        return _buildPlayerCard(player, showRank: true);
      },
    );
  }

  Widget _buildPlayerCard(Map<String, dynamic> player, {bool showRank = false}) {
    final isOnline = player['status'] == 'online';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOnline ? AppTheme.success.withOpacity(0.3) : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _challengePlayer(player),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rank Badge (for top players)
              if (showRank) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getRankGradient(player['rank']),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '#${player['rank']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.primaryTeal,
                    child: Text(
                      player['avatar'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isOnline ? AppTheme.success : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Player Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.goldAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, size: 12, color: AppTheme.goldAccent),
                              const SizedBox(width: 4),
                              Text(
                                'Level ${player['level']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.goldAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${player['wins']} wins',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Score
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.emoji_events, color: AppTheme.info, size: 20),
                    const SizedBox(height: 4),
                    Text(
                      '${player['score']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.info,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Challenge Button
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isOnline ? AppTheme.primaryTeal : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.swords,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _buildDifficultyOptions() {
    final difficulties = [
      {'label': 'Basic', 'color': AppTheme.success, 'icon': Icons.filter_1},
      {'label': 'Intermediate', 'color': AppTheme.info, 'icon': Icons.filter_2},
      {'label': 'Advanced', 'color': AppTheme.warning, 'icon': Icons.filter_3},
      {'label': 'Expert', 'color': AppTheme.error, 'icon': Icons.filter_4},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: difficulties.map((diff) {
        return _buildOptionChip(
          label: diff['label'] as String,
          color: diff['color'] as Color,
          icon: diff['icon'] as IconData,
        );
      }).toList(),
    );
  }

  Widget _buildCategoryOptions() {
    final categories = [
      {'label': 'Prophet Muhammad', 'icon': Icons.auto_stories},
      {'label': 'Imam Ali', 'icon': Icons.menu_book},
      {'label': 'Quran', 'icon': Icons.book},
      {'label': 'Hadith', 'icon': Icons.format_quote},
      {'label': 'Fiqh', 'icon': Icons.gavel},
      {'label': 'History', 'icon': Icons.history_edu},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: categories.map((cat) {
        return _buildOptionChip(
          label: cat['label'] as String,
          color: AppTheme.islamicGreen,
          icon: cat['icon'] as IconData,
        );
      }).toList(),
    );
  }

  Widget _buildOptionChip({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getRankGradient(int rank) {
    switch (rank) {
      case 1:
        return [const Color(0xFFFFD700), const Color(0xFFFFA500)]; // Gold
      case 2:
        return [const Color(0xFFC0C0C0), const Color(0xFF808080)]; // Silver
      case 3:
        return [const Color(0xFFCD7F32), const Color(0xFF8B4513)]; // Bronze
      default:
        return [AppTheme.primaryTeal, AppTheme.islamicGreen];
    }
  }

  void _findRandomMatch() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          margin: EdgeInsets.all(32),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
                ),
                SizedBox(height: 20),
                Text(
                  'Finding a match...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Please wait while we match you with a player',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Simulate finding a match
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      _showMatchFoundDialog(_friends[0]);
    });
  }

  void _challengePlayer(Map<String, dynamic> player) {
    if (player['status'] != 'online') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${player['name']} is currently offline'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    _showMatchFoundDialog(player);
  }

  void _showMatchFoundDialog(Map<String, dynamic> player) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryTeal.withOpacity(0.1),
                AppTheme.islamicGreen.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.swords,
                size: 64,
                color: AppTheme.goldAccent,
              ),
              const SizedBox(height: 16),
              const Text(
                'Match Found!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You will challenge ${player['name']}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textSecondary,
                        side: BorderSide(color: Colors.grey.shade300, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _startChallenge(player);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryTeal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Start'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startChallenge(Map<String, dynamic> player) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting challenge with ${player['name']}...'),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    // Create a challenge session
    final challengeNotifier = ref.read(challengeProvider.notifier);
    await challengeNotifier.createChallenge(
      opponentId: player['id'],
      difficulty: 'intermediate',
    );

    // Note: In production, you would navigate to a quiz session with the created challenge
    // For now, we show that the challenge is being created
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Challenge created! Starting quiz...'),
          backgroundColor: AppTheme.info,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// Custom icon for swords (challenge icon)
class _SwordsIcon extends StatelessWidget {
  final Color? color;
  final double size;

  const _SwordsIcon({this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.cached, // Using cached as a placeholder for crossed swords
      color: color,
      size: size,
    );
  }
}

// Extension to add swords icon to Icons
extension CustomIcons on Icons {
  static const IconData swords = Icons.cached;
}
