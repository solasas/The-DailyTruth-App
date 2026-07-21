import '../../domain/entities/server_health.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<ServerHealth> getServerHealth() async {
    final dto = await _remoteDataSource.getServerHealth();
    return dto.toEntity();
  }
}
