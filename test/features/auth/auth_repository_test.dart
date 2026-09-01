import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_daily_truth/core/network/token_store.dart';
import 'package:the_daily_truth/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:the_daily_truth/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:the_daily_truth/features/auth/data/models/token_response_dto.dart';
import 'package:the_daily_truth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:the_daily_truth/features/auth/domain/entities/auth_session.dart';

class _MockRemote extends Mock implements AuthRemoteDataSource {}

class _MockLocal extends Mock implements AuthLocalDataSource {}

void main() {
  late _MockRemote remote;
  late _MockLocal local;
  late TokenStore tokenStore;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      AuthSession(
        accessToken: 'fallback',
        tokenType: 'Bearer',
        role: UserRole.unknown,
        username: '',
        issuedAt: DateTime(2020),
        lifetime: const Duration(hours: 1),
      ),
    );
  });

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    tokenStore = TokenStore();
    repository = AuthRepositoryImpl(remote, local, tokenStore);

    when(() => local.writeSession(any())).thenAnswer((_) async {});
    when(
      () => local.writeCredentials(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async {});
    when(() => local.clearSession()).thenAnswer((_) async {});
  });

  group('login', () {
    test(
      'maps the token DTO to a session, persists it and arms the token store',
      () async {
        when(
          () => remote.login(username: 'analyst', password: 'analyst123'),
        ).thenAnswer(
          (_) async => TokenResponseDto.fromJson({
            'access_token': 'jwt-123',
            'token_type': 'bearer',
            'role': 'analyst',
          }),
        );

        final session = await repository.login(
          username: 'analyst',
          password: 'analyst123',
        );

        expect(session.accessToken, 'jwt-123');
        expect(session.tokenType, 'Bearer');
        expect(session.role, UserRole.analyst);
        expect(session.username, 'analyst');
        expect(session.lifetime, AuthSession.defaultLifetime);
        expect(tokenStore.token, 'jwt-123');
        expect(tokenStore.refresh, isNotNull);

        verify(() => local.writeSession(session)).called(1);
        verify(
          () => local.writeCredentials(
            username: 'analyst',
            password: 'analyst123',
          ),
        ).called(1);
      },
    );

    test('honours an explicit expiry echoed by the server', () async {
      when(
        () => remote.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => TokenResponseDto.fromJson({
          'access_token': 'jwt',
          'expires_in_minutes': 30,
          'role': 'admin',
        }),
      );

      final session = await repository.login(
        username: 'admin',
        password: 'admin123',
      );

      expect(session.lifetime, const Duration(minutes: 30));
      expect(session.role, UserRole.admin);
    });
  });

  group('restoreSession', () {
    test(
      'returns null and clears storage when the token is expired with no cached creds',
      () async {
        when(() => local.readSession()).thenReturn(
          AuthSession(
            accessToken: 'old',
            tokenType: 'Bearer',
            role: UserRole.analyst,
            username: 'analyst',
            issuedAt: DateTime.now().subtract(const Duration(hours: 3)),
            lifetime: const Duration(hours: 1),
          ),
        );
        when(() => local.readCredentials()).thenReturn(null);

        final restored = await repository.restoreSession();

        expect(restored, isNull);
        verify(() => local.clearSession()).called(1);
      },
    );

    test('re-arms the token store for a still-valid stored session', () async {
      final stored = AuthSession(
        accessToken: 'live-token',
        tokenType: 'Bearer',
        role: UserRole.admin,
        username: 'admin',
        issuedAt: DateTime.now(),
        lifetime: const Duration(hours: 1),
      );
      when(() => local.readSession()).thenReturn(stored);
      when(() => local.readCredentials()).thenReturn(null);

      final restored = await repository.restoreSession();

      expect(restored, stored);
      expect(tokenStore.token, 'live-token');
    });
  });

  test('logout clears storage and the in-memory token', () async {
    tokenStore.token = 'something';
    await repository.logout();

    expect(tokenStore.token, isNull);
    expect(tokenStore.refresh, isNull);
    verify(() => local.clearSession()).called(1);
  });
}
