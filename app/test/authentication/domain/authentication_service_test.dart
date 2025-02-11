import 'dart:async';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/domain/expiration_date.dart';
import 'package:app/core/authentication/domain/user_id.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationStorage {}

void main() {
  late AuthenticationService authenticationService;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    authenticationService = AuthenticationService(authenticationStorage: mockRepository, clock: Clock.fixed(DateTime(1992)));
  });

  group('AuthenticationService', () {
    test('checkAuthenticationStatus should emit authenticated status when token is valid', () async {
      when(() => mockRepository.expirationDate).thenAnswer((final _) => ExpirationDate(DateTime(1993)));
      when(() => mockRepository.userId).thenAnswer((final _) => const UserId('test_user_id'));

      unawaited(
        expectLater(
          authenticationService.authenticationStatus,
          emitsInOrder([
            isA<Unauthenticated>(),
            isA<Authenticated>().having((final a) => a.userId.value, 'userId', 'test_user_id'),
          ]),
        ),
      );

      await authenticationService.checkAuthenticationStatus();
    });

    test('checkAuthenticationStatus should emit unauthenticated status when token is expired', () async {
      when(() => mockRepository.expirationDate).thenAnswer((final _) => ExpirationDate(DateTime(1991)));
      when(() => mockRepository.deleteAuthToken()).thenAnswer((final _) async {});
      unawaited(expectLater(authenticationService.authenticationStatus, emitsInOrder([isA<Unauthenticated>()])));

      await authenticationService.checkAuthenticationStatus();

      verify(() => mockRepository.deleteAuthToken()).called(1);
      await authenticationService.dispose();
    });

    test('checkAuthenticationStatus should emit unauthenticated status when an exception occurs', () async {
      when(() => mockRepository.expirationDate).thenThrow(Exception('Test exception'));
      unawaited(expectLater(authenticationService.authenticationStatus, emitsInOrder([isA<Unauthenticated>()])));

      await authenticationService.checkAuthenticationStatus();
      await authenticationService.dispose();
    });

    test('authenticate should save token and check authentication status', () async {
      when(() => mockRepository.saveToken(any())).thenAnswer((final _) async {});
      when(() => mockRepository.expirationDate).thenAnswer((final _) => ExpirationDate(DateTime(1993)));
      when(() => mockRepository.userId).thenAnswer((final _) => const UserId('test_user_id'));
      unawaited(
        expectLater(
          authenticationService.authenticationStatus,
          emitsInOrder([
            isA<Unauthenticated>(),
            isA<Authenticated>().having((final a) => a.userId.value, 'userId', 'test_user_id'),
          ]),
        ),
      );

      await authenticationService.login('test_token');

      verify(() => mockRepository.saveToken('test_token')).called(1);

      await authenticationService.dispose();
    });

    test('logout should emit unauthenticated status and delete token', () async {
      when(() => mockRepository.deleteAuthToken()).thenAnswer((final _) async {});
      unawaited(expectLater(authenticationService.authenticationStatus, emitsInOrder([isA<Unauthenticated>()])));
      await authenticationService.logout();

      verify(() => mockRepository.deleteAuthToken()).called(1);

      await authenticationService.dispose();
    });

    test('dispose should close the stream controller', () async {
      await authenticationService.dispose();
      expect(authenticationService.authenticationStatus, emitsInOrder([isA<Unauthenticated>()]));
    });
  });
}
