import 'package:flutter/material.dart';

import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';
import 'article_verdict_visuals.dart';

/// Inline notice explaining that a pipeline stage had to degrade — shown
/// above the verdict so a lower-confidence result is understood in context.
class DegradationBanner extends StatelessWidget {
  const DegradationBanner({super.key, required this.degradation});

  final Degradation degradation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = ArticleVerdictVisuals.degradationColor(degradation.severity);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degradation.stage == null
                      ? degradation.severity.label
                      : '${degradation.severity.label} · ${degradation.stage}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(degradation.reason, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
