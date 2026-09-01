import 'package:freezed_annotation/freezed_annotation.dart';

part 'benchmark_result.freezed.dart';

/// A single row of the leaderboard — one model's benchmark metrics plus how
/// long it took to train.
@freezed
class BenchmarkResult with _$BenchmarkResult {
  const factory BenchmarkResult({
    required String modelName,
    required String displayName,
    required String category,
    required double accuracy,
    required double f1Score,
    required double precision,
    required double recall,
    required double auc,

    /// Null when unavailable (e.g. derived from the [isFallback] path,
    /// which has no training-time data).
    double? trainingTimeSeconds,

    /// 1-based rank, assigned client-side after sorting by accuracy.
    @Default(0) int rank,

    /// True when this row was derived client-side from `GET /models`
    /// because `GET /results` was unavailable — see
    /// `benchmarkOrFallbackProvider`.
    @Default(false) bool isFallback,
  }) = _BenchmarkResult;
}
