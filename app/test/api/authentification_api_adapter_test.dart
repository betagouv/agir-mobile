import 'dart:io';

import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_adapter.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';
import 'request_mathcher.dart';

void main() {
  const informationDeConnexion = InformationDeConnexion(
    adresseMail: 'test@example.com',
    motDePasse: 'password123',
  );

  test(
    "connexionDemandee envoie une requête POST à l'API avec les informations de connexion",
    () async {
      // Arrange.
      final client = ClientMock()
        ..postSuccess(
          path: '/utilisateurs/login_v2',
          response: CustomResponse('', statusCode: HttpStatus.created),
        );

      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: AuthentificationTokenStorage(
            secureStorage: FlutterSecureStorageMock(),
            authentificationStatusManagerWriter:
                AuthentificationStatutManager(),
          ),
          inner: client,
        ),
      );

      // Act.
      await adapter.connexionDemandee(informationDeConnexion);

      // Assert.
      verify(
        () => client.send(
          any(
            that: RequestMathcher(
              '/utilisateurs/login_v2',
              body:
                  '{"email":"${informationDeConnexion.adresseMail}","mot_de_passe":"${informationDeConnexion.motDePasse}"}',
            ),
          ),
        ),
      );
    },
  );

  test(
    "validationCodeConnexionDemandee ajoute le token et l'utisateurId dans le secure storage et modifie le statut a connecté",
    () async {
      final client = ClientMock()
        ..postSuccess(
          path: '/utilisateurs/login_v2',
          response: CustomResponse('', statusCode: HttpStatus.created),
        )
        ..postSuccess(
          path: '/utilisateurs/login_v2_code',
          response: CustomResponse(
            '''
{
  "token": "$token",
  "utilisateur": {
    "id": "$utilisateurId"
  }
}''',
            statusCode: HttpStatus.created,
          ),
        );

      final flutterSecureStorageMock = FlutterSecureStorageMock();
      final authentificationStatutManager = AuthentificationStatutManager();

      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: AuthentificationTokenStorage(
            secureStorage: flutterSecureStorageMock,
            authentificationStatusManagerWriter: authentificationStatutManager,
          ),
          inner: client,
        ),
      );
      await adapter.connexionDemandee(informationDeConnexion);

      // Act.
      await adapter.validationDemandee(
        const InformationDeCode(
          adresseMail: 'test@example.com',
          code: '123456',
        ),
      );

      // Assert.
      expect(
        await flutterSecureStorageMock.readAll(),
        {'token': token, 'utilisateurId': utilisateurId},
      );
      expect(
        authentificationStatutManager.statutActuel,
        AuthentificationStatut.connecte,
      );

      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/login_v2_code',
              body: '{"code":"123456","email":"test@example.com"}',
            ),
          ),
        ),
      );
    },
  );

  test(
    "deconnexionDemandee supprime le token et l'utisateurId dans le secure storage et modifie le statut a pas connecté",
    () async {
      // Arrange.
      final flutterSecureStorageMock = FlutterSecureStorageMock();
      final authentificationStatutManager = AuthentificationStatutManager();

      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: AuthentificationTokenStorage(
            secureStorage: flutterSecureStorageMock,
            authentificationStatusManagerWriter: authentificationStatutManager,
          ),
          inner: ClientMock(),
        ),
      );

      // Act.
      await adapter.deconnexionDemandee();

      // Assert.
      expect(await flutterSecureStorageMock.readAll(), <String, dynamic>{});
      expect(
        authentificationStatutManager.statutActuel,
        AuthentificationStatut.pasConnecte,
      );
    },
  );

  test('creationDeCompteDemandee', () async {
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs_v2',
        response: CustomResponse(
          '''
{
  "email": "${informationDeConnexion.adresseMail}",
}''',
          statusCode: HttpStatus.created,
        ),
      );

    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: AuthentificationTokenStorage(
          secureStorage: FlutterSecureStorageMock(),
          authentificationStatusManagerWriter: AuthentificationStatutManager(),
        ),
        inner: client,
      ),
    );

    await adapter.creationDeCompteDemandee(informationDeConnexion);

    verify(
      () => client.send(
        any(
          that: RequestMathcher(
            '/utilisateurs_v2',
            body:
                '{"email":"${informationDeConnexion.adresseMail}","mot_de_passe":"${informationDeConnexion.motDePasse}"}',
          ),
        ),
      ),
    );
  });

  test('validationDemandee', () async {
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs/valider',
        response: CustomResponse(
          '''
{
  "token": "$token",
  "utilisateur": {
    "id": "$utilisateurId"
  }
}''',
          statusCode: HttpStatus.created,
        ),
      );

    final flutterSecureStorageMock = FlutterSecureStorageMock();
    final authentificationStatutManager = AuthentificationStatutManager();

    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: AuthentificationTokenStorage(
          secureStorage: flutterSecureStorageMock,
          authentificationStatusManagerWriter: authentificationStatutManager,
        ),
        inner: client,
      ),
    );

    await adapter.validationDemandee(
      const InformationDeCode(adresseMail: 'test@example.com', code: '123456'),
    );

    // Assert.
    expect(
      await flutterSecureStorageMock.readAll(),
      {'token': token, 'utilisateurId': utilisateurId},
    );
    expect(
      authentificationStatutManager.statutActuel,
      AuthentificationStatut.connecte,
    );

    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/valider',
            body: '{"code":"123456","email":"test@example.com"}',
          ),
        ),
      ),
    );
  });

  test('renvoyerCode', () async {
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs/renvoyer_code',
        response: OkResponse(),
      );

    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: AuthentificationTokenStorage(
          secureStorage: FlutterSecureStorageMock(),
          authentificationStatusManagerWriter: AuthentificationStatutManager(),
        ),
        inner: client,
      ),
    );

    await adapter.renvoyerCodeDemande('test@example.com');

    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/renvoyer_code',
            body: '{"email":"test@example.com"}',
          ),
        ),
      ),
    );
  });

  test('oubliMotDePasse', () async {
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs/oubli_mot_de_passe',
        response: CustomResponse(
          '''
{
  "email": "test@example.com"
}''',
          statusCode: HttpStatus.created,
        ),
      );

    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: AuthentificationTokenStorage(
          secureStorage: FlutterSecureStorageMock(),
          authentificationStatusManagerWriter: AuthentificationStatutManager(),
        ),
        inner: client,
      ),
    );

    await adapter.oubliMotDePasse('test@example.com');

    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/oubli_mot_de_passe',
            body: '{"email":"test@example.com"}',
          ),
        ),
      ),
    );
  });

  test('modifierMotDePasse', () async {
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs/modifier_mot_de_passe',
        response: CustomResponse('', statusCode: HttpStatus.created),
      );

    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: AuthentificationTokenStorage(
          secureStorage: FlutterSecureStorageMock(),
          authentificationStatusManagerWriter: AuthentificationStatutManager(),
        ),
        inner: client,
      ),
    );

    await adapter.modifierMotDePasse(
      email: 'test@example.com',
      code: '123456',
      motDePasse: 'password123',
    );

    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/modifier_mot_de_passe',
            body:
                '{"code":"123456","email":"test@example.com","mot_de_passe":"password123"}',
          ),
        ),
      ),
    );
  });

  test('recupereUtilisateur', () async {
    // Arrange.
    const prenom = 'Lucas';
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
  "is_onboarding_done": true,
  "couverture_aides_ok": false
}''',
        ),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);

    final adapter = AuthentificationApiAdapter(
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
      const Utilisateur(
        prenom: prenom,
        estIntegrationTerminee: true,
        aMaVilleCouverte: false,
      ),
    );
  });
}
