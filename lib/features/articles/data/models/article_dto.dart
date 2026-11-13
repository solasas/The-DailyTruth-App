import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';
import '../../domain/entities/origin.dart';

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
      reasoningTrace: json['reasoning_trace'] as String?,
      claims: _list(
        json['claims'] ?? json['claim_verdicts'],
      ).map(_parseClaim).toList(),
      degradations: _list(
        json['degradations'] ?? json['degradation'] ?? json['warnings'],
      ).map(_parseDegradation).toList(),
    );
  }

  static ClaimVerdictResult _parseClaim(Map<String, dynamic> json) {
    final snippets = _strings(json['evidence_snippets']);
    final sources = _strings(json['sources']);
    final meta = _list(json['evidence_meta']).map(_parseEvidenceMeta).toList();
    final originJson = _asMap(json['origin']);

    return ClaimVerdictResult(
      claim: (json['claim'] ?? json['text'] ?? json['statement'] ?? '')
          .toString(),
      verdict: ClaimVerdictX.parse(
        (json['verdict'] ?? json['label'] ?? json['entailment']) as String?,
      ),
      status: ClaimStatusX.parse(json['status'] as String?),
      confidence: _toDouble(json['confidence'] ?? json['score']),
      evidence:
          (json['evidence'] ??
                  json['evidence_text'] ??
                  json['snippet'] ??
                  (snippets.isEmpty ? null : snippets.first))
              as String?,
      sourceUrl:
          (json['source_url'] ??
                  json['url'] ??
                  (meta.isEmpty || meta.first.url.isEmpty
                      ? null
                      : meta.first.url))
              as String?,
      evidenceSnippets: snippets,
      sources: sources,
      evidenceMeta: meta,
      origin: originJson == null ? null : _parseOrigin(originJson),
    );
  }

  static EvidenceMeta _parseEvidenceMeta(Map<String, dynamic> j) =>
      EvidenceMeta(
        url: _str(j['url']),
        domain: _str(j['domain']),
        provider: _str(j['provider']),
        publishedAt: _str(j['published_at']),
        trust: j['trust'] == null ? 0.5 : _toDouble(j['trust']),
        stance: (j['stance'] as String?) ?? 'neutral',
        stanceScore: _toDouble(j['stance_score']),
      );

  static Origin _parseOrigin(Map<String, dynamic> j) {
    final earliest = _asMap(j['earliest_seen']);
    final debunk = _asMap(j['first_debunk']);
    return Origin(
      basis: (j['basis'] as String?) ?? 'none',
      claimant: j['claimant'] as String?,
      claimDate: j['claim_date'] as String?,
      claimantSource: j['claimant_source'] as String?,
      earliestSeen: earliest == null ? null : _parseTimelineEntry(earliest),
      firstDebunk: debunk == null ? null : _parseTimelineEntry(debunk),
      timeline: _list(j['timeline']).map(_parseTimelineEntry).toList(),
      factChecks: _list(j['fact_checks']).map(_parseFactCheck).toList(),
      factCheckStatus: (j['fact_check_status'] as String?) ?? 'skipped',
      searchStatus: (j['search_status'] as String?) ?? 'skipped',
    );
  }

  static TimelineEntry _parseTimelineEntry(Map<String, dynamic> j) =>
      TimelineEntry(
        date: _str(j['date']),
        domain: _str(j['domain']),
        url: _str(j['url']),
        kind: _str(j['kind']),
        label: _str(j['label']),
        trust: j['trust'] == null ? 0.5 : _toDouble(j['trust']),
        foundBy: (j['found_by'] as String?) ?? 'evidence',
      );

  static FactCheck _parseFactCheck(Map<String, dynamic> j) => FactCheck(
    claimText: _str(j['claim_text']),
    claimant: _str(j['claimant']),
    claimDate: _str(j['claim_date']),
    publisher: _str(j['publisher']),
    site: _str(j['site']),
    url: _str(j['url']),
    rating: _str(j['rating']),
    ratingClass: (j['rating_class'] as String?) ?? 'other',
    reviewDate: _str(j['review_date']),
    relevance: _toDouble(j['relevance']),
    trust: j['trust'] == null ? 0.5 : _toDouble(j['trust']),
  );

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

  static String _str(dynamic v) => v is String ? v : '';

  static List<String> _strings(dynamic v) =>
      v is List ? v.whereType<String>().toList() : const [];

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
    // Server timestamps are UTC without an offset; plain `tryParse` would
    // read them as local time.
    final iso = value.toString().replaceFirst(' ', 'T');
    final hasZone = RegExp(r'(Z|[+-]\d\d:?\d\d)$').hasMatch(iso);
    return DateTime.tryParse(hasZone ? iso : '${iso}Z');
  }
}
