import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_daily_truth/features/review/data/datasources/review_remote_datasource.dart';
import 'package:the_daily_truth/features/review/data/models/review_queue_dto.dart';
import 'package:the_daily_truth/features/review/data/repositories/review_repository_impl.dart';
import 'package:the_daily_truth/features/review/domain/entities/review_queue_item.dart';

class _MockRemote extends Mock implements ReviewRemoteDataSource {}

void main() {
  group('ReviewQueueDto.parsePage', () {
    test('reads an envelope with pagination metadata', () {
      final page = ReviewQueueDto.parsePage(
        {
          'items': [
            {
              'id': 'r1',
              'status': 'pending',
              'text_preview': 'Something contested',
              'model_verdict': 'fake',
              'confidence': 0.51,
            },
          ],
          'page': 2,
          'size': 20,
          'total': 41,
        },
        requestedPage: 2,
        requestedPageSize: 20,
      );

      expect(page.items, hasLength(1));
      expect(page.items.single.id, 'r1');
      expect(page.items.single.status, ReviewStatus.pending);
      expect(page.items.single.confidence, 0.51);
      expect(page.page, 2);
      expect(page.total, 41);
      expect(page.hasMore, isTrue); // 2 * 20 < 41
    });

    test('accepts a bare list and infers a non-paginating total', () {
      final page = ReviewQueueDto.parsePage(
        [
          {'id': 'a', 'status': 'resolved', 'text': 'x'},
          {'id': 'b', 'status': 'escalated', 'claim': 'y'},
        ],
        requestedPage: 1,
        requestedPageSize: 20,
      );

      expect(page.items.map((e) => e.status), [
        ReviewStatus.resolved,
        ReviewStatus.escalated,
      ]);
      expect(page.total, 2);
      expect(page.hasMore, isFalse);
    });
  });

  group('ReviewRepositoryImpl', () {
    late _MockRemote remote;
    late ReviewRepositoryImpl repository;

    setUp(() {
      remote = _MockRemote();
      repository = ReviewRepositoryImpl(remote);
    });

    test('forwards resolve arguments to the datasource', () async {
      final resolved = ReviewQueueDto.parseItem({
        'id': 'r9',
        'status': 'resolved',
        'text': 'done',
        'resolution_note': 'checked sources',
      });
      when(
        () =>
            remote.resolve(id: 'r9', decision: 'real', note: 'checked sources'),
      ).thenAnswer((_) async => resolved);

      final result = await repository.resolve(
        id: 'r9',
        decision: 'real',
        note: 'checked sources',
      );

      expect(result.status, ReviewStatus.resolved);
      expect(result.resolutionNote, 'checked sources');
      verify(
        () =>
            remote.resolve(id: 'r9', decision: 'real', note: 'checked sources'),
      ).called(1);
    });
  });
}
