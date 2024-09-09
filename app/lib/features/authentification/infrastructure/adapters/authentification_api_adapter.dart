import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/domain/entities/authentification_erreur.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/erreur_mapper.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationApiAdapter implements AuthentificationPort {
  AuthentificationApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;
  bool _connexionDemandee = false;

  @override
  Future<Either<AuthentificationErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/login_v2'),
      body: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
      }),
    );

    if (response.statusCode == HttpStatus.created) {
      _connexionDemandee = true;

      return const Right(null);
    }

    return _handleError(
      response.body,
      defaultMessage: 'Erreur lors de la connexion',
    );
  }

  @override
  Future<Either<Exception, void>> deconnexionDemandee() async {
    await _apiClient.supprimerTokenEtUtilisateurId();

    return const Right(null);
  }

  @override
  Future<Either<AuthentificationErreur, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs_v2'),
      body: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
      }),
    );

    return response.statusCode == HttpStatus.created
        ? const Right(null)
        : _handleError(
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

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du code'));
  }

  @override
  Future<Either<AuthentificationErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    final uri = _connexionDemandee
        ? '/utilisateurs/login_v2_code'
        : '/utilisateurs/valider';
    _connexionDemandee = false;
    final response = await _apiClient.post(
      Uri.parse(uri),
      body: jsonEncode({
        'code': informationDeConnexion.code,
        'email': informationDeConnexion.adresseMail,
      }),
    );

    if (response.statusCode == HttpStatus.created) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final token = json['token'] as String;

      await _apiClient.sauvegarderToken(token);

      return const Right(null);
    }

    return _handleError(
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

    return response.statusCode == HttpStatus.created
        ? const Right(null)
        : Left(Exception('Erreur lors de la demande de mot de passe oublié'));
  }

  @override
  Future<Either<AuthentificationErreur, void>> modifierMotDePasse({
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

    return response.statusCode == HttpStatus.created
        ? const Right(null)
        : _handleError(
            response.body,
            defaultMessage: 'Erreur lors de la modification du mot de passe',
          );
  }

  Left<AuthentificationErreur, void> _handleError(
    final String errorMessage, {
    required final String defaultMessage,
  }) {
    if (errorMessage.isEmpty) {
      return Left(AuthentificationErreur(defaultMessage));
    }

    final json = jsonDecode(errorMessage) as Map<String, dynamic>;
    final message = AuthentificationErreurMapper.fromJson(json);

    return Left(message);
  }

  @override
  Future<Either<Exception, Utilisateur>> recupereUtilisateur() async {
    final id = await _apiClient.recupererUtilisateurId;
    if (id == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.get(Uri.parse('/utilisateurs/$id'));
    if (response.statusCode != HttpStatus.ok) {
      return Left(
        Exception("Erreur lors de la récupération de l'utilisateur"),
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(
      Utilisateur(
        prenom: json['prenom'] as String? ?? '',
        estIntegrationTerminee: json['is_onboarding_done'] as bool,
        aMaVilleCouverte: json['couverture_aides_ok'] as bool,
      ),
    );
  }
}
