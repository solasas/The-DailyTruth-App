import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_daily_truth/core/error/app_exception.dart';
import 'package:the_daily_truth/features/articles/data/datasources/articles_remote_datasource.dart';
import 'package:the_daily_truth/features/articles/data/models/article_dto.dart';
import 'package:the_daily_truth/features/articles/data/repositories/articles_repository_impl.dart';
import 'package:the_daily_truth/features/articles/domain/entities/article.dart';
import 'package:the_daily_truth/features/articles/domain/entities/article_enums.dart';

class _MockRemote extends Mock implements ArticlesRemoteDataSource {}

void main() {
  late _MockRemote remote;
  late ArticlesRepositoryImpl repository;

  setUp(() {
    remote = _MockRemote();
    repository = ArticlesRepositoryImpl(remote);
  });

  group('ArticleDto.parse', () {
    test('maps a completed article with a nested verdict and claims', () {
      final article = ArticleDto.parse({
        'id': 'a1',
        'status': 'completed',
        'stage': 'done',
        'verdict': {
          'verdict': 'likely_fake',
          'confidence': 0.82,
          'rationale': 'Two central claims are contradicted by reporting.',
          'claims': [
            {
              'claim': 'X happened on Tuesday',
              'verdict': 'contradiction',
              'status': 'verified',
              'confidence': 0.9,
              'evidence': 'It happened on Friday.',
              'source_url': 'https://example.com/a',
            },
            {'claim': 'Y is true', 'verdict': 'entailment', 'confidence': 0.7},
          ],
          'degradations': [
            {
              'severity': 'minor',
              'reason': 'Evidence retrieval used cache',
              'stage': 'retrieval',
            },
          ],
        },
      });

      expect(article.id, 'a1');
      expect(article.status, ArticleStatus.completed);
      expect(article.stage, ArticleStage.done);
      expect(article.verdict, isNotNull);
      expect(article.verdict!.verdict, ArticleVerdict.likelyFake);
      expect(article.verdict!.confidence, 0.82);
      expect(article.verdict!.claims, hasLength(2));
      expect(article.verdict!.contradictedClaims, 1);
      expect(article.verdict!.supportedClaims, 1);
      expect(article.verdict!.claims.first.sourceUrl, 'https://example.com/a');
      expect(
        article.verdict!.degradations.single.severity,
        DegradationSeverity.minor,
      );
    });

    test(
      'defaults to processing for an unknown status and tolerates a missing verdict',
      () {
        final article = ArticleDto.parse({
          'id': 'a2',
          'stage': 'verifying',
        });

        expect(article.status, ArticleStatus.processing);
        expect(article.stage, ArticleStage.verifying);
        expect(article.verdict, isNull);
      },
    );

    test('parseSubmitId reads the id out of common envelope shapes', () {
      expect(ArticleDto.parseSubmitId({'id': 'x'}), 'x');
      expect(ArticleDto.parseSubmitId({'article_id': 'y'}), 'y');
      expect(ArticleDto.parseSubmitId('z'), 'z');
      expect(
        () => ArticleDto.parseSubmitId({'nope': 1}),
        throwsFormatException,
      );
    });
  });

  group('submitArticle', () {
    test('trims the text before handing it to the datasource', () async {
      when(
        () => remote.submit(text: 'hello world', region: null),
      ).thenAnswer((_) async => 'id-1');

      final id = await repository.submitArticle('  hello world  ');

      expect(id, 'id-1');
      verify(() => remote.submit(text: 'hello world', region: null)).called(1);
    });
  });

  group('submit with region / image', () {
    test('passes a trimmed region and drops a blank one', () async {
      when(
        () => remote.submit(text: 'claim', region: 'Pune'),
      ).thenAnswer((_) async => '7');
      when(
        () => remote.submitImage(path: '/p.png', region: null),
      ).thenAnswer((_) async => '8');

      expect(await repository.submitArticle('claim', region: ' Pune '), '7');
      expect(await repository.submitImage('/p.png', region: '  '), '8');
    });
  });

  group('origin trail parsing', () {
    test('parses origin, timeline, evidence meta and the reasoning trace', () {
      final article = ArticleDto.parse({
        'id': 42,
        'status': 'completed',
        'submitted_at': '2026-11-07 10:00:05',
        'verdict': {
          'verdict': 'uncertain',
          'confidence': 0,
          'reasoning_trace': 'ORIGIN TRAIL\n  2019-08-19 toi',
          'claim_verdicts': [
            {
              'claim': 'UNESCO declared it the best anthem.',
              'verdict': 'neutral',
              'confidence': 1.0,
              'evidence_snippets': ['snippet'],
              'sources': ['en.wikipedia.org'],
              'evidence_meta': [
                {'domain': 'en.wikipedia.org', 'stance': 'debunks', 'trust': 0.9},
              ],
              'origin': {
                'basis': 'none',
                'claimant': null,
                'first_debunk': {
                  'date': '2019-08-19',
                  'domain': 'timesofindia.indiatimes.com',
                  'kind': 'debunks',
                  'trust': 0.9,
                  'found_by': 'wider_search',
                },
                'timeline': [
                  {'date': '2016-03-14', 'domain': 'snopes.com', 'kind': 'fact_check', 'label': 'reviewed'},
                  {'date': '', 'domain': 'x.com', 'kind': 'repeats'},
                ],
                'fact_check_status': 'disabled',
                'search_status': 'ok',
              },
            },
            {'claim': 'older row without new fields', 'verdict': 'entailment'},
          ],
        },
      });

      expect(article.id, '42');
      expect(article.submittedAt!.isUtc, isTrue);
      final v = article.verdict!;
      expect(v.isAbstention, isTrue);
      expect(v.reasoningTrace, contains('ORIGIN TRAIL'));
      final c = v.claims.first;
      expect(c.evidence, 'snippet');
      expect(c.evidenceMeta.single.stance, 'debunks');
      expect(c.origin!.hasClaimant, isFalse);
      expect(c.origin!.firstDebunk!.isWiderSearch, isTrue);
      expect(c.origin!.timeline, hasLength(2));
      expect(c.origin!.timeline.first.isDated, isTrue);
      expect(c.origin!.timeline.last.isDated, isFalse);
      expect(c.origin!.factCheckStatus, 'disabled');
      expect(v.claims.last.origin, isNull);
    });
  });

  group('watchArticle', () {
    test(
      'polls until a terminal status, emitting every intermediate state',
      () async {
        final states = [
          _article(ArticleStatus.processing, ArticleStage.queued),
          _article(ArticleStatus.processing, ArticleStage.verifying),
          _article(ArticleStatus.completed, ArticleStage.done),
        ];
        var call = 0;
        when(
          () => remote.getArticle('id'),
        ).thenAnswer((_) async => states[call++]);

        final emitted = await repository
            .watchArticle('id', interval: const Duration(milliseconds: 1))
            .toList();

        expect(emitted.map((a) => a.status), [
          ArticleStatus.processing,
          ArticleStatus.processing,
          ArticleStatus.completed,
        ]);
        verify(() => remote.getArticle('id')).called(3);
      },
    );

    test('throws TimeoutFailure when the job never settles', () async {
      when(() => remote.getArticle('id')).thenAnswer(
        (_) async =>
            _article(ArticleStatus.processing, ArticleStage.verifying),
      );

      final stream = repository.watchArticle(
        'id',
        interval: const Duration(milliseconds: 1),
        timeout: const Duration(milliseconds: 5),
      );

      expect(stream.toList(), throwsA(isA<TimeoutFailure>()));
    });
  });
}

Article _article(ArticleStatus status, ArticleStage stage) =>
    Article(id: 'id', status: status, stage: stage);
