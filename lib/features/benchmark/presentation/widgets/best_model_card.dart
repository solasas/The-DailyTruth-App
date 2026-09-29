import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/page_hero.dart';
import '../../domain/entities/benchmark_result.dart';

/// Hero card at the top of the Leaderboard screen highlighting the
/// best-performing model by accuracy.
class BestModelCard extends StatelessWidget {
  const BestModelCard({super.key, required this.result});

  final BenchmarkResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AccentCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PillBadge(
            icon: Icons.emoji_events_outlined,
            label: 'Best model',
          ),
          const SizedBox(height: 12),
          Text(
            result.displayName.toUpperCase(),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            result.category,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.extension<AppSemanticColors>()?.textSecondary,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _Stat(
                label: 'Accuracy',
                value: '${(result.accuracy * 100).toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 28),
              _Stat(
                label: 'Training Time',
                value: result.trainingTimeSeconds != null
                    ? '${result.trainingTimeSeconds!.toStringAsFixed(1)}s'
                    : '—',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.eyebrow(
            theme.extension<AppSemanticColors>()?.textSecondary ??
                theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
