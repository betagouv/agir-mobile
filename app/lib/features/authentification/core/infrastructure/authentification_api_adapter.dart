import 'dart:async';
import 'dart:convert';

import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/utilisateur/domain/utilisateur.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationApiAdapter implements AuthentificationPort {
  AuthentificationApiAdapter({
    required final AuthentificationApiClient apiClient,
    required final AuthenticationService authenticationService,
  })  : _apiClient = apiClient,
        _authenticationService = authenticationService;

  final AuthentificationApiClient _apiClient;
  final AuthenticationService _authenticationService;
  bool _connexionDemandee = false;

  @override
  Future<Either<ApiErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/login_v2'),
      body: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
      }),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = true;

      return const Right(null);
    }

    return handleError(
      response.body,
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
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs_v2'),
      body: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
        'source_inscription': 'mobile',
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : handleError(
            response.body,
            defaultMessage: 'Erreur lors de la création du compte',
          );
  }

  @override
  Future<Either<Exception, void>> renvoyerCodeDemande(
    final String email,
  ) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/renvoyer_code'),
      body: jsonEncode({'email': email}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du code'));
  }

  @override
  Future<Either<ApiErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    final uri = _connexionDemandee
        ? '/utilisateurs/login_v2_code'
        : '/utilisateurs/valider';

    final response = await _apiClient.post(
      Uri.parse(uri),
      body: jsonEncode({
        'code': informationDeConnexion.code,
        'email': informationDeConnexion.adresseMail,
      }),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _connexionDemandee = false;
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final token = json['token'] as String;

      await _authenticationService.login(token);

      return const Right(null);
    }

    return handleError(
      response.body,
      defaultMessage: 'Erreur lors de la validation du code',
    );
  }

  @override
  Future<Either<Exception, void>> oubliMotDePasse(final String email) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/oubli_mot_de_passe'),
      body: jsonEncode({'email': email}),
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
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/modifier_mot_de_passe'),
      body: jsonEncode({
        'code': code,
        'email': email,
        'mot_de_passe': motDePasse,
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : handleError(
            response.body,
            defaultMessage: 'Erreur lors de la modification du mot de passe',
          );
  }

  @override
  Future<Either<Exception, Utilisateur>> recupereUtilisateur() async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response =
        await _apiClient.get(Uri.parse('/utilisateurs/$utilisateurId'));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception("Erreur lors de la récupération de l'utilisateur"),
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(
      Utilisateur(
        prenom: json['prenom'] as String? ?? '',
        estIntegrationTerminee: json['is_onboarding_done'] as bool,
      ),
    );
  }
}
