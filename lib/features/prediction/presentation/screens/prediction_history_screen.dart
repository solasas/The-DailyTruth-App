import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/prediction_providers.dart';
import '../widgets/recent_prediction_tile.dart';

/// Full, searchable history of every prediction run on this device, backed
/// by Hive via [predictionHistoryProvider].
class PredictionHistoryScreen extends ConsumerWidget {
  const PredictionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(filteredPredictionHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Prediction History')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) =>
                  ref.read(historySearchQueryProvider.notifier).state = value,
              decoration: const InputDecoration(
                hintText: 'Search history…',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          Expanded(
            child: historyAsync.when(
              loading: () =>
                  const ShimmerListSkeleton(count: 6, itemHeight: 78),
              error: (error, _) => ErrorView(
                error: error,
                onRetry: () => ref.invalidate(predictionHistoryProvider),
              ),
              data: (entries) {
                if (entries.isEmpty) {
                  return const EmptyState(
                    icon: Icons.history_rounded,
                    title: 'No predictions yet',
                    subtitle: 'Analyzed articles will show up here.',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return RecentPredictionTile(
                      entry: entry,
                      onDelete: () async {
                        await ref
                            .read(predictionHistoryRepositoryProvider)
                            .delete(entry.id);
                        ref.invalidate(predictionHistoryProvider);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
