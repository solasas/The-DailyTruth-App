// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_queue_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReviewQueueItem {
  String get id => throw _privateConstructorUsedError;
  ReviewStatus get status => throw _privateConstructorUsedError;
  String get textPreview => throw _privateConstructorUsedError;
  String? get articleId => throw _privateConstructorUsedError;
  String? get modelVerdict => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get assignee => throw _privateConstructorUsedError;
  String? get resolutionNote => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Create a copy of ReviewQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewQueueItemCopyWith<ReviewQueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewQueueItemCopyWith<$Res> {
  factory $ReviewQueueItemCopyWith(
    ReviewQueueItem value,
    $Res Function(ReviewQueueItem) then,
  ) = _$ReviewQueueItemCopyWithImpl<$Res, ReviewQueueItem>;
  @useResult
  $Res call({
    String id,
    ReviewStatus status,
    String textPreview,
    String? articleId,
    String? modelVerdict,
    double? confidence,
    String? reason,
    String? assignee,
    String? resolutionNote,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class _$ReviewQueueItemCopyWithImpl<$Res, $Val extends ReviewQueueItem>
    implements $ReviewQueueItemCopyWith<$Res> {
  _$ReviewQueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? textPreview = null,
    Object? articleId = freezed,
    Object? modelVerdict = freezed,
    Object? confidence = freezed,
    Object? reason = freezed,
    Object? assignee = freezed,
    Object? resolutionNote = freezed,
    Object? createdAt = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReviewStatus,
            textPreview: null == textPreview
                ? _value.textPreview
                : textPreview // ignore: cast_nullable_to_non_nullable
                      as String,
            articleId: freezed == articleId
                ? _value.articleId
                : articleId // ignore: cast_nullable_to_non_nullable
                      as String?,
            modelVerdict: freezed == modelVerdict
                ? _value.modelVerdict
                : modelVerdict // ignore: cast_nullable_to_non_nullable
                      as String?,
            confidence: freezed == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double?,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignee: freezed == assignee
                ? _value.assignee
                : assignee // ignore: cast_nullable_to_non_nullable
                      as String?,
            resolutionNote: freezed == resolutionNote
                ? _value.resolutionNote
                : resolutionNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewQueueItemImplCopyWith<$Res>
    implements $ReviewQueueItemCopyWith<$Res> {
  factory _$$ReviewQueueItemImplCopyWith(
    _$ReviewQueueItemImpl value,
    $Res Function(_$ReviewQueueItemImpl) then,
  ) = __$$ReviewQueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ReviewStatus status,
    String textPreview,
    String? articleId,
    String? modelVerdict,
    double? confidence,
    String? reason,
    String? assignee,
    String? resolutionNote,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$ReviewQueueItemImplCopyWithImpl<$Res>
    extends _$ReviewQueueItemCopyWithImpl<$Res, _$ReviewQueueItemImpl>
    implements _$$ReviewQueueItemImplCopyWith<$Res> {
  __$$ReviewQueueItemImplCopyWithImpl(
    _$ReviewQueueItemImpl _value,
    $Res Function(_$ReviewQueueItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReviewQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? textPreview = null,
    Object? articleId = freezed,
    Object? modelVerdict = freezed,
    Object? confidence = freezed,
    Object? reason = freezed,
    Object? assignee = freezed,
    Object? resolutionNote = freezed,
    Object? createdAt = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$ReviewQueueItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReviewStatus,
        textPreview: null == textPreview
            ? _value.textPreview
            : textPreview // ignore: cast_nullable_to_non_nullable
                  as String,
        articleId: freezed == articleId
            ? _value.articleId
            : articleId // ignore: cast_nullable_to_non_nullable
                  as String?,
        modelVerdict: freezed == modelVerdict
            ? _value.modelVerdict
            : modelVerdict // ignore: cast_nullable_to_non_nullable
                  as String?,
        confidence: freezed == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignee: freezed == assignee
            ? _value.assignee
            : assignee // ignore: cast_nullable_to_non_nullable
                  as String?,
        resolutionNote: freezed == resolutionNote
            ? _value.resolutionNote
            : resolutionNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ReviewQueueItemImpl implements _ReviewQueueItem {
  const _$ReviewQueueItemImpl({
    required this.id,
    required this.status,
    required this.textPreview,
    this.articleId,
    this.modelVerdict,
    this.confidence,
    this.reason,
    this.assignee,
    this.resolutionNote,
    this.createdAt,
    this.resolvedAt,
  });

  @override
  final String id;
  @override
  final ReviewStatus status;
  @override
  final String textPreview;
  @override
  final String? articleId;
  @override
  final String? modelVerdict;
  @override
  final double? confidence;
  @override
  final String? reason;
  @override
  final String? assignee;
  @override
  final String? resolutionNote;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'ReviewQueueItem(id: $id, status: $status, textPreview: $textPreview, articleId: $articleId, modelVerdict: $modelVerdict, confidence: $confidence, reason: $reason, assignee: $assignee, resolutionNote: $resolutionNote, createdAt: $createdAt, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewQueueItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.textPreview, textPreview) ||
                other.textPreview == textPreview) &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            (identical(other.modelVerdict, modelVerdict) ||
                other.modelVerdict == modelVerdict) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.assignee, assignee) ||
                other.assignee == assignee) &&
            (identical(other.resolutionNote, resolutionNote) ||
                other.resolutionNote == resolutionNote) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    status,
    textPreview,
    articleId,
    modelVerdict,
    confidence,
    reason,
    assignee,
    resolutionNote,
    createdAt,
    resolvedAt,
  );

  /// Create a copy of ReviewQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewQueueItemImplCopyWith<_$ReviewQueueItemImpl> get copyWith =>
      __$$ReviewQueueItemImplCopyWithImpl<_$ReviewQueueItemImpl>(
        this,
        _$identity,
      );
}

abstract class _ReviewQueueItem implements ReviewQueueItem {
  const factory _ReviewQueueItem({
    required final String id,
    required final ReviewStatus status,
    required final String textPreview,
    final String? articleId,
    final String? modelVerdict,
    final double? confidence,
    final String? reason,
    final String? assignee,
    final String? resolutionNote,
    final DateTime? createdAt,
    final DateTime? resolvedAt,
  }) = _$ReviewQueueItemImpl;

  @override
  String get id;
  @override
  ReviewStatus get status;
  @override
  String get textPreview;
  @override
  String? get articleId;
  @override
  String? get modelVerdict;
  @override
  double? get confidence;
  @override
  String? get reason;
  @override
  String? get assignee;
  @override
  String? get resolutionNote;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of ReviewQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewQueueItemImplCopyWith<_$ReviewQueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReviewQueuePage {
  List<ReviewQueueItem> get items => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Create a copy of ReviewQueuePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewQueuePageCopyWith<ReviewQueuePage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewQueuePageCopyWith<$Res> {
  factory $ReviewQueuePageCopyWith(
    ReviewQueuePage value,
    $Res Function(ReviewQueuePage) then,
  ) = _$ReviewQueuePageCopyWithImpl<$Res, ReviewQueuePage>;
  @useResult
  $Res call({List<ReviewQueueItem> items, int page, int pageSize, int total});
}

/// @nodoc
class _$ReviewQueuePageCopyWithImpl<$Res, $Val extends ReviewQueuePage>
    implements $ReviewQueuePageCopyWith<$Res> {
  _$ReviewQueuePageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewQueuePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? pageSize = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ReviewQueueItem>,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewQueuePageImplCopyWith<$Res>
    implements $ReviewQueuePageCopyWith<$Res> {
  factory _$$ReviewQueuePageImplCopyWith(
    _$ReviewQueuePageImpl value,
    $Res Function(_$ReviewQueuePageImpl) then,
  ) = __$$ReviewQueuePageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ReviewQueueItem> items, int page, int pageSize, int total});
}

/// @nodoc
class __$$ReviewQueuePageImplCopyWithImpl<$Res>
    extends _$ReviewQueuePageCopyWithImpl<$Res, _$ReviewQueuePageImpl>
    implements _$$ReviewQueuePageImplCopyWith<$Res> {
  __$$ReviewQueuePageImplCopyWithImpl(
    _$ReviewQueuePageImpl _value,
    $Res Function(_$ReviewQueuePageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReviewQueuePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? pageSize = null,
    Object? total = null,
  }) {
    return _then(
      _$ReviewQueuePageImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ReviewQueueItem>,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ReviewQueuePageImpl extends _ReviewQueuePage {
  const _$ReviewQueuePageImpl({
    required final List<ReviewQueueItem> items,
    required this.page,
    required this.pageSize,
    required this.total,
  }) : _items = items,
       super._();

  final List<ReviewQueueItem> _items;
  @override
  List<ReviewQueueItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  @override
  String toString() {
    return 'ReviewQueuePage(items: $items, page: $page, pageSize: $pageSize, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewQueuePageImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    page,
    pageSize,
    total,
  );

  /// Create a copy of ReviewQueuePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewQueuePageImplCopyWith<_$ReviewQueuePageImpl> get copyWith =>
      __$$ReviewQueuePageImplCopyWithImpl<_$ReviewQueuePageImpl>(
        this,
        _$identity,
      );
}

abstract class _ReviewQueuePage extends ReviewQueuePage {
  const factory _ReviewQueuePage({
    required final List<ReviewQueueItem> items,
    required final int page,
    required final int pageSize,
    required final int total,
  }) = _$ReviewQueuePageImpl;
  const _ReviewQueuePage._() : super._();

  @override
  List<ReviewQueueItem> get items;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get total;

  /// Create a copy of ReviewQueuePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewQueuePageImplCopyWith<_$ReviewQueuePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
