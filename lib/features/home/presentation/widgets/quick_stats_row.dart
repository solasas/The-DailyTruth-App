import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../benchmark/domain/entities/benchmark_result.dart';

/// Two-tile "Quick Statistics" row: best model name and its accuracy.
class QuickStatsRow extends StatelessWidget {
  const QuickStatsRow({super.key, required this.bestModel});

  final BenchmarkResult? bestModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.emoji_events_rounded,
            iconColor: AppColors.warning,
            label: 'Best Model',
            value: bestModel?.modelName ?? '—',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            icon: Icons.trending_up_rounded,
            iconColor: AppColors.success,
            label: 'Accuracy',
            value: bestModel != null ? '${(bestModel!.accuracy * 100).toStringAsFixed(1)}%' : '—',
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
