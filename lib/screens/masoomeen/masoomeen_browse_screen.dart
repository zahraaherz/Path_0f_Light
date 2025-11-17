import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/masoomeen/masoom_model.dart';
import 'masoom_detail_screen.dart';
import '../../utils/responsive.dart';

class MasoomeenBrowseScreen extends StatelessWidget {
  const MasoomeenBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('The 14 Masoomeen'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with Arabic
            Container(
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
                children: [
                  Text(
                    'المَعصُومُونَ الأَربَعَةَ عَشَر',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.islamicGreen,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.spaceSmall),
                  Text(
                    'The 14 Infallibles',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.paddingSmall),
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

            SizedBox(height: r.spaceLarge),

            // List of Masoomeen
            ...MasoomeenData.all.map((masoom) {
              return Padding(
                padding: EdgeInsets.only(bottom: r.paddingSmall),
                child: _MasoomCard(r: r, masoom: masoom),
              );
            }).toList(),

            SizedBox(height: r.spaceMedium),
          ],
        ),
      ),
    );
  }
}

class _MasoomCard extends StatelessWidget {
  final Responsive r;
  final Masoom masoom;

  const _MasoomCard({required this.r, required this.masoom});

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
      borderRadius: BorderRadius.circular(r.radiusMedium),
      child: Container(
        padding: EdgeInsets.all(r.paddingMedium),
        decoration: BoxDecoration(
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(r.radiusMedium),
        ),
        child: Row(
          children: [
            // Order number
            Container(
              width: r.iconLarge,
              height: r.iconLarge,
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
                    fontSize: r.fontLarge,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),

            SizedBox(width: r.spaceMedium),

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
                  SizedBox(height: r.spaceSmall / 2),
                  Text(
                    masoom.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  SizedBox(height: r.spaceSmall / 2),
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
              padding: EdgeInsets.symmetric(horizontal: r.paddingSmall, vertical: r.spaceSmall / 1.5),
              decoration: BoxDecoration(
                color: AppTheme.goldAccent.withOpacity(0.1),
                border: Border.all(
                  color: AppTheme.goldAccent.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(r.radiusMedium),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.quiz,
                    size: r.fontMedium,
                    color: AppTheme.goldAccent,
                  ),
                  SizedBox(width: r.spaceSmall / 2),
                  Text(
                    '${masoom.quizCount}',
                    style: TextStyle(
                      fontSize: r.fontSmall,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldAccent,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: r.spaceSmall),

            Icon(
              Icons.arrow_forward_ios,
              size: r.fontMedium,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
