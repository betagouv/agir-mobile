import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ActionRepository {
  const ActionRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Action>> fetch(final String id) async {
    final response = await _client.get(Endpoints.action(id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception("Erreur lors de la récupération l'action"));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(ActionMapper.fromJson(json));
  }
}
