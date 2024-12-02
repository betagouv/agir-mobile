import 'dart:convert';
import 'dart:io';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/domain/user_id.dart';
import 'package:app/features/authentication/infrastructure/authentication_storage.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/utilisateur/domain/utilisateur.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_fake.dart';

void main() {
  const informationDeConnexion = InformationDeConnexion(
    adresseMail: 'test@example.com',
    motDePasse: 'password123',
  );

  test(
    "connexionDemandee envoie une requête POST à l'API avec les informations de connexion",
    () async {
      // Arrange.
      final dio = DioMock()..postM(Endpoints.login);

      final adapter = AuthentificationApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
        authenticationService: authenticationService,
      );

      // Act.
      await adapter.connexionDemandee(informationDeConnexion);

      // Assert.
      verify(
        () => dio.post<dynamic>(
          Endpoints.login,
          data:
              '{"email":"${informationDeConnexion.adresseMail}","mot_de_passe":"${informationDeConnexion.motDePasse}"}',
        ),
      );
    },
  );

  test('connexionDemandee avec un utilisateur non actif', () async {
    // Arrange.
    final dio = DioMock()
      ..postM(
        Endpoints.login,
        responseData: jsonDecode('{"message":"Utilisateur non actif"}'),
        statusCode: HttpStatus.badRequest,
      )
      ..postM(Endpoints.renvoyerCode);

    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      authenticationService: authenticationService,
    );

    // Act.
    await adapter.connexionDemandee(informationDeConnexion);

    // Assert.
    verify(
      () => dio.post<dynamic>(
        Endpoints.renvoyerCode,
        data: '{"email":"${informationDeConnexion.adresseMail}"}',
      ),
    );
  });

  test(
    "validationCodeConnexionDemandee ajoute le token et l'utisateurId dans le secure storage et modifie le statut a connecté",
    () async {
      final dio = DioMock()
        ..postM(Endpoints.login, statusCode: HttpStatus.created)
        ..postM(
          Endpoints.loginCode,
          responseData: jsonDecode(
            '''
{
  "token": "$token",
  "utilisateur": {
    "id": "user123"
  }
}''',
          ),
          statusCode: HttpStatus.created,
        );

      final flutterSecureStorage = FlutterSecureStorageFake();

      final authenticationService = AuthenticationService(
        authenticationRepository: AuthenticationStorage(flutterSecureStorage),
        clock: Clock.fixed(DateTime(1992)),
      );
      final adapter = AuthentificationApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
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
        () => dio.post<dynamic>(
          Endpoints.loginCode,
          data: '{"code":"123456","email":"test@example.com"}',
        ),
      );
    },
  );

  test(
    "deconnexionDemandee supprime le token et l'utisateurId dans le secure storage et modifie le statut a pas connecté",
    () async {
      // Arrange.
      final flutterSecureStorageMock = FlutterSecureStorageFake();

      final adapter = AuthentificationApiAdapter(
        client: DioHttpClient(
          dio: DioMock(),
          authenticationService: authenticationService,
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
    final dio = DioMock()
      ..postM(
        '/utilisateurs_v2',
        responseData: CustomResponse(
          '''
{
  "email": "${informationDeConnexion.adresseMail}",
}''',
        ),
        statusCode: HttpStatus.created,
      );

    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      authenticationService: authenticationService,
    );

    await adapter.creationDeCompteDemandee(informationDeConnexion);

    verify(
      () => dio.post<dynamic>(
        '/utilisateurs_v2',
        data:
            '{"email":"${informationDeConnexion.adresseMail}","mot_de_passe":"${informationDeConnexion.motDePasse}","source_inscription":"mobile"}',
      ),
    );
  });

  test('validationDemandee', () async {
    final dio = DioMock()
      ..postM(
        Endpoints.validerCode,
        responseData: jsonDecode(
          '''
{
  "token": "$token",
  "utilisateur": {
    "id": "$utilisateurId"
  }
}''',
        ),
        statusCode: HttpStatus.created,
      );

    final flutterSecureStorageMock = FlutterSecureStorageFake();
    final authenticationService = AuthenticationService(
      authenticationRepository: AuthenticationStorage(flutterSecureStorageMock),
      clock: Clock.fixed(DateTime(1992)),
    );
    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
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
      () => dio.post<dynamic>(
        Endpoints.validerCode,
        data: '{"code":"123456","email":"test@example.com"}',
      ),
    );
  });

  test('renvoyerCode', () async {
    final dio = DioMock()..postM(Endpoints.renvoyerCode);

    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      authenticationService: authenticationService,
    );

    await adapter.renvoyerCodeDemande('test@example.com');
    verify(
      () => dio.post<dynamic>(
        Endpoints.renvoyerCode,
        data: '{"email":"test@example.com"}',
      ),
    );
  });

  test('oubliMotDePasse', () async {
    final dio = DioMock()
      ..postM(
        Endpoints.oubliMotDePasse,
        responseData: jsonDecode('''
{
  "email": "test@example.com"
}'''),
        statusCode: HttpStatus.created,
      );

    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      authenticationService: authenticationService,
    );

    await adapter.oubliMotDePasse('test@example.com');

    verify(
      () => dio.post<dynamic>(
        Endpoints.oubliMotDePasse,
        data: '{"email":"test@example.com"}',
      ),
    );
  });

  test('modifierMotDePasse', () async {
    final dio = DioMock()
      ..postM(Endpoints.modifierMotDePasse, statusCode: HttpStatus.created);

    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      authenticationService: authenticationService,
    );

    await adapter.modifierMotDePasse(
      email: 'test@example.com',
      code: '123456',
      motDePasse: 'password123',
    );

    verify(
      () => dio.post<dynamic>(
        Endpoints.modifierMotDePasse,
        data:
            '{"code":"123456","email":"test@example.com","mot_de_passe":"password123"}',
      ),
    );
  });

  test('recupereUtilisateur', () async {
    // Arrange.
    const prenom = 'Lucas';
    final dio = DioMock()
      ..getM(
        Endpoints.utilisateur,
        responseData: jsonDecode(
          '''
{
  "id": "saudon",
  "nom": "Saudon",
  "prenom": "$prenom",
  "email": "ls@mail.com",
  "is_onboarding_done": true
}''',
        ),
      );

    final adapter = AuthentificationApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      authenticationService: authenticationService,
    );

    // Act.
    final utilisateur = await adapter.recupereUtilisateur();

    // Assert.
    expect(
      utilisateur.getRight().getOrElse(() => throw Exception()),
      const Utilisateur(prenom: prenom, estIntegrationTerminee: true),
    );
  });
}
