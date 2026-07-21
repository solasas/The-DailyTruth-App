// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'benchmark_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BenchmarkResult {
  String get modelName => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  double get f1Score => throw _privateConstructorUsedError;
  double get precision => throw _privateConstructorUsedError;
  double get recall => throw _privateConstructorUsedError;
  double get auc => throw _privateConstructorUsedError;

  /// Null when unavailable (e.g. derived from the [isFallback] path,
  /// which has no training-time data).
  double? get trainingTimeSeconds => throw _privateConstructorUsedError;

  /// 1-based rank, assigned client-side after sorting by accuracy.
  int get rank => throw _privateConstructorUsedError;

  /// True when this row was derived client-side from `GET /models`
  /// because `GET /results` was unavailable — see
  /// `benchmarkOrFallbackProvider`.
  bool get isFallback => throw _privateConstructorUsedError;

  /// Create a copy of BenchmarkResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BenchmarkResultCopyWith<BenchmarkResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BenchmarkResultCopyWith<$Res> {
  factory $BenchmarkResultCopyWith(
    BenchmarkResult value,
    $Res Function(BenchmarkResult) then,
  ) = _$BenchmarkResultCopyWithImpl<$Res, BenchmarkResult>;
  @useResult
  $Res call({
    String modelName,
    String displayName,
    String category,
    double accuracy,
    double f1Score,
    double precision,
    double recall,
    double auc,
    double? trainingTimeSeconds,
    int rank,
    bool isFallback,
  });
}

