// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_models_prediction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AllModelsPredictionDto _$AllModelsPredictionDtoFromJson(
  Map<String, dynamic> json,
) {
  return _AllModelsPredictionDto.fromJson(json);
}

/// @nodoc
mixin _$AllModelsPredictionDto {
  ConsensusDto get consensus => throw _privateConstructorUsedError;
  List<PredictionResultDto> get results => throw _privateConstructorUsedError;

  /// Serializes this AllModelsPredictionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllModelsPredictionDtoCopyWith<AllModelsPredictionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllModelsPredictionDtoCopyWith<$Res> {
  factory $AllModelsPredictionDtoCopyWith(
    AllModelsPredictionDto value,
    $Res Function(AllModelsPredictionDto) then,
  ) = _$AllModelsPredictionDtoCopyWithImpl<$Res, AllModelsPredictionDto>;
  @useResult
  $Res call({ConsensusDto consensus, List<PredictionResultDto> results});

  $ConsensusDtoCopyWith<$Res> get consensus;
}

/// @nodoc
class _$AllModelsPredictionDtoCopyWithImpl<
  $Res,
  $Val extends AllModelsPredictionDto
>
    implements $AllModelsPredictionDtoCopyWith<$Res> {
  _$AllModelsPredictionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? consensus = null, Object? results = null}) {
    return _then(
      _value.copyWith(
            consensus: null == consensus
                ? _value.consensus
                : consensus // ignore: cast_nullable_to_non_nullable
                      as ConsensusDto,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<PredictionResultDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConsensusDtoCopyWith<$Res> get consensus {
    return $ConsensusDtoCopyWith<$Res>(_value.consensus, (value) {
      return _then(_value.copyWith(consensus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AllModelsPredictionDtoImplCopyWith<$Res>
    implements $AllModelsPredictionDtoCopyWith<$Res> {
  factory _$$AllModelsPredictionDtoImplCopyWith(
    _$AllModelsPredictionDtoImpl value,
    $Res Function(_$AllModelsPredictionDtoImpl) then,
  ) = __$$AllModelsPredictionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConsensusDto consensus, List<PredictionResultDto> results});

  @override
  $ConsensusDtoCopyWith<$Res> get consensus;
}

/// @nodoc
class __$$AllModelsPredictionDtoImplCopyWithImpl<$Res>
    extends
        _$AllModelsPredictionDtoCopyWithImpl<$Res, _$AllModelsPredictionDtoImpl>
    implements _$$AllModelsPredictionDtoImplCopyWith<$Res> {
  __$$AllModelsPredictionDtoImplCopyWithImpl(
    _$AllModelsPredictionDtoImpl _value,
    $Res Function(_$AllModelsPredictionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? consensus = null, Object? results = null}) {
    return _then(
      _$AllModelsPredictionDtoImpl(
        consensus: null == consensus
            ? _value.consensus
            : consensus // ignore: cast_nullable_to_non_nullable
                  as ConsensusDto,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<PredictionResultDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AllModelsPredictionDtoImpl extends _AllModelsPredictionDto {
  const _$AllModelsPredictionDtoImpl({
    required this.consensus,
    final List<PredictionResultDto> results = const [],
  }) : _results = results,
       super._();

  factory _$AllModelsPredictionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllModelsPredictionDtoImplFromJson(json);

  @override
  final ConsensusDto consensus;
  final List<PredictionResultDto> _results;
  @override
  @JsonKey()
  List<PredictionResultDto> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'AllModelsPredictionDto(consensus: $consensus, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllModelsPredictionDtoImpl &&
            (identical(other.consensus, consensus) ||
                other.consensus == consensus) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    consensus,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllModelsPredictionDtoImplCopyWith<_$AllModelsPredictionDtoImpl>
  get copyWith =>
      __$$AllModelsPredictionDtoImplCopyWithImpl<_$AllModelsPredictionDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AllModelsPredictionDtoImplToJson(this);
  }
}

abstract class _AllModelsPredictionDto extends AllModelsPredictionDto {
  const factory _AllModelsPredictionDto({
    required final ConsensusDto consensus,
    final List<PredictionResultDto> results,
  }) = _$AllModelsPredictionDtoImpl;
  const _AllModelsPredictionDto._() : super._();

  factory _AllModelsPredictionDto.fromJson(Map<String, dynamic> json) =
      _$AllModelsPredictionDtoImpl.fromJson;

  @override
  ConsensusDto get consensus;
  @override
  List<PredictionResultDto> get results;

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllModelsPredictionDtoImplCopyWith<_$AllModelsPredictionDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ConsensusDto _$ConsensusDtoFromJson(Map<String, dynamic> json) {
  return _ConsensusDto.fromJson(json);
}

/// @nodoc
mixin _$ConsensusDto {
  String get prediction => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get confidence => throw _privateConstructorUsedError;

  /// Serializes this ConsensusDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsensusDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsensusDtoCopyWith<ConsensusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsensusDtoCopyWith<$Res> {
  factory $ConsensusDtoCopyWith(
    ConsensusDto value,
    $Res Function(ConsensusDto) then,
  ) = _$ConsensusDtoCopyWithImpl<$Res, ConsensusDto>;
  @useResult
  $Res call({
    String prediction,
    @JsonKey(fromJson: _toDouble) double confidence,
  });
}

/// @nodoc
class _$ConsensusDtoCopyWithImpl<$Res, $Val extends ConsensusDto>
    implements $ConsensusDtoCopyWith<$Res> {
  _$ConsensusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsensusDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? prediction = null, Object? confidence = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsensusDtoImplCopyWith<$Res>
    implements $ConsensusDtoCopyWith<$Res> {
  factory _$$ConsensusDtoImplCopyWith(
    _$ConsensusDtoImpl value,
    $Res Function(_$ConsensusDtoImpl) then,
  ) = __$$ConsensusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String prediction,
    @JsonKey(fromJson: _toDouble) double confidence,
  });
}

/// @nodoc
class __$$ConsensusDtoImplCopyWithImpl<$Res>
    extends _$ConsensusDtoCopyWithImpl<$Res, _$ConsensusDtoImpl>
    implements _$$ConsensusDtoImplCopyWith<$Res> {
  __$$ConsensusDtoImplCopyWithImpl(
    _$ConsensusDtoImpl _value,
    $Res Function(_$ConsensusDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsensusDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? prediction = null, Object? confidence = null}) {
    return _then(
      _$ConsensusDtoImpl(
        prediction: null == prediction
            ? _value.prediction
            : prediction // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsensusDtoImpl implements _ConsensusDto {
  const _$ConsensusDtoImpl({
    required this.prediction,
    @JsonKey(fromJson: _toDouble) this.confidence = 0.0,
  });

  factory _$ConsensusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsensusDtoImplFromJson(json);

  @override
  final String prediction;
  @override
  @JsonKey(fromJson: _toDouble)
  final double confidence;

  @override
  String toString() {
    return 'ConsensusDto(prediction: $prediction, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsensusDtoImpl &&
            (identical(other.prediction, prediction) ||
                other.prediction == prediction) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, prediction, confidence);

  /// Create a copy of ConsensusDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsensusDtoImplCopyWith<_$ConsensusDtoImpl> get copyWith =>
      __$$ConsensusDtoImplCopyWithImpl<_$ConsensusDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsensusDtoImplToJson(this);
  }
}

abstract class _ConsensusDto implements ConsensusDto {
  const factory _ConsensusDto({
    required final String prediction,
    @JsonKey(fromJson: _toDouble) final double confidence,
  }) = _$ConsensusDtoImpl;

  factory _ConsensusDto.fromJson(Map<String, dynamic> json) =
      _$ConsensusDtoImpl.fromJson;

  @override
  String get prediction;
  @override
  @JsonKey(fromJson: _toDouble)
  double get confidence;

  /// Create a copy of ConsensusDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsensusDtoImplCopyWith<_$ConsensusDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
