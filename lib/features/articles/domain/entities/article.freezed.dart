// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClaimVerdictResult {
  String get claim => throw _privateConstructorUsedError;
  ClaimVerdict get verdict => throw _privateConstructorUsedError;
  ClaimStatus get status => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String? get evidence => throw _privateConstructorUsedError;
  String? get sourceUrl => throw _privateConstructorUsedError;

  /// Evidence shown to NLI; `sources` and `evidenceMeta` run parallel to it.
  List<String> get evidenceSnippets => throw _privateConstructorUsedError;
  List<String> get sources => throw _privateConstructorUsedError;
  List<EvidenceMeta> get evidenceMeta => throw _privateConstructorUsedError;

  /// Present only for claims the evidence did not support.
  Origin? get origin => throw _privateConstructorUsedError;

  /// Create a copy of ClaimVerdictResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimVerdictResultCopyWith<ClaimVerdictResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimVerdictResultCopyWith<$Res> {
  factory $ClaimVerdictResultCopyWith(
    ClaimVerdictResult value,
    $Res Function(ClaimVerdictResult) then,
  ) = _$ClaimVerdictResultCopyWithImpl<$Res, ClaimVerdictResult>;
  @useResult
  $Res call({
    String claim,
    ClaimVerdict verdict,
    ClaimStatus status,
    double confidence,
    String? evidence,
    String? sourceUrl,
    List<String> evidenceSnippets,
    List<String> sources,
    List<EvidenceMeta> evidenceMeta,
    Origin? origin,
  });
}

