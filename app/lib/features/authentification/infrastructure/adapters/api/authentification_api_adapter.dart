import 'dart:async';
import 'dart:convert';

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';

class AuthentificationApiAdapter implements AuthentificationPort {
  const AuthentificationApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<void> connectionDemandee(
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
      return;
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final token = json['token'] as String;
    final utilisateur = json['utilisateur'] as Map<String, dynamic>;
    final utilisateurId = utilisateur['id'] as String;
    await _apiClient.sauvegarderTokenEtUtilisateurId(token, utilisateurId);
  }

  @override
  Future<void> deconnectionDemandee() async {
    await _apiClient.supprimerTokenEtUtilisateurId();
  }
}
