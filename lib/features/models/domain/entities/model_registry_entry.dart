import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_registry_entry.freezed.dart';

/// The four benchmark charts the backend renders per model
/// (`GET /results/charts/{name}`).
enum BenchmarkChart {
  confusionMatrix,
  rocCurve,
  metricsComparison,
  classDistribution,
}

extension BenchmarkChartX on BenchmarkChart {
  /// Filename stem used by `GET /results/charts/{name}`.
  String get apiName => switch (this) {
    BenchmarkChart.confusionMatrix => 'confusion_matrix',
    BenchmarkChart.rocCurve => 'roc_curve',
    BenchmarkChart.metricsComparison => 'metrics_comparison',
    BenchmarkChart.classDistribution => 'class_distribution',
  };

  String get title => switch (this) {
    BenchmarkChart.confusionMatrix => 'Confusion matrix',
    BenchmarkChart.rocCurve => 'ROC curve',
    BenchmarkChart.metricsComparison => 'Metrics comparison',
    BenchmarkChart.classDistribution => 'Class distribution',
  };

  static BenchmarkChart? tryParse(String raw) {
    final v = raw
        .toLowerCase()
        .replaceAll(RegExp(r'\.(png|jpg|jpeg|svg)$'), '')
        .trim();
    for (final c in BenchmarkChart.values) {
      if (v == c.apiName || v.contains(c.apiName)) return c;
    }
    return null;
  }
}

/// One entry from `GET /models/registry` — richer than `GET /models`: it
/// carries the training metrics and the chart artefacts the model produced.
@freezed
class ModelRegistryEntry with _$ModelRegistryEntry {
  const factory ModelRegistryEntry({
    required String name,
    required String displayName,
    required String category,
    required String featureType,
    required bool loaded,
    String? version,
    @Default(0.0) double accuracy,
    @Default(0.0) double f1Score,
    @Default(0.0) double precision,
    @Default(0.0) double recall,
    @Default(0.0) double auc,
    @Default(<String>[]) List<String> charts,
    DateTime? trainedAt,
  }) = _ModelRegistryEntry;

  const ModelRegistryEntry._();

  double get overallScore =>
      (accuracy + f1Score + precision + recall + auc) / 5;

  /// Charts recognised as one of the known [BenchmarkChart] kinds.
  List<BenchmarkChart> get knownCharts => charts
      .map(BenchmarkChartX.tryParse)
      .whereType<BenchmarkChart>()
      .toSet()
      .toList();
}

/// Full `GET /models/registry` payload.
@freezed
class ModelRegistry with _$ModelRegistry {
  const factory ModelRegistry({
    required List<ModelRegistryEntry> entries,
    DateTime? generatedAt,
  }) = _ModelRegistry;
}
