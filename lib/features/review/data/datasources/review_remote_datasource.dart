import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/review_queue_item.dart';
import '../models/review_queue_dto.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewQueuePage> getQueue({
    int page,
    int pageSize,
    ReviewStatus? status,
  });

  Future<ReviewQueueItem> resolve({
    required String id,
    required String decision,
    String? note,
  });
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  ReviewRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<ReviewQueuePage> getQueue({
    int page = 1,
    int pageSize = AppConstants.reviewQueuePageSize,
    ReviewStatus? status,
  }) {
    return _client.guard(() async {
      final response = await _client.dio.get(
        ApiEndpoints.reviewQueue,
        queryParameters: {
          'page': page,
          'size': pageSize,
          if (status != null) 'status': status.name,
        },
      );
      return ReviewQueueDto.parsePage(
        response.data,
        requestedPage: page,
        requestedPageSize: pageSize,
      );
    });
  }

  @override
  Future<ReviewQueueItem> resolve({
    required String id,
    required String decision,
    String? note,
  }) {
    return _client.guard(() async {
      final response = await _client.dio.post(
        ApiEndpoints.reviewQueueResolve(id),
        data: {
          'decision': decision,
          if (note != null && note.trim().isNotEmpty) 'note': note.trim(),
        },
      );
      final data = response.data;
      if (data is Map && data.isNotEmpty) {
        return ReviewQueueDto.parseItem(data.cast<String, dynamic>());
      }
      // Some backends answer 204/empty — synthesise a resolved item so the
      // list can update optimistically.
      return ReviewQueueItem(
        id: id,
        status: ReviewStatus.resolved,
        textPreview: '',
        resolutionNote: note,
        resolvedAt: DateTime.now(),
      );
    });
  }
}
