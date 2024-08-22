import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/error_mapper.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationApiAdapter implements AuthentificationPort {
  AuthentificationApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;
  bool _connexionDemandee = false;

  @override
  Future<Either<Exception, void>> connexionDemandee(
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

    if (response.body.isEmpty) {
      return Left(Exception('Erreur lors de la connexion'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final message = AdapterErreurMapper.fromJson(json);

    return Left(message);
  }

  @override
  Future<Either<Exception, void>> deconnexionDemandee() async {
    await _apiClient.supprimerTokenEtUtilisateurId();

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs_v2'),
      body: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
      }),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la création du compte'));
  }

  @override
  Future<Either<Exception, void>> renvoyerCodeDemandee(
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
  Future<Either<Exception, void>> validationDemandee(
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

    if (response.body.isEmpty) {
      return Left(Exception('Erreur lors de la validation du code'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final message = AdapterErreurMapper.fromJson(json);

    return Left(message);
  }
}
