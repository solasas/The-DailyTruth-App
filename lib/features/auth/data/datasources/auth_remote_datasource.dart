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
      // The backend's LoginRequest is a JSON body ({username, password});
      // `username` also accepts an email address.
      final response = await _client.dio.post(
        ApiEndpoints.authToken,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data as Map<String, dynamic>;
      return TokenResponseDto.fromJson(data);
    });
  }
}
