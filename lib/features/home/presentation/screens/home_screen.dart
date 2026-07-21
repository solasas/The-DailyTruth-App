import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../benchmark/presentation/providers/benchmark_providers.dart';
import '../../../prediction/presentation/providers/prediction_providers.dart';
import '../../../prediction/presentation/widgets/recent_prediction_tile.dart';
import '../providers/home_providers.dart';
import '../widgets/quick_action_buttons.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/server_health_card.dart';

/// The app's dashboard: server health, quick stats, quick actions and a
/// preview of recent predictions.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _onRefresh(WidgetRef ref) async {
    ref.invalidate(serverHealthProvider);
    ref.invalidate(benchmarkResultsProvider);
    ref.invalidate(predictionHistoryProvider);
    await Future.wait([
      ref.read(serverHealthProvider.future),
      ref.read(benchmarkResultsProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthAsync = ref.watch(serverHealthProvider);
    final bestModelAsync = ref.watch(bestModelSummaryProvider);
    final historyAsync = ref.watch(predictionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: AppColors.primaryGradient),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.shield_moon_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppConstants.appName),
                Text(
                  AppConstants.appTagline,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(ref),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  FadeSlideIn(
                    child: healthAsync.when(
                      loading: () => const ShimmerCardSkeleton(height: 92),
                      error: (error, _) => ErrorView(
                        error: error,
                        compact: true,
                        onRetry: () => ref.invalidate(serverHealthProvider),
                      ),
                      data: (health) => ServerHealthCard(health: health),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 60),
                    child: bestModelAsync.when(
                      loading: () => const ShimmerCardSkeleton(height: 92),
                      error: (_, _) => const QuickStatsRow(),
                      data: (best) => QuickStatsRow(
                        bestModelName: best?.name,
                        bestModelAccuracy: best?.accuracy,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 120),
                    child: QuickActionButtons(
                      onAnalyze: () => context.go('/analyze'),
                      onCompareModels: () => context.go('/models'),
                      onBenchmark: () => context.go('/leaderboard'),
                    ),
                  ),
                  const SizedBox(height: 28),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 160),
                    child: SectionHeader(
                      title: 'Recent Predictions',
                      action: TextButton(
                        onPressed: () => context.push('/history'),
                        child: const Text('See all'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 200),
                    child: historyAsync.when(
                      loading: () => const ShimmerListSkeleton(count: 3, itemHeight: 78),
                      error: (error, _) => ErrorView(error: error, compact: true),
                      data: (entries) {
                        if (entries.isEmpty) {
                          return const EmptyState(
                            icon: Icons.history_rounded,
                            title: 'No predictions yet',
                            subtitle: 'Analyze an article to get started.',
                          );
                        }
                        final preview = entries.take(5).toList();
                        return Column(
                          children: preview
                              .map((entry) => RecentPredictionTile(entry: entry))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
