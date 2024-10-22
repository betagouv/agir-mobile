import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/communes/domain/communes_port.dart';
import 'package:fpdart/fpdart.dart';

class CommunesApiAdapter implements CommunesPort {
  const CommunesApiAdapter({
    required final AuthentificationApiClient client,
  }) : _apiClient = client;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<String>>> recupererLesCommunes(
    final String codePostal,
  ) async {
    final response =
        await _apiClient.get(Uri.parse('/communes?code_postal=$codePostal'));

    return isResponseSuccessful(response.statusCode)
        ? Right((jsonDecode(response.body) as List<dynamic>).cast())
        : Left(Exception('Erreur lors de la récupération des communes'));
  }
}
