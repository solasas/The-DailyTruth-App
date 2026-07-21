import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/prediction_result.dart';

part 'prediction_result_dto.freezed.dart';

/// Wire format shared by the `result` object of `POST /predict` and each
/// item inside `POST /predict/all` / `POST /predict/batch` result arrays.
///
/// The backend returns the verdict as a lowercase `label` string
/// ("real"/"fake") alongside a redundant numeric `prediction` (1/0), and
/// probabilities as `prob_fake`/`prob_real` — parsed by hand since the
/// shape doesn't map 1:1 onto idiomatic Dart field names.
@freezed
class PredictionResultDto with _$PredictionResultDto {
  const factory PredictionResultDto({
    required String label,
    @Default(0.0) double confidence,
    @Default(0.0) double probFake,
    @Default(0.0) double probReal,
    @Default('') String modelName,
    @Default('') String displayName,
    @Default('') String category,
  }) = _PredictionResultDto;

  const PredictionResultDto._();

  factory PredictionResultDto.fromJson(Map<String, dynamic> json) {
    final modelName = json['model_name'] as String? ?? '';
    return PredictionResultDto(
      label: (json['label'] as String?)?.toLowerCase() ?? _labelFromPrediction(json['prediction']),
      confidence: _toDouble(json['confidence']),
      probFake: _toDouble(json['prob_fake'] ?? json['fake_probability']),
      probReal: _toDouble(json['prob_real'] ?? json['real_probability']),
      modelName: modelName,
      displayName: json['display_name'] as String? ?? modelName,
      category: json['category'] as String? ?? '',
    );
  }

  PredictionResult toEntity() {
    return PredictionResult(
      label: label == 'fake' ? PredictionLabel.fake : PredictionLabel.real,
      confidence: confidence,
      fakeProbability: probFake,
      realProbability: probReal,
      modelName: modelName,
      displayName: displayName,
      category: category,
    );
  }
}

/// Fallback when a `label` string isn't present: the backend also sends a
/// redundant `prediction` of `1` (real) / `0` (fake).
String _labelFromPrediction(dynamic prediction) {
  if (prediction is num && prediction == 0) return 'fake';
  return 'real';
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
