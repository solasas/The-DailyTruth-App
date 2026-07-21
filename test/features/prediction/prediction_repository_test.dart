import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_daily_truth/features/prediction/data/datasources/prediction_remote_datasource.dart';
import 'package:the_daily_truth/features/prediction/data/models/all_models_prediction_dto.dart';
import 'package:the_daily_truth/features/prediction/data/models/prediction_result_dto.dart';
import 'package:the_daily_truth/features/prediction/data/repositories/prediction_repository_impl.dart';
import 'package:the_daily_truth/features/prediction/domain/entities/prediction_result.dart';

class MockPredictionRemoteDataSource extends Mock implements PredictionRemoteDataSource {}

void main() {
  late MockPredictionRemoteDataSource remoteDataSource;
  late PredictionRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockPredictionRemoteDataSource();
    repository = PredictionRepositoryImpl(remoteDataSource);
  });

  group('PredictionRepositoryImpl.predict', () {
    test('maps a FAKE verdict DTO to a PredictionLabel.fake entity', () async {
      when(() => remoteDataSource.predict(text: any(named: 'text'), modelName: any(named: 'modelName')))
          .thenAnswer(
        (_) async => const PredictionResultDto(
          prediction: 'FAKE',
          confidence: 0.87,
          fakeProbability: 0.87,
          realProbability: 0.13,
          modelName: 'BERT',
          category: 'transformer',
        ),
      );

      final result = await repository.predict(text: 'some article', modelName: 'BERT');

      expect(result.label, PredictionLabel.fake);
      expect(result.confidence, 0.87);
      expect(result.modelName, 'BERT');
    });

    test('maps a REAL verdict DTO to a PredictionLabel.real entity', () async {
      when(() => remoteDataSource.predict(text: any(named: 'text'), modelName: any(named: 'modelName')))
          .thenAnswer(
        (_) async => const PredictionResultDto(
          prediction: 'REAL',
          confidence: 0.75,
          fakeProbability: 0.25,
          realProbability: 0.75,
          modelName: 'SVM',
          category: 'classical',
        ),
      );

      final result = await repository.predict(text: 'some article', modelName: 'SVM');

      expect(result.label, PredictionLabel.real);
    });
  });

  group('PredictionRepositoryImpl.predictAll', () {
    test('maps consensus + per-model results', () async {
      when(() => remoteDataSource.predictAll(text: any(named: 'text'))).thenAnswer(
        (_) async => const AllModelsPredictionDto(
          consensus: ConsensusDto(prediction: 'FAKE', confidence: 0.8),
          results: [
            PredictionResultDto(
              prediction: 'FAKE',
              confidence: 0.8,
              fakeProbability: 0.8,
              realProbability: 0.2,
              modelName: 'Model A',
              category: 'classical',
            ),
            PredictionResultDto(
              prediction: 'REAL',
              confidence: 0.6,
              fakeProbability: 0.4,
              realProbability: 0.6,
              modelName: 'Model B',
              category: 'ensemble',
            ),
          ],
        ),
      );

      final result = await repository.predictAll(text: 'some article');

      expect(result.consensusLabel, PredictionLabel.fake);
      expect(result.consensusConfidence, 0.8);
      expect(result.results, hasLength(2));
      expect(result.results.first.modelName, 'Model A');
    });
  });
}
