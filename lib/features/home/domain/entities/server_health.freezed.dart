// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ServerHealth {
  ServerHealthStatus get status => throw _privateConstructorUsedError;
  int get modelsLoaded => throw _privateConstructorUsedError;
  int? get totalModels => throw _privateConstructorUsedError;

  /// Create a copy of ServerHealth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerHealthCopyWith<ServerHealth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerHealthCopyWith<$Res> {
  factory $ServerHealthCopyWith(
    ServerHealth value,
    $Res Function(ServerHealth) then,
  ) = _$ServerHealthCopyWithImpl<$Res, ServerHealth>;
  @useResult
  $Res call({ServerHealthStatus status, int modelsLoaded, int? totalModels});
}

/// @nodoc
class _$ServerHealthCopyWithImpl<$Res, $Val extends ServerHealth>
    implements $ServerHealthCopyWith<$Res> {
  _$ServerHealthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerHealth
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
                      as ServerHealthStatus,
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
abstract class _$$ServerHealthImplCopyWith<$Res>
    implements $ServerHealthCopyWith<$Res> {
  factory _$$ServerHealthImplCopyWith(
    _$ServerHealthImpl value,
    $Res Function(_$ServerHealthImpl) then,
  ) = __$$ServerHealthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ServerHealthStatus status, int modelsLoaded, int? totalModels});
}

/// @nodoc
class __$$ServerHealthImplCopyWithImpl<$Res>
    extends _$ServerHealthCopyWithImpl<$Res, _$ServerHealthImpl>
    implements _$$ServerHealthImplCopyWith<$Res> {
  __$$ServerHealthImplCopyWithImpl(
    _$ServerHealthImpl _value,
    $Res Function(_$ServerHealthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServerHealth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? modelsLoaded = null,
    Object? totalModels = freezed,
  }) {
    return _then(
      _$ServerHealthImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ServerHealthStatus,
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

class _$ServerHealthImpl implements _ServerHealth {
  const _$ServerHealthImpl({
    required this.status,
    required this.modelsLoaded,
    this.totalModels,
  });

  @override
  final ServerHealthStatus status;
  @override
  final int modelsLoaded;
  @override
  final int? totalModels;

  @override
  String toString() {
    return 'ServerHealth(status: $status, modelsLoaded: $modelsLoaded, totalModels: $totalModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerHealthImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.modelsLoaded, modelsLoaded) ||
                other.modelsLoaded == modelsLoaded) &&
            (identical(other.totalModels, totalModels) ||
                other.totalModels == totalModels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, modelsLoaded, totalModels);

  /// Create a copy of ServerHealth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerHealthImplCopyWith<_$ServerHealthImpl> get copyWith =>
      __$$ServerHealthImplCopyWithImpl<_$ServerHealthImpl>(this, _$identity);
}

abstract class _ServerHealth implements ServerHealth {
  const factory _ServerHealth({
    required final ServerHealthStatus status,
    required final int modelsLoaded,
    final int? totalModels,
  }) = _$ServerHealthImpl;

  @override
  ServerHealthStatus get status;
  @override
  int get modelsLoaded;
  @override
  int? get totalModels;

  /// Create a copy of ServerHealth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerHealthImplCopyWith<_$ServerHealthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
