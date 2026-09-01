import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../charts/presentation/providers/charts_providers.dart';
import '../../domain/entities/model_info.dart';
import '../providers/models_providers.dart';

/// Browse the model catalog: a best-performer card, the full list, and the
/// benchmark chart gallery.
class ModelsScreen extends ConsumerWidget {
  const ModelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final modelsAsync = ref.watch(modelsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Models'),
        actions: [
          IconButton(
            tooltip: 'Model registry',
            icon: const Icon(Icons.inventory_2_outlined),
            onPressed: () => context.push('/models/registry'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(modelsListProvider.future),
        child: modelsAsync.when(
          loading: () => const ShimmerListSkeleton(count: 5, itemHeight: 64),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              ErrorView(
                error: error,
                onRetry: () => ref.invalidate(modelsListProvider),
              ),
            ],
          ),
          data: (models) {
            final ranked = [...models]
              ..sort((a, b) => b.accuracy.compareTo(a.accuracy));
            final best = ranked.isEmpty ? null : ranked.first;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                if (best != null) _LeaderboardCard(best: best),
                const SizedBox(height: 24),
                Text('All models', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                for (final m in ranked) _ModelRow(model: m),
                const SizedBox(height: 24),
                Text('Benchmark charts', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                const _ChartGallery(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  const _LeaderboardCard({required this.best});

  final ModelInfo best;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.sage100,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.sage300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BEST PERFORMING MODEL',
            style: AppTypography.eyebrow(AppColors.sage700),
          ),
          const SizedBox(height: 8),
          Text(
            best.displayName,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.sage800,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _Metric(label: 'Accuracy', value: best.accuracy),
              _Metric(label: 'F1', value: best.f1Score),
              _Metric(label: 'AUC', value: best.auc),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.sage700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${(value * 100).toStringAsFixed(1)}%',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.sage800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  const _ModelRow({required this.model});

  final ModelInfo model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = AppColors.categoryColor(model.category);

    return Opacity(
      opacity: model.loaded ? 1 : 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: model.loaded ? AppColors.success : theme.dividerColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                model.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: 8),
            StatusBadge(
              label: model.category,
              color: categoryColor,
              dense: true,
            ),
            const SizedBox(width: 12),
            Text(
              '${(model.accuracy * 100).toStringAsFixed(1)}%',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartGallery extends ConsumerWidget {
  const _ChartGallery();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final chartsAsync = ref.watch(chartsListProvider);

    return SizedBox(
      height: 130,
      child: chartsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            Text('Charts unavailable.', style: theme.textTheme.bodySmall),
        data: (charts) {
          if (charts.isEmpty) {
            return Text(
              'No charts published.',
              style: theme.textTheme.bodySmall,
            );
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: charts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final chart = charts[i];
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () =>
                    context.push('/charts/${chart.name}', extra: chart.title),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      Text(
                        chart.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
