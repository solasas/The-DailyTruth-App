import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_queue_item.freezed.dart';

/// Where a queue item sits in the analyst workflow.
enum ReviewStatus { pending, inReview, resolved, escalated }

extension ReviewStatusX on ReviewStatus {
  String get label => switch (this) {
    ReviewStatus.pending => 'Pending',
    ReviewStatus.inReview => 'In review',
    ReviewStatus.resolved => 'Resolved',
    ReviewStatus.escalated => 'Escalated',
  };

  bool get isOpen =>
      this == ReviewStatus.pending || this == ReviewStatus.inReview;

  static ReviewStatus parse(String? raw) => switch (raw?.toLowerCase().trim()) {
    'resolved' || 'closed' || 'done' => ReviewStatus.resolved,
    'escalated' => ReviewStatus.escalated,
    'in_review' ||
    'in-review' ||
    'reviewing' ||
    'assigned' => ReviewStatus.inReview,
    _ => ReviewStatus.pending,
  };
}

/// An item flagged for human review — typically a low-confidence or
/// contested prediction/verdict the pipeline couldn't settle.
@freezed
class ReviewQueueItem with _$ReviewQueueItem {
  const factory ReviewQueueItem({
    required String id,
    required ReviewStatus status,
    required String textPreview,
    String? articleId,
    String? modelVerdict,
    double? confidence,
    String? reason,
    String? assignee,
    String? resolutionNote,
    DateTime? createdAt,
    DateTime? resolvedAt,
  }) = _ReviewQueueItem;
}

/// One page of `GET /review-queue`.
@freezed
class ReviewQueuePage with _$ReviewQueuePage {
  const factory ReviewQueuePage({
    required List<ReviewQueueItem> items,
    required int page,
    required int pageSize,
    required int total,
  }) = _ReviewQueuePage;

  const ReviewQueuePage._();

  bool get hasMore => page * pageSize < total;
}
