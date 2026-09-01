import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

/// Single-model verdict: a 140px confidence ring, verdict badge, probability
/// bars, and flag / new-check actions.
class SinglePredictionResultScreen extends ConsumerStatefulWidget {
  const SinglePredictionResultScreen({super.key});

  @override
  ConsumerState<SinglePredictionResultScreen> createState() =>
      _SinglePredictionResultScreenState();
}

class _SinglePredictionResultScreenState
    extends ConsumerState<SinglePredictionResultScreen> {
  bool _flagged = false;

  String _shareText(PredictionResult result) {
    return 'The Daily Truth analysis\n'
        'Verdict: ${result.label.label}\n'
        'Confidence: ${(result.confidence * 100).toStringAsFixed(1)}%\n'
        'Model: ${result.displayName} (${result.category})';
  }

  void _newCheck() {
    ref.read(singlePredictionProvider.notifier).reset();
    context.go('/analyze');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(singlePredictionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        actions: [
          state.valueOrNull == null
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.share_rounded),
                  onPressed: () => Share.share(_shareText(state.value!)),
                ),
        ],
      ),
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
                AnimatedConfidenceRing(
                  value: result.confidence,
                  color: color,
                  size: 140,
                  strokeWidth: 12,
                ),
                const SizedBox(height: 16),
                StatusBadge(
                  label: result.label.label,
                  color: color,
                  icon: result.label.icon,
                ),
                const SizedBox(height: 6),
                StatusBadge(
                  label: result.category,
                  color: AppColors.categoryColor(result.category),
                  dense: true,
                ),
                const SizedBox(height: 28),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.psychology_alt_rounded,
                      size: 18,
                      color: theme.hintColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Model: ${result.displayName}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _flagged
                            ? null
                            : () {
                                setState(() => _flagged = true);
                                SnackbarUtils.showInfo(
                                  context,
                                  'Flagged for analyst review',
                                );
                              },
                        icon: Icon(
                          _flagged
                              ? Icons.check_rounded
                              : Icons.outlined_flag_rounded,
                        ),
                        label: Text(_flagged ? 'Flagged' : 'Flag for review'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _newCheck,
                        child: const Text('New check'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  label: const Text('Copy summary'),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: _shareText(result)),
                    );
                    if (context.mounted) {
                      SnackbarUtils.showSuccess(context, 'Result copied');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
