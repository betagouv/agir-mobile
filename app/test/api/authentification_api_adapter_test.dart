import 'dart:io';

import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_adapter.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  group('AuthentificationApiAdapter', () {
    const informationDeConnexion = InformationDeConnexion(
      adresseMail: 'test@example.com',
      motDePasse: 'password123',
    );

    const response = '''
{
  "token": "$token",
  "utilisateur": {
    "id": "$utilisateurId"
  }
}''';

    test(
      "connectionDemandee ajoute le token et l'utisateurId dans le secure storage et modifie le statut a connecté",
      () async {
        // Arrange.
        final client = ClientMock()
          ..postSuccess(
            path: '/utilisateurs/login',
            response: CustomResponse(response, statusCode: HttpStatus.created),
          );

        final flutterSecureStorageMock = FlutterSecureStorageMock();
        final authentificationStatutManager = AuthentificationStatutManager();

        final adapter = AuthentificationApiAdapter(
          apiClient: AuthentificationApiClient(
            apiUrl: apiUrl,
            authentificationTokenStorage: AuthentificationTokenStorage(
              secureStorage: flutterSecureStorageMock,
              authentificationStatusManager: authentificationStatutManager,
            ),
            inner: client,
          ),
        );

        // Act.
        await adapter.connectionDemandee(informationDeConnexion);

        // Assert.
        expect(
          await flutterSecureStorageMock.readAll(),
          {'token': token, 'utilisateurId': utilisateurId},
        );
        expect(
          authentificationStatutManager.statutActuel,
          AuthentificationStatut.connecte,
        );
      },
    );

    test(
      "deconnectionDemandee supprime le token et l'utisateurId dans le secure storage et modifie le statut a pas connecté",
      () async {
        // Arrange.
        final flutterSecureStorageMock = FlutterSecureStorageMock();
        final authentificationStatutManager = AuthentificationStatutManager();

        final adapter = AuthentificationApiAdapter(
          apiClient: AuthentificationApiClient(
            apiUrl: apiUrl,
            authentificationTokenStorage: AuthentificationTokenStorage(
              secureStorage: flutterSecureStorageMock,
              authentificationStatusManager: authentificationStatutManager,
            ),
            inner: ClientMock(),
          ),
        );

        // Act.
        await adapter.deconnectionDemandee();

        // Assert.
        expect(await flutterSecureStorageMock.readAll(), <String, dynamic>{});
        expect(
          authentificationStatutManager.statutActuel,
          AuthentificationStatut.pasConnecte,
        );
      },
    );
  });
}
