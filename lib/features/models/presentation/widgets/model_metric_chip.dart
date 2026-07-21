import 'package:flutter/material.dart';

/// Small labeled metric tile (e.g. "Accuracy 96.2%") used inside model and
/// leaderboard cards.
class ModelMetricChip extends StatelessWidget {
  const ModelMetricChip({super.key, required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${(value * 100).toStringAsFixed(1)}%',
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
