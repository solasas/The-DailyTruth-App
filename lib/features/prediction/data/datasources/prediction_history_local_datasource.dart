import 'package:hive/hive.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/prediction_history_entry.dart';
import '../../domain/entities/prediction_result.dart';

/// Persists prediction history locally via Hive.
///
/// Entries are stored as plain JSON-compatible maps (rather than a
/// hive-generated TypeAdapter) so the domain [PredictionHistoryEntry]
/// stays free of any storage-specific annotations.
abstract class PredictionHistoryLocalDataSource {
  Future<List<PredictionHistoryEntry>> getAll();
  Future<void> add(PredictionHistoryEntry entry);
  Future<void> delete(String id);
  Future<void> clear();
}

class PredictionHistoryLocalDataSourceImpl implements PredictionHistoryLocalDataSource {
  PredictionHistoryLocalDataSourceImpl(this._box);

  final Box _box;

  @override
  Future<List<PredictionHistoryEntry>> getAll() async {
    final entries = _box.values
        .map((raw) => _fromMap(Map<String, dynamic>.from(raw as Map)))
        .toList();
    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }

  @override
  Future<void> add(PredictionHistoryEntry entry) async {
    await _box.put(entry.id, _toMap(entry));

    if (_box.length > AppConstants.maxRecentPredictions) {
      final all = await getAll();
      final overflow = all.skip(AppConstants.maxRecentPredictions);
      for (final entry in overflow) {
        await _box.delete(entry.id);
      }
    }
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  Map<String, dynamic> _toMap(PredictionHistoryEntry entry) {
    return {
      'id': entry.id,
      'text': entry.text,
      'timestamp': entry.timestamp.toIso8601String(),
      'isAllModels': entry.isAllModels,
      'consensusLabel': entry.consensusLabel?.name,
      'consensusConfidence': entry.consensusConfidence,
      'results': entry.results
          .map(
            (r) => {
              'label': r.label.name,
              'confidence': r.confidence,
              'fakeProbability': r.fakeProbability,
              'realProbability': r.realProbability,
              'modelName': r.modelName,
              'category': r.category,
            },
          )
          .toList(),
    };
  }

  PredictionHistoryEntry _fromMap(Map<String, dynamic> map) {
    final rawResults = (map['results'] as List).cast<Object?>();
    return PredictionHistoryEntry(
      id: map['id'] as String,
      text: map['text'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      isAllModels: map['isAllModels'] as bool? ?? false,
      consensusLabel: (map['consensusLabel'] as String?) != null
          ? PredictionLabel.values.byName(map['consensusLabel'] as String)
          : null,
      consensusConfidence: (map['consensusConfidence'] as num?)?.toDouble(),
      results: rawResults.map((raw) {
        final r = Map<String, dynamic>.from(raw as Map);
        return PredictionResult(
          label: PredictionLabel.values.byName(r['label'] as String),
          confidence: (r['confidence'] as num).toDouble(),
          fakeProbability: (r['fakeProbability'] as num).toDouble(),
          realProbability: (r['realProbability'] as num).toDouble(),
          modelName: r['modelName'] as String,
          category: r['category'] as String,
        );
      }).toList(),
    );
  }
}
