import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/communes/domain/communes_port.dart';
import 'package:fpdart/fpdart.dart';

class CommunesApiAdapter implements CommunesPort {
  const CommunesApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<String>>> recupererLesCommunes(
    final String codePostal,
  ) async {
    final response = await _client.get(
      Uri(
        path: Endpoints.communes,
        queryParameters: {'code_postal': codePostal},
      ).toString(),
    );

    return isResponseSuccessful(response.statusCode)
        ? Right((response.data as List<dynamic>).cast())
        : Left(Exception('Erreur lors de la récupération des communes'));
  }
}
