import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationApiAdapter implements AuthentificationPort {
  const AuthentificationApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, void>> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/login'),
      body: jsonEncode({
        'email': informationDeConnexion.adresseMail,
        'mot_de_passe': informationDeConnexion.motDePasse,
      }),
    );
    if (response.statusCode != 201) {
      return Left(Exception('Erreur lors de la connexion'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final token = json['token'] as String;
    await _apiClient.sauvegarderToken(token);

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> deconnectionDemandee() async {
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
    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/valider'),
      body: jsonEncode({
        'code': informationDeConnexion.code,
        'email': informationDeConnexion.adresseMail,
      }),
    );

    if (response.statusCode != HttpStatus.created) {
      return Left(Exception('Erreur lors de la validation du code'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final token = json['token'] as String;

    await _apiClient.sauvegarderToken(token);

    return const Right(null);
  }
}
