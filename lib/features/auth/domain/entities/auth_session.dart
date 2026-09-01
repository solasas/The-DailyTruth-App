import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/app_constants.dart';

part 'auth_session.freezed.dart';

/// Backend roles issued by `POST /auth/token`. `admin` can do everything an
/// `analyst` can; `unknown` covers any future/unrecognised role string.
enum UserRole { admin, analyst, unknown }

extension UserRoleX on UserRole {
  String get label => switch (this) {
    UserRole.admin => 'Administrator',
    UserRole.analyst => 'Analyst',
    UserRole.unknown => 'Member',
  };

  /// Whether this role may act on the analyst review queue
  /// (`POST /review-queue/{id}/resolve`).
  bool get canResolveReviews =>
      this == UserRole.admin || this == UserRole.analyst;

  static UserRole parse(String? raw) => switch (raw?.toLowerCase().trim()) {
    'admin' => UserRole.admin,
    'analyst' => UserRole.analyst,
    _ => UserRole.unknown,
  };
}

/// An authenticated session — the decoded result of `POST /auth/token` plus
/// the local bookkeeping needed to know when it has gone stale.
@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required String tokenType,
    required UserRole role,
    required String username,
    required DateTime issuedAt,
    required Duration lifetime,
  }) = _AuthSession;

  const AuthSession._();

  DateTime get expiresAt => issuedAt.add(lifetime);

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// True once the token is within ~1 minute of expiry — used to refresh
  /// proactively instead of waiting for a `401`.
  bool get isNearlyExpired =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(minutes: 1)));

  String get authorizationHeader => '$tokenType $accessToken';

  static Duration get defaultLifetime => AppConstants.tokenLifetimeFallback;
}
