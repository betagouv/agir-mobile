import 'dart:io';

import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/domain/user_id.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/utilisateur/domain/utilisateur.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/authentication_service_fake.dart';
import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_fake.dart';
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

      final authenticationService = AuthenticationService(
        authenticationRepository:
            AuthenticationRepository(FlutterSecureStorageFake()),
        clock: Clock.fixed(DateTime(1992)),
      );
      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: authenticationService,
          inner: client,
        ),
        authenticationService: authenticationService,
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

  test('connexionDemandee avec un utilisateur non actif', () async {
    // Arrange.
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs/login_v2',
        response: CustomResponse(
          '{"message":"Utilisateur non actif"}',
          statusCode: HttpStatus.badRequest,
        ),
      )
      ..postSuccess(
        path: '/utilisateurs/renvoyer_code',
        response: OkResponse(),
      );

    final authenticationService = AuthenticationService(
      authenticationRepository:
          AuthenticationRepository(FlutterSecureStorageFake()),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
    );

    // Act.
    await adapter.connexionDemandee(informationDeConnexion);

    // Assert.
    verify(
      () => client.send(
        any(
          that: RequestMathcher(
            '/utilisateurs/renvoyer_code',
            body: '{"email":"${informationDeConnexion.adresseMail}"}',
          ),
        ),
      ),
    );
  });

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
    "id": "user123"
  }
}''',
            statusCode: HttpStatus.created,
          ),
        );

      final flutterSecureStorage = FlutterSecureStorageFake();

      final authenticationService = AuthenticationService(
        authenticationRepository:
            AuthenticationRepository(flutterSecureStorage),
        clock: Clock.fixed(DateTime(1992)),
      );
      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: authenticationService,
          inner: client,
        ),
        authenticationService: authenticationService,
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
      final actual = await flutterSecureStorage.readAll();
      expect(actual, {'token': token});
      expect(
        authenticationService.status,
        const Authenticated(UserId(utilisateurId)),
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
      final flutterSecureStorageMock = FlutterSecureStorageFake();

      final authenticationService = AuthenticationService(
        authenticationRepository:
            AuthenticationRepository(FlutterSecureStorageFake()),
        clock: Clock.fixed(DateTime(1992)),
      );
      final adapter = AuthentificationApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: authenticationService,
          inner: ClientMock(),
        ),
        authenticationService: authenticationService,
      );

      // Act.
      await adapter.deconnexionDemandee();

      // Assert.
      expect(await flutterSecureStorageMock.readAll(), <String, dynamic>{});
      expect(authenticationService.status, const Unauthenticated());
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

    final authenticationService = AuthenticationService(
      authenticationRepository:
          AuthenticationRepository(FlutterSecureStorageFake()),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
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

    final flutterSecureStorageMock = FlutterSecureStorageFake();
    final authenticationService = AuthenticationService(
      authenticationRepository:
          AuthenticationRepository(flutterSecureStorageMock),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
    );

    await adapter.validationDemandee(
      const InformationDeCode(adresseMail: 'test@example.com', code: '123456'),
    );

    // Assert.
    expect(await flutterSecureStorageMock.readAll(), {'token': token});
    expect(
      authenticationService.status,
      const Authenticated(UserId(utilisateurId)),
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

    final authenticationService = AuthenticationService(
      authenticationRepository:
          AuthenticationRepository(FlutterSecureStorageFake()),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
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

    final authenticationService = AuthenticationService(
      authenticationRepository:
          AuthenticationRepository(FlutterSecureStorageFake()),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
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

    final authenticationService = AuthenticationService(
      authenticationRepository:
          AuthenticationRepository(FlutterSecureStorageFake()),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
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

    const authenticationService = AuthenticationServiceFake();

    final adapter = AuthentificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: authenticationService,
        inner: client,
      ),
      authenticationService: authenticationService,
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
