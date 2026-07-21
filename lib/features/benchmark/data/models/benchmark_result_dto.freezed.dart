// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'benchmark_result_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BenchmarkResultDto _$BenchmarkResultDtoFromJson(Map<String, dynamic> json) {
  return _BenchmarkResultDto.fromJson(json);
}

/// @nodoc
mixin _$BenchmarkResultDto {
  @JsonKey(name: 'model_name')
  String get modelName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get accuracy => throw _privateConstructorUsedError;
  @JsonKey(name: 'f1_score', fromJson: _toDouble)
  double get f1Score => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get precision => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get recall => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get auc => throw _privateConstructorUsedError;
  @JsonKey(name: 'training_time', fromJson: _toDouble)
  double get trainingTime => throw _privateConstructorUsedError;

  /// Serializes this BenchmarkResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BenchmarkResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BenchmarkResultDtoCopyWith<BenchmarkResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BenchmarkResultDtoCopyWith<$Res> {
  factory $BenchmarkResultDtoCopyWith(
    BenchmarkResultDto value,
    $Res Function(BenchmarkResultDto) then,
  ) = _$BenchmarkResultDtoCopyWithImpl<$Res, BenchmarkResultDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'model_name') String modelName,
    String category,
    @JsonKey(fromJson: _toDouble) double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) double f1Score,
    @JsonKey(fromJson: _toDouble) double precision,
    @JsonKey(fromJson: _toDouble) double recall,
    @JsonKey(fromJson: _toDouble) double auc,
    @JsonKey(name: 'training_time', fromJson: _toDouble) double trainingTime,
  });
}

/// @nodoc
class _$BenchmarkResultDtoCopyWithImpl<$Res, $Val extends BenchmarkResultDto>
    implements $BenchmarkResultDtoCopyWith<$Res> {
  _$BenchmarkResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BenchmarkResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? category = null,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? trainingTime = null,
  }) {
    return _then(
      _value.copyWith(
            modelName: null == modelName
                ? _value.modelName
                : modelName // ignore: cast_nullable_to_non_nullable
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
            trainingTime: null == trainingTime
                ? _value.trainingTime
                : trainingTime // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BenchmarkResultDtoImplCopyWith<$Res>
    implements $BenchmarkResultDtoCopyWith<$Res> {
  factory _$$BenchmarkResultDtoImplCopyWith(
    _$BenchmarkResultDtoImpl value,
    $Res Function(_$BenchmarkResultDtoImpl) then,
  ) = __$$BenchmarkResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'model_name') String modelName,
    String category,
    @JsonKey(fromJson: _toDouble) double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) double f1Score,
    @JsonKey(fromJson: _toDouble) double precision,
    @JsonKey(fromJson: _toDouble) double recall,
    @JsonKey(fromJson: _toDouble) double auc,
    @JsonKey(name: 'training_time', fromJson: _toDouble) double trainingTime,
  });
}

/// @nodoc
class __$$BenchmarkResultDtoImplCopyWithImpl<$Res>
    extends _$BenchmarkResultDtoCopyWithImpl<$Res, _$BenchmarkResultDtoImpl>
    implements _$$BenchmarkResultDtoImplCopyWith<$Res> {
  __$$BenchmarkResultDtoImplCopyWithImpl(
    _$BenchmarkResultDtoImpl _value,
    $Res Function(_$BenchmarkResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BenchmarkResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? category = null,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? trainingTime = null,
  }) {
    return _then(
      _$BenchmarkResultDtoImpl(
        modelName: null == modelName
            ? _value.modelName
            : modelName // ignore: cast_nullable_to_non_nullable
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
        trainingTime: null == trainingTime
            ? _value.trainingTime
            : trainingTime // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BenchmarkResultDtoImpl extends _BenchmarkResultDto {
  const _$BenchmarkResultDtoImpl({
    @JsonKey(name: 'model_name') required this.modelName,
    required this.category,
    @JsonKey(fromJson: _toDouble) this.accuracy = 0.0,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) this.f1Score = 0.0,
    @JsonKey(fromJson: _toDouble) this.precision = 0.0,
    @JsonKey(fromJson: _toDouble) this.recall = 0.0,
    @JsonKey(fromJson: _toDouble) this.auc = 0.0,
    @JsonKey(name: 'training_time', fromJson: _toDouble)
    this.trainingTime = 0.0,
  }) : super._();

  factory _$BenchmarkResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BenchmarkResultDtoImplFromJson(json);

  @override
  @JsonKey(name: 'model_name')
  final String modelName;
  @override
  final String category;
  @override
  @JsonKey(fromJson: _toDouble)
  final double accuracy;
  @override
  @JsonKey(name: 'f1_score', fromJson: _toDouble)
  final double f1Score;
  @override
  @JsonKey(fromJson: _toDouble)
  final double precision;
  @override
  @JsonKey(fromJson: _toDouble)
  final double recall;
  @override
  @JsonKey(fromJson: _toDouble)
  final double auc;
  @override
  @JsonKey(name: 'training_time', fromJson: _toDouble)
  final double trainingTime;

  @override
  String toString() {
    return 'BenchmarkResultDto(modelName: $modelName, category: $category, accuracy: $accuracy, f1Score: $f1Score, precision: $precision, recall: $recall, auc: $auc, trainingTime: $trainingTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BenchmarkResultDtoImpl &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.auc, auc) || other.auc == auc) &&
            (identical(other.trainingTime, trainingTime) ||
                other.trainingTime == trainingTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    modelName,
    category,
    accuracy,
    f1Score,
    precision,
    recall,
    auc,
    trainingTime,
  );

  /// Create a copy of BenchmarkResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BenchmarkResultDtoImplCopyWith<_$BenchmarkResultDtoImpl> get copyWith =>
      __$$BenchmarkResultDtoImplCopyWithImpl<_$BenchmarkResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BenchmarkResultDtoImplToJson(this);
  }
}

abstract class _BenchmarkResultDto extends BenchmarkResultDto {
  const factory _BenchmarkResultDto({
    @JsonKey(name: 'model_name') required final String modelName,
    required final String category,
    @JsonKey(fromJson: _toDouble) final double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) final double f1Score,
    @JsonKey(fromJson: _toDouble) final double precision,
    @JsonKey(fromJson: _toDouble) final double recall,
    @JsonKey(fromJson: _toDouble) final double auc,
    @JsonKey(name: 'training_time', fromJson: _toDouble)
    final double trainingTime,
  }) = _$BenchmarkResultDtoImpl;
  const _BenchmarkResultDto._() : super._();

  factory _BenchmarkResultDto.fromJson(Map<String, dynamic> json) =
      _$BenchmarkResultDtoImpl.fromJson;

  @override
  @JsonKey(name: 'model_name')
  String get modelName;
  @override
  String get category;
  @override
  @JsonKey(fromJson: _toDouble)
  double get accuracy;
  @override
  @JsonKey(name: 'f1_score', fromJson: _toDouble)
  double get f1Score;
  @override
  @JsonKey(fromJson: _toDouble)
  double get precision;
  @override
  @JsonKey(fromJson: _toDouble)
  double get recall;
  @override
  @JsonKey(fromJson: _toDouble)
  double get auc;
  @override
  @JsonKey(name: 'training_time', fromJson: _toDouble)
  double get trainingTime;

  /// Create a copy of BenchmarkResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BenchmarkResultDtoImplCopyWith<_$BenchmarkResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
