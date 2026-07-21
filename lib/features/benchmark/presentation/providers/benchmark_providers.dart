import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
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

/// Convenience provider for the Home dashboard's "Best Model" stat — the
/// rank-1 leaderboard row, if any.
final bestModelProvider = Provider.autoDispose<AsyncValue<BenchmarkResult?>>((
  ref,
) {
  return ref.watch(benchmarkResultsProvider).whenData(
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
  final resultsAsync = ref.watch(benchmarkResultsProvider);
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
          a.trainingTimeSeconds.compareTo(b.trainingTimeSeconds),
      };
    }

    sorted.sort(sort.ascending ? compare : (a, b) => compare(b, a));
    return sorted;
  });
});
