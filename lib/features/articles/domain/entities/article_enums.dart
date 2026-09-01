/// Lifecycle of a submitted article in the agentic pipeline.
///
/// `POST /articles/submit` returns `202` with an id in `processing`; the
/// client polls `GET /articles/{id}` until `completed` or `failed`.
enum ArticleStatus { processing, completed, failed }

extension ArticleStatusX on ArticleStatus {
  bool get isTerminal => this != ArticleStatus.processing;

  String get label => switch (this) {
    ArticleStatus.processing => 'Verifying',
    ArticleStatus.completed => 'Completed',
    ArticleStatus.failed => 'Failed',
  };

  static ArticleStatus parse(String? raw) => switch (raw
      ?.toLowerCase()
      .trim()) {
    'completed' || 'complete' || 'done' || 'success' => ArticleStatus.completed,
    'failed' || 'error' => ArticleStatus.failed,
    _ => ArticleStatus.processing,
  };
}

/// Coarse pipeline stage, surfaced as a progress hint while `processing`.
enum ArticleStage {
  queued,
  extractingClaims,
  retrievingEvidence,
  checkingEntailment,
  aggregating,
  done,
  unknown,
}

extension ArticleStageX on ArticleStage {
  String get label => switch (this) {
    ArticleStage.queued => 'Queued',
    ArticleStage.extractingClaims => 'Extracting claims',
    ArticleStage.retrievingEvidence => 'Retrieving evidence',
    ArticleStage.checkingEntailment => 'Checking entailment',
    ArticleStage.aggregating => 'Aggregating verdict',
    ArticleStage.done => 'Done',
    ArticleStage.unknown => 'Working',
  };

  /// Ordered position for a step indicator (0-based). `unknown` sorts last.
  int get order => switch (this) {
    ArticleStage.queued => 0,
    ArticleStage.extractingClaims => 1,
    ArticleStage.retrievingEvidence => 2,
    ArticleStage.checkingEntailment => 3,
    ArticleStage.aggregating => 4,
    ArticleStage.done => 5,
    ArticleStage.unknown => 5,
  };

  static const orderedSteps = [
    ArticleStage.queued,
    ArticleStage.extractingClaims,
    ArticleStage.retrievingEvidence,
    ArticleStage.checkingEntailment,
    ArticleStage.aggregating,
    ArticleStage.done,
  ];

  static ArticleStage parse(String? raw) {
    final v = raw?.toLowerCase().trim() ?? '';
    if (v.isEmpty) return ArticleStage.unknown;
    if (v.contains('queue')) return ArticleStage.queued;
    if (v.contains('extract') || v.contains('claim')) {
      return ArticleStage.extractingClaims;
    }
    if (v.contains('retriev') ||
        v.contains('search') ||
        v.contains('evidence')) {
      return ArticleStage.retrievingEvidence;
    }
    if (v.contains('entail') || v.contains('nli') || v.contains('verif')) {
      return ArticleStage.checkingEntailment;
    }
    if (v.contains('aggreg') || v.contains('score') || v.contains('summar')) {
      return ArticleStage.aggregating;
    }
    if (v.contains('done') || v.contains('complet') || v.contains('finish')) {
      return ArticleStage.done;
    }
    return ArticleStage.unknown;
  }
}

/// Overall article-level verdict from the aggregation stage.
enum ArticleVerdict { likelyFake, likelyReal, uncertain }

extension ArticleVerdictX on ArticleVerdict {
  String get label => switch (this) {
    ArticleVerdict.likelyFake => 'Likely fake',
    ArticleVerdict.likelyReal => 'Likely real',
    ArticleVerdict.uncertain => 'Uncertain',
  };

  static ArticleVerdict parse(String? raw) {
    final v =
        raw?.toLowerCase().trim().replaceAll(RegExp(r'[\s-]+'), '_') ?? '';
    return switch (v) {
      'likely_fake' || 'fake' || 'false' => ArticleVerdict.likelyFake,
      'likely_real' || 'real' || 'true' => ArticleVerdict.likelyReal,
      _ => ArticleVerdict.uncertain,
    };
  }
}

/// Per-claim NLI outcome against the retrieved evidence.
enum ClaimVerdict { entailment, contradiction, neutral, unverifiable }

extension ClaimVerdictX on ClaimVerdict {
  String get label => switch (this) {
    ClaimVerdict.entailment => 'Supported',
    ClaimVerdict.contradiction => 'Contradicted',
    ClaimVerdict.neutral => 'Neutral',
    ClaimVerdict.unverifiable => 'Unverifiable',
  };

  static ClaimVerdict parse(String? raw) {
    final v = raw?.toLowerCase().trim() ?? '';
    return switch (v) {
      'entailment' ||
      'entails' ||
      'support' ||
      'supported' => ClaimVerdict.entailment,
      'contradiction' ||
      'contradict' ||
      'contradicted' ||
      'refuted' => ClaimVerdict.contradiction,
      'neutral' || 'nei' => ClaimVerdict.neutral,
      _ => ClaimVerdict.unverifiable,
    };
  }
}

/// Whether an individual claim finished its own sub-pipeline.
enum ClaimStatus { pending, verified, failed }

extension ClaimStatusX on ClaimStatus {
  static ClaimStatus parse(String? raw) => switch (raw?.toLowerCase().trim()) {
    'verified' || 'done' || 'completed' => ClaimStatus.verified,
    'failed' || 'error' => ClaimStatus.failed,
    _ => ClaimStatus.pending,
  };
}

/// How badly a stage had to fall back (e.g. evidence retrieval degraded to
/// cached results, or an NLI model timed out under `STAGE_TIMEOUT_S`).
enum DegradationSeverity { info, minor, major }

extension DegradationSeverityX on DegradationSeverity {
  String get label => switch (this) {
    DegradationSeverity.info => 'Note',
    DegradationSeverity.minor => 'Minor degradation',
    DegradationSeverity.major => 'Major degradation',
  };

  static DegradationSeverity parse(String? raw) => switch (raw
      ?.toLowerCase()
      .trim()) {
    'major' || 'severe' || 'critical' || 'high' => DegradationSeverity.major,
    'minor' ||
    'moderate' ||
    'low' ||
    'medium' ||
    'warning' => DegradationSeverity.minor,
    _ => DegradationSeverity.info,
  };
}