/// @nodoc
class _$BenchmarkResultCopyWithImpl<$Res, $Val extends BenchmarkResult>
    implements $BenchmarkResultCopyWith<$Res> {
  _$BenchmarkResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BenchmarkResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? displayName = null,
    Object? category = null,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? trainingTimeSeconds = freezed,
    Object? rank = null,
    Object? isFallback = null,
  }) {
    return _then(
      _value.copyWith(
            modelName: null == modelName
                ? _value.modelName
                : modelName // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            accuracy: null == accuracy
                ? _value.accuracy
                : accuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            f1Score: null == f1Score
                ? _value.f1Score
                : f1Score // ignore: cast_nullable_to_non_nullable
                      as double,
            precision: null == precision
                ? _value.precision
                : precision // ignore: cast_nullable_to_non_nullable
                      as double,
            recall: null == recall
                ? _value.recall
                : recall // ignore: cast_nullable_to_non_nullable
                      as double,
            auc: null == auc
                ? _value.auc
                : auc // ignore: cast_nullable_to_non_nullable
                      as double,
            trainingTimeSeconds: freezed == trainingTimeSeconds
                ? _value.trainingTimeSeconds
                : trainingTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as double?,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            isFallback: null == isFallback
                ? _value.isFallback
                : isFallback // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BenchmarkResultImplCopyWith<$Res>
    implements $BenchmarkResultCopyWith<$Res> {
  factory _$$BenchmarkResultImplCopyWith(
    _$BenchmarkResultImpl value,
    $Res Function(_$BenchmarkResultImpl) then,
  ) = __$$BenchmarkResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String modelName,
    String displayName,
    String category,
    double accuracy,
    double f1Score,
    double precision,
    double recall,
    double auc,
    double? trainingTimeSeconds,
    int rank,
    bool isFallback,
  });
}

/// @nodoc
class __$$BenchmarkResultImplCopyWithImpl<$Res>
    extends _$BenchmarkResultCopyWithImpl<$Res, _$BenchmarkResultImpl>
    implements _$$BenchmarkResultImplCopyWith<$Res> {
  __$$BenchmarkResultImplCopyWithImpl(
    _$BenchmarkResultImpl _value,
    $Res Function(_$BenchmarkResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BenchmarkResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? displayName = null,
    Object? category = null,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? trainingTimeSeconds = freezed,
    Object? rank = null,
    Object? isFallback = null,
  }) {
    return _then(
      _$BenchmarkResultImpl(
        modelName: null == modelName
            ? _value.modelName
            : modelName // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        accuracy: null == accuracy
            ? _value.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        f1Score: null == f1Score
            ? _value.f1Score
            : f1Score // ignore: cast_nullable_to_non_nullable
                  as double,
        precision: null == precision
            ? _value.precision
            : precision // ignore: cast_nullable_to_non_nullable
                  as double,
        recall: null == recall
            ? _value.recall
            : recall // ignore: cast_nullable_to_non_nullable
                  as double,
        auc: null == auc
            ? _value.auc
            : auc // ignore: cast_nullable_to_non_nullable
                  as double,
        trainingTimeSeconds: freezed == trainingTimeSeconds
            ? _value.trainingTimeSeconds
            : trainingTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as double?,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        isFallback: null == isFallback
            ? _value.isFallback
            : isFallback // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$BenchmarkResultImpl implements _BenchmarkResult {
  const _$BenchmarkResultImpl({
    required this.modelName,
    required this.displayName,
    required this.category,
    required this.accuracy,
    required this.f1Score,
    required this.precision,
    required this.recall,
    required this.auc,
    this.trainingTimeSeconds,
    this.rank = 0,
    this.isFallback = false,
  });

  @override
  final String modelName;
  @override
  final String displayName;
  @override
  final String category;
  @override
  final double accuracy;
  @override
  final double f1Score;
  @override
  final double precision;
  @override
  final double recall;
  @override
  final double auc;

  /// Null when unavailable (e.g. derived from the [isFallback] path,
  /// which has no training-time data).
  @override
  final double? trainingTimeSeconds;

  /// 1-based rank, assigned client-side after sorting by accuracy.
  @override
  @JsonKey()
  final int rank;

  /// True when this row was derived client-side from `GET /models`
  /// because `GET /results` was unavailable — see
  /// `benchmarkOrFallbackProvider`.
  @override
  @JsonKey()
  final bool isFallback;

  @override
  String toString() {
    return 'BenchmarkResult(modelName: $modelName, displayName: $displayName, category: $category, accuracy: $accuracy, f1Score: $f1Score, precision: $precision, recall: $recall, auc: $auc, trainingTimeSeconds: $trainingTimeSeconds, rank: $rank, isFallback: $isFallback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BenchmarkResultImpl &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.auc, auc) || other.auc == auc) &&
            (identical(other.trainingTimeSeconds, trainingTimeSeconds) ||
                other.trainingTimeSeconds == trainingTimeSeconds) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.isFallback, isFallback) ||
                other.isFallback == isFallback));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    modelName,
    displayName,
    category,
    accuracy,
    f1Score,
    precision,
    recall,
    auc,
    trainingTimeSeconds,
    rank,
    isFallback,
  );

  /// Create a copy of BenchmarkResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BenchmarkResultImplCopyWith<_$BenchmarkResultImpl> get copyWith =>
      __$$BenchmarkResultImplCopyWithImpl<_$BenchmarkResultImpl>(
        this,
        _$identity,
      );
}

abstract class _BenchmarkResult implements BenchmarkResult {
  const factory _BenchmarkResult({
    required final String modelName,
    required final String displayName,
    required final String category,
    required final double accuracy,
    required final double f1Score,
    required final double precision,
    required final double recall,
    required final double auc,
    final double? trainingTimeSeconds,
    final int rank,
    final bool isFallback,
  }) = _$BenchmarkResultImpl;

  @override
  String get modelName;
  @override
  String get displayName;
  @override
  String get category;
  @override
  double get accuracy;
  @override
  double get f1Score;
  @override
  double get precision;
  @override
  double get recall;
  @override
  double get auc;

  /// Null when unavailable (e.g. derived from the [isFallback] path,
  /// which has no training-time data).
  @override
  double? get trainingTimeSeconds;

  /// 1-based rank, assigned client-side after sorting by accuracy.
  @override
  int get rank;

  /// True when this row was derived client-side from `GET /models`
  /// because `GET /results` was unavailable — see
  /// `benchmarkOrFallbackProvider`.
  @override
  bool get isFallback;

  /// Create a copy of BenchmarkResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BenchmarkResultImplCopyWith<_$BenchmarkResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
