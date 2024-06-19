import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/informations/domain/entities/mes_informations.dart';
import 'package:app/features/profil/infrastructure/adapters/logement_mapper.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';

class ProfilApiAdapter implements ProfilPort {
  const ProfilApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Informations> recupererProfil() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }

    final response =
        await _apiClient.get(Uri.parse('/utilisateurs/$utilisateurId/profile'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Informations(
      prenom: json['prenom'] as String,
      nom: json['nom'] as String,
      email: json['email'] as String,
      codePostal: json['code_postal'] as String,
      ville: json['commune'] as String,
      nombreDePartsFiscales:
          (json['nombre_de_parts_fiscales'] as num).toDouble(),
      revenuFiscal: (json['revenu_fiscal'] as num?)?.toInt(),
    );
  }

  @override
  Future<void> mettreAJour({
    required final String prenom,
    required final String nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/profile');
    final body = jsonEncode({
      'email': email,
      'nom': nom,
      'nombre_de_parts_fiscales': nombreDePartsFiscales,
      'prenom': prenom,
      'revenu_fiscal': revenuFiscal,
    });

    final response = await _apiClient.patch(uri, body: body);

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  @override
  Future<Logement> recupererLogement() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/logement'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return LogementMapper.mapLogementFromJson(json);
  }

  @override
  Future<void> mettreAJourLogement({required final Logement logement}) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/logement');
    final body = jsonEncode(LogementMapper.mapLogementToJson(logement));

    final response = await _apiClient.patch(uri, body: body);

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  @override
  Future<void> supprimerLeCompte() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId');

    final response = await _apiClient.delete(uri);

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
