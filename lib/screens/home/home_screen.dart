import 'package:flutter/material.dart';
import '../../widgets/halal_banner_ad.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path of Light'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildWelcomeCard(),
                const SizedBox(height: 16),
                _buildQuickAccessGrid(context),
                const SizedBox(height: 16),
                _buildDailyReminder(),
              ],
            ),
          ),
          // Banner Ad at the bottom
          const HalalBannerAd(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'As-salamu alaykum!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to Path of Light - Your Islamic Learning Companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildQuickAccessCard(
          icon: Icons.book,
          title: 'Books',
          color: Colors.blue,
          onTap: () {
            // Navigate to books screen
          },
        ),
        _buildQuickAccessCard(
          icon: Icons.emoji_events,
          title: 'Challenges',
          color: Colors.orange,
          onTap: () {
            // Navigate to challenges screen
          },
        ),
        _buildQuickAccessCard(
          icon: Icons.bookmark,
          title: 'Collections',
          color: Colors.purple,
          onTap: () {
            // Navigate to collections screen
          },
        ),
        _buildQuickAccessCard(
          icon: Icons.dashboard,
          title: 'Dashboard',
          color: Colors.green,
          onTap: () {
            // Navigate to dashboard screen
          },
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyReminder() {
    return Card(
      elevation: 2,
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: 40,
              color: Colors.green.shade700,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Reminder',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Seek knowledge from the cradle to the grave',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
