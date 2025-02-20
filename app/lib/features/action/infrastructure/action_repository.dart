import 'dart:async';

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
    final actionTypeAPI = actionTypeToAPIString(type);
    final response = await _client.get(Endpoints.action(type: actionTypeAPI, code: id));

    if (isResponseUnsuccessful(response.statusCode)) {
      // TODO(erolley): specify a better error message?
      return Left(Exception("Type: $actionTypeAPI,\nID: $id,\nError: Erreur lors de la récupération de l'action: $response"));
    }

    final json = response.data! as Map<String, dynamic>;

    switch (type) {
      case ActionType.simulator:
        return Right(ActionSimulatorMapper.fromJson(json));
      case ActionType.classic:
        return Right(ActionClassicMapper.fromJson(json));
      case ActionType.quiz:
      case ActionType.performance:
        // TODO(erolley): Handle this case.
        throw UnimplementedError();
    }
  }
}
