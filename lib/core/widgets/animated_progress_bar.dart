import 'package:flutter/material.dart';

/// Horizontal animated progress bar with a label + percentage, used for
/// fake/real probability breakdowns and metric bars (accuracy, F1, ...).
class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.height = 10,
    this.showPercentage = true,
  });

  /// 0.0 - 1.0
  final double value;
  final String label;
  final Color color;
  final double height;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: theme.textTheme.bodySmall),
            if (showPercentage)
              Text(
                '${(value * 100).toStringAsFixed(1)}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(height),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value.clamp(0, 1)),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, _) {
              return LinearProgressIndicator(
                value: animatedValue,
                minHeight: height,
                backgroundColor: color.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation(color),
              );
            },
          ),
        ),
      ],
    );
  }
}
