import 'package:flutter_test/flutter_test.dart';
import 'package:the_daily_truth/features/models/data/models/model_registry_dto.dart';
import 'package:the_daily_truth/features/models/domain/entities/model_registry_entry.dart';

void main() {
  group('ModelRegistryDto.parse', () {
    test('reads an enveloped registry with nested metrics and chart names', () {
      final registry = ModelRegistryDto.parse({
        'generated_at': '2026-01-05T10:00:00Z',
        'models': [
          {
            'name': 'bert_base',
            'display_name': 'BERT Base',
            'category': 'Transformer',
            'feature_type': 'embeddings',
            'loaded': true,
            'version': '2',
            'metrics': {
              'accuracy': 0.97,
              'f1_score': 0.96,
              'precision': 0.95,
              'recall': 0.94,
              'roc_auc': 0.98,
            },
            'charts': [
              'confusion_matrix.png',
              'roc_curve.png',
              'mystery_chart.png',
            ],
          },
        ],
      });

      expect(registry.generatedAt, isNotNull);
      expect(registry.entries, hasLength(1));

      final entry = registry.entries.single;
      expect(entry.name, 'bert_base');
      expect(entry.version, '2');
      expect(entry.accuracy, 0.97);
      expect(entry.f1Score, 0.96);
      expect(entry.auc, 0.98);
      expect(entry.overallScore, closeTo(0.96, 0.001));
      expect(entry.charts, hasLength(3));
      expect(
        entry.knownCharts,
        containsAll([BenchmarkChart.confusionMatrix, BenchmarkChart.rocCurve]),
      );
      expect(
        entry.knownCharts,
        isNot(contains(BenchmarkChart.metricsComparison)),
      );
    });

    test('accepts a bare list with inline metrics', () {
      final registry = ModelRegistryDto.parse([
        {
          'name': 'logreg',
          'category': 'Classical ML',
          'accuracy': 0.9,
          'f1': 0.88,
        },
      ]);

      final entry = registry.entries.single;
      expect(entry.displayName, 'logreg'); // falls back to name
      expect(entry.accuracy, 0.9);
      expect(entry.f1Score, 0.88);
      expect(entry.loaded, isFalse);
      expect(entry.knownCharts, isEmpty);
    });
  });
}
