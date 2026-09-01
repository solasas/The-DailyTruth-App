import '../../domain/entities/prediction_history_entry.dart';
import '../../domain/repositories/prediction_history_repository.dart';
import '../datasources/prediction_history_local_datasource.dart';

class PredictionHistoryRepositoryImpl implements PredictionHistoryRepository {
  PredictionHistoryRepositoryImpl(this._localDataSource);

  final PredictionHistoryLocalDataSource _localDataSource;

  @override
  Future<List<PredictionHistoryEntry>> getHistory() =>
      _localDataSource.getAll();

  @override
  Future<void> save(PredictionHistoryEntry entry) =>
      _localDataSource.add(entry);

  @override
  Future<void> delete(String id) => _localDataSource.delete(id);

  @override
  Future<void> clear() => _localDataSource.clear();
}
