import 'package:flutter/material.dart';

import '../../domain/entities/prediction_result.dart';
import 'verdict_visuals.dart';

/// One "Per-model results" row: model name, a 90×6 confidence bar tinted to
/// the model's verdict, and the short verdict label.
class ModelResultBar extends StatelessWidget {
  const ModelResultBar({super.key, required this.result});

  final PredictionResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = result.label.color;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              result.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 90,
            height: 6,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: result.confidence.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 76,
            child: Text(
              result.label.label,
              textAlign: TextAlign.right,
              style: theme.textTheme.labelSmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
