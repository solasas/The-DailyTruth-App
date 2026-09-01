import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/token_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponseDto> login({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<TokenResponseDto> login({
    required String username,
    required String password,
  }) {
    return _client.guard(() async {
      // FastAPI's OAuth2PasswordRequestForm expects form-encoded fields, not
      // JSON — hence the explicit content type and `FormData`.
      final response = await _client.dio.post(
        ApiEndpoints.authToken,
        data: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      final data = response.data as Map<String, dynamic>;
      return TokenResponseDto.fromJson(data);
    });
  }
}
