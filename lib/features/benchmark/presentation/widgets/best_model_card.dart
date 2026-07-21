import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../domain/entities/benchmark_result.dart';

/// Hero card at the top of the Leaderboard screen highlighting the
/// best-performing model by accuracy.
class BestModelCard extends StatelessWidget {
  const BestModelCard({super.key, required this.result});

  final BenchmarkResult result;

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      colors: AppColors.primaryGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 8),
              Text(
                'Best Model',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            result.displayName,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            result.category,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Stat(label: 'Accuracy', value: '${(result.accuracy * 100).toStringAsFixed(1)}%'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
