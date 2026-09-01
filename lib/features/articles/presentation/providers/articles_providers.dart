import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/articles_remote_datasource.dart';
import '../../data/repositories/articles_repository_impl.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/articles_repository.dart';

final articlesRemoteDataSourceProvider = Provider<ArticlesRemoteDataSource>((
  ref,
) {
  return ArticlesRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final articlesRepositoryProvider = Provider<ArticlesRepository>((ref) {
  return ArticlesRepositoryImpl(ref.watch(articlesRemoteDataSourceProvider));
});

/// Draft text on the submit screen, kept in a provider so validation lives
/// in one place (mirrors the Analyze screen's `analyzeTextProvider`).
final articleDraftProvider = StateProvider.autoDispose<String>((ref) => '');

/// `true` when the draft is within the backend's accepted `text` length
/// (5–50 000 chars).
final articleDraftValidProvider = Provider.autoDispose<bool>((ref) {
  final length = ref.watch(articleDraftProvider).trim().length;
  return length >= AppConstants.minPredictTextLength &&
      length <= AppConstants.maxPredictTextLength;
});

/// Submits an article for verification. On success its value is the new
/// article id, which the screen uses to navigate to the verdict poller.
class ArticleSubmitController extends AutoDisposeAsyncNotifier<String?> {
  @override
  Future<String?> build() async => null;

  Future<void> submit(String text) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(articlesRepositoryProvider).submitArticle(text);
    });
  }

  void reset() => state = const AsyncData(null);
}

final articleSubmitControllerProvider =
    AsyncNotifierProvider.autoDispose<ArticleSubmitController, String?>(
      ArticleSubmitController.new,
    );

/// Polls `GET /articles/{id}` until the job settles, surfacing every
/// intermediate `processing` state so the UI can show live stage progress.
final articleStatusProvider = StreamProvider.autoDispose
    .family<Article, String>((ref, id) {
      return ref.watch(articlesRepositoryProvider).watchArticle(id);
    });
