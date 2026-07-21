import '../entities/benchmark_result.dart';

abstract class BenchmarkRepository {
  /// Returns leaderboard rows sorted by accuracy (descending), with [rank]
  /// already assigned.
  Future<List<BenchmarkResult>> getResults();
}
