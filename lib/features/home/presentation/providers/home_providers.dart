import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../benchmark/presentation/providers/benchmark_providers.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/server_health.dart';
import '../../domain/repositories/home_repository.dart';

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.watch(homeRemoteDataSourceProvider));
});

final serverHealthProvider = FutureProvider.autoDispose<ServerHealth>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getServerHealth();
});

/// Display-only summary for the dashboard's "Best Model" / "Accuracy" tiles.
class BestModelSummary {
  const BestModelSummary({required this.name, required this.accuracy});

  final String name;
  final double accuracy;
}

/// Thin display mapping over [bestModelProvider], which already prefers
/// `GET /results` and falls back to `GET /models` internally (see
/// `benchmarkOrFallbackProvider`) — kept here only to decouple the Home
/// widgets from the benchmark feature's entity type.
final bestModelSummaryProvider = Provider.autoDispose<AsyncValue<BestModelSummary?>>((
  ref,
) {
  return ref.watch(bestModelProvider).whenData(
    (best) => best == null ? null : BestModelSummary(name: best.displayName, accuracy: best.accuracy),
  );
});
