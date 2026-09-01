// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_registry_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ModelRegistryEntry {
  String get name => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get featureType => throw _privateConstructorUsedError;
  bool get loaded => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  double get f1Score => throw _privateConstructorUsedError;
  double get precision => throw _privateConstructorUsedError;
  double get recall => throw _privateConstructorUsedError;
  double get auc => throw _privateConstructorUsedError;
  List<String> get charts => throw _privateConstructorUsedError;
  DateTime? get trainedAt => throw _privateConstructorUsedError;

  /// Create a copy of ModelRegistryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelRegistryEntryCopyWith<ModelRegistryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelRegistryEntryCopyWith<$Res> {
  factory $ModelRegistryEntryCopyWith(
    ModelRegistryEntry value,
    $Res Function(ModelRegistryEntry) then,
  ) = _$ModelRegistryEntryCopyWithImpl<$Res, ModelRegistryEntry>;
  @useResult
  $Res call({
    String name,
    String displayName,
    String category,
    String featureType,
    bool loaded,
    String? version,
    double accuracy,
    double f1Score,
    double precision,
    double recall,
    double auc,
    List<String> charts,
    DateTime? trainedAt,
  });
}

/// @nodoc
class _$ModelRegistryEntryCopyWithImpl<$Res, $Val extends ModelRegistryEntry>
    implements $ModelRegistryEntryCopyWith<$Res> {
  _$ModelRegistryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelRegistryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayName = null,
    Object? category = null,
    Object? featureType = null,
    Object? loaded = null,
    Object? version = freezed,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? charts = null,
    Object? trainedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            featureType: null == featureType
                ? _value.featureType
                : featureType // ignore: cast_nullable_to_non_nullable
                      as String,
            loaded: null == loaded
                ? _value.loaded
                : loaded // ignore: cast_nullable_to_non_nullable
                      as bool,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            charts: null == charts
                ? _value.charts
                : charts // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            trainedAt: freezed == trainedAt
                ? _value.trainedAt
                : trainedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModelRegistryEntryImplCopyWith<$Res>
    implements $ModelRegistryEntryCopyWith<$Res> {
  factory _$$ModelRegistryEntryImplCopyWith(
    _$ModelRegistryEntryImpl value,
    $Res Function(_$ModelRegistryEntryImpl) then,
  ) = __$$ModelRegistryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String displayName,
    String category,
    String featureType,
    bool loaded,
    String? version,
    double accuracy,
    double f1Score,
    double precision,
    double recall,
    double auc,
    List<String> charts,
    DateTime? trainedAt,
  });
}

