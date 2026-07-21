import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/model_info.dart';

part 'model_info_dto.freezed.dart';

/// Wire format for a model entry returned by `GET /models`.
///
/// The backend nests headline metrics under a `metrics` object and uses
/// `name`/`display_name` for the machine id vs. the human-friendly label, so
/// this DTO parses itself by hand rather than via json_serializable.
@freezed
class ModelInfoDto with _$ModelInfoDto {
  const factory ModelInfoDto({
    required String name,
    required String displayName,
    required String category,
    @Default(false) bool loaded,
    @Default(0.0) double accuracy,
    @Default(0.0) double f1Score,
    @Default(0.0) double precision,
    @Default(0.0) double recall,
    @Default(0.0) double auc,
    @Default('unknown') String featureType,
  }) = _ModelInfoDto;

  const ModelInfoDto._();

  factory ModelInfoDto.fromJson(Map<String, dynamic> json) {
    final metrics = json['metrics'] as Map<String, dynamic>? ?? const {};
    final name = json['name'] as String? ?? json['model_name'] as String? ?? '';

    return ModelInfoDto(
      name: name,
      displayName: json['display_name'] as String? ?? name,
      category: json['category'] as String? ?? 'unknown',
      loaded: json['loaded'] as bool? ?? false,
      accuracy: _toDouble(metrics['accuracy'] ?? json['accuracy']),
      f1Score: _toDouble(metrics['f1'] ?? metrics['f1_score'] ?? json['f1_score']),
      precision: _toDouble(metrics['precision'] ?? json['precision']),
      recall: _toDouble(metrics['recall'] ?? json['recall']),
      auc: _toDouble(metrics['auc'] ?? json['auc']),
      featureType: json['feature_type'] as String? ?? 'unknown',
    );
  }

  ModelInfo toEntity() {
    return ModelInfo(
      name: name,
      displayName: displayName,
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
