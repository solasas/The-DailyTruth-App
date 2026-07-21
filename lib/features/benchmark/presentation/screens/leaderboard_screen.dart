import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/benchmark_providers.dart';
import '../widgets/best_model_card.dart';
import '../widgets/leaderboard_table.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedAsync = ref.watch(sortedLeaderboardProvider);
    final sortState = ref.watch(leaderboardSortProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: 'View Charts',
            onPressed: () => context.push('/charts'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(benchmarkResultsProvider.future),
        child: sortedAsync.when(
          loading: () => const ShimmerListSkeleton(count: 4, itemHeight: 160),
          error: (error, _) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(benchmarkResultsProvider),
          ),
          data: (results) {
            if (results.isEmpty) {
              return const EmptyState(
                icon: Icons.leaderboard_outlined,
                title: 'No benchmark results yet',
              );
            }
            final best = results.firstWhere((r) => r.rank == 1);

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                FadeSlideIn(child: BestModelCard(result: best)),
                const SizedBox(height: 24),
                Text('Full Leaderboard', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 100),
                  child: LeaderboardTable(
                    results: results,
                    sortState: sortState,
                    onSort: ref.read(leaderboardSortProvider.notifier).sortBy,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
