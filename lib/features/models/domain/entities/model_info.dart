import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_info.freezed.dart';

/// Domain representation of a single ML model exposed by the backend.
///
/// This is what the presentation layer works with — decoupled from the
/// wire format used by [ModelInfoDto].
@freezed
class ModelInfo with _$ModelInfo {
  const factory ModelInfo({
    required String name,
    required String displayName,
    required String category,
    required bool loaded,
    required double accuracy,
    required double f1Score,
    required double precision,
    required double recall,
    required double auc,
    required String featureType,
  }) = _ModelInfo;

  const ModelInfo._();

  /// Average of the five headline metrics, used as a simple sort key when a
  /// dedicated "overall score" isn't provided by the backend.
  double get overallScore => (accuracy + f1Score + precision + recall + auc) / 5;
}
