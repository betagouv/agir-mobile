import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/communes/domain/ports/communes_port.dart';

class CommunesApiAdapter implements CommunesPort {
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
