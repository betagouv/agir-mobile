import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/communes/domain/ports/communes_port.dart';
import 'package:fpdart/fpdart.dart';

class CommunesApiAdapter implements CommunesPort {
  const CommunesApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<String>>> recupererLesCommunes(
    final String codePostal,
  ) async {
    final response =
        await _apiClient.get(Uri.parse('/communes?code_postal=$codePostal'));

    return response.statusCode == HttpStatus.ok
        ? Right((jsonDecode(response.body) as List<dynamic>).cast())
        : Left(Exception('Erreur lors de la récupération des communes'));
  }
}
