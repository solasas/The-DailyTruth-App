import 'package:freezed_annotation/freezed_annotation.dart';

part 'benchmark_result.freezed.dart';

/// A single row of the leaderboard — one model's benchmark metrics plus how
/// long it took to train.
@freezed
class BenchmarkResult with _$BenchmarkResult {
  const factory BenchmarkResult({
    required String modelName,
    required String category,
    required double accuracy,
    required double f1Score,
    required double precision,
    required double recall,
    required double auc,
    required double trainingTimeSeconds,
    /// 1-based rank, assigned client-side after sorting by accuracy.
    @Default(0) int rank,
  }) = _BenchmarkResult;
}
