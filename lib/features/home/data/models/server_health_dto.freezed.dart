// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_health_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ServerHealthDto _$ServerHealthDtoFromJson(Map<String, dynamic> json) {
  return _ServerHealthDto.fromJson(json);
}

/// @nodoc
mixin _$ServerHealthDto {
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'models_loaded')
  int get modelsLoaded => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_models')
  int? get totalModels => throw _privateConstructorUsedError;

  /// Serializes this ServerHealthDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerHealthDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerHealthDtoCopyWith<ServerHealthDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerHealthDtoCopyWith<$Res> {
  factory $ServerHealthDtoCopyWith(
    ServerHealthDto value,
    $Res Function(ServerHealthDto) then,
  ) = _$ServerHealthDtoCopyWithImpl<$Res, ServerHealthDto>;
  @useResult
  $Res call({
    String status,
    @JsonKey(name: 'models_loaded') int modelsLoaded,
    @JsonKey(name: 'total_models') int? totalModels,
  });
}

/// @nodoc
class _$ServerHealthDtoCopyWithImpl<$Res, $Val extends ServerHealthDto>
    implements $ServerHealthDtoCopyWith<$Res> {
  _$ServerHealthDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerHealthDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? modelsLoaded = null,
    Object? totalModels = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            modelsLoaded: null == modelsLoaded
                ? _value.modelsLoaded
                : modelsLoaded // ignore: cast_nullable_to_non_nullable
                      as int,
            totalModels: freezed == totalModels
                ? _value.totalModels
                : totalModels // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServerHealthDtoImplCopyWith<$Res>
    implements $ServerHealthDtoCopyWith<$Res> {
  factory _$$ServerHealthDtoImplCopyWith(
    _$ServerHealthDtoImpl value,
    $Res Function(_$ServerHealthDtoImpl) then,
  ) = __$$ServerHealthDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    @JsonKey(name: 'models_loaded') int modelsLoaded,
    @JsonKey(name: 'total_models') int? totalModels,
  });
}

/// @nodoc
class __$$ServerHealthDtoImplCopyWithImpl<$Res>
    extends _$ServerHealthDtoCopyWithImpl<$Res, _$ServerHealthDtoImpl>
    implements _$$ServerHealthDtoImplCopyWith<$Res> {
  __$$ServerHealthDtoImplCopyWithImpl(
    _$ServerHealthDtoImpl _value,
    $Res Function(_$ServerHealthDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServerHealthDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? modelsLoaded = null,
    Object? totalModels = freezed,
  }) {
    return _then(
      _$ServerHealthDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        modelsLoaded: null == modelsLoaded
            ? _value.modelsLoaded
            : modelsLoaded // ignore: cast_nullable_to_non_nullable
                  as int,
        totalModels: freezed == totalModels
            ? _value.totalModels
            : totalModels // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerHealthDtoImpl extends _ServerHealthDto {
  const _$ServerHealthDtoImpl({
    this.status = 'unknown',
    @JsonKey(name: 'models_loaded') this.modelsLoaded = 0,
    @JsonKey(name: 'total_models') this.totalModels,
  }) : super._();

  factory _$ServerHealthDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerHealthDtoImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'models_loaded')
  final int modelsLoaded;
  @override
  @JsonKey(name: 'total_models')
  final int? totalModels;

  @override
  String toString() {
    return 'ServerHealthDto(status: $status, modelsLoaded: $modelsLoaded, totalModels: $totalModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerHealthDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.modelsLoaded, modelsLoaded) ||
                other.modelsLoaded == modelsLoaded) &&
            (identical(other.totalModels, totalModels) ||
                other.totalModels == totalModels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, modelsLoaded, totalModels);

  /// Create a copy of ServerHealthDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerHealthDtoImplCopyWith<_$ServerHealthDtoImpl> get copyWith =>
      __$$ServerHealthDtoImplCopyWithImpl<_$ServerHealthDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerHealthDtoImplToJson(this);
  }
}

abstract class _ServerHealthDto extends ServerHealthDto {
  const factory _ServerHealthDto({
    final String status,
    @JsonKey(name: 'models_loaded') final int modelsLoaded,
    @JsonKey(name: 'total_models') final int? totalModels,
  }) = _$ServerHealthDtoImpl;
  const _ServerHealthDto._() : super._();

  factory _ServerHealthDto.fromJson(Map<String, dynamic> json) =
      _$ServerHealthDtoImpl.fromJson;

  @override
  String get status;
  @override
  @JsonKey(name: 'models_loaded')
  int get modelsLoaded;
  @override
  @JsonKey(name: 'total_models')
  int? get totalModels;

  /// Create a copy of ServerHealthDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerHealthDtoImplCopyWith<_$ServerHealthDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
