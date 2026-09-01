import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_daily_truth/core/error/app_exception.dart';

void main() {
  RequestOptions options() => RequestOptions(path: '/test');

  group('AppException.fromDioException', () {
    test('maps connection timeout to TimeoutFailure', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.connectionTimeout,
      );
      expect(AppException.fromDioException(error), isA<TimeoutFailure>());
    });

    test('maps connection error to NoInternetFailure', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.connectionError,
      );
      expect(AppException.fromDioException(error), isA<NoInternetFailure>());
    });

    test('maps HTTP 404 to NotFoundFailure', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: options(), statusCode: 404),
      );
      expect(AppException.fromDioException(error), isA<NotFoundFailure>());
    });

    test('maps HTTP 422 to ValidationFailure using server message', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: options(),
          statusCode: 422,
          data: {'detail': 'Text is too short'},
        ),
      );
      final result = AppException.fromDioException(error);
      expect(result, isA<ValidationFailure>());
      expect(result.message, 'Text is too short');
    });

    test('maps HTTP 413 to PayloadTooLargeFailure', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: options(), statusCode: 413),
      );
      expect(
        AppException.fromDioException(error),
        isA<PayloadTooLargeFailure>(),
      );
    });

    test('maps HTTP 503 to ServiceUnavailableFailure', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: options(), statusCode: 503),
      );
      expect(
        AppException.fromDioException(error),
        isA<ServiceUnavailableFailure>(),
      );
    });

    test('maps HTTP 500 to ServerFailure', () {
      final error = DioException(
        requestOptions: options(),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: options(), statusCode: 500),
      );
      expect(AppException.fromDioException(error), isA<ServerFailure>());
    });
  });
}
