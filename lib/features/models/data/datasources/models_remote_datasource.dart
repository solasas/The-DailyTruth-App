import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/model_info_dto.dart';

abstract class ModelsRemoteDataSource {
  Future<List<ModelInfoDto>> getModels();
}

class ModelsRemoteDataSourceImpl implements ModelsRemoteDataSource {
  ModelsRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<List<ModelInfoDto>> getModels() {
    return _client.guard(() async {
      final response = await _client.dio.get(ApiEndpoints.models);
      return _parseModelList(response.data);
    });
  }

  /// Backend may respond with a bare list or an envelope like
  /// `{"models": [...], "count": n}` — support both shapes.
  List<ModelInfoDto> _parseModelList(dynamic data) {
    final List<dynamic> rawList;
    if (data is List) {
      rawList = data;
    } else if (data is Map && data['models'] is List) {
      rawList = data['models'] as List;
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.models),
        error: 'Unexpected /models response shape',
      );
    }
    return rawList
        .map((e) => ModelInfoDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
