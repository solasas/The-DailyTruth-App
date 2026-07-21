// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PredictionResult {
  PredictionLabel get label => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  double get fakeProbability => throw _privateConstructorUsedError;
  double get realProbability => throw _privateConstructorUsedError;
  String get modelName => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  /// Create a copy of PredictionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictionResultCopyWith<PredictionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionResultCopyWith<$Res> {
  factory $PredictionResultCopyWith(
    PredictionResult value,
    $Res Function(PredictionResult) then,
  ) = _$PredictionResultCopyWithImpl<$Res, PredictionResult>;
  @useResult
  $Res call({
    PredictionLabel label,
    double confidence,
    double fakeProbability,
    double realProbability,
    String modelName,
    String displayName,
    String category,
  });
}

/// @nodoc
class _$PredictionResultCopyWithImpl<$Res, $Val extends PredictionResult>
    implements $PredictionResultCopyWith<$Res> {
  _$PredictionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? confidence = null,
    Object? fakeProbability = null,
    Object? realProbability = null,
    Object? modelName = null,
    Object? displayName = null,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as PredictionLabel,
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
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PredictionResultImplCopyWith<$Res>
    implements $PredictionResultCopyWith<$Res> {
  factory _$$PredictionResultImplCopyWith(
    _$PredictionResultImpl value,
    $Res Function(_$PredictionResultImpl) then,
  ) = __$$PredictionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PredictionLabel label,
    double confidence,
    double fakeProbability,
    double realProbability,
    String modelName,
    String displayName,
    String category,
  });
}

/// @nodoc
class __$$PredictionResultImplCopyWithImpl<$Res>
    extends _$PredictionResultCopyWithImpl<$Res, _$PredictionResultImpl>
    implements _$$PredictionResultImplCopyWith<$Res> {
  __$$PredictionResultImplCopyWithImpl(
    _$PredictionResultImpl _value,
    $Res Function(_$PredictionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PredictionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? confidence = null,
    Object? fakeProbability = null,
    Object? realProbability = null,
    Object? modelName = null,
    Object? displayName = null,
    Object? category = null,
  }) {
    return _then(
      _$PredictionResultImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as PredictionLabel,
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
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
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

class _$PredictionResultImpl implements _PredictionResult {
  const _$PredictionResultImpl({
    required this.label,
    required this.confidence,
    required this.fakeProbability,
    required this.realProbability,
    required this.modelName,
    required this.displayName,
    required this.category,
  });

  @override
  final PredictionLabel label;
  @override
  final double confidence;
  @override
  final double fakeProbability;
  @override
  final double realProbability;
  @override
  final String modelName;
  @override
  final String displayName;
  @override
  final String category;

  @override
  String toString() {
    return 'PredictionResult(label: $label, confidence: $confidence, fakeProbability: $fakeProbability, realProbability: $realProbability, modelName: $modelName, displayName: $displayName, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionResultImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.fakeProbability, fakeProbability) ||
                other.fakeProbability == fakeProbability) &&
            (identical(other.realProbability, realProbability) ||
                other.realProbability == realProbability) &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    label,
    confidence,
    fakeProbability,
    realProbability,
    modelName,
    displayName,
    category,
  );

  /// Create a copy of PredictionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionResultImplCopyWith<_$PredictionResultImpl> get copyWith =>
      __$$PredictionResultImplCopyWithImpl<_$PredictionResultImpl>(
        this,
        _$identity,
      );
}

abstract class _PredictionResult implements PredictionResult {
  const factory _PredictionResult({
    required final PredictionLabel label,
    required final double confidence,
    required final double fakeProbability,
    required final double realProbability,
    required final String modelName,
    required final String displayName,
    required final String category,
  }) = _$PredictionResultImpl;

  @override
  PredictionLabel get label;
  @override
  double get confidence;
  @override
  double get fakeProbability;
  @override
  double get realProbability;
  @override
  String get modelName;
  @override
  String get displayName;
  @override
  String get category;

  /// Create a copy of PredictionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionResultImplCopyWith<_$PredictionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
