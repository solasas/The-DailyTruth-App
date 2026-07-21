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

/// @nodoc
mixin _$AllModelsPredictionDto {
  String get consensus => throw _privateConstructorUsedError;
  double get consensusConfidence => throw _privateConstructorUsedError;
  List<PredictionResultDto> get results => throw _privateConstructorUsedError;

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
  $Res call({
    String consensus,
    double consensusConfidence,
    List<PredictionResultDto> results,
  });
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
  $Res call({
    Object? consensus = null,
    Object? consensusConfidence = null,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            consensus: null == consensus
                ? _value.consensus
                : consensus // ignore: cast_nullable_to_non_nullable
                      as String,
            consensusConfidence: null == consensusConfidence
                ? _value.consensusConfidence
                : consensusConfidence // ignore: cast_nullable_to_non_nullable
                      as double,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<PredictionResultDto>,
          )
          as $Val,
    );
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
  $Res call({
    String consensus,
    double consensusConfidence,
    List<PredictionResultDto> results,
  });
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
  $Res call({
    Object? consensus = null,
    Object? consensusConfidence = null,
    Object? results = null,
  }) {
    return _then(
      _$AllModelsPredictionDtoImpl(
        consensus: null == consensus
            ? _value.consensus
            : consensus // ignore: cast_nullable_to_non_nullable
                  as String,
        consensusConfidence: null == consensusConfidence
            ? _value.consensusConfidence
            : consensusConfidence // ignore: cast_nullable_to_non_nullable
                  as double,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<PredictionResultDto>,
      ),
    );
  }
}

/// @nodoc

class _$AllModelsPredictionDtoImpl extends _AllModelsPredictionDto {
  const _$AllModelsPredictionDtoImpl({
    required this.consensus,
    this.consensusConfidence = 0.0,
    final List<PredictionResultDto> results = const [],
  }) : _results = results,
       super._();

  @override
  final String consensus;
  @override
  @JsonKey()
  final double consensusConfidence;
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
    return 'AllModelsPredictionDto(consensus: $consensus, consensusConfidence: $consensusConfidence, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllModelsPredictionDtoImpl &&
            (identical(other.consensus, consensus) ||
                other.consensus == consensus) &&
            (identical(other.consensusConfidence, consensusConfidence) ||
                other.consensusConfidence == consensusConfidence) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    consensus,
    consensusConfidence,
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
}

abstract class _AllModelsPredictionDto extends AllModelsPredictionDto {
  const factory _AllModelsPredictionDto({
    required final String consensus,
    final double consensusConfidence,
    final List<PredictionResultDto> results,
  }) = _$AllModelsPredictionDtoImpl;
  const _AllModelsPredictionDto._() : super._();

  @override
  String get consensus;
  @override
  double get consensusConfidence;
  @override
  List<PredictionResultDto> get results;

  /// Create a copy of AllModelsPredictionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllModelsPredictionDtoImplCopyWith<_$AllModelsPredictionDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
