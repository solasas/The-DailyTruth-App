import '../entities/model_info.dart';

/// Contract for fetching model metadata, implemented by
/// [ModelsRepositoryImpl] and faked in tests.
abstract class ModelsRepository {
  Future<List<ModelInfo>> getModels();
}
