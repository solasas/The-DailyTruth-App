import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_health.freezed.dart';

enum ServerHealthStatus { healthy, degraded, unavailable, unknown }

@freezed
class ServerHealth with _$ServerHealth {
  const factory ServerHealth({
    required ServerHealthStatus status,
    required int modelsLoaded,
    int? totalModels,
  }) = _ServerHealth;
}
