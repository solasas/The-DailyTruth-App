import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/animated_confidence_ring.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/prediction_result.dart';
import '../providers/prediction_providers.dart';
import '../widgets/model_result_bar.dart';
import '../widgets/verdict_visuals.dart';

/// The consensus verdict from `POST /predict/all`: a confidence ring, a
/// verdict badge, and a per-model breakdown.
class AllModelsResultScreen extends ConsumerStatefulWidget {
  const AllModelsResultScreen({super.key});

  @override
  ConsumerState<AllModelsResultScreen> createState() =>
      _AllModelsResultScreenState();
}

class _AllModelsResultScreenState extends ConsumerState<AllModelsResultScreen> {
  bool _flagged = false;

  void _newCheck() {
    ref.read(allModelsPredictionProvider.notifier).reset();
    context.go('/analyze');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(allModelsPredictionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(error: error),
        data: (prediction) {
          if (prediction == null) {
            return const ErrorView(error: 'No result available.');
          }
          final label = prediction.consensusLabel;
          final color = label.color;
          final fakeCount = prediction.results
              .where((r) => r.label == PredictionLabel.fake)
              .length;
          final total = prediction.results.length;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            children: [
              FadeSlideIn(
                child: Center(
                  child: Column(
                    children: [
                      AnimatedConfidenceRing(
                        value: prediction.consensusConfidence,
                        color: color,
                        size: 140,
                        strokeWidth: 12,
                      ),
                      const SizedBox(height: 16),
                      StatusBadge(
                        label: label.label,
                        color: color,
                        icon: label.icon,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$fakeCount of $total models flagged this as fake.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text('Per-model results', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              for (final result in prediction.results)
                ModelResultBar(result: result),
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
            ],
          );
        },
      ),
    );
  }
}
