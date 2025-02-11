import 'dart:async';
import 'dart:convert';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/france_connect/domain/open_id.dart';
import 'package:fpdart/fpdart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthentificationRepository {
  AuthentificationRepository({required final DioHttpClient client, required final AuthenticationService authenticationService})
    : _client = client,
      _authenticationService = authenticationService;

  final DioHttpClient _client;
  final AuthenticationService _authenticationService;
  var _connexionDemandee = false;

  Future<Either<ApiErreur, Unit>> connexionDemandee(final InformationDeConnexion informationDeConnexion) async {
    final response = await _client.post(
      Endpoints.login,
      data: jsonEncode({'email': informationDeConnexion.adresseMail, 'mot_de_passe': informationDeConnexion.motDePasse}),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = true;

      return const Right(unit);
    }

    return handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la connexion').fold((final l) async {
      if (l.message != 'Utilisateur non actif') {
        return Left(l);
      }

      await renvoyerCodeDemande(informationDeConnexion.adresseMail);

      return const Right(unit);
    }, (final r) => const Right(unit));
  }

  Future<Either<Exception, Unit>> deconnexionDemandee() async {
    final response = await _client.post(Endpoints.logout);
    if (isResponseSuccessful(response.statusCode) && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final callbackUrl = data['france_connect_logout_url'] as String?;
      if (callbackUrl != null) {
        unawaited(FnvUrlLauncher.launch(callbackUrl, mode: LaunchMode.externalApplication));
      }
    }
    await _authenticationService.logout();

    return const Right(unit);
  }

  Future<Either<ApiErreur, Unit>> creationDeCompteDemandee(final InformationDeConnexion informationDeConnexion) async {
    final response = await _client.post(
      Endpoints.creationCompte,
      data: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
        'source_inscription': 'mobile',
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la création du compte');
  }

  Future<Either<Exception, Unit>> renvoyerCodeDemande(final String email) async {
    final response = await _client.post(Endpoints.renvoyerCode, data: jsonEncode({'email': email}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la validation du code'));
  }

  Future<Either<ApiErreur, Unit>> validationDemandee(final InformationDeCode informationDeConnexion) async {
    final uri = _connexionDemandee ? Endpoints.loginCode : Endpoints.validerCode;

    final response = await _client.post(
      uri,
      data: jsonEncode({'code': informationDeConnexion.code, 'email': informationDeConnexion.adresseMail}),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = false;
      final json = response.data as Map<String, dynamic>;
      final token = json['token'] as String;

      await _authenticationService.login(token);

      return const Right(unit);
    }

    return handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la validation du code');
  }

  Future<Either<Exception, Unit>> oubliMotDePasse(final String email) async {
    final response = await _client.post(Endpoints.oubliMotDePasse, data: jsonEncode({'email': email}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : Left(Exception('Erreur lors de la demande de mot de passe oublié'));
  }

  Future<Either<ApiErreur, Unit>> modifierMotDePasse({
    required final String email,
    required final String code,
    required final String motDePasse,
  }) async {
    final response = await _client.post(
      Endpoints.modifierMotDePasse,
      data: jsonEncode({'code': code, 'email': email, 'mot_de_passe': motDePasse}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la modification du mot de passe');
  }

  void franceConnectStep1() =>
      unawaited(FnvUrlLauncher.launch('${_client.baseUrl}/login_france_connect', mode: LaunchMode.externalApplication));

  Future<Either<ApiErreur, Unit>> franceConnectStep2({required final OpenId openId}) async {
    final uri = Uri(path: Endpoints.franceConnectStep2, queryParameters: {'oidc_code': openId.code, 'oidc_state': openId.state});
    final response = await _client.get(uri.toString());
    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = false;
      final json = response.data as Map<String, dynamic>;
      final token = json['token'] as String;

      await _authenticationService.login(token);

      return const Right(unit);
    }

    return handleError(jsonEncode(response.data), defaultMessage: 'Erreur lors de la connexion via FranceConnect');
  }
}
