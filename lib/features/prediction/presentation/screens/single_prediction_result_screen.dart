import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart' show Share;

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/animated_confidence_ring.dart';
import '../../../../core/widgets/animated_progress_bar.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../domain/entities/prediction_result.dart';
import '../providers/prediction_providers.dart';
import '../widgets/verdict_visuals.dart';

/// Displays the result of a single-model prediction with an animated
/// confidence ring, probability bars and copy/share actions.
class SinglePredictionResultScreen extends ConsumerWidget {
  const SinglePredictionResultScreen({super.key});

  String _shareText(PredictionResult result) {
    return 'The DailyTruth analysis\n'
        'Verdict: ${result.label.label}\n'
        'Confidence: ${(result.confidence * 100).toStringAsFixed(1)}%\n'
        'Model: ${result.displayName} (${result.category})';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(singlePredictionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Prediction Result')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(error: error),
        data: (result) {
          if (result == null) {
            return const ErrorView(error: 'No result available.');
          }
          final color = result.label.color;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Hero(
                  tag: 'verdict-icon',
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(result.label.icon, color: color, size: 52),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  result.label.label,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                StatusBadge(label: result.category, color: AppColors.categoryColor(result.category)),
                const SizedBox(height: 28),
                AnimatedConfidenceRing(value: result.confidence, color: color),
                const SizedBox(height: 28),
                Column(
                  children: [
                    AnimatedProgressBar(
                      label: 'Fake probability',
                      value: result.fakeProbability,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 14),
                    AnimatedProgressBar(
                      label: 'Real probability',
                      value: result.realProbability,
                      color: AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.psychology_alt_rounded, size: 18, color: Theme.of(context).hintColor),
                    const SizedBox(width: 8),
                    Text('Model: ${result.displayName}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.copy_rounded),
                        label: const Text('Copy'),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: _shareText(result)));
                          if (context.mounted) {
                            SnackbarUtils.showSuccess(context, 'Result copied to clipboard');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.share_rounded),
                        label: const Text('Share'),
                        onPressed: () => Share.share(_shareText(result)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
