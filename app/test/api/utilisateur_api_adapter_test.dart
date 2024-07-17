import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/infrastructure/adapters/utilisateur_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  group('UtilisateurApiAdapter', () {
    test('recupereUtilisateur', () async {
      // Arrange.
      const prenom = 'Lucas';
      const aides = Fonctionnalites.aides;
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId',
          response: CustomResponse(
            '''
{
  "id": "saudon",
  "nom": "Saudon",
  "prenom": "$prenom",
  "email": "ls@mail.com",
  "fonctionnalites_debloquees": [
    "${aides.name}"
  ]
}''',
          ),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        secureStorage: FlutterSecureStorageMock(),
        authentificationStatusManagerWriter: AuthentificationStatutManager(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = UtilisateurApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
          inner: client,
        ),
      );

      // Act.
      final utilisateur = await adapter.recupereUtilisateur();

      // Assert.
      expect(
        utilisateur.getRight().getOrElse(() => throw Exception()),
        const Utilisateur(prenom: prenom, fonctionnalitesDebloquees: [aides]),
      );
    });

    test('recupereUtilisateur avec une fonctionnalités non connue', () async {
      // Arrange.
      const prenom = 'Lucas';
      const aides = Fonctionnalites.aides;
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId',
          response: CustomResponse(
            '''
{
  "id": "saudon",
  "nom": "Saudon",
  "prenom": "$prenom",
  "email": "ls@mail.com",
  "fonctionnalites_debloquees": [
    "${aides.name}",
    "nouveau"
  ]
}''',
          ),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        secureStorage: FlutterSecureStorageMock(),
        authentificationStatusManagerWriter: AuthentificationStatutManager(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = UtilisateurApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
          inner: client,
        ),
      );

      // Act.
      final result = await adapter.recupereUtilisateur();

      // Assert.
      final utilisateur = result.getRight().getOrElse(() => throw Exception());
      expect(utilisateur.fonctionnalitesDebloquees, [aides]);
    });
  });
}
