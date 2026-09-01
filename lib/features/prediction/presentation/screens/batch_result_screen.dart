import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/prediction_result.dart';
import '../providers/prediction_providers.dart';
import '../widgets/verdict_visuals.dart';

/// Result list for a Batch check — one row per submitted item.
class BatchResultScreen extends ConsumerWidget {
  const BatchResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final async = ref.watch(batchPredictionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Batch result')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(error: error),
        data: (items) {
          if (items == null || items.isEmpty) {
            return const ErrorView(error: 'No batch results available.');
          }
          final fake = items
              .where((i) => i.result.label == PredictionLabel.fake)
              .length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SoftCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${items.length} items checked',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    StatusBadge(
                      label: '$fake flagged',
                      color: PredictionLabel.fake.color,
                      dense: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SoftCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          item.result.label.icon,
                          color: item.result.label.color,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.text,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.result.label.label} · '
                                '${(item.result.confidence * 100).toStringAsFixed(0)}%',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: item.result.label.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  ref.read(batchPredictionProvider.notifier).reset();
                  context.go('/analyze');
                },
                child: const Text('New check'),
              ),
            ],
          );
        },
      ),
    );
  }
}