/// @nodoc
class _$ClaimVerdictResultCopyWithImpl<$Res, $Val extends ClaimVerdictResult>
    implements $ClaimVerdictResultCopyWith<$Res> {
  _$ClaimVerdictResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClaimVerdictResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claim = null,
    Object? verdict = null,
    Object? status = null,
    Object? confidence = null,
    Object? evidence = freezed,
    Object? sourceUrl = freezed,
    Object? evidenceSnippets = null,
    Object? sources = null,
    Object? evidenceMeta = null,
    Object? origin = freezed,
  }) {
    return _then(
      _value.copyWith(
            claim: null == claim
                ? _value.claim
                : claim // ignore: cast_nullable_to_non_nullable
                      as String,
            verdict: null == verdict
                ? _value.verdict
                : verdict // ignore: cast_nullable_to_non_nullable
                      as ClaimVerdict,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ClaimStatus,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            evidence: freezed == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceUrl: freezed == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            evidenceSnippets: null == evidenceSnippets
                ? _value.evidenceSnippets
                : evidenceSnippets // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            sources: null == sources
                ? _value.sources
                : sources // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            evidenceMeta: null == evidenceMeta
                ? _value.evidenceMeta
                : evidenceMeta // ignore: cast_nullable_to_non_nullable
                      as List<EvidenceMeta>,
            origin: freezed == origin
                ? _value.origin
                : origin // ignore: cast_nullable_to_non_nullable
                      as Origin?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClaimVerdictResultImplCopyWith<$Res>
    implements $ClaimVerdictResultCopyWith<$Res> {
  factory _$$ClaimVerdictResultImplCopyWith(
    _$ClaimVerdictResultImpl value,
    $Res Function(_$ClaimVerdictResultImpl) then,
  ) = __$$ClaimVerdictResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String claim,
    ClaimVerdict verdict,
    ClaimStatus status,
    double confidence,
    String? evidence,
    String? sourceUrl,
    List<String> evidenceSnippets,
    List<String> sources,
    List<EvidenceMeta> evidenceMeta,
    Origin? origin,
  });
}

/// @nodoc
class __$$ClaimVerdictResultImplCopyWithImpl<$Res>
    extends _$ClaimVerdictResultCopyWithImpl<$Res, _$ClaimVerdictResultImpl>
    implements _$$ClaimVerdictResultImplCopyWith<$Res> {
  __$$ClaimVerdictResultImplCopyWithImpl(
    _$ClaimVerdictResultImpl _value,
    $Res Function(_$ClaimVerdictResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClaimVerdictResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claim = null,
    Object? verdict = null,
    Object? status = null,
    Object? confidence = null,
    Object? evidence = freezed,
    Object? sourceUrl = freezed,
    Object? evidenceSnippets = null,
    Object? sources = null,
    Object? evidenceMeta = null,
    Object? origin = freezed,
  }) {
    return _then(
      _$ClaimVerdictResultImpl(
        claim: null == claim
            ? _value.claim
            : claim // ignore: cast_nullable_to_non_nullable
                  as String,
        verdict: null == verdict
            ? _value.verdict
            : verdict // ignore: cast_nullable_to_non_nullable
                  as ClaimVerdict,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ClaimStatus,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        evidence: freezed == evidence
            ? _value.evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceUrl: freezed == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        evidenceSnippets: null == evidenceSnippets
            ? _value._evidenceSnippets
            : evidenceSnippets // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sources: null == sources
            ? _value._sources
            : sources // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        evidenceMeta: null == evidenceMeta
            ? _value._evidenceMeta
            : evidenceMeta // ignore: cast_nullable_to_non_nullable
                  as List<EvidenceMeta>,
        origin: freezed == origin
            ? _value.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as Origin?,
      ),
    );
  }
}

/// @nodoc

class _$ClaimVerdictResultImpl implements _ClaimVerdictResult {
  const _$ClaimVerdictResultImpl({
    required this.claim,
    required this.verdict,
    required this.status,
    this.confidence = 0.0,
    this.evidence,
    this.sourceUrl,
    final List<String> evidenceSnippets = const <String>[],
    final List<String> sources = const <String>[],
    final List<EvidenceMeta> evidenceMeta = const <EvidenceMeta>[],
    this.origin,
  }) : _evidenceSnippets = evidenceSnippets,
       _sources = sources,
       _evidenceMeta = evidenceMeta;

  @override
  final String claim;
  @override
  final ClaimVerdict verdict;
  @override
  final ClaimStatus status;
  @override
  @JsonKey()
  final double confidence;
  @override
  final String? evidence;
  @override
  final String? sourceUrl;

  /// Evidence shown to NLI; `sources` and `evidenceMeta` run parallel to it.
  final List<String> _evidenceSnippets;

  /// Evidence shown to NLI; `sources` and `evidenceMeta` run parallel to it.
  @override
  @JsonKey()
  List<String> get evidenceSnippets {
    if (_evidenceSnippets is EqualUnmodifiableListView)
      return _evidenceSnippets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceSnippets);
  }

  final List<String> _sources;
  @override
  @JsonKey()
  List<String> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  final List<EvidenceMeta> _evidenceMeta;
  @override
  @JsonKey()
  List<EvidenceMeta> get evidenceMeta {
    if (_evidenceMeta is EqualUnmodifiableListView) return _evidenceMeta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceMeta);
  }

  /// Present only for claims the evidence did not support.
  @override
  final Origin? origin;

  @override
  String toString() {
    return 'ClaimVerdictResult(claim: $claim, verdict: $verdict, status: $status, confidence: $confidence, evidence: $evidence, sourceUrl: $sourceUrl, evidenceSnippets: $evidenceSnippets, sources: $sources, evidenceMeta: $evidenceMeta, origin: $origin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimVerdictResultImpl &&
            (identical(other.claim, claim) || other.claim == claim) &&
            (identical(other.verdict, verdict) || other.verdict == verdict) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.evidence, evidence) ||
                other.evidence == evidence) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            const DeepCollectionEquality().equals(
              other._evidenceSnippets,
              _evidenceSnippets,
            ) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            const DeepCollectionEquality().equals(
              other._evidenceMeta,
              _evidenceMeta,
            ) &&
            (identical(other.origin, origin) || other.origin == origin));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    claim,
    verdict,
    status,
    confidence,
    evidence,
    sourceUrl,
    const DeepCollectionEquality().hash(_evidenceSnippets),
    const DeepCollectionEquality().hash(_sources),
    const DeepCollectionEquality().hash(_evidenceMeta),
    origin,
  );

  /// Create a copy of ClaimVerdictResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimVerdictResultImplCopyWith<_$ClaimVerdictResultImpl> get copyWith =>
      __$$ClaimVerdictResultImplCopyWithImpl<_$ClaimVerdictResultImpl>(
        this,
        _$identity,
      );
}

abstract class _ClaimVerdictResult implements ClaimVerdictResult {
  const factory _ClaimVerdictResult({
    required final String claim,
    required final ClaimVerdict verdict,
    required final ClaimStatus status,
    final double confidence,
    final String? evidence,
    final String? sourceUrl,
    final List<String> evidenceSnippets,
    final List<String> sources,
    final List<EvidenceMeta> evidenceMeta,
    final Origin? origin,
  }) = _$ClaimVerdictResultImpl;

  @override
  String get claim;
  @override
  ClaimVerdict get verdict;
  @override
  ClaimStatus get status;
  @override
  double get confidence;
  @override
  String? get evidence;
  @override
  String? get sourceUrl;

