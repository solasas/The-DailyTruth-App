// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/server_health.dart';

part 'server_health_dto.freezed.dart';
part 'server_health_dto.g.dart';

/// Wire format for `GET /health`.
@freezed
class ServerHealthDto with _$ServerHealthDto {
  const factory ServerHealthDto({
    @Default('unknown') String status,
    @JsonKey(name: 'models_loaded') @Default(0) int modelsLoaded,
    @JsonKey(name: 'total_models') int? totalModels,
  }) = _ServerHealthDto;

  const ServerHealthDto._();

  factory ServerHealthDto.fromJson(Map<String, dynamic> json) =>
      _$ServerHealthDtoFromJson(json);

  ServerHealth toEntity() {
    return ServerHealth(
      status: switch (status.toLowerCase()) {
        'healthy' || 'ok' => ServerHealthStatus.healthy,
        'degraded' => ServerHealthStatus.degraded,
        'unavailable' || 'down' || 'error' => ServerHealthStatus.unavailable,
        _ => ServerHealthStatus.unknown,
      },
      modelsLoaded: modelsLoaded,
      totalModels: totalModels,
    );
  }
}
