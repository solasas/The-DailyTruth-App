import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/auth_session.dart';

/// Persists the current [AuthSession] across app launches.
///
/// NOTE: this uses [SharedPreferences], not the platform keystore — adequate
/// for a demo/internal tool with short-lived tokens, but a production build
/// should move [_credsKey] (and ideally the token too) into
/// `flutter_secure_storage`. Credentials are cached only to support the
/// transparent `401` refresh in [DioClient].
abstract class AuthLocalDataSource {
  AuthSession? readSession();
  Future<void> writeSession(AuthSession session);
  Future<void> clearSession();

  ({String username, String password})? readCredentials();
  Future<void> writeCredentials({
    required String username,
    required String password,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _sessionKey = 'auth.session';
  static const _credsKey = 'auth.credentials';

  @override
  AuthSession? readSession() {
    final raw = _prefs.getString(_sessionKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return AuthSession(
        accessToken: map['access_token'] as String,
        tokenType: map['token_type'] as String? ?? 'Bearer',
        role: UserRoleX.parse(map['role'] as String?),
        username: map['username'] as String? ?? '',
        issuedAt: DateTime.fromMillisecondsSinceEpoch(map['issued_at'] as int),
        lifetime: Duration(seconds: map['lifetime_s'] as int? ?? 3600),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> writeSession(AuthSession session) {
    return _prefs.setString(
      _sessionKey,
      jsonEncode({
        'access_token': session.accessToken,
        'token_type': session.tokenType,
        'role': session.role.name,
        'username': session.username,
        'issued_at': session.issuedAt.millisecondsSinceEpoch,
        'lifetime_s': session.lifetime.inSeconds,
      }),
    );
  }

  @override
  Future<void> clearSession() async {
    await _prefs.remove(_sessionKey);
    await _prefs.remove(_credsKey);
  }

  @override
  ({String username, String password})? readCredentials() {
    final raw = _prefs.getString(_credsKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return (username: map['u'] as String, password: map['p'] as String);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> writeCredentials({
    required String username,
    required String password,
  }) {
    return _prefs.setString(
      _credsKey,
      jsonEncode({'u': username, 'p': password}),
    );
  }
}
