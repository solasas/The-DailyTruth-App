import 'dart:typed_data';

import '../../domain/entities/chart_info.dart';
import '../../domain/repositories/charts_repository.dart';
import '../datasources/charts_remote_datasource.dart';

class ChartsRepositoryImpl implements ChartsRepository {
  ChartsRepositoryImpl(this._remoteDataSource);

  final ChartsRemoteDataSource _remoteDataSource;

  @override
  Future<List<ChartInfo>> getCharts() async {
    final dtos = await _remoteDataSource.getCharts();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Uint8List> getChartImage(String name) {
    return _remoteDataSource.getChartImage(name);
  }
}
