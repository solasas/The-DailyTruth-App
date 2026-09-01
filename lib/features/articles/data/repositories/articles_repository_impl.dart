import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';
import '../../domain/repositories/articles_repository.dart';
import '../datasources/articles_remote_datasource.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRepositoryImpl(this._remote);

  final ArticlesRemoteDataSource _remote;

  @override
  Future<String> submitArticle(String text) =>
      _remote.submit(text: text.trim());

  @override
  Future<Article> getArticle(String id) => _remote.getArticle(id);

  @override
  Stream<Article> watchArticle(
    String id, {
    Duration interval = AppConstants.verificationPollInterval,
    Duration timeout = AppConstants.verificationTimeout,
  }) async* {
    final deadline = DateTime.now().add(timeout);

    while (true) {
      final article = await _remote.getArticle(id);
      yield article;

      if (article.status.isTerminal) return;

      if (DateTime.now().isAfter(deadline)) {
        throw const TimeoutFailure(
          'Verification is taking longer than expected. It may still finish — '
          'check back shortly.',
        );
      }
      await Future<void>.delayed(interval);
    }
  }
}
