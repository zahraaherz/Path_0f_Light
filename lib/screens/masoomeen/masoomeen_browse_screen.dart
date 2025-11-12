import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/masoomeen/masoom_model.dart';
import 'masoom_detail_screen.dart';

class MasoomeenBrowseScreen extends StatelessWidget {
  const MasoomeenBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('The 14 Masoomeen'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with Arabic
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.islamicGreen.withOpacity(0.05),
                border: Border.all(
                  color: AppTheme.islamicGreen.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'المَعصُومُونَ الأَربَعَةَ عَشَر',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.islamicGreen,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The 14 Infallibles',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Peace be upon them all',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // List of Masoomeen
            ...MasoomeenData.all.map((masoom) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _MasoomCard(masoom: masoom),
              );
            }).toList(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MasoomCard extends StatelessWidget {
  final Masoom masoom;

  const _MasoomCard({required this.masoom});

  Color _getOrderColor(int order) {
    if (order == 1) return AppTheme.goldAccent; // Prophet
    if (order == 2) return const Color(0xFFE91E63); // Lady Fatima - Pink/Rose
    if (order <= 5) return AppTheme.primaryTeal; // First 3 Imams
    if (order <= 9) return AppTheme.islamicGreen; // Next Imams
    return AppTheme.info; // Later Imams
  }

  @override
  Widget build(BuildContext context) {
    final color = _getOrderColor(masoom.order);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MasoomDetailScreen(masoom: masoom),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Order number
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${masoom.order}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    masoom.arabicName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    masoom.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    masoom.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ),

            // Quiz count badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.goldAccent.withOpacity(0.1),
                border: Border.all(
                  color: AppTheme.goldAccent.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.quiz,
                    size: 14,
                    color: AppTheme.goldAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${masoom.quizCount}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
