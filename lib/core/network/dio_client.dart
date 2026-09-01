import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/env_config.dart';
import '../constants/app_constants.dart';
import '../error/app_exception.dart';
import 'network_info.dart';
import 'token_store.dart';

/// Configures and owns the single [Dio] instance used by every datasource.
///
/// Centralizing this means one place to tweak timeouts, headers, logging and
/// the connectivity pre-check for the whole app.
class DioClient {
  DioClient({
    required this.networkInfo,
    TokenStore? tokenStore,
    String? baseUrl,
  }) : tokenStore = tokenStore ?? TokenStore(),
       dio = Dio(
         BaseOptions(
           baseUrl: baseUrl ?? EnvConfig.defaultApiBaseUrl,
           connectTimeout: AppConstants.defaultConnectTimeout,
           receiveTimeout: AppConstants.defaultReceiveTimeout,
           headers: const {'Content-Type': 'application/json'},
         ),
       ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!await networkInfo.isConnected) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                error: 'No internet connection',
              ),
            );
            return;
          }
          final token = this.tokenStore.token;
          if (token != null && !options.headers.containsKey('Authorization')) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final shouldRefresh =
              error.response?.statusCode == 401 &&
              this.tokenStore.refresh != null &&
              error.requestOptions.extra['__retried_after_401__'] != true;

          if (!shouldRefresh) {
            handler.next(error);
            return;
          }

          try {
            final fresh = await this.tokenStore.refresh!();
            if (fresh == null || fresh.isEmpty) {
              this.tokenStore.clear();
              handler.next(error);
              return;
            }
            this.tokenStore.token = fresh;
            final retried = error.requestOptions
              ..extra['__retried_after_401__'] = true
              ..headers['Authorization'] = 'Bearer $fresh';
            final response = await dio.fetch<dynamic>(retried);
            handler.resolve(response);
          } on DioException {
            this.tokenStore.clear();
            handler.next(error);
          }
        },
      ),
    );

    if (EnvConfig.enableNetworkLogs) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
        ),
      );
    }
  }

  final Dio dio;
  final NetworkInfo networkInfo;
  final TokenStore tokenStore;

  /// Repoints the client at a new base URL (used when the user changes the
  /// API base URL from Settings) without needing to rebuild every provider
  /// that depends on [Dio].
  void updateBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  /// Runs [request] and converts any [DioException] into an [AppException],
  /// so callers only ever need to catch one error hierarchy.
  Future<T> guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    } on TypeError {
      throw const InvalidDataFailure();
    }
  }
}
