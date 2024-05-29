import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/api_url.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/fonctionnalites/utilisateur/infrastructure/adapters/utilisateur_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api/client_mock.dart';
import 'api/custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  group('UtilisateurApiAdapter', () {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
    const utilisateurId = 'utilisateurId';
    final apiUrl = ApiUrl(Uri.parse('https://example.com/'));

    test('recupereUtilisateur', () async {
      // Arrange
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId',
          response: CustomResponse(
            '''
{
  "id": "saudon",
  "nom": "Saudon",
  "prenom": "Lucas",
  "email": "ls@mail.com",
  "fonctionnalites_debloquees": [
    "aides"
  ]
}''',
            200,
          ),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        authentificationStatusManager: AuthentificationStatutManager(),
        secureStorage: FlutterSecureStorageMock(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = UtilisateurApiAdapter(
        apiClient: AuthentificationApiClient(
          inner: client,
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
        ),
      );

      // Act
      final utilisateur = await adapter.recupereUtilisateur();

      // Assert
      expect(
        utilisateur,
        const Utilisateur(prenom: 'Lucas'),
      );
    });
  });
}
