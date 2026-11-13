import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/brand_app_bar.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/page_hero.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../charts/presentation/providers/charts_providers.dart';
import '../../domain/entities/model_info.dart';
import '../providers/models_providers.dart';

/// Browse the model catalog: the "Model Leaderboard" hero, a best-performer
/// card, the ranked list, and the benchmark chart gallery.
class ModelsScreen extends ConsumerWidget {
  const ModelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAsync = ref.watch(modelsListProvider);

    const hero = Padding(
      padding: EdgeInsets.only(top: 12, bottom: 28),
      child: PageHero(
        badgeIcon: Icons.bar_chart_rounded,
        badgeLabel: 'Benchmark rankings',
        title: 'Model leaderboard',
        subtitle: 'Performance rankings and metrics.',
      ),
    );

    return Scaffold(
      appBar: BrandAppBar(
        actions: [
          CircleIconButton(
            tooltip: 'Model registry',
            icon: Icons.inventory_2_outlined,
            onPressed: () => context.push('/models/registry'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(modelsListProvider.future),
        child: modelsAsync.when(
          loading: () => ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: const [
              hero,
              ShimmerListSkeleton(count: 5, itemHeight: 64),
            ],
          ),
          error: (error, _) => ListView(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: hero,
              ),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                hero,
                if (best != null) _LeaderboardCard(best: best),
                const SizedBox(height: 28),
                SectionHeader(
                  title: 'All models',
                  action: TextButton(
                    onPressed: () => context.push('/leaderboard'),
                    child: const Text('Full table'),
                  ),
                ),
                const SizedBox(height: 8),
                SoftCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < ranked.length; i++) ...[
                        if (i > 0) const Divider(height: 1),
                        _ModelRow(rank: i + 1, model: ranked[i]),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const SectionHeader(title: 'Benchmark charts'),
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
    return AccentCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PillBadge(
            icon: Icons.emoji_events_outlined,
            label: 'Best performing model',
          ),
          const SizedBox(height: 12),
          Text(
            best.displayName.toUpperCase(),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
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
            label.toUpperCase(),
            style: AppTypography.eyebrow(
              theme.extension<AppSemanticColors>()?.textSecondary ??
                  theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(value * 100).toStringAsFixed(1)}%',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  const _ModelRow({required this.rank, required this.model});

  final int rank;
  final ModelInfo model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = AppColors.categoryColor(model.category);

    return Opacity(
      opacity: model.loaded ? 1 : 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 26,
              child: Text(
                rank.toString().padLeft(2, '0'),
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: rank == 1 ? AppColors.primary : theme.hintColor,
                ),
              ),
            ),
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
                borderRadius: BorderRadius.circular(12),
                onTap: () =>
                    context.push('/charts/${chart.name}', extra: chart.title),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(12),
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
