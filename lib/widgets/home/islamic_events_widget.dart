import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/islamic_events/islamic_event.dart';
import '../../data/mock_data.dart';

class IslamicEventsWidget extends StatelessWidget {
  const IslamicEventsWidget({super.key});

  Color _getEventColor(IslamicEventType type) {
    switch (type) {
      case IslamicEventType.birth:
        return AppTheme.islamicGreen;
      case IslamicEventType.martyrdom:
        return const Color(0xFF8B0000); // Dark red
      case IslamicEventType.occasion:
        return AppTheme.primaryTeal;
      case IslamicEventType.fastingDay:
        return AppTheme.goldAccent;
      case IslamicEventType.celebration:
        return const Color(0xFFFFA500); // Orange
    }
  }

  IconData _getEventIcon(IslamicEventType type) {
    switch (type) {
      case IslamicEventType.birth:
        return Icons.cake;
      case IslamicEventType.martyrdom:
        return Icons.favorite;
      case IslamicEventType.occasion:
        return Icons.star;
      case IslamicEventType.fastingDay:
        return Icons.local_dining;
      case IslamicEventType.celebration:
        return Icons.celebration;
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = MockData.upcomingEvents;

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
                    'Islamic Events',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'المناسبات الإسلامية',
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

        // Events list
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: events.map((event) => _EventCard(
              event: event,
              color: _getEventColor(event.type),
              icon: _getEventIcon(event.type),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final IslamicEvent event;
  final Color color;
  final IconData icon;

  const _EventCard({
    required this.event,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and date
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  event.hijriDate,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Title
          Text(
            event.arabicTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            event.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            event.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.4,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
