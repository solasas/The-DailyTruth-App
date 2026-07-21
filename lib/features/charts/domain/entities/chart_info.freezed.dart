// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChartInfo {
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartInfoCopyWith<ChartInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartInfoCopyWith<$Res> {
  factory $ChartInfoCopyWith(ChartInfo value, $Res Function(ChartInfo) then) =
      _$ChartInfoCopyWithImpl<$Res, ChartInfo>;
  @useResult
  $Res call({String name, String title});
}

/// @nodoc
class _$ChartInfoCopyWithImpl<$Res, $Val extends ChartInfo>
    implements $ChartInfoCopyWith<$Res> {
  _$ChartInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? title = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChartInfoImplCopyWith<$Res>
    implements $ChartInfoCopyWith<$Res> {
  factory _$$ChartInfoImplCopyWith(
    _$ChartInfoImpl value,
    $Res Function(_$ChartInfoImpl) then,
  ) = __$$ChartInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String title});
}

/// @nodoc
class __$$ChartInfoImplCopyWithImpl<$Res>
    extends _$ChartInfoCopyWithImpl<$Res, _$ChartInfoImpl>
    implements _$$ChartInfoImplCopyWith<$Res> {
  __$$ChartInfoImplCopyWithImpl(
    _$ChartInfoImpl _value,
    $Res Function(_$ChartInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? title = null}) {
    return _then(
      _$ChartInfoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChartInfoImpl implements _ChartInfo {
  const _$ChartInfoImpl({required this.name, required this.title});

  @override
  final String name;
  @override
  final String title;

  @override
  String toString() {
    return 'ChartInfo(name: $name, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, title);

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartInfoImplCopyWith<_$ChartInfoImpl> get copyWith =>
      __$$ChartInfoImplCopyWithImpl<_$ChartInfoImpl>(this, _$identity);
}

abstract class _ChartInfo implements ChartInfo {
  const factory _ChartInfo({
    required final String name,
    required final String title,
  }) = _$ChartInfoImpl;

  @override
  String get name;
  @override
  String get title;

  /// Create a copy of ChartInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartInfoImplCopyWith<_$ChartInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
