import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/benchmark_result.dart';

part 'benchmark_result_dto.freezed.dart';

/// Wire format for a single leaderboard row from `GET /results`.
///
/// Mirrors `GET /models`' shape (nested `metrics`, `name`/`display_name`)
/// plus a training-time field, parsed leniently since the exact key for the
/// latter isn't confirmed against a live response.
@freezed
class BenchmarkResultDto with _$BenchmarkResultDto {
  const factory BenchmarkResultDto({
    required String modelName,
    required String displayName,
    required String category,
    @Default(0.0) double accuracy,
    @Default(0.0) double f1Score,
    @Default(0.0) double precision,
    @Default(0.0) double recall,
    @Default(0.0) double auc,
    @Default(0.0) double trainingTime,
  }) = _BenchmarkResultDto;

  const BenchmarkResultDto._();

  factory BenchmarkResultDto.fromJson(Map<String, dynamic> json) {
    final metrics = json['metrics'] as Map<String, dynamic>? ?? const {};
    final modelName =
        json['name'] as String? ?? json['model_name'] as String? ?? '';

    return BenchmarkResultDto(
      modelName: modelName,
      displayName: json['display_name'] as String? ?? modelName,
      category: json['category'] as String? ?? 'unknown',
      accuracy: _toDouble(metrics['accuracy'] ?? json['accuracy']),
      f1Score: _toDouble(
        metrics['f1'] ?? metrics['f1_score'] ?? json['f1_score'],
      ),
      precision: _toDouble(metrics['precision'] ?? json['precision']),
      recall: _toDouble(metrics['recall'] ?? json['recall']),
      auc: _toDouble(metrics['auc'] ?? json['auc']),
      trainingTime: _toDouble(
        json['training_time'] ??
            json['training_time_seconds'] ??
            json['train_time'],
      ),
    );
  }

  BenchmarkResult toEntity({int rank = 0}) {
    return BenchmarkResult(
      modelName: modelName,
      displayName: displayName,
      category: category,
      accuracy: accuracy,
      f1Score: f1Score,
      precision: precision,
      recall: recall,
      auc: auc,
      trainingTimeSeconds: trainingTime,
      rank: rank,
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
