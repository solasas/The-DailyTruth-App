// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benchmark_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BenchmarkResultDtoImpl _$$BenchmarkResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BenchmarkResultDtoImpl(
  modelName: json['model_name'] as String,
  category: json['category'] as String,
  accuracy: json['accuracy'] == null ? 0.0 : _toDouble(json['accuracy']),
  f1Score: json['f1_score'] == null ? 0.0 : _toDouble(json['f1_score']),
  precision: json['precision'] == null ? 0.0 : _toDouble(json['precision']),
  recall: json['recall'] == null ? 0.0 : _toDouble(json['recall']),
  auc: json['auc'] == null ? 0.0 : _toDouble(json['auc']),
  trainingTime: json['training_time'] == null
      ? 0.0
      : _toDouble(json['training_time']),
);

Map<String, dynamic> _$$BenchmarkResultDtoImplToJson(
  _$BenchmarkResultDtoImpl instance,
) => <String, dynamic>{
  'model_name': instance.modelName,
  'category': instance.category,
  'accuracy': instance.accuracy,
  'f1_score': instance.f1Score,
  'precision': instance.precision,
  'recall': instance.recall,
  'auc': instance.auc,
  'training_time': instance.trainingTime,
};
