import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/model_info.dart';
import 'model_metric_chip.dart';

/// Full metrics card for a single model — name, category, loaded badge and
/// the five headline metrics, used on the Models screen.
class ModelCard extends StatelessWidget {
  const ModelCard({super.key, required this.model});

  final ModelInfo model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = AppColors.categoryColor(model.category);

    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.psychology_alt_rounded, color: categoryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.displayName,
                      style: theme.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      model.featureType,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusBadge(
                label: model.loaded ? 'Loaded' : 'Not loaded',
                color: model.loaded ? AppColors.success : AppColors.textSecondaryLight,
                icon: model.loaded ? Icons.check_circle : Icons.circle_outlined,
                dense: true,
              ),
            ],
          ),
          const SizedBox(height: 14),
          StatusBadge(label: model.category, color: categoryColor),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: ModelMetricChip(label: 'Accuracy', value: model.accuracy)),
              Expanded(child: ModelMetricChip(label: 'F1', value: model.f1Score)),
              Expanded(child: ModelMetricChip(label: 'Precision', value: model.precision)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: ModelMetricChip(label: 'Recall', value: model.recall)),
              Expanded(child: ModelMetricChip(label: 'AUC', value: model.auc)),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
