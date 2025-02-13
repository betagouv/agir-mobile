import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/lvao/domain/lvao_actor.dart';
import 'package:app/features/services/lvao/infrastructure/lvao_actor_mapper.dart';
import 'package:fpdart/fpdart.dart';

class LvaoRepository {
  const LvaoRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<LvaoActor>>> fetch({required final String category}) async {
    final response = await _client.post(
      Endpoints.lvaoSearch,
      data: {'categorie': category, 'nombre_max_resultats': 4, 'rayon_metres': 5000},
    );

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération des lieux de Que faire de mes objets'))
        : Right(
          ((response.data as Map<String, dynamic>)['resultats'] as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(LvaoActorMapper.fromJson)
              .toList(),
        );
  }
}