  /// Evidence shown to NLI; `sources` and `evidenceMeta` run parallel to it.
  @override
  List<String> get evidenceSnippets;
  @override
  List<String> get sources;
  @override
  List<EvidenceMeta> get evidenceMeta;

  /// Present only for claims the evidence did not support.
  @override
  Origin? get origin;

  /// Create a copy of ClaimVerdictResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimVerdictResultImplCopyWith<_$ClaimVerdictResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Degradation {
  DegradationSeverity get severity => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get stage => throw _privateConstructorUsedError;

  /// Create a copy of Degradation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DegradationCopyWith<Degradation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DegradationCopyWith<$Res> {
  factory $DegradationCopyWith(
    Degradation value,
    $Res Function(Degradation) then,
  ) = _$DegradationCopyWithImpl<$Res, Degradation>;
  @useResult
  $Res call({DegradationSeverity severity, String reason, String? stage});
}

/// @nodoc
class _$DegradationCopyWithImpl<$Res, $Val extends Degradation>
    implements $DegradationCopyWith<$Res> {
  _$DegradationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Degradation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? reason = null,
    Object? stage = freezed,
  }) {
    return _then(
      _value.copyWith(
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as DegradationSeverity,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            stage: freezed == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DegradationImplCopyWith<$Res>
    implements $DegradationCopyWith<$Res> {
  factory _$$DegradationImplCopyWith(
    _$DegradationImpl value,
    $Res Function(_$DegradationImpl) then,
  ) = __$$DegradationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DegradationSeverity severity, String reason, String? stage});
}

/// @nodoc
class __$$DegradationImplCopyWithImpl<$Res>
    extends _$DegradationCopyWithImpl<$Res, _$DegradationImpl>
    implements _$$DegradationImplCopyWith<$Res> {
  __$$DegradationImplCopyWithImpl(
    _$DegradationImpl _value,
    $Res Function(_$DegradationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Degradation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? reason = null,
    Object? stage = freezed,
  }) {
    return _then(
      _$DegradationImpl(
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as DegradationSeverity,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        stage: freezed == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DegradationImpl implements _Degradation {
  const _$DegradationImpl({
    required this.severity,
    required this.reason,
    this.stage,
  });

  @override
  final DegradationSeverity severity;
  @override
  final String reason;
  @override
  final String? stage;

  @override
  String toString() {
    return 'Degradation(severity: $severity, reason: $reason, stage: $stage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DegradationImpl &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.stage, stage) || other.stage == stage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, severity, reason, stage);

  /// Create a copy of Degradation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DegradationImplCopyWith<_$DegradationImpl> get copyWith =>
      __$$DegradationImplCopyWithImpl<_$DegradationImpl>(this, _$identity);
}

abstract class _Degradation implements Degradation {
  const factory _Degradation({
    required final DegradationSeverity severity,
    required final String reason,
    final String? stage,
  }) = _$DegradationImpl;

  @override
  DegradationSeverity get severity;
  @override
  String get reason;
  @override
  String? get stage;

  /// Create a copy of Degradation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DegradationImplCopyWith<_$DegradationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Verdict {
  ArticleVerdict get verdict => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String? get rationale => throw _privateConstructorUsedError;

  /// Plain-text explanation, including each claim's `ORIGIN TRAIL`.
  String? get reasoningTrace => throw _privateConstructorUsedError;
  List<ClaimVerdictResult> get claims => throw _privateConstructorUsedError;
  List<Degradation> get degradations => throw _privateConstructorUsedError;

  /// Create a copy of Verdict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerdictCopyWith<Verdict> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerdictCopyWith<$Res> {
  factory $VerdictCopyWith(Verdict value, $Res Function(Verdict) then) =
      _$VerdictCopyWithImpl<$Res, Verdict>;
  @useResult
  $Res call({
    ArticleVerdict verdict,
    double confidence,
    String? rationale,
    String? reasoningTrace,
    List<ClaimVerdictResult> claims,
    List<Degradation> degradations,
  });
}

/// @nodoc
class _$VerdictCopyWithImpl<$Res, $Val extends Verdict>
    implements $VerdictCopyWith<$Res> {
  _$VerdictCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Verdict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verdict = null,
    Object? confidence = null,
    Object? rationale = freezed,
    Object? reasoningTrace = freezed,
    Object? claims = null,
    Object? degradations = null,
  }) {
    return _then(
      _value.copyWith(
            verdict: null == verdict
                ? _value.verdict
                : verdict // ignore: cast_nullable_to_non_nullable
                      as ArticleVerdict,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            rationale: freezed == rationale
                ? _value.rationale
                : rationale // ignore: cast_nullable_to_non_nullable
                      as String?,
            reasoningTrace: freezed == reasoningTrace
                ? _value.reasoningTrace
                : reasoningTrace // ignore: cast_nullable_to_non_nullable
                      as String?,
            claims: null == claims
                ? _value.claims
                : claims // ignore: cast_nullable_to_non_nullable
                      as List<ClaimVerdictResult>,
            degradations: null == degradations
                ? _value.degradations
                : degradations // ignore: cast_nullable_to_non_nullable
                      as List<Degradation>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VerdictImplCopyWith<$Res> implements $VerdictCopyWith<$Res> {
  factory _$$VerdictImplCopyWith(
    _$VerdictImpl value,
    $Res Function(_$VerdictImpl) then,
  ) = __$$VerdictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ArticleVerdict verdict,
    double confidence,
    String? rationale,
    String? reasoningTrace,
    List<ClaimVerdictResult> claims,
    List<Degradation> degradations,
  });
}

/// @nodoc
class __$$VerdictImplCopyWithImpl<$Res>
    extends _$VerdictCopyWithImpl<$Res, _$VerdictImpl>
    implements _$$VerdictImplCopyWith<$Res> {
  __$$VerdictImplCopyWithImpl(
    _$VerdictImpl _value,
    $Res Function(_$VerdictImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Verdict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verdict = null,
    Object? confidence = null,
    Object? rationale = freezed,
    Object? reasoningTrace = freezed,
    Object? claims = null,
    Object? degradations = null,
  }) {
    return _then(
      _$VerdictImpl(
        verdict: null == verdict
            ? _value.verdict
            : verdict // ignore: cast_nullable_to_non_nullable
                  as ArticleVerdict,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        rationale: freezed == rationale
            ? _value.rationale
            : rationale // ignore: cast_nullable_to_non_nullable
                  as String?,
        reasoningTrace: freezed == reasoningTrace
            ? _value.reasoningTrace
            : reasoningTrace // ignore: cast_nullable_to_non_nullable
                  as String?,
        claims: null == claims
            ? _value._claims
            : claims // ignore: cast_nullable_to_non_nullable
                  as List<ClaimVerdictResult>,
        degradations: null == degradations
            ? _value._degradations
            : degradations // ignore: cast_nullable_to_non_nullable
                  as List<Degradation>,
      ),
    );
  }
}

/// @nodoc

class _$VerdictImpl extends _Verdict {
  const _$VerdictImpl({
    required this.verdict,
    this.confidence = 0.0,
    this.rationale,
    this.reasoningTrace,
    final List<ClaimVerdictResult> claims = const <ClaimVerdictResult>[],
    final List<Degradation> degradations = const <Degradation>[],
  }) : _claims = claims,
       _degradations = degradations,
       super._();

  @override
  final ArticleVerdict verdict;
  @override
  @JsonKey()
  final double confidence;
  @override
  final String? rationale;

  /// Plain-text explanation, including each claim's `ORIGIN TRAIL`.
  @override
  final String? reasoningTrace;
  final List<ClaimVerdictResult> _claims;
  @override
  @JsonKey()
  List<ClaimVerdictResult> get claims {
    if (_claims is EqualUnmodifiableListView) return _claims;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_claims);
  }

  final List<Degradation> _degradations;
  @override
  @JsonKey()
  List<Degradation> get degradations {
    if (_degradations is EqualUnmodifiableListView) return _degradations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_degradations);
  }

  @override
  String toString() {
    return 'Verdict(verdict: $verdict, confidence: $confidence, rationale: $rationale, reasoningTrace: $reasoningTrace, claims: $claims, degradations: $degradations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerdictImpl &&
            (identical(other.verdict, verdict) || other.verdict == verdict) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.rationale, rationale) ||
                other.rationale == rationale) &&
            (identical(other.reasoningTrace, reasoningTrace) ||
                other.reasoningTrace == reasoningTrace) &&
            const DeepCollectionEquality().equals(other._claims, _claims) &&
            const DeepCollectionEquality().equals(
              other._degradations,
              _degradations,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    verdict,
    confidence,
    rationale,
    reasoningTrace,
    const DeepCollectionEquality().hash(_claims),
    const DeepCollectionEquality().hash(_degradations),
  );

  /// Create a copy of Verdict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerdictImplCopyWith<_$VerdictImpl> get copyWith =>
      __$$VerdictImplCopyWithImpl<_$VerdictImpl>(this, _$identity);
}

abstract class _Verdict extends Verdict {
  const factory _Verdict({
    required final ArticleVerdict verdict,
    final double confidence,
    final String? rationale,
    final String? reasoningTrace,
    final List<ClaimVerdictResult> claims,
    final List<Degradation> degradations,
  }) = _$VerdictImpl;
  const _Verdict._() : super._();

  @override
  ArticleVerdict get verdict;
  @override
  double get confidence;
  @override
  String? get rationale;

  /// Plain-text explanation, including each claim's `ORIGIN TRAIL`.
  @override
  String? get reasoningTrace;
  @override
  List<ClaimVerdictResult> get claims;
  @override
  List<Degradation> get degradations;

  /// Create a copy of Verdict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerdictImplCopyWith<_$VerdictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Article {
  String get id => throw _privateConstructorUsedError;
  ArticleStatus get status => throw _privateConstructorUsedError;
  ArticleStage get stage => throw _privateConstructorUsedError;
  String? get textPreview => throw _privateConstructorUsedError;
  DateTime? get submittedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  Verdict? get verdict => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call({
    String id,
    ArticleStatus status,
    ArticleStage stage,
    String? textPreview,
    DateTime? submittedAt,
    DateTime? completedAt,
    Verdict? verdict,
    String? error,
  });

  $VerdictCopyWith<$Res>? get verdict;
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? stage = null,
    Object? textPreview = freezed,
    Object? submittedAt = freezed,
    Object? completedAt = freezed,
    Object? verdict = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ArticleStatus,
            stage: null == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as ArticleStage,
            textPreview: freezed == textPreview
                ? _value.textPreview
                : textPreview // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedAt: freezed == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            verdict: freezed == verdict
                ? _value.verdict
                : verdict // ignore: cast_nullable_to_non_nullable
                      as Verdict?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerdictCopyWith<$Res>? get verdict {
    if (_value.verdict == null) {
      return null;
    }

    return $VerdictCopyWith<$Res>(_value.verdict!, (value) {
      return _then(_value.copyWith(verdict: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
    _$ArticleImpl value,
    $Res Function(_$ArticleImpl) then,
  ) = __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ArticleStatus status,
    ArticleStage stage,
    String? textPreview,
    DateTime? submittedAt,
    DateTime? completedAt,
    Verdict? verdict,
    String? error,
  });

  @override
  $VerdictCopyWith<$Res>? get verdict;
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
    _$ArticleImpl _value,
    $Res Function(_$ArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? stage = null,
    Object? textPreview = freezed,
    Object? submittedAt = freezed,
    Object? completedAt = freezed,
    Object? verdict = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$ArticleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ArticleStatus,
        stage: null == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as ArticleStage,
        textPreview: freezed == textPreview
            ? _value.textPreview
            : textPreview // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: freezed == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        verdict: freezed == verdict
            ? _value.verdict
            : verdict // ignore: cast_nullable_to_non_nullable
                  as Verdict?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ArticleImpl extends _Article {
  const _$ArticleImpl({
    required this.id,
    required this.status,
    required this.stage,
    this.textPreview,
    this.submittedAt,
    this.completedAt,
    this.verdict,
    this.error,
  }) : super._();

  @override
  final String id;
  @override
  final ArticleStatus status;
  @override
  final ArticleStage stage;
  @override
  final String? textPreview;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? completedAt;
  @override
  final Verdict? verdict;
  @override
  final String? error;

  @override
  String toString() {
    return 'Article(id: $id, status: $status, stage: $stage, textPreview: $textPreview, submittedAt: $submittedAt, completedAt: $completedAt, verdict: $verdict, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.textPreview, textPreview) ||
                other.textPreview == textPreview) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.verdict, verdict) || other.verdict == verdict) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    status,
    stage,
    textPreview,
    submittedAt,
    completedAt,
    verdict,
    error,
  );

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);
}

abstract class _Article extends Article {
  const factory _Article({
    required final String id,
    required final ArticleStatus status,
    required final ArticleStage stage,
    final String? textPreview,
    final DateTime? submittedAt,
    final DateTime? completedAt,
    final Verdict? verdict,
    final String? error,
  }) = _$ArticleImpl;
  const _Article._() : super._();

  @override
  String get id;
  @override
  ArticleStatus get status;
  @override
  ArticleStage get stage;
  @override
  String? get textPreview;
  @override
  DateTime? get submittedAt;
  @override
  DateTime? get completedAt;
  @override
  Verdict? get verdict;
  @override
  String? get error;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
