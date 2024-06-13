import 'dart:async';
import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';

class UtilisateurApiAdapter implements UtilisateurPort {
  const UtilisateurApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Utilisateur> recupereUtilisateur() async {
    final id = await _apiClient.recupererUtilisateurId;
    if (id == null) {
      throw Exception();
    }
    final response = await _apiClient.get(Uri.parse('/utilisateurs/$id'));
    if (response.statusCode != 200) {
      throw UnimplementedError();
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Utilisateur(
      prenom: json['prenom'] as String,
      fonctionnalitesDebloquees:
          (json['fonctionnalites_debloquees'] as List<dynamic>)
              .where((final e) => e == Fonctionnalites.aides.name)
              .map((final e) => Fonctionnalites.values.byName(e as String))
              .toList(),
    );
  }
}
