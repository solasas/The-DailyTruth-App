// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_health_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServerHealthDtoImpl _$$ServerHealthDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ServerHealthDtoImpl(
  status: json['status'] as String? ?? 'unknown',
  modelsLoaded: (json['models_loaded'] as num?)?.toInt() ?? 0,
  totalModels: (json['total_models'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ServerHealthDtoImplToJson(
  _$ServerHealthDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'models_loaded': instance.modelsLoaded,
  'total_models': instance.totalModels,
};
