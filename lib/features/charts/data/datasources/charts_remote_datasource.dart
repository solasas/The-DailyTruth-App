import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/chart_info_dto.dart';

abstract class ChartsRemoteDataSource {
  Future<List<ChartInfoDto>> getCharts();
  Future<Uint8List> getChartImage(String name);
}

class ChartsRemoteDataSourceImpl implements ChartsRemoteDataSource {
  ChartsRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<List<ChartInfoDto>> getCharts() {
    return _client.guard(() async {
      final response = await _client.dio.get(ApiEndpoints.resultsCharts);
      final data = response.data;

      final List<dynamic> rawList;
      if (data is List) {
        rawList = data;
      } else if (data is Map && data['charts'] is List) {
        rawList = data['charts'] as List;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: ApiEndpoints.resultsCharts),
          error: 'Unexpected /results/charts response shape',
        );
      }
      return rawList.map(ChartInfoDto.fromDynamic).toList();
    });
  }

  @override
  Future<Uint8List> getChartImage(String name) {
    return _client.guard(() async {
      final response = await _client.dio.get<List<int>>(
        ApiEndpoints.resultsChartByName(name),
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data ?? const []);
    });
  }
}
