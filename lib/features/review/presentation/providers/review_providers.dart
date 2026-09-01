import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/review_remote_datasource.dart';
import '../../data/repositories/review_repository_impl.dart';
import '../../domain/entities/review_queue_item.dart';
import '../../domain/repositories/review_repository.dart';

final reviewRemoteDataSourceProvider = Provider<ReviewRemoteDataSource>((ref) {
  return ReviewRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl(ref.watch(reviewRemoteDataSourceProvider));
});

/// Optional status filter for the queue. Changing it rebuilds
/// [reviewQueueControllerProvider] from page 1.
final reviewStatusFilterProvider = StateProvider<ReviewStatus?>((ref) => null);

/// Accumulated, de-duplicated view of the paginated review queue.
class ReviewQueueState {
  const ReviewQueueState({
    this.items = const [],
    this.page = 0,
    this.total = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<ReviewQueueItem> items;
  final int page;
  final int total;
  final bool hasMore;
  final bool isLoadingMore;

  ReviewQueueState copyWith({
    List<ReviewQueueItem>? items,
    int? page,
    int? total,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ReviewQueueState(
      items: items ?? this.items,
      page: page ?? this.page,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ReviewQueueController extends AsyncNotifier<ReviewQueueState> {
  ReviewStatus? get _filter => ref.read(reviewStatusFilterProvider);

  @override
  Future<ReviewQueueState> build() async {
    // Rebuild whenever the status filter changes.
    ref.watch(reviewStatusFilterProvider);
    return _fetchPage(1);
  }

  Future<ReviewQueueState> _fetchPage(
    int page, {
    List<ReviewQueueItem> existing = const [],
  }) async {
    final result = await ref
        .read(reviewRepositoryProvider)
        .getQueue(
          page: page,
          pageSize: AppConstants.reviewQueuePageSize,
          status: _filter,
        );

    final seen = {for (final e in existing) e.id};
    final merged = [
      ...existing,
      ...result.items.where((e) => e.id.isEmpty || seen.add(e.id)),
    ];

    return ReviewQueueState(
      items: merged,
      page: result.page,
      total: result.total,
      hasMore: result.hasMore && result.items.isNotEmpty,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(1));
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    state = await AsyncValue.guard(
      () => _fetchPage(current.page + 1, existing: current.items),
    );
  }

  /// Resolves an item and drops it from the local list on success.
  Future<void> resolve({
    required String id,
    required String decision,
    String? note,
  }) async {
    await ref
        .read(reviewRepositoryProvider)
        .resolve(id: id, decision: decision, note: note);
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        items: current.items.where((e) => e.id != id).toList(),
        total: (current.total - 1).clamp(0, 1 << 31),
      ),
    );
  }
}

final reviewQueueControllerProvider =
    AsyncNotifierProvider<ReviewQueueController, ReviewQueueState>(
      ReviewQueueController.new,
    );

/// Decision values accepted by `POST /review-queue/{id}/resolve`.
enum ReviewDecision { real, fake, uncertain }

extension ReviewDecisionX on ReviewDecision {
  String get label => switch (this) {
    ReviewDecision.real => 'Real',
    ReviewDecision.fake => 'Fake',
    ReviewDecision.uncertain => 'Uncertain',
  };

  String get wireValue => name;
}
