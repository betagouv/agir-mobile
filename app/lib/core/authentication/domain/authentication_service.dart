import 'dart:async';

import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/domain/token.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:clock/clock.dart';
import 'package:rxdart/subjects.dart';

class AuthenticationService {
  AuthenticationService({
    required final AuthenticationStorage authenticationRepository,
    required final Clock clock,
  })  : _authenticationRepository = authenticationRepository,
        _clock = clock;

  final AuthenticationStorage _authenticationRepository;
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
      final expirationDate = _authenticationRepository.expirationDate;
      if (expirationDate.value.isAfter(_clock.now())) {
        if (status is Authenticated) {
          return;
        }
        final userId = _authenticationRepository.userId;
        _authenticationStatusController.add(Authenticated(userId));
      } else {
        await _authenticationRepository.deleteToken();
        _authenticationStatusController.add(const Unauthenticated());
      }
    } on Exception catch (_) {
      _authenticationStatusController.add(const Unauthenticated());
    }
  }

  Token get token => _authenticationRepository.token;

  Future<void> logout() async {
    _authenticationStatusController.add(const Unauthenticated());
    await _authenticationRepository.deleteToken();
  }

  Future<void> dispose() async => _authenticationStatusController.close();
}
