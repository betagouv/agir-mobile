import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/mission/mission/domain/mission.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/infrastructure/mission_mapper.dart';
import 'package:fpdart/fpdart.dart';

class MissionRepository {
  const MissionRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Mission>> fetch(final MissionCode code) async {
    final response = await _client.get(Endpoints.mission(code.value));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération de la mission'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(MissionMapper.fromJson(json));
  }

  Future<Either<Exception, void>> complete(final MissionCode code) async {
    final response = await _client.post(Endpoints.missionTerminer(code.value));

    return isResponseSuccessful(response.statusCode) ? const Right(null) : Left(Exception('Erreur lors de la fin de la mission'));
  }
}
