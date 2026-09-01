import '../entities/all_models_prediction.dart';
import '../entities/prediction_result.dart';

/// Contract for running predictions against the backend. [threshold] is the
/// decision boundary (0.0–1.0, default 0.5) the backend applies when turning
/// a probability into a label.
abstract class PredictionRepository {
  Future<PredictionResult> predict({
    required String text,
    required String modelName,
    double threshold,
  });

  Future<AllModelsPrediction> predictAll({
    required String text,
    double threshold,
  });

  Future<List<PredictionResult>> predictBatch({
    required List<String> texts,
    required String modelName,
    double threshold,
  });
}
