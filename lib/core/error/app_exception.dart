import 'package:dio/dio.dart';

/// Base type for every error the app surfaces to the UI.
///
/// Datasources translate raw [DioException]s into one of these via
/// [AppException.fromDioException] so presentation code never has to reason
/// about HTTP status codes or Dio internals directly.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;

  factory AppException.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const TimeoutFailure(
          'The server took too long to respond. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const NoInternetFailure(
          'No internet connection. Check your network and try again.',
        );
      case DioExceptionType.badCertificate:
        return const ServerFailure(
          'A secure connection could not be established.',
        );
      case DioExceptionType.cancel:
        return const RequestCancelledFailure('Request was cancelled.');
      case DioExceptionType.badResponse:
        return AppException._fromStatusCode(error);
      case DioExceptionType.unknown:
        return const NoInternetFailure(
          'Could not reach the server. Check your connection and try again.',
        );
    }
  }

  static AppException _fromStatusCode(DioException error) {
    final status = error.response?.statusCode ?? 0;
    final serverMessage = _extractServerMessage(error.response?.data);

    switch (status) {
      case 401:
        return UnauthorizedFailure(
          serverMessage ?? 'Your session has expired. Please sign in again.',
        );
      case 403:
        return ForbiddenFailure(
          serverMessage ??
              'Your account is not allowed to perform this action.',
        );
      case 404:
        return NotFoundFailure(
          serverMessage ?? 'The requested resource was not found.',
        );
      case 422:
        return ValidationFailure(
          serverMessage ?? 'The submitted data is invalid.',
        );
      case 413:
        return const PayloadTooLargeFailure(
          'The text you submitted is too large. Try shortening it.',
        );
      case 500:
        return ServerFailure(
          serverMessage ?? 'Something went wrong on the server.',
        );
      case 503:
        return const ServiceUnavailableFailure(
          'The prediction service is temporarily unavailable.',
        );
      default:
        return ServerFailure(
          serverMessage ?? 'Unexpected error (HTTP $status).',
        );
    }
  }

  static String? _extractServerMessage(dynamic data) {
    if (data is Map) {
      final detail = data['detail'] ?? data['message'] ?? data['error'];
      if (detail is String) return detail;
      if (detail is List && detail.isNotEmpty) return detail.first.toString();
    }
    return null;
  }
}

class NoInternetFailure extends AppException {
  const NoInternetFailure(super.message);
}

class TimeoutFailure extends AppException {
  const TimeoutFailure(super.message);
}

class NotFoundFailure extends AppException {
  const NotFoundFailure(super.message);
}

/// HTTP 401 — the bearer token is missing, invalid or expired. The auth
/// layer watches for this to drop the stored session and prompt re-login.
class UnauthorizedFailure extends AppException {
  const UnauthorizedFailure(super.message);
}

/// HTTP 403 — authenticated, but the account's role can't perform the action
/// (e.g. an `analyst`-only endpoint hit with a different role).
class ForbiddenFailure extends AppException {
  const ForbiddenFailure(super.message);
}

class ValidationFailure extends AppException {
  const ValidationFailure(super.message);
}

class PayloadTooLargeFailure extends AppException {
  const PayloadTooLargeFailure(super.message);
}

class ServerFailure extends AppException {
  const ServerFailure(super.message);
}

class ServiceUnavailableFailure extends AppException {
  const ServiceUnavailableFailure(super.message);
}

class RequestCancelledFailure extends AppException {
  const RequestCancelledFailure(super.message);
}

class InvalidDataFailure extends AppException {
  const InvalidDataFailure([
    super.message = 'Received malformed data from the server.',
  ]);
}

class UnknownFailure extends AppException {
  const UnknownFailure([super.message = 'An unexpected error occurred.']);
}
