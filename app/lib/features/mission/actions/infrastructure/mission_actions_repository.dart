import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/mission/actions/domain/mission_actions.dart';
import 'package:app/features/mission/actions/infrastructure/mission_actions_mapper.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:fpdart/fpdart.dart';

class MissionActionsRepository {
  const MissionActionsRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, MissionActions>> fetch(
    final MissionCode code,
  ) async {
    final response = await _client.get(Endpoints.mission(code.value));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception(
          'Erreur lors de la récupération des actions de la mission',
        ),
      );
    }

    final json = response.data as Map<String, dynamic>;

    return Right(MissionActionsMapper.fromJson(json));
  }
}
