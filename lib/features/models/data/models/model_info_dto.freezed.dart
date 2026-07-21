// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ModelInfoDto _$ModelInfoDtoFromJson(Map<String, dynamic> json) {
  return _ModelInfoDto.fromJson(json);
}

/// @nodoc
mixin _$ModelInfoDto {
  @JsonKey(name: 'model_name')
  String get modelName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  bool get loaded => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'feature_type')
  String get featureType => throw _privateConstructorUsedError;

  /// Serializes this ModelInfoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelInfoDtoCopyWith<ModelInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelInfoDtoCopyWith<$Res> {
  factory $ModelInfoDtoCopyWith(
    ModelInfoDto value,
    $Res Function(ModelInfoDto) then,
  ) = _$ModelInfoDtoCopyWithImpl<$Res, ModelInfoDto>;
  @useResult
  $Res call({
    @JsonKey(name: 'model_name') String modelName,
    String category,
    bool loaded,
    @JsonKey(fromJson: _toDouble) double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) double f1Score,
    @JsonKey(fromJson: _toDouble) double precision,
    @JsonKey(fromJson: _toDouble) double recall,
    @JsonKey(fromJson: _toDouble) double auc,
    @JsonKey(name: 'feature_type') String featureType,
  });
}

/// @nodoc
class _$ModelInfoDtoCopyWithImpl<$Res, $Val extends ModelInfoDto>
    implements $ModelInfoDtoCopyWith<$Res> {
  _$ModelInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? category = null,
    Object? loaded = null,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? featureType = null,
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
            loaded: null == loaded
                ? _value.loaded
                : loaded // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            featureType: null == featureType
                ? _value.featureType
                : featureType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModelInfoDtoImplCopyWith<$Res>
    implements $ModelInfoDtoCopyWith<$Res> {
  factory _$$ModelInfoDtoImplCopyWith(
    _$ModelInfoDtoImpl value,
    $Res Function(_$ModelInfoDtoImpl) then,
  ) = __$$ModelInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'model_name') String modelName,
    String category,
    bool loaded,
    @JsonKey(fromJson: _toDouble) double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) double f1Score,
    @JsonKey(fromJson: _toDouble) double precision,
    @JsonKey(fromJson: _toDouble) double recall,
    @JsonKey(fromJson: _toDouble) double auc,
    @JsonKey(name: 'feature_type') String featureType,
  });
}

/// @nodoc
class __$$ModelInfoDtoImplCopyWithImpl<$Res>
    extends _$ModelInfoDtoCopyWithImpl<$Res, _$ModelInfoDtoImpl>
    implements _$$ModelInfoDtoImplCopyWith<$Res> {
  __$$ModelInfoDtoImplCopyWithImpl(
    _$ModelInfoDtoImpl _value,
    $Res Function(_$ModelInfoDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModelInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? category = null,
    Object? loaded = null,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? featureType = null,
  }) {
    return _then(
      _$ModelInfoDtoImpl(
        modelName: null == modelName
            ? _value.modelName
            : modelName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        loaded: null == loaded
            ? _value.loaded
            : loaded // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        featureType: null == featureType
            ? _value.featureType
            : featureType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelInfoDtoImpl extends _ModelInfoDto {
  const _$ModelInfoDtoImpl({
    @JsonKey(name: 'model_name') required this.modelName,
    required this.category,
    this.loaded = false,
    @JsonKey(fromJson: _toDouble) this.accuracy = 0.0,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) this.f1Score = 0.0,
    @JsonKey(fromJson: _toDouble) this.precision = 0.0,
    @JsonKey(fromJson: _toDouble) this.recall = 0.0,
    @JsonKey(fromJson: _toDouble) this.auc = 0.0,
    @JsonKey(name: 'feature_type') this.featureType = 'unknown',
  }) : super._();

  factory _$ModelInfoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelInfoDtoImplFromJson(json);

  @override
  @JsonKey(name: 'model_name')
  final String modelName;
  @override
  final String category;
  @override
  @JsonKey()
  final bool loaded;
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
  @JsonKey(name: 'feature_type')
  final String featureType;

  @override
  String toString() {
    return 'ModelInfoDto(modelName: $modelName, category: $category, loaded: $loaded, accuracy: $accuracy, f1Score: $f1Score, precision: $precision, recall: $recall, auc: $auc, featureType: $featureType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelInfoDtoImpl &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.loaded, loaded) || other.loaded == loaded) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.auc, auc) || other.auc == auc) &&
            (identical(other.featureType, featureType) ||
                other.featureType == featureType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    modelName,
    category,
    loaded,
    accuracy,
    f1Score,
    precision,
    recall,
    auc,
    featureType,
  );

  /// Create a copy of ModelInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelInfoDtoImplCopyWith<_$ModelInfoDtoImpl> get copyWith =>
      __$$ModelInfoDtoImplCopyWithImpl<_$ModelInfoDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelInfoDtoImplToJson(this);
  }
}

abstract class _ModelInfoDto extends ModelInfoDto {
  const factory _ModelInfoDto({
    @JsonKey(name: 'model_name') required final String modelName,
    required final String category,
    final bool loaded,
    @JsonKey(fromJson: _toDouble) final double accuracy,
    @JsonKey(name: 'f1_score', fromJson: _toDouble) final double f1Score,
    @JsonKey(fromJson: _toDouble) final double precision,
    @JsonKey(fromJson: _toDouble) final double recall,
    @JsonKey(fromJson: _toDouble) final double auc,
    @JsonKey(name: 'feature_type') final String featureType,
  }) = _$ModelInfoDtoImpl;
  const _ModelInfoDto._() : super._();

  factory _ModelInfoDto.fromJson(Map<String, dynamic> json) =
      _$ModelInfoDtoImpl.fromJson;

  @override
  @JsonKey(name: 'model_name')
  String get modelName;
  @override
  String get category;
  @override
  bool get loaded;
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
  @JsonKey(name: 'feature_type')
  String get featureType;

  /// Create a copy of ModelInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelInfoDtoImplCopyWith<_$ModelInfoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
