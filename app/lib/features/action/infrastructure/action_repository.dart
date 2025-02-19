import 'dart:async';
import 'dart:developer';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_mapper.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:fpdart/fpdart.dart';

class ActionRepository {
  const ActionRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Action>> fetch(final String id, final ActionType type) async {
    log("Fetching action with type: ${type.toAPIString()} and id: $id");
    final response = await _client.get(Endpoints.action(type: type.toAPIString(), code: id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception("Type: ${type.toAPIString()},\nID: $id,\nError: Erreur lors de la récupération de l'action: ${response}"),
      );
    }

    final json = response.data! as Map<String, dynamic>;

    switch (type) {
      case ActionType.simulator:
        return Right(ActionSimulateurMapper.fromJson(json));
      case ActionType.classic:
        return Right(ActionMapper.fromJson(json));
      case ActionType.quiz:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ActionType.performance:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
