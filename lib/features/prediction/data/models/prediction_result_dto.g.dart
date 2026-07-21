// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PredictionResultDtoImpl _$$PredictionResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PredictionResultDtoImpl(
  prediction: json['prediction'] as String,
  confidence: json['confidence'] == null ? 0.0 : _toDouble(json['confidence']),
  fakeProbability: json['fake_probability'] == null
      ? 0.0
      : _toDouble(json['fake_probability']),
  realProbability: json['real_probability'] == null
      ? 0.0
      : _toDouble(json['real_probability']),
  modelName: json['model_name'] as String? ?? '',
  category: json['category'] as String? ?? '',
);

Map<String, dynamic> _$$PredictionResultDtoImplToJson(
  _$PredictionResultDtoImpl instance,
) => <String, dynamic>{
  'prediction': instance.prediction,
  'confidence': instance.confidence,
  'fake_probability': instance.fakeProbability,
  'real_probability': instance.realProbability,
  'model_name': instance.modelName,
  'category': instance.category,
};
