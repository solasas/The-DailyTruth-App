import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/charts_providers.dart';
import '../widgets/chart_thumbnail.dart';

/// Grid gallery of every chart the backend generated for the benchmark run.
class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartsAsync = ref.watch(chartsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Charts')),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(chartsListProvider.future),
        child: chartsAsync.when(
          loading: () => GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: 6,
            itemBuilder: (_, _) => const ShimmerCardSkeleton(height: 180),
          ),
          error: (error, _) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(chartsListProvider),
          ),
          data: (charts) {
            if (charts.isEmpty) {
              return const EmptyState(
                icon: Icons.bar_chart_rounded,
                title: 'No charts available yet',
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: charts.length,
              itemBuilder: (context, index) {
                final chart = charts[index];
                return ChartThumbnail(
                  chart: chart,
                  onTap: () => context.push('/charts/${chart.name}', extra: chart.title),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
