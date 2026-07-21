import '../entities/prediction_history_entry.dart';

abstract class PredictionHistoryRepository {
  Future<List<PredictionHistoryEntry>> getHistory();
  Future<void> save(PredictionHistoryEntry entry);
  Future<void> delete(String id);
  Future<void> clear();
}
