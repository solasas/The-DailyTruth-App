import 'package:freezed_annotation/freezed_annotation.dart';

import 'article_enums.dart';

part 'article.freezed.dart';

/// One claim extracted from the article and checked against retrieved
/// evidence (`ClaimVerdictOut` on the wire).
@freezed
class ClaimVerdictResult with _$ClaimVerdictResult {
  const factory ClaimVerdictResult({
    required String claim,
    required ClaimVerdict verdict,
    required ClaimStatus status,
    @Default(0.0) double confidence,
    String? evidence,
    String? sourceUrl,
  }) = _ClaimVerdictResult;
}

/// A stage that had to degrade its behaviour (`DegradationOut` on the wire).
@freezed
class Degradation with _$Degradation {
  const factory Degradation({
    required DegradationSeverity severity,
    required String reason,
    String? stage,
  }) = _Degradation;
}

/// The aggregated verdict for an article (`VerdictOut` on the wire).
@freezed
class Verdict with _$Verdict {
  const factory Verdict({
    required ArticleVerdict verdict,
    @Default(0.0) double confidence,
    String? rationale,
    @Default(<ClaimVerdictResult>[]) List<ClaimVerdictResult> claims,
    @Default(<Degradation>[]) List<Degradation> degradations,
  }) = _Verdict;

  const Verdict._();

  int get supportedClaims =>
      claims.where((c) => c.verdict == ClaimVerdict.entailment).length;

  int get contradictedClaims =>
      claims.where((c) => c.verdict == ClaimVerdict.contradiction).length;

  bool get isDegraded => degradations.isNotEmpty;
}

/// A submitted article and its verification state (`ArticleOut` on the wire).
@freezed
class Article with _$Article {
  const factory Article({
    required String id,
    required ArticleStatus status,
    required ArticleStage stage,
    String? textPreview,
    DateTime? submittedAt,
    DateTime? completedAt,
    Verdict? verdict,
    String? error,
  }) = _Article;

  const Article._();

  bool get isProcessing => status == ArticleStatus.processing;
  bool get isCompleted => status == ArticleStatus.completed;
  bool get isFailed => status == ArticleStatus.failed;
}
