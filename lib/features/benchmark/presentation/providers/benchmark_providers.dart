import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../models/domain/entities/model_info.dart';
import '../../../models/presentation/providers/models_providers.dart';
import '../../data/datasources/benchmark_remote_datasource.dart';
import '../../data/repositories/benchmark_repository_impl.dart';
import '../../domain/entities/benchmark_result.dart';
import '../../domain/repositories/benchmark_repository.dart';

final benchmarkRemoteDataSourceProvider = Provider<BenchmarkRemoteDataSource>((
  ref,
) {
  return BenchmarkRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final benchmarkRepositoryProvider = Provider<BenchmarkRepository>((ref) {
  return BenchmarkRepositoryImpl(ref.watch(benchmarkRemoteDataSourceProvider));
});

final benchmarkResultsProvider = FutureProvider.autoDispose<List<BenchmarkResult>>((
  ref,
) async {
  final repository = ref.watch(benchmarkRepositoryProvider);
  return repository.getResults();
});

/// Prefers real leaderboard data from `GET /results`, but falls back to a
/// client-side ranking derived from `GET /models` (sorted by accuracy; no
/// training-time data, since `/models` doesn't report it) whenever
/// `/results` errors — so a broken or unavailable leaderboard endpoint
/// doesn't leave Leaderboard/Home with nothing to show. Every row in a
/// fallback result carries `isFallback: true` so the UI can be transparent
/// about it instead of silently presenting derived data as authoritative.
final benchmarkOrFallbackProvider = Provider.autoDispose<AsyncValue<List<BenchmarkResult>>>((
  ref,
) {
  final resultsAsync = ref.watch(benchmarkResultsProvider);

  return resultsAsync.when(
    data: (results) => AsyncData(results),
    loading: () => const AsyncLoading(),
    error: (error, stackTrace) {
      final modelsAsync = ref.watch(modelsListProvider);
      return modelsAsync.whenData((models) {
        final loaded = models.where((m) => m.loaded).toList()
          ..sort((a, b) => b.accuracy.compareTo(a.accuracy));
        return [
          for (var i = 0; i < loaded.length; i++) _fromModelInfo(loaded[i], rank: i + 1),
        ];
      });
    },
  );
});

BenchmarkResult _fromModelInfo(ModelInfo model, {required int rank}) {
  return BenchmarkResult(
    modelName: model.name,
    displayName: model.displayName,
    category: model.category,
    accuracy: model.accuracy,
    f1Score: model.f1Score,
    precision: model.precision,
    recall: model.recall,
    auc: model.auc,
    trainingTimeSeconds: null,
    rank: rank,
    isFallback: true,
  );
}

/// Convenience provider for the Home dashboard's "Best Model" stat — the
/// rank-1 leaderboard row, if any.
final bestModelProvider = Provider.autoDispose<AsyncValue<BenchmarkResult?>>((
  ref,
) {
  return ref.watch(benchmarkOrFallbackProvider).whenData(
    (results) => results.isEmpty ? null : results.first,
  );
});

enum LeaderboardColumn { rank, accuracy, f1, precision, recall, auc, trainingTime }

class LeaderboardSortState {
  const LeaderboardSortState({
    this.column = LeaderboardColumn.rank,
    this.ascending = true,
  });

  final LeaderboardColumn column;
  final bool ascending;

  LeaderboardSortState toggled(LeaderboardColumn column) {
    if (column == this.column) {
      return LeaderboardSortState(column: column, ascending: !ascending);
    }
    return LeaderboardSortState(column: column, ascending: true);
  }
}

class LeaderboardSortNotifier extends Notifier<LeaderboardSortState> {
  @override
  LeaderboardSortState build() => const LeaderboardSortState();

  void sortBy(LeaderboardColumn column) => state = state.toggled(column);
}

final leaderboardSortProvider =
    NotifierProvider<LeaderboardSortNotifier, LeaderboardSortState>(
      LeaderboardSortNotifier.new,
    );

final sortedLeaderboardProvider = Provider.autoDispose<AsyncValue<List<BenchmarkResult>>>((
  ref,
) {
  final resultsAsync = ref.watch(benchmarkOrFallbackProvider);
  final sort = ref.watch(leaderboardSortProvider);

  return resultsAsync.whenData((results) {
    final sorted = [...results];
    int compare(BenchmarkResult a, BenchmarkResult b) {
      return switch (sort.column) {
        LeaderboardColumn.rank => a.rank.compareTo(b.rank),
        LeaderboardColumn.accuracy => a.accuracy.compareTo(b.accuracy),
        LeaderboardColumn.f1 => a.f1Score.compareTo(b.f1Score),
        LeaderboardColumn.precision => a.precision.compareTo(b.precision),
        LeaderboardColumn.recall => a.recall.compareTo(b.recall),
        LeaderboardColumn.auc => a.auc.compareTo(b.auc),
        LeaderboardColumn.trainingTime =>
          (a.trainingTimeSeconds ?? -1).compareTo(b.trainingTimeSeconds ?? -1),
      };
    }

    sorted.sort(sort.ascending ? compare : (a, b) => compare(b, a));
    return sorted;
  });
});
