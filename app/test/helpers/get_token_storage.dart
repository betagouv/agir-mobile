// ignore_for_file: avoid_dynamic_calls, avoid-accessing-collections-by-constant-index

import 'package:app/features/authentification/core/domain/authentification_statut_manager.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import '../old/api/constants.dart';
import '../old/api/flutter_secure_storage_mock.dart';

Future<AuthentificationTokenStorage> getTokenStorage() async {
  final tokenStorage = AuthentificationTokenStorage(
    secureStorage: FlutterSecureStorageMock(),
    authentificationStatusManagerWriter: AuthentificationStatutManager(),
  );
  await tokenStorage.sauvegarderToken(token);

  return tokenStorage;
}
