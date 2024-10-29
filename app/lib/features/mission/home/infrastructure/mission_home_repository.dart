import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/infrastructure/mission_liste_mapper.dart';
import 'package:fpdart/fpdart.dart';

class MissionHomeRepository {
  const MissionHomeRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<MissionListe>>> fetch() async {
    final response =
        await _client.get('/utilisateurs/{userId}/thematiques_recommandees');

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des missions'));
    }

    final json = response.data as List<dynamic>;

    return Right(
      json
          .map(
            (final e) => MissionListeMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
