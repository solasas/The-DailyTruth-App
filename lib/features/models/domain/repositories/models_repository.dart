import '../entities/model_info.dart';
import '../entities/model_registry_entry.dart';

/// Contract for fetching model metadata, implemented by
/// [ModelsRepositoryImpl] and faked in tests.
abstract class ModelsRepository {
  Future<List<ModelInfo>> getModels();

  /// Richer per-model detail from `GET /models/registry` (training metrics +
  /// chart artefacts).
  Future<ModelRegistry> getRegistry();
}
