import '../entities/article.dart';

/// Contract for the agentic article-verification flow.
abstract class ArticlesRepository {
  /// Submits [text] for verification and returns the new article id.
  Future<String> submitArticle(String text, {String? region});

  /// Submits a photo/screenshot at [path]; returns the new article id.
  Future<String> submitImage(String path, {String? region});

  /// Fetches the current state of a verification job (single poll).
  Future<Article> getArticle(String id);

  /// Polls [getArticle] on an interval until the job reaches a terminal
  /// state (`completed` / `failed`), emitting every intermediate state.
  /// Throws [TimeoutFailure] if it never settles within [timeout].
  Stream<Article> watchArticle(
    String id, {
    Duration interval,
    Duration timeout,
  });
}
