// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PredictionHistoryEntry {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isAllModels => throw _privateConstructorUsedError;

  /// For single-model runs this has exactly one entry; for all-models runs
  /// it holds every per-model result plus the consensus is derivable from
  /// [consensusLabel]/[consensusConfidence].
  List<PredictionResult> get results => throw _privateConstructorUsedError;
  PredictionLabel? get consensusLabel => throw _privateConstructorUsedError;
  double? get consensusConfidence => throw _privateConstructorUsedError;

  /// Create a copy of PredictionHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictionHistoryEntryCopyWith<PredictionHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionHistoryEntryCopyWith<$Res> {
  factory $PredictionHistoryEntryCopyWith(
    PredictionHistoryEntry value,
    $Res Function(PredictionHistoryEntry) then,
  ) = _$PredictionHistoryEntryCopyWithImpl<$Res, PredictionHistoryEntry>;
  @useResult
  $Res call({
    String id,
    String text,
    DateTime timestamp,
    bool isAllModels,
    List<PredictionResult> results,
    PredictionLabel? consensusLabel,
    double? consensusConfidence,
  });
}

/// @nodoc
class _$PredictionHistoryEntryCopyWithImpl<
  $Res,
  $Val extends PredictionHistoryEntry
>
    implements $PredictionHistoryEntryCopyWith<$Res> {
  _$PredictionHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictionHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? timestamp = null,
    Object? isAllModels = null,
    Object? results = null,
    Object? consensusLabel = freezed,
    Object? consensusConfidence = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isAllModels: null == isAllModels
                ? _value.isAllModels
                : isAllModels // ignore: cast_nullable_to_non_nullable
                      as bool,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<PredictionResult>,
            consensusLabel: freezed == consensusLabel
                ? _value.consensusLabel
                : consensusLabel // ignore: cast_nullable_to_non_nullable
                      as PredictionLabel?,
            consensusConfidence: freezed == consensusConfidence
                ? _value.consensusConfidence
                : consensusConfidence // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PredictionHistoryEntryImplCopyWith<$Res>
    implements $PredictionHistoryEntryCopyWith<$Res> {
  factory _$$PredictionHistoryEntryImplCopyWith(
    _$PredictionHistoryEntryImpl value,
    $Res Function(_$PredictionHistoryEntryImpl) then,
  ) = __$$PredictionHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    DateTime timestamp,
    bool isAllModels,
    List<PredictionResult> results,
    PredictionLabel? consensusLabel,
    double? consensusConfidence,
  });
}

/// @nodoc
class __$$PredictionHistoryEntryImplCopyWithImpl<$Res>
    extends
        _$PredictionHistoryEntryCopyWithImpl<$Res, _$PredictionHistoryEntryImpl>
    implements _$$PredictionHistoryEntryImplCopyWith<$Res> {
  __$$PredictionHistoryEntryImplCopyWithImpl(
    _$PredictionHistoryEntryImpl _value,
    $Res Function(_$PredictionHistoryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PredictionHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? timestamp = null,
    Object? isAllModels = null,
    Object? results = null,
    Object? consensusLabel = freezed,
    Object? consensusConfidence = freezed,
  }) {
    return _then(
      _$PredictionHistoryEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isAllModels: null == isAllModels
            ? _value.isAllModels
            : isAllModels // ignore: cast_nullable_to_non_nullable
                  as bool,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<PredictionResult>,
        consensusLabel: freezed == consensusLabel
            ? _value.consensusLabel
            : consensusLabel // ignore: cast_nullable_to_non_nullable
                  as PredictionLabel?,
        consensusConfidence: freezed == consensusConfidence
            ? _value.consensusConfidence
            : consensusConfidence // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$PredictionHistoryEntryImpl extends _PredictionHistoryEntry {
  const _$PredictionHistoryEntryImpl({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isAllModels,
    required final List<PredictionResult> results,
    this.consensusLabel,
    this.consensusConfidence,
  }) : _results = results,
       super._();

  @override
  final String id;
  @override
  final String text;
  @override
  final DateTime timestamp;
  @override
  final bool isAllModels;

  /// For single-model runs this has exactly one entry; for all-models runs
  /// it holds every per-model result plus the consensus is derivable from
  /// [consensusLabel]/[consensusConfidence].
  final List<PredictionResult> _results;

  /// For single-model runs this has exactly one entry; for all-models runs
  /// it holds every per-model result plus the consensus is derivable from
  /// [consensusLabel]/[consensusConfidence].
  @override
  List<PredictionResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  final PredictionLabel? consensusLabel;
  @override
  final double? consensusConfidence;

  @override
  String toString() {
    return 'PredictionHistoryEntry(id: $id, text: $text, timestamp: $timestamp, isAllModels: $isAllModels, results: $results, consensusLabel: $consensusLabel, consensusConfidence: $consensusConfidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionHistoryEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isAllModels, isAllModels) ||
                other.isAllModels == isAllModels) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.consensusLabel, consensusLabel) ||
                other.consensusLabel == consensusLabel) &&
            (identical(other.consensusConfidence, consensusConfidence) ||
                other.consensusConfidence == consensusConfidence));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    timestamp,
    isAllModels,
    const DeepCollectionEquality().hash(_results),
    consensusLabel,
    consensusConfidence,
  );

  /// Create a copy of PredictionHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionHistoryEntryImplCopyWith<_$PredictionHistoryEntryImpl>
  get copyWith =>
      __$$PredictionHistoryEntryImplCopyWithImpl<_$PredictionHistoryEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _PredictionHistoryEntry extends PredictionHistoryEntry {
  const factory _PredictionHistoryEntry({
    required final String id,
    required final String text,
    required final DateTime timestamp,
    required final bool isAllModels,
    required final List<PredictionResult> results,
    final PredictionLabel? consensusLabel,
    final double? consensusConfidence,
  }) = _$PredictionHistoryEntryImpl;
  const _PredictionHistoryEntry._() : super._();

  @override
  String get id;
  @override
  String get text;
  @override
  DateTime get timestamp;
  @override
  bool get isAllModels;

  /// For single-model runs this has exactly one entry; for all-models runs
  /// it holds every per-model result plus the consensus is derivable from
  /// [consensusLabel]/[consensusConfidence].
  @override
  List<PredictionResult> get results;
  @override
  PredictionLabel? get consensusLabel;
  @override
  double? get consensusConfidence;

  /// Create a copy of PredictionHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionHistoryEntryImplCopyWith<_$PredictionHistoryEntryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
