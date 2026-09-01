// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TokenResponseDto {
  String get accessToken => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  int? get expiresInSeconds => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseDtoCopyWith<TokenResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseDtoCopyWith<$Res> {
  factory $TokenResponseDtoCopyWith(
    TokenResponseDto value,
    $Res Function(TokenResponseDto) then,
  ) = _$TokenResponseDtoCopyWithImpl<$Res, TokenResponseDto>;
  @useResult
  $Res call({
    String accessToken,
    String tokenType,
    String? role,
    int? expiresInSeconds,
  });
}

/// @nodoc
class _$TokenResponseDtoCopyWithImpl<$Res, $Val extends TokenResponseDto>
    implements $TokenResponseDtoCopyWith<$Res> {
  _$TokenResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
    Object? role = freezed,
    Object? expiresInSeconds = freezed,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenType: null == tokenType
                ? _value.tokenType
                : tokenType // ignore: cast_nullable_to_non_nullable
                      as String,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresInSeconds: freezed == expiresInSeconds
                ? _value.expiresInSeconds
                : expiresInSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenResponseDtoImplCopyWith<$Res>
    implements $TokenResponseDtoCopyWith<$Res> {
  factory _$$TokenResponseDtoImplCopyWith(
    _$TokenResponseDtoImpl value,
    $Res Function(_$TokenResponseDtoImpl) then,
  ) = __$$TokenResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String tokenType,
    String? role,
    int? expiresInSeconds,
  });
}

/// @nodoc
class __$$TokenResponseDtoImplCopyWithImpl<$Res>
    extends _$TokenResponseDtoCopyWithImpl<$Res, _$TokenResponseDtoImpl>
    implements _$$TokenResponseDtoImplCopyWith<$Res> {
  __$$TokenResponseDtoImplCopyWithImpl(
    _$TokenResponseDtoImpl _value,
    $Res Function(_$TokenResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
    Object? role = freezed,
    Object? expiresInSeconds = freezed,
  }) {
    return _then(
      _$TokenResponseDtoImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenType: null == tokenType
            ? _value.tokenType
            : tokenType // ignore: cast_nullable_to_non_nullable
                  as String,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresInSeconds: freezed == expiresInSeconds
            ? _value.expiresInSeconds
            : expiresInSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$TokenResponseDtoImpl extends _TokenResponseDto {
  const _$TokenResponseDtoImpl({
    required this.accessToken,
    this.tokenType = 'bearer',
    this.role,
    this.expiresInSeconds,
  }) : super._();

  @override
  final String accessToken;
  @override
  @JsonKey()
  final String tokenType;
  @override
  final String? role;
  @override
  final int? expiresInSeconds;

  @override
  String toString() {
    return 'TokenResponseDto(accessToken: $accessToken, tokenType: $tokenType, role: $role, expiresInSeconds: $expiresInSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseDtoImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.expiresInSeconds, expiresInSeconds) ||
                other.expiresInSeconds == expiresInSeconds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, tokenType, role, expiresInSeconds);

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseDtoImplCopyWith<_$TokenResponseDtoImpl> get copyWith =>
      __$$TokenResponseDtoImplCopyWithImpl<_$TokenResponseDtoImpl>(
        this,
        _$identity,
      );
}

abstract class _TokenResponseDto extends TokenResponseDto {
  const factory _TokenResponseDto({
    required final String accessToken,
    final String tokenType,
    final String? role,
    final int? expiresInSeconds,
  }) = _$TokenResponseDtoImpl;
  const _TokenResponseDto._() : super._();

  @override
  String get accessToken;
  @override
  String get tokenType;
  @override
  String? get role;
  @override
  int? get expiresInSeconds;

  /// Create a copy of TokenResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseDtoImplCopyWith<_$TokenResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
