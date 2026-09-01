import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_daily_truth/features/prediction/data/datasources/prediction_remote_datasource.dart';
import 'package:the_daily_truth/features/prediction/data/models/all_models_prediction_dto.dart';
import 'package:the_daily_truth/features/prediction/data/models/prediction_result_dto.dart';
import 'package:the_daily_truth/features/prediction/data/repositories/prediction_repository_impl.dart';
import 'package:the_daily_truth/features/prediction/domain/entities/prediction_result.dart';

class MockPredictionRemoteDataSource extends Mock
    implements PredictionRemoteDataSource {}

void main() {
  late MockPredictionRemoteDataSource remoteDataSource;
  late PredictionRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockPredictionRemoteDataSource();
    repository = PredictionRepositoryImpl(remoteDataSource);
  });

  group('PredictionRepositoryImpl.predict', () {
    test('maps a fake verdict DTO to a PredictionLabel.fake entity', () async {
      when(
        () => remoteDataSource.predict(
          text: any(named: 'text'),
          modelName: any(named: 'modelName'),
          threshold: any(named: 'threshold'),
        ),
      ).thenAnswer(
        (_) async => const PredictionResultDto(
          label: 'fake',
          confidence: 0.87,
          probFake: 0.87,
          probReal: 0.13,
          modelName: 'bert',
          displayName: 'BERT',
          category: 'transformer',
        ),
      );

      final result = await repository.predict(
        text: 'some article',
        modelName: 'bert',
      );

      expect(result.label, PredictionLabel.fake);
      expect(result.confidence, 0.87);
      expect(result.modelName, 'bert');
      expect(result.displayName, 'BERT');
    });

    test('maps a real verdict DTO to a PredictionLabel.real entity', () async {
      when(
        () => remoteDataSource.predict(
          text: any(named: 'text'),
          modelName: any(named: 'modelName'),
          threshold: any(named: 'threshold'),
        ),
      ).thenAnswer(
        (_) async => const PredictionResultDto(
          label: 'real',
          confidence: 0.75,
          probFake: 0.25,
          probReal: 0.75,
          modelName: 'linear_svm',
          displayName: 'Linear SVM',
          category: 'classical',
        ),
      );

      final result = await repository.predict(
        text: 'some article',
        modelName: 'linear_svm',
      );

      expect(result.label, PredictionLabel.real);
    });
  });

  group('PredictionRepositoryImpl.predictAll', () {
    test('maps consensus + per-model results', () async {
      when(
        () => remoteDataSource.predictAll(
          text: any(named: 'text'),
          threshold: any(named: 'threshold'),
        ),
      ).thenAnswer(
        (_) async => const AllModelsPredictionDto(
          consensus: 'fake',
          consensusConfidence: 0.8,
          results: [
            PredictionResultDto(
              label: 'fake',
              confidence: 0.8,
              probFake: 0.8,
              probReal: 0.2,
              modelName: 'model_a',
              displayName: 'Model A',
              category: 'classical',
            ),
            PredictionResultDto(
              label: 'real',
              confidence: 0.6,
              probFake: 0.4,
              probReal: 0.6,
              modelName: 'model_b',
              displayName: 'Model B',
              category: 'ensemble',
            ),
          ],
        ),
      );

      final result = await repository.predictAll(text: 'some article');

      expect(result.consensusLabel, PredictionLabel.fake);
      expect(result.consensusConfidence, 0.8);
      expect(result.results, hasLength(2));
      expect(result.results.first.displayName, 'Model A');
    });
  });
}
