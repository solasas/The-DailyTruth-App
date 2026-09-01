import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/article.dart';
import '../models/article_dto.dart';

abstract class ArticlesRemoteDataSource {
  /// `POST /articles/submit` (Bearer). Returns the new article id; the server
  /// answers `202 Accepted` and verification continues asynchronously.
  Future<String> submit({required String text});

  /// `GET /articles/{id}` — one poll of the verification job.
  Future<Article> getArticle(String id);
}

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  ArticlesRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<String> submit({required String text}) {
    return _client.guard(() async {
      final response = await _client.dio.post(
        ApiEndpoints.articlesSubmit,
        data: {'text': text},
      );
      return ArticleDto.parseSubmitId(response.data);
    });
  }

  @override
  Future<Article> getArticle(String id) {
    return _client.guard(() async {
      final response = await _client.dio.get(ApiEndpoints.articleById(id));
      final data = response.data;
      final map = data is Map<String, dynamic>
          ? data
          : (data as Map).cast<String, dynamic>();
      return ArticleDto.parse(map);
    });
  }
}
