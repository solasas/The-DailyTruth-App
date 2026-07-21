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

/// @nodoc
mixin _$PredictionResultDto {
  String get label => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  double get probFake => throw _privateConstructorUsedError;
  double get probReal => throw _privateConstructorUsedError;
  String get modelName => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

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
    String label,
    double confidence,
    double probFake,
    double probReal,
    String modelName,
    String displayName,
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
    Object? label = null,
    Object? confidence = null,
    Object? probFake = null,
    Object? probReal = null,
    Object? modelName = null,
    Object? displayName = null,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            probFake: null == probFake
                ? _value.probFake
                : probFake // ignore: cast_nullable_to_non_nullable
                      as double,
            probReal: null == probReal
                ? _value.probReal
                : probReal // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PredictionResultDtoImplCopyWith<$Res>
    implements $PredictionResultDtoCopyWith<$Res> {
  factory _$$PredictionResultDtoImplCopyWith(
    _$PredictionResultDtoImpl value,
    $Res Function(_$PredictionResultDtoImpl) then,
  ) = __$$PredictionResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String label,
    double confidence,
    double probFake,
    double probReal,
    String modelName,
    String displayName,
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
    Object? label = null,
    Object? confidence = null,
    Object? probFake = null,
    Object? probReal = null,
    Object? modelName = null,
    Object? displayName = null,
    Object? category = null,
  }) {
    return _then(
      _$PredictionResultDtoImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        probFake: null == probFake
            ? _value.probFake
            : probFake // ignore: cast_nullable_to_non_nullable
                  as double,
        probReal: null == probReal
            ? _value.probReal
            : probReal // ignore: cast_nullable_to_non_nullable
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

class _$PredictionResultDtoImpl extends _PredictionResultDto {
  const _$PredictionResultDtoImpl({
    required this.label,
    this.confidence = 0.0,
    this.probFake = 0.0,
    this.probReal = 0.0,
    this.modelName = '',
    this.displayName = '',
    this.category = '',
  }) : super._();

  @override
  final String label;
  @override
  @JsonKey()
  final double confidence;
  @override
  @JsonKey()
  final double probFake;
  @override
  @JsonKey()
  final double probReal;
  @override
  @JsonKey()
  final String modelName;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'PredictionResultDto(label: $label, confidence: $confidence, probFake: $probFake, probReal: $probReal, modelName: $modelName, displayName: $displayName, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionResultDtoImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.probFake, probFake) ||
                other.probFake == probFake) &&
            (identical(other.probReal, probReal) ||
                other.probReal == probReal) &&
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
    probFake,
    probReal,
    modelName,
    displayName,
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
}

abstract class _PredictionResultDto extends PredictionResultDto {
  const factory _PredictionResultDto({
    required final String label,
    final double confidence,
    final double probFake,
    final double probReal,
    final String modelName,
    final String displayName,
    final String category,
  }) = _$PredictionResultDtoImpl;
  const _PredictionResultDto._() : super._();

  @override
  String get label;
  @override
  double get confidence;
  @override
  double get probFake;
  @override
  double get probReal;
  @override
  String get modelName;
  @override
  String get displayName;
  @override
  String get category;

  /// Create a copy of PredictionResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionResultDtoImplCopyWith<_$PredictionResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
