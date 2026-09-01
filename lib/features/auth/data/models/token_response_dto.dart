import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_session.dart';

part 'token_response_dto.freezed.dart';

/// Wire format for `POST /auth/token`.
///
/// FastAPI's OAuth2 password flow returns `{access_token, token_type}`; this
/// backend also attaches the caller's `role`. An explicit expiry may be
/// echoed as `expires_in` (seconds) or `expires_in_minutes` — when absent we
/// fall back to `JWT_EXPIRE_MINUTES` (see [AuthSession.defaultLifetime]).
@freezed
class TokenResponseDto with _$TokenResponseDto {
  const factory TokenResponseDto({
    required String accessToken,
    @Default('bearer') String tokenType,
    String? role,
    int? expiresInSeconds,
  }) = _TokenResponseDto;

  const TokenResponseDto._();

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) {
    final minutes = json['expires_in_minutes'];
    final seconds = json['expires_in'] ?? json['expires_in_seconds'];
    int? expiry;
    if (minutes is num) {
      expiry = (minutes * 60).round();
    } else if (seconds is num) {
      expiry = seconds.round();
    }

    final tokenType = json['token_type'] as String?;
    return TokenResponseDto(
      accessToken: (json['access_token'] ?? json['token'] ?? '') as String,
      tokenType: (tokenType != null && tokenType.trim().isNotEmpty)
          ? tokenType
          : 'bearer',
      role: json['role'] as String? ?? json['user_role'] as String?,
      expiresInSeconds: expiry,
    );
  }

  AuthSession toEntity({required String username, DateTime? issuedAt}) {
    return AuthSession(
      accessToken: accessToken,
      // Normalise "bearer" -> "Bearer" for the Authorization header.
      tokenType: tokenType.toLowerCase() == 'bearer' ? 'Bearer' : tokenType,
      role: UserRoleX.parse(role),
      username: username,
      issuedAt: issuedAt ?? DateTime.now(),
      lifetime: expiresInSeconds != null && expiresInSeconds! > 0
          ? Duration(seconds: expiresInSeconds!)
          : AuthSession.defaultLifetime,
    );
  }
}
