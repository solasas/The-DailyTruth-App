import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/article.dart';
import '../models/article_dto.dart';

abstract class ArticlesRemoteDataSource {
  /// `POST /articles/submit` (Bearer). Returns the new article id; the server
  /// answers `202 Accepted` and verification continues asynchronously.
  Future<String> submit({required String text, String? region});

  /// `POST /articles/submit-image` (Bearer, multipart). The server OCRs the
  /// image (Hindi + English) and verifies the recovered text.
  Future<String> submitImage({required String path, String? region});

  /// `GET /articles/{id}` — one poll of the verification job.
  Future<Article> getArticle(String id);
}

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  ArticlesRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<String> submit({required String text, String? region}) {
    return _client.guard(() async {
      final response = await _client.dio.post(
        ApiEndpoints.articlesSubmit,
        data: {
          'text': text,
          if (region != null && region.isNotEmpty) 'region': region,
        },
      );
      return ArticleDto.parseSubmitId(response.data);
    });
  }

  @override
  Future<String> submitImage({required String path, String? region}) {
    return _client.guard(() async {
      // The server checks the *part's* content type, not the filename, so it
      // must be set explicitly (the default octet-stream gets a 415).
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          path,
          filename: path.split(RegExp(r'[\\/]')).last,
          contentType: MediaType('image', _imageSubtype(path)),
        ),
        if (region != null && region.isNotEmpty) 'region': region,
      });
      final response = await _client.dio.post(
        ApiEndpoints.articlesSubmitImage,
        data: form,
        options: Options(contentType: 'multipart/form-data'),
      );
      return ArticleDto.parseSubmitId(response.data);
    });
  }

  /// `jpeg`, `png`, `webp`, `bmp` or `tiff` — the formats the server accepts.
  static String _imageSubtype(String path) {
    final ext = path.split('.').last.toLowerCase();
    return switch (ext) {
      'png' => 'png',
      'webp' => 'webp',
      'bmp' => 'bmp',
      'tif' || 'tiff' => 'tiff',
      _ => 'jpeg',
    };
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
