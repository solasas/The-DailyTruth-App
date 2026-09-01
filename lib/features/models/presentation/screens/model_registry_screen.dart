import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/model_registry_entry.dart';
import '../providers/models_providers.dart';
import '../widgets/model_metric_chip.dart';

/// `GET /models/registry` — training metrics and the benchmark charts each
/// model produced. Charts deep-link into the existing chart viewer.
class ModelRegistryScreen extends ConsumerWidget {
  const ModelRegistryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(modelRegistryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Model registry')),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(modelRegistryProvider.future),
        child: async.when(
          loading: () => const ShimmerListSkeleton(count: 4, itemHeight: 210),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              ErrorView(
                error: error,
                onRetry: () => ref.invalidate(modelRegistryProvider),
              ),
            ],
          ),
          data: (registry) {
            if (registry.entries.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 80),
                  EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Registry is empty',
                    subtitle: 'The backend reported no registered models.',
                  ),
                ],
              );
            }
            final entries = [...registry.entries]
              ..sort((a, b) => b.overallScore.compareTo(a.overallScore));

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount:
                  entries.length + (registry.generatedAt != null ? 1 : 0),
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == entries.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Generated ${DateFormatter.relative(registry.generatedAt!)}',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return _RegistryCard(entry: entries[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class _RegistryCard extends StatelessWidget {
  const _RegistryCard({required this.entry});

  final ModelRegistryEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = AppColors.categoryColor(entry.category);

    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  entry.displayName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              StatusBadge(
                label: entry.loaded ? 'Loaded' : 'Not loaded',
                color: entry.loaded
                    ? AppColors.success
                    : AppColors.textSecondaryLight,
                dense: true,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              StatusBadge(
                label: entry.category,
                color: categoryColor,
                dense: true,
              ),
              Text(entry.featureType, style: theme.textTheme.bodySmall),
              if (entry.version != null)
                Text('v${entry.version}', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ModelMetricChip(label: 'Acc', value: entry.accuracy),
              ModelMetricChip(label: 'F1', value: entry.f1Score),
              ModelMetricChip(label: 'Prec', value: entry.precision),
              ModelMetricChip(label: 'Rec', value: entry.recall),
              ModelMetricChip(label: 'AUC', value: entry.auc),
            ],
          ),
          if (entry.knownCharts.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text('Charts', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final chart in entry.knownCharts)
                  ActionChip(
                    avatar: const Icon(Icons.bar_chart_rounded, size: 16),
                    label: Text(chart.title),
                    onPressed: () => context.push(
                      '/charts/${chart.apiName}',
                      extra: chart.title,
                    ),
                  ),
              ],
            ),
          ],
          if (entry.trainedAt != null) ...[
            const SizedBox(height: 10),
            Text(
              'Trained ${DateFormatter.relative(entry.trainedAt!)}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
