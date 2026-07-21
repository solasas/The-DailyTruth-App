import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/all_models_prediction_dto.dart';
import '../models/prediction_result_dto.dart';

abstract class PredictionRemoteDataSource {
  Future<PredictionResultDto> predict({required String text, required String modelName});

  Future<AllModelsPredictionDto> predictAll({required String text});

  Future<List<PredictionResultDto>> predictBatch({
    required List<String> texts,
    required String modelName,
  });
}

class PredictionRemoteDataSourceImpl implements PredictionRemoteDataSource {
  PredictionRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<PredictionResultDto> predict({
    required String text,
    required String modelName,
  }) {
    return _client.guard(() async {
      final response = await _client.dio.post(
        ApiEndpoints.predict,
        data: {'text': text, 'model_name': modelName},
      );
      // The backend wraps the verdict in an envelope: {"text_preview": ..., "result": {...}}.
      final data = response.data as Map<String, dynamic>;
      final result = data['result'] as Map<String, dynamic>? ?? data;
      return PredictionResultDto.fromJson(result);
    });
  }

  @override
  Future<AllModelsPredictionDto> predictAll({required String text}) {
    return _client.guard(() async {
      final response = await _client.dio.post(
        ApiEndpoints.predictAll,
        data: {'text': text},
      );
      return AllModelsPredictionDto.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<List<PredictionResultDto>> predictBatch({
    required List<String> texts,
    required String modelName,
  }) {
    return _client.guard(() async {
      final response = await _client.dio.post(
        ApiEndpoints.predictBatch,
        data: {'texts': texts, 'model_name': modelName},
      );
      final data = response.data;
      final List<dynamic> rawList = data is List
          ? data
          : (data is Map && data['results'] is List ? data['results'] as List : const []);
      return rawList
          .map((e) => PredictionResultDto.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
