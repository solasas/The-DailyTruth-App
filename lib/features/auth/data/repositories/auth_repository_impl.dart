import '../../../../core/network/token_store.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local, this._tokenStore);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final TokenStore _tokenStore;

  @override
  Future<AuthSession?> restoreSession() async {
    final session = _local.readSession();
    if (session == null) return null;

    // Token fully dead and no cached credentials to refresh with -> treat as
    // signed out and tidy up.
    if (session.isExpired && _local.readCredentials() == null) {
      await logout();
      return null;
    }

    _install(session);
    return session;
  }

  @override
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    // Drop any stale bearer so the login request itself goes out clean.
    _tokenStore.clear();

    final dto = await _remote.login(username: username, password: password);
    final session = dto.toEntity(username: username);

    await _local.writeSession(session);
    await _local.writeCredentials(username: username, password: password);
    _install(session);
    return session;
  }

  @override
  Future<void> logout() async {
    await _local.clearSession();
    _tokenStore
      ..clear()
      ..refresh = null;
  }

  void _install(AuthSession session) {
    _tokenStore
      ..token = session.accessToken
      ..refresh = _refreshToken;
  }

  /// Silent re-authentication used by [DioClient] on `401`. Returns the new
  /// raw access token, or `null` when no cached credentials are available.
  Future<String?> _refreshToken() async {
    final creds = _local.readCredentials();
    if (creds == null) return null;
    try {
      final dto = await _remote.login(
        username: creds.username,
        password: creds.password,
      );
      final session = dto.toEntity(username: creds.username);
      await _local.writeSession(session);
      return session.accessToken;
    } catch (_) {
      return null;
    }
  }
}
