import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/masoomeen/masoom_model.dart';
import '../../providers/quiz_providers.dart';
import '../quiz/quiz_question_screen.dart';

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Order badge
                  Container(
                    width: 64,
                    height: 64,
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
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Arabic name
                  Text(
                    masoom.arabicName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // English name
                  Text(
                    masoom.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Titles
                  Text(
                    masoom.arabicTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 4),

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

            const SizedBox(height: 24),

            // Biography
            _SectionCard(
              title: 'Biography',
              color: color,
              child: Text(
                masoom.shortBio,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
              ),
            ),

            const SizedBox(height: 16),

            // Life Details
            _SectionCard(
              title: 'Life Details',
              color: color,
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Birth Place',
                    value: masoom.birthPlace,
                    color: color,
                  ),
                  const Divider(height: 20),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Birth Date',
                    value: masoom.birthDate,
                    color: color,
                  ),
                  if (masoom.deathPlace != null) ...[
                    const Divider(height: 20),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Place of Martyrdom',
                      value: masoom.deathPlace!,
                      color: color,
                    ),
                  ],
                  if (masoom.deathDate != null) ...[
                    const Divider(height: 20),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date of Martyrdom',
                      value: masoom.deathDate!,
                      color: color,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Notable Events
            _SectionCard(
              title: 'Notable Events',
              color: color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: masoom.notableEvents.map((event) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
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

            const SizedBox(height: 16),

            // Teachings
            _SectionCard(
              title: 'Key Teachings',
              color: color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: masoom.teachings.map((teaching) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
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

            const SizedBox(height: 32),

            // Start Quiz Button
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _startMasoomQuiz(context, ref),
                icon: const Icon(Icons.quiz),
                label: Text(
                  'Start Quiz (${masoom.quizCount} available)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
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
  final String title;
  final Widget child;
  final Color color;

  const _SectionCard({
    required this.title,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
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
              const SizedBox(height: 2),
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
