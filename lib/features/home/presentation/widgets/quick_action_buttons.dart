import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';

/// "Analyze News" / "Compare Models" / "Benchmark Results" quick-action
/// buttons shown on the dashboard.
class QuickActionButtons extends StatelessWidget {
  const QuickActionButtons({
    super.key,
    required this.onAnalyze,
    required this.onCompareModels,
    required this.onBenchmark,
  });

  final VoidCallback onAnalyze;
  final VoidCallback onCompareModels;
  final VoidCallback onBenchmark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onAnalyze,
            icon: const Icon(Icons.search_rounded),
            label: const Text('Analyze News'),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionTile(
                icon: Icons.hub_rounded,
                label: 'Compare Models',
                color: AppColors.primary,
                onTap: onCompareModels,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: Icons.leaderboard_rounded,
                label: 'Benchmark Results',
                color: AppColors.success,
                onTap: onBenchmark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
