import 'dart:async';
import 'dart:convert';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationApiAdapter implements AuthentificationPort {
  AuthentificationApiAdapter({
    required final DioHttpClient client,
    required final AuthenticationService authenticationService,
  })  : _client = client,
        _authenticationService = authenticationService;

  final DioHttpClient _client;
  final AuthenticationService _authenticationService;
  bool _connexionDemandee = false;

  @override
  Future<Either<ApiErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _client.post(
      Endpoints.login,
      data: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
      }),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = true;

      return const Right(null);
    }

    return handleError(
      jsonEncode(response.data),
      defaultMessage: 'Erreur lors de la connexion',
    ).fold(
      (final l) async {
        if (l.message != 'Utilisateur non actif') {
          return Left(l);
        }

        await renvoyerCodeDemande(informationDeConnexion.adresseMail);

        return const Right(null);
      },
      (final r) => const Right(null),
    );
  }

  @override
  Future<Either<Exception, void>> deconnexionDemandee() async {
    await _authenticationService.logout();

    return const Right(null);
  }

  @override
  Future<Either<ApiErreur, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _client.post(
      Endpoints.creationCompte,
      data: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
        'source_inscription': 'mobile',
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : handleError(
            jsonEncode(response.data),
            defaultMessage: 'Erreur lors de la création du compte',
          );
  }

  @override
  Future<Either<Exception, void>> renvoyerCodeDemande(
    final String email,
  ) async {
    final response = await _client.post(
      Endpoints.renvoyerCode,
      data: jsonEncode({'email': email}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du code'));
  }

  @override
  Future<Either<ApiErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    final uri =
        _connexionDemandee ? Endpoints.loginCode : Endpoints.validerCode;

    final response = await _client.post(
      uri,
      data: jsonEncode({
        'code': informationDeConnexion.code,
        'email': informationDeConnexion.adresseMail,
      }),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = false;
      final json = response.data as Map<String, dynamic>;
      final token = json['token'] as String;

      await _authenticationService.login(token);

      return const Right(null);
    }

    return handleError(
      jsonEncode(response.data),
      defaultMessage: 'Erreur lors de la validation du code',
    );
  }

  @override
  Future<Either<Exception, void>> oubliMotDePasse(final String email) async {
    final response = await _client.post(
      Endpoints.oubliMotDePasse,
      data: jsonEncode({'email': email}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la demande de mot de passe oublié'));
  }

  @override
  Future<Either<ApiErreur, void>> modifierMotDePasse({
    required final String email,
    required final String code,
    required final String motDePasse,
  }) async {
    final response = await _client.post(
      Endpoints.modifierMotDePasse,
      data: jsonEncode({
        'code': code,
        'email': email,
        'mot_de_passe': motDePasse,
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : handleError(
            jsonEncode(response.data),
            defaultMessage: 'Erreur lors de la modification du mot de passe',
          );
  }
}
