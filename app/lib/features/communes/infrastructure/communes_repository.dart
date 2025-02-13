import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:fpdart/fpdart.dart';

class CommunesRepository {
  const CommunesRepository({required final DioHttpClient client})
    : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<String>>> recupererLesCommunes(
    final String codePostal,
  ) async {
    final response = await _client.get(Endpoints.communes(codePostal));

    return isResponseSuccessful(response.statusCode)
        ? Right((response.data as List<dynamic>).cast())
        : Left(Exception('Erreur lors de la récupération des communes'));
  }
}
