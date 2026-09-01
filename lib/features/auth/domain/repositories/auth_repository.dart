import '../entities/auth_session.dart';

/// Contract for obtaining and persisting an [AuthSession].
abstract class AuthRepository {
  /// Restores a previously persisted session (if any) and re-arms the
  /// [DioClient] token store. Returns `null` when there's nothing stored or
  /// the stored token has already expired past any refresh window.
  Future<AuthSession?> restoreSession();

  /// Exchanges credentials for a token via `POST /auth/token`, persists the
  /// resulting session and installs it on the token store.
  Future<AuthSession> login({
    required String username,
    required String password,
  });

  /// Clears the persisted session/credentials and the in-memory token.
  Future<void> logout();
}