/// @nodoc
class __$$ModelRegistryEntryImplCopyWithImpl<$Res>
    extends _$ModelRegistryEntryCopyWithImpl<$Res, _$ModelRegistryEntryImpl>
    implements _$$ModelRegistryEntryImplCopyWith<$Res> {
  __$$ModelRegistryEntryImplCopyWithImpl(
    _$ModelRegistryEntryImpl _value,
    $Res Function(_$ModelRegistryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModelRegistryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayName = null,
    Object? category = null,
    Object? featureType = null,
    Object? loaded = null,
    Object? version = freezed,
    Object? accuracy = null,
    Object? f1Score = null,
    Object? precision = null,
    Object? recall = null,
    Object? auc = null,
    Object? charts = null,
    Object? trainedAt = freezed,
  }) {
    return _then(
      _$ModelRegistryEntryImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        featureType: null == featureType
            ? _value.featureType
            : featureType // ignore: cast_nullable_to_non_nullable
                  as String,
        loaded: null == loaded
            ? _value.loaded
            : loaded // ignore: cast_nullable_to_non_nullable
                  as bool,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        charts: null == charts
            ? _value._charts
            : charts // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        trainedAt: freezed == trainedAt
            ? _value.trainedAt
            : trainedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ModelRegistryEntryImpl extends _ModelRegistryEntry {
  const _$ModelRegistryEntryImpl({
    required this.name,
    required this.displayName,
    required this.category,
    required this.featureType,
    required this.loaded,
    this.version,
    this.accuracy = 0.0,
    this.f1Score = 0.0,
    this.precision = 0.0,
    this.recall = 0.0,
    this.auc = 0.0,
    final List<String> charts = const <String>[],
    this.trainedAt,
  }) : _charts = charts,
       super._();

  @override
  final String name;
  @override
  final String displayName;
  @override
  final String category;
  @override
  final String featureType;
  @override
  final bool loaded;
  @override
  final String? version;
  @override
  @JsonKey()
  final double accuracy;
  @override
  @JsonKey()
  final double f1Score;
  @override
  @JsonKey()
  final double precision;
  @override
  @JsonKey()
  final double recall;
  @override
  @JsonKey()
  final double auc;
  final List<String> _charts;
  @override
  @JsonKey()
  List<String> get charts {
    if (_charts is EqualUnmodifiableListView) return _charts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_charts);
  }

  @override
  final DateTime? trainedAt;

  @override
  String toString() {
    return 'ModelRegistryEntry(name: $name, displayName: $displayName, category: $category, featureType: $featureType, loaded: $loaded, version: $version, accuracy: $accuracy, f1Score: $f1Score, precision: $precision, recall: $recall, auc: $auc, charts: $charts, trainedAt: $trainedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelRegistryEntryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.featureType, featureType) ||
                other.featureType == featureType) &&
            (identical(other.loaded, loaded) || other.loaded == loaded) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.auc, auc) || other.auc == auc) &&
            const DeepCollectionEquality().equals(other._charts, _charts) &&
            (identical(other.trainedAt, trainedAt) ||
                other.trainedAt == trainedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    displayName,
    category,
    featureType,
    loaded,
    version,
    accuracy,
    f1Score,
    precision,
    recall,
    auc,
    const DeepCollectionEquality().hash(_charts),
    trainedAt,
  );

  /// Create a copy of ModelRegistryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelRegistryEntryImplCopyWith<_$ModelRegistryEntryImpl> get copyWith =>
      __$$ModelRegistryEntryImplCopyWithImpl<_$ModelRegistryEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _ModelRegistryEntry extends ModelRegistryEntry {
  const factory _ModelRegistryEntry({
    required final String name,
    required final String displayName,
    required final String category,
    required final String featureType,
    required final bool loaded,
    final String? version,
    final double accuracy,
    final double f1Score,
    final double precision,
    final double recall,
    final double auc,
    final List<String> charts,
    final DateTime? trainedAt,
  }) = _$ModelRegistryEntryImpl;
  const _ModelRegistryEntry._() : super._();

  @override
  String get name;
  @override
  String get displayName;
  @override
  String get category;
  @override
  String get featureType;
  @override
  bool get loaded;
  @override
  String? get version;
  @override
  double get accuracy;
  @override
  double get f1Score;
  @override
  double get precision;
  @override
  double get recall;
  @override
  double get auc;
  @override
  List<String> get charts;
  @override
  DateTime? get trainedAt;

  /// Create a copy of ModelRegistryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelRegistryEntryImplCopyWith<_$ModelRegistryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ModelRegistry {
  List<ModelRegistryEntry> get entries => throw _privateConstructorUsedError;
  DateTime? get generatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ModelRegistry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelRegistryCopyWith<ModelRegistry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelRegistryCopyWith<$Res> {
  factory $ModelRegistryCopyWith(
    ModelRegistry value,
    $Res Function(ModelRegistry) then,
  ) = _$ModelRegistryCopyWithImpl<$Res, ModelRegistry>;
  @useResult
  $Res call({List<ModelRegistryEntry> entries, DateTime? generatedAt});
}

/// @nodoc
class _$ModelRegistryCopyWithImpl<$Res, $Val extends ModelRegistry>
    implements $ModelRegistryCopyWith<$Res> {
  _$ModelRegistryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelRegistry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? entries = null, Object? generatedAt = freezed}) {
    return _then(
      _value.copyWith(
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<ModelRegistryEntry>,
            generatedAt: freezed == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModelRegistryImplCopyWith<$Res>
    implements $ModelRegistryCopyWith<$Res> {
  factory _$$ModelRegistryImplCopyWith(
    _$ModelRegistryImpl value,
    $Res Function(_$ModelRegistryImpl) then,
  ) = __$$ModelRegistryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ModelRegistryEntry> entries, DateTime? generatedAt});
}

/// @nodoc
class __$$ModelRegistryImplCopyWithImpl<$Res>
    extends _$ModelRegistryCopyWithImpl<$Res, _$ModelRegistryImpl>
    implements _$$ModelRegistryImplCopyWith<$Res> {
  __$$ModelRegistryImplCopyWithImpl(
    _$ModelRegistryImpl _value,
    $Res Function(_$ModelRegistryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModelRegistry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? entries = null, Object? generatedAt = freezed}) {
    return _then(
      _$ModelRegistryImpl(
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<ModelRegistryEntry>,
        generatedAt: freezed == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ModelRegistryImpl implements _ModelRegistry {
  const _$ModelRegistryImpl({
    required final List<ModelRegistryEntry> entries,
    this.generatedAt,
  }) : _entries = entries;

  final List<ModelRegistryEntry> _entries;
  @override
  List<ModelRegistryEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final DateTime? generatedAt;

  @override
  String toString() {
    return 'ModelRegistry(entries: $entries, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelRegistryImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_entries),
    generatedAt,
  );

  /// Create a copy of ModelRegistry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelRegistryImplCopyWith<_$ModelRegistryImpl> get copyWith =>
      __$$ModelRegistryImplCopyWithImpl<_$ModelRegistryImpl>(this, _$identity);
}

abstract class _ModelRegistry implements ModelRegistry {
  const factory _ModelRegistry({
    required final List<ModelRegistryEntry> entries,
    final DateTime? generatedAt,
  }) = _$ModelRegistryImpl;

  @override
  List<ModelRegistryEntry> get entries;
  @override
  DateTime? get generatedAt;

  /// Create a copy of ModelRegistry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelRegistryImplCopyWith<_$ModelRegistryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
