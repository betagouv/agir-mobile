import 'dart:io';

import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/domain/information_de_connexion.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/api_url.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_adapter.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api/client_mock.dart';
import 'api/custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  group('AuthentificationApiAdapter', () {
    const informationDeConnexion = InformationDeConnexion(
      adresseMail: 'test@example.com',
      motDePasse: 'password123',
    );
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
    const utilisateurId = 'utilisateurId';
    const response = '''
{
  "token": "$token",
  "utilisateur": {
    "id": "$utilisateurId"
  }
}''';
    final apiUrl = ApiUrl(Uri.parse('https://example.com/'));

    test(
        "connectionDemandee ajoute le token et l'utisateurId dans le secure storage et modifie le statut a connecté",
        () async {
      // Arrange
      final client = ClientMock()
        ..postSuccess(
          bodyFields: {
            'email': informationDeConnexion.adresseMail,
            'mot_de_passe': informationDeConnexion.motDePasse,
          },
          response: CustomResponse(response, HttpStatus.created),
        );

      final flutterSecureStorageMock = FlutterSecureStorageMock();
      final authentificationStatutManager = AuthentificationStatutManager();

      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          inner: client,
          apiUrl: apiUrl,
          authentificationTokenStorage: AuthentificationTokenStorage(
            authentificationStatusManager: authentificationStatutManager,
            secureStorage: flutterSecureStorageMock,
          ),
        ),
      );

      // Act
      await adapter.connectionDemandee(informationDeConnexion);

      // Assert
      expect(
        await flutterSecureStorageMock.readAll(),
        {'token': token, 'utilisateurId': utilisateurId},
      );
      expect(
        authentificationStatutManager.statutActuel(),
        AuthentificationStatut.connecte,
      );
    });

    test(
        "deconnectionDemandee supprime le token et l'utisateurId dans le secure storage et modifie le statut a pas connecté",
        () async {
      // Arrange
      final flutterSecureStorageMock = FlutterSecureStorageMock();
      final authentificationStatutManager = AuthentificationStatutManager();

      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          inner: ClientMock(),
          apiUrl: apiUrl,
          authentificationTokenStorage: AuthentificationTokenStorage(
            authentificationStatusManager: authentificationStatutManager,
            secureStorage: flutterSecureStorageMock,
          ),
        ),
      );

      // Act
      await adapter.deconnectionDemandee();

      // Assert
      expect(await flutterSecureStorageMock.readAll(), <String, dynamic>{});
      expect(
        authentificationStatutManager.statutActuel(),
        AuthentificationStatut.pasConnecte,
      );
    });
  });
}
