import '../../domain/entities/benchmark_result.dart';
import '../../domain/repositories/benchmark_repository.dart';
import '../datasources/benchmark_remote_datasource.dart';

class BenchmarkRepositoryImpl implements BenchmarkRepository {
  BenchmarkRepositoryImpl(this._remoteDataSource);

  final BenchmarkRemoteDataSource _remoteDataSource;

  @override
  Future<List<BenchmarkResult>> getResults() async {
    final dtos = await _remoteDataSource.getResults();
    final sorted = [...dtos]..sort((a, b) => b.accuracy.compareTo(a.accuracy));
    return [
      for (var i = 0; i < sorted.length; i++) sorted[i].toEntity(rank: i + 1),
    ];
  }
}
