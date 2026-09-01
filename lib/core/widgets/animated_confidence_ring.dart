import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Circular animated confidence gauge — animates from 0 to [value] whenever
/// the widget is built with a new value, used on the single-prediction
/// result screen.
class AnimatedConfidenceRing extends StatelessWidget {
  const AnimatedConfidenceRing({
    super.key,
    required this.value,
    required this.color,
    this.size = 160,
    this.strokeWidth = 14,
    this.centerLabel,
    this.centerSubLabel,
  });

  /// 0.0 - 1.0
  final double value;
  final Color color;
  final double size;
  final double strokeWidth;
  final String? centerLabel;
  final String? centerSubLabel;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0, 1)),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  value: animatedValue,
                  color: color,
                  strokeWidth: strokeWidth,
                  trackColor: color.withValues(alpha: 0.12),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    centerLabel ??
                        '${(animatedValue * 100).toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (centerSubLabel != null)
                    Text(
                      centerSubLabel!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
    required this.trackColor,
  });

  final double value;
  final Color color;
  final double strokeWidth;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final valuePaint = Paint()
      ..shader = SweepGradient(
        colors: [color.withValues(alpha: 0.5), color],
        startAngle: 0,
        endAngle: 2 * math.pi * value.clamp(0.001, 1.0),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}
