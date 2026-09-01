import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/review_queue_item.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/review_remote_datasource.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl(this._remote);

  final ReviewRemoteDataSource _remote;

  @override
  Future<ReviewQueuePage> getQueue({
    int page = 1,
    int pageSize = AppConstants.reviewQueuePageSize,
    ReviewStatus? status,
  }) {
    return _remote.getQueue(page: page, pageSize: pageSize, status: status);
  }

  @override
  Future<ReviewQueueItem> resolve({
    required String id,
    required String decision,
    String? note,
  }) {
    return _remote.resolve(id: id, decision: decision, note: note);
  }
}
