// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModelInfoDtoImpl _$$ModelInfoDtoImplFromJson(Map<String, dynamic> json) =>
    _$ModelInfoDtoImpl(
      modelName: json['model_name'] as String,
      category: json['category'] as String,
      loaded: json['loaded'] as bool? ?? false,
      accuracy: json['accuracy'] == null ? 0.0 : _toDouble(json['accuracy']),
      f1Score: json['f1_score'] == null ? 0.0 : _toDouble(json['f1_score']),
      precision: json['precision'] == null ? 0.0 : _toDouble(json['precision']),
      recall: json['recall'] == null ? 0.0 : _toDouble(json['recall']),
      auc: json['auc'] == null ? 0.0 : _toDouble(json['auc']),
      featureType: json['feature_type'] as String? ?? 'unknown',
    );

Map<String, dynamic> _$$ModelInfoDtoImplToJson(_$ModelInfoDtoImpl instance) =>
    <String, dynamic>{
      'model_name': instance.modelName,
      'category': instance.category,
      'loaded': instance.loaded,
      'accuracy': instance.accuracy,
      'f1_score': instance.f1Score,
      'precision': instance.precision,
      'recall': instance.recall,
      'auc': instance.auc,
      'feature_type': instance.featureType,
    };
