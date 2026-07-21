// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_models_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AllModelsPrediction {
  PredictionLabel get consensusLabel => throw _privateConstructorUsedError;
  double get consensusConfidence => throw _privateConstructorUsedError;
  List<PredictionResult> get results => throw _privateConstructorUsedError;

  /// Create a copy of AllModelsPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllModelsPredictionCopyWith<AllModelsPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllModelsPredictionCopyWith<$Res> {
  factory $AllModelsPredictionCopyWith(
    AllModelsPrediction value,
    $Res Function(AllModelsPrediction) then,
  ) = _$AllModelsPredictionCopyWithImpl<$Res, AllModelsPrediction>;
  @useResult
  $Res call({
    PredictionLabel consensusLabel,
    double consensusConfidence,
    List<PredictionResult> results,
  });
}

/// @nodoc
class _$AllModelsPredictionCopyWithImpl<$Res, $Val extends AllModelsPrediction>
    implements $AllModelsPredictionCopyWith<$Res> {
  _$AllModelsPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllModelsPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consensusLabel = null,
    Object? consensusConfidence = null,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            consensusLabel: null == consensusLabel
                ? _value.consensusLabel
                : consensusLabel // ignore: cast_nullable_to_non_nullable
                      as PredictionLabel,
            consensusConfidence: null == consensusConfidence
                ? _value.consensusConfidence
                : consensusConfidence // ignore: cast_nullable_to_non_nullable
                      as double,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<PredictionResult>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AllModelsPredictionImplCopyWith<$Res>
    implements $AllModelsPredictionCopyWith<$Res> {
  factory _$$AllModelsPredictionImplCopyWith(
    _$AllModelsPredictionImpl value,
    $Res Function(_$AllModelsPredictionImpl) then,
  ) = __$$AllModelsPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PredictionLabel consensusLabel,
    double consensusConfidence,
    List<PredictionResult> results,
  });
}

/// @nodoc
class __$$AllModelsPredictionImplCopyWithImpl<$Res>
    extends _$AllModelsPredictionCopyWithImpl<$Res, _$AllModelsPredictionImpl>
    implements _$$AllModelsPredictionImplCopyWith<$Res> {
  __$$AllModelsPredictionImplCopyWithImpl(
    _$AllModelsPredictionImpl _value,
    $Res Function(_$AllModelsPredictionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AllModelsPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consensusLabel = null,
    Object? consensusConfidence = null,
    Object? results = null,
  }) {
    return _then(
      _$AllModelsPredictionImpl(
        consensusLabel: null == consensusLabel
            ? _value.consensusLabel
            : consensusLabel // ignore: cast_nullable_to_non_nullable
                  as PredictionLabel,
        consensusConfidence: null == consensusConfidence
            ? _value.consensusConfidence
            : consensusConfidence // ignore: cast_nullable_to_non_nullable
                  as double,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<PredictionResult>,
      ),
    );
  }
}

/// @nodoc

class _$AllModelsPredictionImpl implements _AllModelsPrediction {
  const _$AllModelsPredictionImpl({
    required this.consensusLabel,
    required this.consensusConfidence,
    required final List<PredictionResult> results,
  }) : _results = results;

  @override
  final PredictionLabel consensusLabel;
  @override
  final double consensusConfidence;
  final List<PredictionResult> _results;
  @override
  List<PredictionResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'AllModelsPrediction(consensusLabel: $consensusLabel, consensusConfidence: $consensusConfidence, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllModelsPredictionImpl &&
            (identical(other.consensusLabel, consensusLabel) ||
                other.consensusLabel == consensusLabel) &&
            (identical(other.consensusConfidence, consensusConfidence) ||
                other.consensusConfidence == consensusConfidence) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    consensusLabel,
    consensusConfidence,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of AllModelsPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllModelsPredictionImplCopyWith<_$AllModelsPredictionImpl> get copyWith =>
      __$$AllModelsPredictionImplCopyWithImpl<_$AllModelsPredictionImpl>(
        this,
        _$identity,
      );
}

abstract class _AllModelsPrediction implements AllModelsPrediction {
  const factory _AllModelsPrediction({
    required final PredictionLabel consensusLabel,
    required final double consensusConfidence,
    required final List<PredictionResult> results,
  }) = _$AllModelsPredictionImpl;

  @override
  PredictionLabel get consensusLabel;
  @override
  double get consensusConfidence;
  @override
  List<PredictionResult> get results;

  /// Create a copy of AllModelsPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllModelsPredictionImplCopyWith<_$AllModelsPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
