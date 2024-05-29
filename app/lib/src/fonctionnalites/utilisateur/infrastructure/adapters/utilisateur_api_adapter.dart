import 'dart:async';
import 'dart:convert';

import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/ports/utilisateur_repository.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';

class UtilisateurApiAdapter implements UtilisateurRepository {
  UtilisateurApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Utilisateur> recupereUtilisateur() async {
    final response = await _apiClient.get(
      Uri.parse('/utilisateurs/${await _apiClient.recupererUtilisateurId()}'),
    );
    if (response.statusCode != 200) {
      throw UnimplementedError();
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return Utilisateur(prenom: json['prenom'] as String);
  }
}
