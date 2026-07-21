// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_result_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PredictionResultDto _$PredictionResultDtoFromJson(Map<String, dynamic> json) {
  return _PredictionResultDto.fromJson(json);
}

/// @nodoc
mixin _$PredictionResultDto {
  String get prediction => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get confidence => throw _privateConstructorUsedError;
  @JsonKey(name: 'fake_probability', fromJson: _toDouble)
  double get fakeProbability => throw _privateConstructorUsedError;
  @JsonKey(name: 'real_probability', fromJson: _toDouble)
  double get realProbability => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_name')
  String get modelName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  /// Serializes this PredictionResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PredictionResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictionResultDtoCopyWith<PredictionResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionResultDtoCopyWith<$Res> {
  factory $PredictionResultDtoCopyWith(
    PredictionResultDto value,
    $Res Function(PredictionResultDto) then,
  ) = _$PredictionResultDtoCopyWithImpl<$Res, PredictionResultDto>;
  @useResult
  $Res call({
    String prediction,
    @JsonKey(fromJson: _toDouble) double confidence,
    @JsonKey(name: 'fake_probability', fromJson: _toDouble)
    double fakeProbability,
    @JsonKey(name: 'real_probability', fromJson: _toDouble)
    double realProbability,
    @JsonKey(name: 'model_name') String modelName,
    String category,
  });
}

/// @nodoc
class _$PredictionResultDtoCopyWithImpl<$Res, $Val extends PredictionResultDto>
    implements $PredictionResultDtoCopyWith<$Res> {
  _$PredictionResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictionResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prediction = null,
    Object? confidence = null,
    Object? fakeProbability = null,
    Object? realProbability = null,
    Object? modelName = null,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            prediction: null == prediction
                ? _value.prediction
                : prediction // ignore: cast_nullable_to_non_nullable
                      as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            fakeProbability: null == fakeProbability
                ? _value.fakeProbability
                : fakeProbability // ignore: cast_nullable_to_non_nullable
                      as double,
            realProbability: null == realProbability
                ? _value.realProbability
                : realProbability // ignore: cast_nullable_to_non_nullable
                      as double,
            modelName: null == modelName
                ? _value.modelName
                : modelName // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PredictionResultDtoImplCopyWith<$Res>
    implements $PredictionResultDtoCopyWith<$Res> {
  factory _$$PredictionResultDtoImplCopyWith(
    _$PredictionResultDtoImpl value,
    $Res Function(_$PredictionResultDtoImpl) then,
  ) = __$$PredictionResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String prediction,
    @JsonKey(fromJson: _toDouble) double confidence,
    @JsonKey(name: 'fake_probability', fromJson: _toDouble)
    double fakeProbability,
    @JsonKey(name: 'real_probability', fromJson: _toDouble)
    double realProbability,
    @JsonKey(name: 'model_name') String modelName,
    String category,
  });
}

/// @nodoc
class __$$PredictionResultDtoImplCopyWithImpl<$Res>
    extends _$PredictionResultDtoCopyWithImpl<$Res, _$PredictionResultDtoImpl>
    implements _$$PredictionResultDtoImplCopyWith<$Res> {
  __$$PredictionResultDtoImplCopyWithImpl(
    _$PredictionResultDtoImpl _value,
    $Res Function(_$PredictionResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PredictionResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prediction = null,
    Object? confidence = null,
    Object? fakeProbability = null,
    Object? realProbability = null,
    Object? modelName = null,
    Object? category = null,
  }) {
    return _then(
      _$PredictionResultDtoImpl(
        prediction: null == prediction
            ? _value.prediction
            : prediction // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        fakeProbability: null == fakeProbability
            ? _value.fakeProbability
            : fakeProbability // ignore: cast_nullable_to_non_nullable
                  as double,
        realProbability: null == realProbability
            ? _value.realProbability
            : realProbability // ignore: cast_nullable_to_non_nullable
                  as double,
        modelName: null == modelName
            ? _value.modelName
            : modelName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictionResultDtoImpl extends _PredictionResultDto {
  const _$PredictionResultDtoImpl({
    required this.prediction,
    @JsonKey(fromJson: _toDouble) this.confidence = 0.0,
    @JsonKey(name: 'fake_probability', fromJson: _toDouble)
    this.fakeProbability = 0.0,
    @JsonKey(name: 'real_probability', fromJson: _toDouble)
    this.realProbability = 0.0,
    @JsonKey(name: 'model_name') this.modelName = '',
    this.category = '',
  }) : super._();

  factory _$PredictionResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictionResultDtoImplFromJson(json);

  @override
  final String prediction;
  @override
  @JsonKey(fromJson: _toDouble)
  final double confidence;
  @override
  @JsonKey(name: 'fake_probability', fromJson: _toDouble)
  final double fakeProbability;
  @override
  @JsonKey(name: 'real_probability', fromJson: _toDouble)
  final double realProbability;
  @override
  @JsonKey(name: 'model_name')
  final String modelName;
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'PredictionResultDto(prediction: $prediction, confidence: $confidence, fakeProbability: $fakeProbability, realProbability: $realProbability, modelName: $modelName, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionResultDtoImpl &&
            (identical(other.prediction, prediction) ||
                other.prediction == prediction) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.fakeProbability, fakeProbability) ||
                other.fakeProbability == fakeProbability) &&
            (identical(other.realProbability, realProbability) ||
                other.realProbability == realProbability) &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    prediction,
    confidence,
    fakeProbability,
    realProbability,
    modelName,
    category,
  );

  /// Create a copy of PredictionResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionResultDtoImplCopyWith<_$PredictionResultDtoImpl> get copyWith =>
      __$$PredictionResultDtoImplCopyWithImpl<_$PredictionResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictionResultDtoImplToJson(this);
  }
}

abstract class _PredictionResultDto extends PredictionResultDto {
  const factory _PredictionResultDto({
    required final String prediction,
    @JsonKey(fromJson: _toDouble) final double confidence,
    @JsonKey(name: 'fake_probability', fromJson: _toDouble)
    final double fakeProbability,
    @JsonKey(name: 'real_probability', fromJson: _toDouble)
    final double realProbability,
    @JsonKey(name: 'model_name') final String modelName,
    final String category,
  }) = _$PredictionResultDtoImpl;
  const _PredictionResultDto._() : super._();

  factory _PredictionResultDto.fromJson(Map<String, dynamic> json) =
      _$PredictionResultDtoImpl.fromJson;

  @override
  String get prediction;
  @override
  @JsonKey(fromJson: _toDouble)
  double get confidence;
  @override
  @JsonKey(name: 'fake_probability', fromJson: _toDouble)
  double get fakeProbability;
  @override
  @JsonKey(name: 'real_probability', fromJson: _toDouble)
  double get realProbability;
  @override
  @JsonKey(name: 'model_name')
  String get modelName;
  @override
  String get category;

  /// Create a copy of PredictionResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionResultDtoImplCopyWith<_$PredictionResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
