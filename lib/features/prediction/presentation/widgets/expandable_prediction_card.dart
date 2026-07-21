import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/animated_progress_bar.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/prediction_result.dart';
import 'verdict_visuals.dart';

/// Expandable per-model result row shown on the All-Model Analysis screen.
class ExpandablePredictionCard extends StatefulWidget {
  const ExpandablePredictionCard({super.key, required this.result});

  final PredictionResult result;

  @override
  State<ExpandablePredictionCard> createState() => _ExpandablePredictionCardState();
}

class _ExpandablePredictionCardState extends State<ExpandablePredictionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final verdictColor = result.label.color;
    final theme = Theme.of(context);

    return SoftCard(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: verdictColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(result.label.icon, color: verdictColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.modelName,
                      style: theme.textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(result.category, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              StatusBadge(label: result.label.label, color: verdictColor),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        AnimatedProgressBar(
                          label: 'Confidence',
                          value: result.confidence,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 10),
                        AnimatedProgressBar(
                          label: 'Fake probability',
                          value: result.fakeProbability,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 10),
                        AnimatedProgressBar(
                          label: 'Real probability',
                          value: result.realProbability,
                          color: AppColors.success,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
