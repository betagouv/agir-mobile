import 'dart:convert';

import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/communes/domain/ports/communes_repository.dart';

class CommunesApiAdapter implements CommunesRepository {
  const CommunesApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<List<String>> recupererLesCommunes(final String codePostal) async {
    final response =
        await _apiClient.get(Uri.parse('/communes?code_postal=$codePostal'));
    if (response.statusCode != 200) {
      throw UnimplementedError();
    }

    return (jsonDecode(response.body) as List<dynamic>).cast();
  }
}
