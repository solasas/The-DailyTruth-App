import 'package:flutter/material.dart';

import '../../domain/entities/prediction_result.dart';
import 'verdict_visuals.dart';

/// Hero card at the top of the All-Model Analysis screen summarizing the
/// consensus verdict across every model that ran.
class ConsensusCard extends StatelessWidget {
  const ConsensusCard({
    super.key,
    required this.label,
    required this.confidence,
    required this.modelCount,
  });

  final PredictionLabel label;
  final double confidence;
  final int modelCount;

  @override
  Widget build(BuildContext context) {
    final gradient = label.gradient;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'CONSENSUS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Icon(label.icon, color: Colors.white, size: 56),
          const SizedBox(height: 8),
          Text(
            label.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(confidence * 100).toStringAsFixed(1)}% confidence · $modelCount models',
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
