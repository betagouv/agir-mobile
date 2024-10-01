import 'dart:async';

import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/domain/token.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:clock/clock.dart';
import 'package:rxdart/subjects.dart';

class AuthenticationService {
  AuthenticationService({
    required final AuthenticationRepository authenticationRepository,
    required final Clock clock,
  })  : _authenticationRepository = authenticationRepository,
        _clock = clock;

  final AuthenticationRepository _authenticationRepository;
  final Clock _clock;

  final _authenticationStatusController =
      BehaviorSubject<AuthenticationStatus>.seeded(const Unauthenticated());

  Stream<AuthenticationStatus> get authenticationStatus =>
      _authenticationStatusController.stream;

  AuthenticationStatus get status => _authenticationStatusController.value;

  Future<void> login(final String token) async {
    await _authenticationRepository.saveToken(token);
    await checkAuthenticationStatus();
  }

  Future<void> checkAuthenticationStatus() async {
    try {
      final expirationDate = await _authenticationRepository.expirationDate;

      if (expirationDate.value.isAfter(_clock.now())) {
        if (status is Authenticated) {
          return; // HACK(lsaudon): Pour ne pas ajouter le même status sinon ça casse GoRouter.of(context).pop(true);
        }
        final userId = await _authenticationRepository.userId;
        _authenticationStatusController
            .add(AuthenticationStatus.authenticated(userId));
      } else {
        await _authenticationRepository.deleteToken();
        _authenticationStatusController
            .add(const AuthenticationStatus.unauthenticated());
      }
    } on Exception catch (_) {
      _authenticationStatusController
          .add(const AuthenticationStatus.unauthenticated());
    }
  }

  Future<Token> get token async => _authenticationRepository.token;

  Future<void> logout() async {
    _authenticationStatusController
        .add(const AuthenticationStatus.unauthenticated());
    await _authenticationRepository.deleteToken();
  }

  Future<void> dispose() async => _authenticationStatusController.close();
}
