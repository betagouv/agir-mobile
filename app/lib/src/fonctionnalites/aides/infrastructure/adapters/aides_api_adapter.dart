import 'dart:async';
import 'dart:convert';

import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';

class AidesApiAdapter implements AidesRepository {
  AidesApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<List<Aide>> recupereLesAides() async {
    final response = await _apiClient.get(
      Uri.parse(
        '/utilisateurs/${await _apiClient.recupererUtilisateurId()}/aides',
      ),
    );
    if (response.statusCode != 200) {
      throw UnimplementedError();
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    final aides = json.map(
      (final e) {
        final f = e as Map<String, dynamic>;
        return Aide(
          titre: f['titre'] as String,
          thematique:
              (f['thematiques_label'] as List<dynamic>).cast<String>().first,
          montantMax: (f['montant_max'] as num?)?.toInt(),
          contenu: f['contenu'] as String,
        );
      },
    ).toList();
    return aides;
  }
}
