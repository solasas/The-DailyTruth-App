import '../entities/all_models_prediction.dart';
import '../entities/prediction_result.dart';

/// Contract for running predictions against the backend.
abstract class PredictionRepository {
  Future<PredictionResult> predict({required String text, required String modelName});

  Future<AllModelsPrediction> predictAll({required String text});

  Future<List<PredictionResult>> predictBatch({
    required List<String> texts,
    required String modelName,
  });
}
