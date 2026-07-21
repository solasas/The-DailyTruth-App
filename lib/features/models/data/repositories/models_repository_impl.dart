import '../../domain/entities/model_info.dart';
import '../../domain/repositories/models_repository.dart';
import '../datasources/models_remote_datasource.dart';

class ModelsRepositoryImpl implements ModelsRepository {
  ModelsRepositoryImpl(this._remoteDataSource);

  final ModelsRemoteDataSource _remoteDataSource;

  @override
  Future<List<ModelInfo>> getModels() async {
    final dtos = await _remoteDataSource.getModels();
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
