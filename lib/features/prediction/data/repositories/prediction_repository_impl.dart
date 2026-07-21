import '../../domain/entities/all_models_prediction.dart';
import '../../domain/entities/prediction_result.dart';
import '../../domain/repositories/prediction_repository.dart';
import '../datasources/prediction_remote_datasource.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  PredictionRepositoryImpl(this._remoteDataSource);

  final PredictionRemoteDataSource _remoteDataSource;

  @override
  Future<PredictionResult> predict({
    required String text,
    required String modelName,
  }) async {
    final dto = await _remoteDataSource.predict(text: text, modelName: modelName);
    return dto.toEntity();
  }

  @override
  Future<AllModelsPrediction> predictAll({required String text}) async {
    final dto = await _remoteDataSource.predictAll(text: text);
    return dto.toEntity();
  }

  @override
  Future<List<PredictionResult>> predictBatch({
    required List<String> texts,
    required String modelName,
  }) async {
    final dtos = await _remoteDataSource.predictBatch(texts: texts, modelName: modelName);
    return dtos.map((d) => d.toEntity()).toList();
  }
}
