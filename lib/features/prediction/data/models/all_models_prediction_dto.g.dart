// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_models_prediction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllModelsPredictionDtoImpl _$$AllModelsPredictionDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AllModelsPredictionDtoImpl(
  consensus: ConsensusDto.fromJson(json['consensus'] as Map<String, dynamic>),
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => PredictionResultDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AllModelsPredictionDtoImplToJson(
  _$AllModelsPredictionDtoImpl instance,
) => <String, dynamic>{
  'consensus': instance.consensus,
  'results': instance.results,
};

_$ConsensusDtoImpl _$$ConsensusDtoImplFromJson(Map<String, dynamic> json) =>
    _$ConsensusDtoImpl(
      prediction: json['prediction'] as String,
      confidence: json['confidence'] == null
          ? 0.0
          : _toDouble(json['confidence']),
    );

Map<String, dynamic> _$$ConsensusDtoImplToJson(_$ConsensusDtoImpl instance) =>
    <String, dynamic>{
      'prediction': instance.prediction,
      'confidence': instance.confidence,
    };
