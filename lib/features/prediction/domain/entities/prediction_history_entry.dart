import 'package:freezed_annotation/freezed_annotation.dart';

import 'prediction_result.dart';

part 'prediction_history_entry.freezed.dart';

/// A single locally-persisted history record, created after every successful
/// analyze call (single-model or all-models).
@freezed
class PredictionHistoryEntry with _$PredictionHistoryEntry {
  const factory PredictionHistoryEntry({
    required String id,
    required String text,
    required DateTime timestamp,
    required bool isAllModels,
    /// For single-model runs this has exactly one entry; for all-models runs
    /// it holds every per-model result plus the consensus is derivable from
    /// [consensusLabel]/[consensusConfidence].
    required List<PredictionResult> results,
    PredictionLabel? consensusLabel,
    double? consensusConfidence,
  }) = _PredictionHistoryEntry;

  const PredictionHistoryEntry._();

  PredictionResult get primaryResult => results.first;
}
