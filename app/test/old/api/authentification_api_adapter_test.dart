import 'dart:convert';
import 'dart:io';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/domain/user_id.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../mocks/flutter_secure_storage_fake.dart';
import 'constants.dart';

void main() {
  const informationDeConnexion = InformationDeConnexion(adresseMail: 'test@example.com', motDePasse: 'password123');

  test("connexionDemandee envoie une requête POST à l'API avec les informations de connexion", () async {
    // Arrange.
    final dio = DioMock()..postM(Endpoints.login);

    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    // Act.
    await repository.connexionDemandee(informationDeConnexion);

    // Assert.
    verify(
      () => dio.post<dynamic>(
        Endpoints.login,
        data: '{"email":"${informationDeConnexion.adresseMail}","mot_de_passe":"${informationDeConnexion.motDePasse}"}',
      ),
    );
  });

  test('connexionDemandee avec un utilisateur non actif', () async {
    // Arrange.
    final dio =
        DioMock()
          ..postM(
            Endpoints.login,
            statusCode: HttpStatus.badRequest,
            responseData: jsonDecode('{"message":"Utilisateur non actif"}'),
          )
          ..postM(Endpoints.renvoyerCode);

    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    // Act.
    await repository.connexionDemandee(informationDeConnexion);

    // Assert.
    verify(() => dio.post<dynamic>(Endpoints.renvoyerCode, data: '{"email":"${informationDeConnexion.adresseMail}"}'));
  });

  test(
    "validationCodeConnexionDemandee ajoute le token et l'utisateurId dans le secure storage et modifie le statut a connecté",
    () async {
      final dio =
          DioMock()
            ..postM(Endpoints.login, statusCode: HttpStatus.created)
            ..postM(
              Endpoints.loginCode,
              statusCode: HttpStatus.created,
              responseData: jsonDecode('''
{
  "token": "$token",
  "utilisateur": {
    "id": "user123"
  }
}'''),
            );

      final flutterSecureStorage = FlutterSecureStorageFake();

      final authenticationService = AuthenticationService(
        authenticationStorage: AuthenticationStorage(flutterSecureStorage),
        clock: Clock.fixed(DateTime(1992)),
      );
      final repository = AuthentificationRepository(
        client: DioHttpClient(dio: dio, authenticationService: authenticationService),
        authenticationService: authenticationService,
      );
      await repository.connexionDemandee(informationDeConnexion);

      // Act.
      await repository.validationDemandee(const InformationDeCode(adresseMail: 'test@example.com', code: '123456'));

      // Assert.
      final actual = await flutterSecureStorage.readAll();
      expect(actual, {'token': token});
      expect(authenticationService.status, const Authenticated(UserId(utilisateurId)));

      verify(() => dio.post<dynamic>(Endpoints.loginCode, data: '{"code":"123456","email":"test@example.com"}'));
    },
  );

  test(
    "deconnexionDemandee supprime le token et l'utisateurId dans le secure storage et modifie le statut a pas connecté",
    () async {
      // Arrange.
      final flutterSecureStorageMock = FlutterSecureStorageFake();

      final dioMock = DioMock()..postM(Endpoints.logout);
      final repository = AuthentificationRepository(
        client: DioHttpClient(dio: dioMock, authenticationService: authenticationService),
        authenticationService: authenticationService,
      );

      // Act.
      await repository.deconnexionDemandee();

      // Assert.
      expect(await flutterSecureStorageMock.readAll(), <String, dynamic>{});
      expect(authenticationService.status, const Unauthenticated());
    },
  );

  test('creationDeCompteDemandee', () async {
    final dio =
        DioMock()..postM(
          Endpoints.creationCompte,
          statusCode: HttpStatus.created,
          responseData: '''
{
  "email": "${informationDeConnexion.adresseMail}",
}''',
        );

    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    await repository.creationDeCompteDemandee(informationDeConnexion);

    verify(
      () => dio.post<dynamic>(
        Endpoints.creationCompte,
        data:
            '{"email":"${informationDeConnexion.adresseMail}","mot_de_passe":"${informationDeConnexion.motDePasse}","source_inscription":"mobile"}',
      ),
    );
  });

  test('validationDemandee', () async {
    final dio =
        DioMock()..postM(
          Endpoints.validerCode,
          statusCode: HttpStatus.created,
          responseData: jsonDecode('''
{
  "token": "$token",
  "utilisateur": {
    "id": "$utilisateurId"
  }
}'''),
        );

    final flutterSecureStorageMock = FlutterSecureStorageFake();
    final authenticationService = AuthenticationService(
      authenticationStorage: AuthenticationStorage(flutterSecureStorageMock),
      clock: Clock.fixed(DateTime(1992)),
    );
    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    await repository.validationDemandee(const InformationDeCode(adresseMail: 'test@example.com', code: '123456'));

    // Assert.
    expect(await flutterSecureStorageMock.readAll(), {'token': token});
    expect(authenticationService.status, const Authenticated(UserId(utilisateurId)));

    verify(() => dio.post<dynamic>(Endpoints.validerCode, data: '{"code":"123456","email":"test@example.com"}'));
  });

  test('renvoyerCode', () async {
    final dio = DioMock()..postM(Endpoints.renvoyerCode);

    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    await repository.renvoyerCodeDemande('test@example.com');
    verify(() => dio.post<dynamic>(Endpoints.renvoyerCode, data: '{"email":"test@example.com"}'));
  });

  test('oubliMotDePasse', () async {
    final dio =
        DioMock()..postM(
          Endpoints.oubliMotDePasse,
          statusCode: HttpStatus.created,
          responseData: jsonDecode('''
{
  "email": "test@example.com"
}'''),
        );

    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    await repository.oubliMotDePasse('test@example.com');

    verify(() => dio.post<dynamic>(Endpoints.oubliMotDePasse, data: '{"email":"test@example.com"}'));
  });

  test('modifierMotDePasse', () async {
    final dio = DioMock()..postM(Endpoints.modifierMotDePasse, statusCode: HttpStatus.created);

    final repository = AuthentificationRepository(
      client: DioHttpClient(dio: dio, authenticationService: authenticationService),
      authenticationService: authenticationService,
    );

    await repository.modifierMotDePasse(email: 'test@example.com', code: '123456', motDePasse: 'password123');

    verify(
      () => dio.post<dynamic>(
        Endpoints.modifierMotDePasse,
        data: '{"code":"123456","email":"test@example.com","mot_de_passe":"password123"}',
      ),
    );
  });
}
