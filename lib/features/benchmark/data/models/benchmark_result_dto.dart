// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/benchmark_result.dart';

part 'benchmark_result_dto.freezed.dart';
part 'benchmark_result_dto.g.dart';

/// Wire format for a single leaderboard row from `GET /results`.
@freezed
class BenchmarkResultDto with _$BenchmarkResultDto {
  const factory BenchmarkResultDto({
    @JsonKey(name: 'model_name') required String modelName,
    required String category,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) @Default(0.0) double f1Score,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double precision,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double recall,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double auc,
    @JsonKey(name: 'training_time', fromJson: _toDouble)
    @Default(0.0)
    double trainingTime,
  }) = _BenchmarkResultDto;

  const BenchmarkResultDto._();

  factory BenchmarkResultDto.fromJson(Map<String, dynamic> json) =>
      _$BenchmarkResultDtoFromJson(json);

  BenchmarkResult toEntity({int rank = 0}) {
    return BenchmarkResult(
      modelName: modelName,
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
