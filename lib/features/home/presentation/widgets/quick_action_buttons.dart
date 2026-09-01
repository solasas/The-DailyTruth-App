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
    this.onVerifyArticle,
  });

  final VoidCallback onAnalyze;
  final VoidCallback onCompareModels;
  final VoidCallback onBenchmark;

  /// Opens the agentic article-verification flow. Optional so Home degrades
  /// gracefully if the feature is ever pulled.
  final VoidCallback? onVerifyArticle;

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
        if (onVerifyArticle != null) ...[
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onVerifyArticle,
              icon: const Icon(Icons.hub_rounded),
              label: const Text('Verify an article (agentic)'),
            ),
          ),
          const SizedBox(height: 12),
        ],
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
