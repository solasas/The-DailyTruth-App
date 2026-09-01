import '../entities/review_queue_item.dart';

abstract class ReviewRepository {
  Future<ReviewQueuePage> getQueue({
    int page,
    int pageSize,
    ReviewStatus? status,
  });

  /// `POST /review-queue/{id}/resolve` (Bearer) — records the analyst's
  /// override. [decision] is one of `real` / `fake` / `uncertain`.
  Future<ReviewQueueItem> resolve({
    required String id,
    required String decision,
    String? note,
  });
}
