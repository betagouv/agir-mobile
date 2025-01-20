import 'dart:convert';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/domain/token.dart';
import 'package:app/core/authentication/domain/user_id.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api/constants.dart';

class AuthenticationServiceFake implements AuthenticationService {
  const AuthenticationServiceFake();

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      throw UnimplementedError();

  @override
  Future<void> checkAuthenticationStatus() => throw UnimplementedError();

  @override
  Future<void> dispose() async {}

  @override
  Future<void> login(final String token) => throw UnimplementedError();

  @override
  Future<void> logout() => throw UnimplementedError();

  static const _userId = utilisateurId;

  @override
  AuthenticationStatus get status => const Authenticated(UserId(_userId));

  @override
  Token get token => Token('header.${base64Encode(
        jsonEncode({'exp': 1727698718, 'utilisateurId': _userId}).codeUnits,
      )}.signature');
}
