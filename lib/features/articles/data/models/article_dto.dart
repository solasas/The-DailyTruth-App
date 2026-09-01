import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';

/// Hand-rolled parsing for the agentic verification payloads
/// (`ArticleOut` → `VerdictOut` → `ClaimVerdictOut` / `DegradationOut`).
///
/// The pipeline is young and its envelope keys drift, so every field is
/// looked up under a few plausible names and every list tolerates being
/// absent or `null`.
class ArticleDto {
  const ArticleDto(this.article);

  final Article article;

  static Article parse(Map<String, dynamic> json) {
    final verdictJson = _asMap(json['verdict']) ?? _asMap(json['result']);

    return Article(
      id: (json['id'] ?? json['article_id'] ?? json['task_id'] ?? '')
          .toString(),
      status: ArticleStatusX.parse(json['status'] as String?),
      stage: ArticleStageX.parse(
        (json['stage'] ?? json['current_stage'] ?? json['step']) as String?,
      ),
      textPreview:
          (json['text_preview'] ?? json['preview'] ?? json['text']) as String?,
      submittedAt: _date(json['submitted_at'] ?? json['created_at']),
      completedAt: _date(json['completed_at'] ?? json['finished_at']),
      verdict: verdictJson == null ? null : _parseVerdict(verdictJson),
      error:
          (json['error'] ?? json['error_message'] ?? json['detail']) as String?,
    );
  }

  /// The `202` body returned by `POST /articles/submit` — usually just an id.
  static String parseSubmitId(dynamic data) {
    if (data is String && data.isNotEmpty) return data;
    if (data is Map) {
      final id =
          data['id'] ?? data['article_id'] ?? data['task_id'] ?? data['job_id'];
      if (id != null) return id.toString();
    }
    throw const FormatException('No article id in /articles/submit response');
  }

  static Verdict _parseVerdict(Map<String, dynamic> json) {
    return Verdict(
      verdict: ArticleVerdictX.parse(
        (json['verdict'] ?? json['label'] ?? json['overall']) as String?,
      ),
      confidence: _toDouble(json['confidence'] ?? json['score']),
      rationale:
          (json['rationale'] ?? json['explanation'] ?? json['summary'])
              as String?,
      claims: _list(
        json['claims'] ?? json['claim_verdicts'],
      ).map(_parseClaim).toList(),
      degradations: _list(
        json['degradations'] ?? json['degradation'] ?? json['warnings'],
      ).map(_parseDegradation).toList(),
    );
  }

  static ClaimVerdictResult _parseClaim(Map<String, dynamic> json) {
    return ClaimVerdictResult(
      claim: (json['claim'] ?? json['text'] ?? json['statement'] ?? '')
          .toString(),
      verdict: ClaimVerdictX.parse(
        (json['verdict'] ?? json['label'] ?? json['entailment']) as String?,
      ),
      status: ClaimStatusX.parse(json['status'] as String?),
      confidence: _toDouble(json['confidence'] ?? json['score']),
      evidence:
          (json['evidence'] ?? json['evidence_text'] ?? json['snippet'])
              as String?,
      sourceUrl:
          (json['source_url'] ?? json['url'] ?? json['source']) as String?,
    );
  }

  static Degradation _parseDegradation(Map<String, dynamic> json) {
    return Degradation(
      severity: DegradationSeverityX.parse(
        (json['severity'] ?? json['level']) as String?,
      ),
      reason:
          (json['reason'] ?? json['message'] ?? json['detail'] ?? 'Degraded')
              .toString(),
      stage: (json['stage'] ?? json['step']) as String?,
    );
  }

  static Map<String, dynamic>? _asMap(dynamic v) => v is Map<String, dynamic>
      ? v
      : (v is Map ? v.cast<String, dynamic>() : null);

  static List<Map<String, dynamic>> _list(dynamic v) {
    if (v is! List) return const [];
    return v.whereType<Map>().map((e) => e.cast<String, dynamic>()).toList();
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      // Heuristic: seconds vs milliseconds since epoch.
      return DateTime.fromMillisecondsSinceEpoch(
        value < 1e12 ? value * 1000 : value,
      );
    }
    return DateTime.tryParse(value.toString());
  }
}
