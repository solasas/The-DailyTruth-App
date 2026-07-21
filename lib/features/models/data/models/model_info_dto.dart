// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/model_info.dart';

part 'model_info_dto.freezed.dart';
part 'model_info_dto.g.dart';

/// Wire format for a model entry returned by `GET /models` and `GET /results`.
///
/// Numeric metrics are parsed leniently (`num` -> `double`) since some
/// backends serialize metrics as integers (e.g. `1` instead of `1.0`).
@freezed
class ModelInfoDto with _$ModelInfoDto {
  const factory ModelInfoDto({
    @JsonKey(name: 'model_name') required String modelName,
    required String category,
    @Default(false) bool loaded,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) @Default(0.0) double f1Score,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double precision,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double recall,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double auc,
    @JsonKey(name: 'feature_type') @Default('unknown') String featureType,
  }) = _ModelInfoDto;

  const ModelInfoDto._();

  factory ModelInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoDtoFromJson(json);

  ModelInfo toEntity() {
    return ModelInfo(
      name: modelName,
      category: category,
      loaded: loaded,
      accuracy: accuracy,
      f1Score: f1Score,
      precision: precision,
      recall: recall,
      auc: auc,
      featureType: featureType,
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
