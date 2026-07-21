import 'package:freezed_annotation/freezed_annotation.dart';

part 'prediction_result.freezed.dart';

enum PredictionLabel { fake, real }

/// The outcome of running one model against one piece of text — the core
/// unit reused by the single-prediction screen, the all-models screen (one
/// per model) and prediction history.
@freezed
class PredictionResult with _$PredictionResult {
  const factory PredictionResult({
    required PredictionLabel label,
    required double confidence,
    required double fakeProbability,
    required double realProbability,
    required String modelName,
    required String category,
  }) = _PredictionResult;
}
