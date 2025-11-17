import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/masoomeen/masoom_model.dart';
import '../../providers/quiz_providers.dart';
import '../quiz/quiz_question_screen.dart';
import '../../utils/responsive.dart';

class MasoomDetailScreen extends ConsumerWidget {
  final Masoom masoom;

  const MasoomDetailScreen({super.key, required this.masoom});

  Color _getOrderColor(int order) {
    if (order == 1) return AppTheme.goldAccent;
    if (order == 2) return const Color(0xFFE91E63);
    if (order <= 5) return AppTheme.primaryTeal;
    if (order <= 9) return AppTheme.islamicGreen;
    return AppTheme.info;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final color = _getOrderColor(masoom.order);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(masoom.name),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Container(
              padding: EdgeInsets.all(r.paddingLarge),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(r.radiusMedium),
              ),
              child: Column(
                children: [
                  // Order badge
                  Container(
                    width: r.iconXLarge,
                    height: r.iconXLarge,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${masoom.order}',
                        style: TextStyle(
                          fontSize: r.fontXLarge + 4,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: r.spaceMedium),

                  // Arabic name
                  Text(
                    masoom.arabicName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: r.spaceSmall),

                  // English name
                  Text(
                    masoom.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: r.spaceSmall),

                  // Titles
                  Text(
                    masoom.arabicTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: r.spaceSmall / 2),

                  Text(
                    masoom.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: r.spaceLarge),

            // Biography
            _SectionCard(
              r: r,
              title: 'Biography',
              color: color,
              child: Text(
                masoom.shortBio,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
              ),
            ),

            SizedBox(height: r.spaceMedium),

            // Life Details
            _SectionCard(
              r: r,
              title: 'Life Details',
              color: color,
              child: Column(
                children: [
                  _InfoRow(
                    r: r,
                    icon: Icons.location_on_outlined,
                    label: 'Birth Place',
                    value: masoom.birthPlace,
                    color: color,
                  ),
                  Divider(height: r.paddingLarge),
                  _InfoRow(
                    r: r,
                    icon: Icons.calendar_today_outlined,
                    label: 'Birth Date',
                    value: masoom.birthDate,
                    color: color,
                  ),
                  if (masoom.deathPlace != null) ...[
                    Divider(height: r.paddingLarge),
                    _InfoRow(
                      r: r,
                      icon: Icons.location_on_outlined,
                      label: 'Place of Martyrdom',
                      value: masoom.deathPlace!,
                      color: color,
                    ),
                  ],
                  if (masoom.deathDate != null) ...[
                    Divider(height: r.paddingLarge),
                    _InfoRow(
                      r: r,
                      icon: Icons.calendar_today_outlined,
                      label: 'Date of Martyrdom',
                      value: masoom.deathDate!,
                      color: color,
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: r.spaceMedium),

            // Notable Events
            _SectionCard(
              r: r,
              title: 'Notable Events',
              color: color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: masoom.notableEvents.map((event) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: r.spaceSmall),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: r.spaceSmall / 1.5),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: r.paddingSmall),
                        Expanded(
                          child: Text(
                            event,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: r.spaceMedium),

            // Teachings
            _SectionCard(
              r: r,
              title: 'Key Teachings',
              color: color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: masoom.teachings.map((teaching) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: r.spaceSmall),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: r.spaceSmall / 1.5),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: r.paddingSmall),
                        Expanded(
                          child: Text(
                            teaching,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: r.spaceLarge + 8),

            // Start Quiz Button
            SizedBox(
              height: r.iconLarge + 4,
              child: ElevatedButton.icon(
                onPressed: () => _startMasoomQuiz(context, ref),
                icon: Icon(Icons.quiz, size: r.iconMedium),
                label: Text(
                  'Start Quiz (${masoom.quizCount} available)',
                  style: TextStyle(fontSize: r.fontMedium, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(r.radiusMedium),
                  ),
                ),
              ),
            ),

            SizedBox(height: r.spaceMedium),
          ],
        ),
      ),
    );
  }

  Future<void> _startMasoomQuiz(BuildContext context, WidgetRef ref) async {
    final quizNotifier = ref.read(quizSessionProvider.notifier);

    // Start quiz filtered by this Masoom's ID
    final success = await quizNotifier.startQuiz(
      masoomId: masoom.id, // Filter questions tagged with this Masoom
      count: 10,
      language: 'en',
    );

    if (success && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const QuizQuestionScreen()),
      );
    } else if (context.mounted) {
      final quizState = ref.read(quizSessionProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(quizState.error ?? 'Failed to start quiz'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _SectionCard extends StatelessWidget {
  final Responsive r;
  final String title;
  final Widget child;
  final Color color;

  const _SectionCard({
    required this.r,
    required this.title,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          SizedBox(height: r.paddingSmall),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final Responsive r;
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.r,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(r.spaceSmall),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(r.radiusSmall),
          ),
          child: Icon(icon, color: color, size: r.fontLarge),
        ),
        SizedBox(width: r.paddingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              SizedBox(height: r.spaceSmall / 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
