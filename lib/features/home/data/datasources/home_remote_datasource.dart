import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/server_health_dto.dart';

abstract class HomeRemoteDataSource {
  Future<ServerHealthDto> getServerHealth();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<ServerHealthDto> getServerHealth() {
    return _client.guard(() async {
      final response = await _client.dio.get(ApiEndpoints.health);
      return ServerHealthDto.fromJson(response.data as Map<String, dynamic>);
    });
  }
}
