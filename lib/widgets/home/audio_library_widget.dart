import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/dua/dua_model.dart';
import '../../data/mock_data.dart';

class AudioLibraryWidget extends StatelessWidget {
  const AudioLibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audios = MockData.audioRecitations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Audio Library',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'مكتبة الصوتيات',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Audio list
        ...audios.map((audio) => _AudioCard(audio: audio)),
      ],
    );
  }
}

class _AudioCard extends StatelessWidget {
  final AudioRecitation audio;

  const _AudioCard({required this.audio});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal.withOpacity(0.05),
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Play button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              onPressed: () {
                // Play audio
              },
            ),
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio.arabicTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.primaryTeal,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  audio.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  audio.reciter,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
              ],
            ),
          ),

          // Duration
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.headphones,
                color: AppTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                '${audio.durationMinutes} min',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
