// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/prediction_result.dart';

part 'prediction_result_dto.freezed.dart';
part 'prediction_result_dto.g.dart';

/// Wire format shared by `POST /predict` (single object) and each item
/// inside `POST /predict/all` / `POST /predict/batch` result arrays.
@freezed
class PredictionResultDto with _$PredictionResultDto {
  const factory PredictionResultDto({
    required String prediction,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double confidence,
    @JsonKey(name: 'fake_probability', fromJson: _toDouble)
    @Default(0.0)
    double fakeProbability,
    @JsonKey(name: 'real_probability', fromJson: _toDouble)
    @Default(0.0)
    double realProbability,
    @JsonKey(name: 'model_name') @Default('') String modelName,
    @Default('') String category,
  }) = _PredictionResultDto;

  const PredictionResultDto._();

  factory PredictionResultDto.fromJson(Map<String, dynamic> json) =>
      _$PredictionResultDtoFromJson(json);

  PredictionResult toEntity() {
    return PredictionResult(
      label: prediction.toUpperCase() == 'FAKE'
          ? PredictionLabel.fake
          : PredictionLabel.real,
      confidence: confidence,
      fakeProbability: fakeProbability,
      realProbability: realProbability,
      modelName: modelName,
      category: category,
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
