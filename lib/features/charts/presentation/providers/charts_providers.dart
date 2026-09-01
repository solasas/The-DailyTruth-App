import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/charts_remote_datasource.dart';
import '../../data/repositories/charts_repository_impl.dart';
import '../../domain/entities/chart_info.dart';
import '../../domain/repositories/charts_repository.dart';

final chartsRemoteDataSourceProvider = Provider<ChartsRemoteDataSource>((ref) {
  return ChartsRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final chartsRepositoryProvider = Provider<ChartsRepository>((ref) {
  return ChartsRepositoryImpl(ref.watch(chartsRemoteDataSourceProvider));
});

final chartsListProvider = FutureProvider.autoDispose<List<ChartInfo>>((
  ref,
) async {
  final repository = ref.watch(chartsRepositoryProvider);
  return repository.getCharts();
});

/// Lazily fetches and caches the raw bytes of one chart image, keyed by
/// filename, so scrolling the gallery doesn't re-download visible thumbnails.
final chartImageProvider = FutureProvider.autoDispose.family<Uint8List, String>(
  (ref, name) async {
    final repository = ref.watch(chartsRepositoryProvider);
    final link = ref.keepAlive();
    ref.onDispose(link.close);
    return repository.getChartImage(name);
  },
);
