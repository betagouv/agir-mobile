import 'dart:async';
import 'dart:convert';

import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/domain/ports/aides_port.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';

class AidesApiAdapter implements AidesPort {
  const AidesApiAdapter({required final AuthentificationApiClient apiClient})
      : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<List<Aide>> recupereLesAides() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }
    final response = await _apiClient.get(
      Uri.parse('/utilisateurs/$utilisateurId/aides'),
    );
    if (response.statusCode != 200) {
      throw Exception();
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return json.map((final e) {
      final f = e as Map<String, dynamic>;

      return Aide(
        titre: f['titre'] as String,
        thematique: (f['thematiques_label'] as List<dynamic>)
                .cast<String>()
                .firstOrNull ??
            '',
        contenu: f['contenu'] as String,
        montantMax: (f['montant_max'] as num?)?.toInt(),
        urlSimulateur: f['url_simulateur'] as String?,
      );
    }).toList();
  }
}
