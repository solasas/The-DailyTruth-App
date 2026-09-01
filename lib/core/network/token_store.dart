/// In-memory holder for the current bearer token.
///
/// [DioClient]'s auth interceptor reads [token] on every request and calls
/// [refresh] once when the server answers `401`. The auth feature owns the
/// lifecycle: it hydrates [token] on startup, updates it on login/logout and
/// installs [refresh] so an expired token can be swapped transparently
/// (backend `JWT_EXPIRE_MINUTES` is only 60, so mid-session expiry is
/// common).
class TokenStore {
  String? _token;

  String? get token => _token;

  bool get hasToken => _token != null && _token!.isNotEmpty;

  set token(String? value) =>
      _token = (value == null || value.isEmpty) ? null : value;

  void clear() => _token = null;

  /// Obtains a fresh token (typically by re-running `POST /auth/token` with
  /// cached credentials). Returns `null` when no silent refresh is possible,
  /// in which case the caller should surface an [UnauthorizedFailure].
  Future<String?> Function()? refresh;
}
