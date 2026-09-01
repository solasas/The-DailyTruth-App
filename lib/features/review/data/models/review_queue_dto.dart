import '../../domain/entities/review_queue_item.dart';

/// Lenient parsing for `GET /review-queue` (paginated) and the item echoed
/// back by `POST /review-queue/{id}/resolve`.
class ReviewQueueDto {
  ReviewQueueDto._();

  static ReviewQueuePage parsePage(
    dynamic data, {
    required int requestedPage,
    required int requestedPageSize,
  }) {
    List<dynamic> rawItems;
    int page = requestedPage;
    int pageSize = requestedPageSize;
    int? total;

    if (data is List) {
      rawItems = data;
    } else if (data is Map) {
      final map = data.cast<String, dynamic>();
      rawItems =
          (map['items'] ?? map['results'] ?? map['queue'] ?? const []) as List;
      page = _int(map['page']) ?? page;
      pageSize =
          _int(map['page_size'] ?? map['size'] ?? map['per_page']) ?? pageSize;
      total = _int(map['total'] ?? map['count'] ?? map['total_count']);
    } else {
      rawItems = const [];
    }

    final items = rawItems
        .whereType<Map>()
        .map((e) => parseItem(e.cast<String, dynamic>()))
        .toList();

    return ReviewQueuePage(
      items: items,
      page: page,
      pageSize: pageSize == 0
          ? (items.isEmpty ? requestedPageSize : items.length)
          : pageSize,
      total: total ?? ((page - 1) * requestedPageSize + items.length),
    );
  }

  static ReviewQueueItem parseItem(Map<String, dynamic> json) {
    return ReviewQueueItem(
      id: (json['id'] ?? json['item_id'] ?? json['review_id'] ?? '').toString(),
      status: ReviewStatusX.parse(json['status'] as String?),
      textPreview:
          (json['text_preview'] ??
                  json['preview'] ??
                  json['text'] ??
                  json['claim'] ??
                  '')
              .toString(),
      articleId: (json['article_id'] ?? json['articleId'])?.toString(),
      modelVerdict:
          (json['model_verdict'] ??
                  json['prediction'] ??
                  json['verdict'] ??
                  json['label'])
              as String?,
      confidence: _double(json['confidence'] ?? json['score']),
      reason:
          (json['reason'] ?? json['flag_reason'] ?? json['note']) as String?,
      assignee:
          (json['assignee'] ?? json['assigned_to'] ?? json['reviewer'])
              as String?,
      resolutionNote:
          (json['resolution_note'] ??
                  json['resolution'] ??
                  json['decision_note'])
              as String?,
      createdAt: _date(
        json['created_at'] ?? json['flagged_at'] ?? json['submitted_at'],
      ),
      resolvedAt: _date(json['resolved_at'] ?? json['closed_at']),
    );
  }

  static int? _int(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '');
  }

  static double? _double(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  static DateTime? _date(dynamic v) {
    if (v == null) return null;
    if (v is int) {
      return DateTime.fromMillisecondsSinceEpoch(v < 1e12 ? v * 1000 : v);
    }
    return DateTime.tryParse(v.toString());
  }
}
