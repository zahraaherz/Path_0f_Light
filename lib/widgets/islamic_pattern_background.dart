import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Reusable Islamic pattern background widget
/// Can be used across different pages for consistent Islamic aesthetic
class IslamicPatternBackground extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? patternColor;
  final double patternOpacity;
  final IslamicPatternType patternType;

  const IslamicPatternBackground({
    super.key,
    required this.child,
    this.backgroundColor,
    this.patternColor,
    this.patternOpacity = 0.03,
    this.patternType = IslamicPatternType.geometric,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? const Color(0xFFF8F9FA),
      child: Stack(
        children: [
          // Islamic pattern layer
          Positioned.fill(
            child: CustomPaint(
              painter: _IslamicPatternPainter(
                patternColor: patternColor ?? Colors.black,
                opacity: patternOpacity,
                patternType: patternType,
              ),
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}

enum IslamicPatternType {
  geometric,
  stars,
  arabesque,
}

class _IslamicPatternPainter extends CustomPainter {
  final Color patternColor;
  final double opacity;
  final IslamicPatternType patternType;

  _IslamicPatternPainter({
    required this.patternColor,
    required this.opacity,
    required this.patternType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (patternType) {
      case IslamicPatternType.geometric:
        _drawGeometricPattern(canvas, size);
        break;
      case IslamicPatternType.stars:
        _drawStarPattern(canvas, size);
        break;
      case IslamicPatternType.arabesque:
        _drawArabesquePattern(canvas, size);
        break;
    }
  }

  void _drawGeometricPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 60.0;
    const radius = 20.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        // Draw interlocking octagons
        final path = Path();
        for (int i = 0; i < 8; i++) {
          final angle = (i * 45) * math.pi / 180;
          final px = x + radius * math.cos(angle);
          final py = y + radius * math.sin(angle);
          if (i == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }
        path.close();
        canvas.drawPath(path, paint);

        // Draw small connecting squares
        canvas.drawCircle(Offset(x, y), 2, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
      }
    }
  }

  void _drawStarPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 80.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        _drawStar(canvas, Offset(x, y), 15.0, 8, paint);
      }
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, int points, Paint paint) {
    final path = Path();
    final innerRadius = radius * 0.5;

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * math.pi / points) - math.pi / 2;
      final r = i.isEven ? radius : innerRadius;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawArabesquePattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 70.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        // Draw flowing curves
        final path = Path();
        path.moveTo(x - 20, y);
        path.quadraticBezierTo(x - 10, y - 15, x, y - 10);
        path.quadraticBezierTo(x + 10, y - 5, x + 20, y);
        path.quadraticBezierTo(x + 10, y + 5, x, y + 10);
        path.quadraticBezierTo(x - 10, y + 15, x - 20, y);

        canvas.drawPath(path, paint);

        // Add small decorative circles
        canvas.drawCircle(Offset(x, y - 10), 2, paint..style = PaintingStyle.fill);
        canvas.drawCircle(Offset(x, y + 10), 2, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Decorative Islamic header with gradient and pattern
class IslamicHeaderDecoration extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double patternOpacity;

  const IslamicHeaderDecoration({
    super.key,
    required this.child,
    required this.gradientColors,
    this.patternOpacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _IslamicPatternPainter(
                patternColor: Colors.white,
                opacity: patternOpacity,
                patternType: IslamicPatternType.stars,
              ),
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}
