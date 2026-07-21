import 'package:freezed_annotation/freezed_annotation.dart';

import 'prediction_result.dart';

part 'all_models_prediction.freezed.dart';

/// Response of `POST /predict/all` — one consensus verdict plus the
/// individual per-model results it was derived from.
@freezed
class AllModelsPrediction with _$AllModelsPrediction {
  const factory AllModelsPrediction({
    required PredictionLabel consensusLabel,
    required double consensusConfidence,
    required List<PredictionResult> results,
  }) = _AllModelsPrediction;
}
