import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_daily_truth/features/models/data/datasources/models_remote_datasource.dart';
import 'package:the_daily_truth/features/models/data/models/model_info_dto.dart';
import 'package:the_daily_truth/features/models/data/repositories/models_repository_impl.dart';

class MockModelsRemoteDataSource extends Mock implements ModelsRemoteDataSource {}

void main() {
  late MockModelsRemoteDataSource remoteDataSource;
  late ModelsRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockModelsRemoteDataSource();
    repository = ModelsRepositoryImpl(remoteDataSource);
  });

  group('ModelsRepositoryImpl.getModels', () {
    test('maps DTOs from the remote data source into domain entities', () async {
      when(() => remoteDataSource.getModels()).thenAnswer(
        (_) async => [
          const ModelInfoDto(
            name: 'logistic_regression',
            displayName: 'Logistic Regression',
            category: 'Classical ML',
            loaded: true,
            accuracy: 0.94,
            f1Score: 0.93,
            precision: 0.92,
            recall: 0.91,
            auc: 0.95,
            featureType: 'tfidf',
          ),
        ],
      );

      final result = await repository.getModels();

      expect(result, hasLength(1));
      expect(result.first.name, 'logistic_regression');
      expect(result.first.displayName, 'Logistic Regression');
      expect(result.first.loaded, isTrue);
      expect(result.first.accuracy, 0.94);
      expect(result.first.overallScore, closeTo(0.93, 0.001));
    });

    test('propagates errors thrown by the remote data source', () async {
      when(() => remoteDataSource.getModels()).thenThrow(Exception('network down'));

      expect(() => repository.getModels(), throwsException);
    });
  });
}
