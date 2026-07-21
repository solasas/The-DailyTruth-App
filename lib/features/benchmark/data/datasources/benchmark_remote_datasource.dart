import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/benchmark_result_dto.dart';

abstract class BenchmarkRemoteDataSource {
  Future<List<BenchmarkResultDto>> getResults();
}

class BenchmarkRemoteDataSourceImpl implements BenchmarkRemoteDataSource {
  BenchmarkRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<List<BenchmarkResultDto>> getResults() {
    return _client.guard(() async {
      final response = await _client.dio.get(ApiEndpoints.results);
      final data = response.data;

      final List<dynamic> rawList;
      if (data is List) {
        rawList = data;
      } else if (data is Map && data['results'] is List) {
        rawList = data['results'] as List;
      } else if (data is Map && data['models'] is List) {
        rawList = data['models'] as List;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.results),
          error: 'Unexpected /results response shape',
        );
      }

      return rawList
          .map((e) => BenchmarkResultDto.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
