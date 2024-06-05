import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/fonctionnalites/utilisateur/infrastructure/adapters/utilisateur_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

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
        authentificationStatusManager: AuthentificationStatutManager(),
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
        utilisateur,
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
        authentificationStatusManager: AuthentificationStatutManager(),
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
      expect(utilisateur.fonctionnalitesDebloquees, [aides]);
    });
  });
}
