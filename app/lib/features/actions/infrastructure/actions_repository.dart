import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/actions/infrastructure/action_summary_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ActionsRepository {
  const ActionsRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<ActionSummary>>> fetch() async {
    final response = await _client.get(Endpoints.actions);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des actions'));
    }

    final json = response.data! as List<dynamic>;

    return Right(
      json
          .cast<Map<String, dynamic>>()
          .map(ActionSummaryMapper.fromJson)
          .where((final e) => e.type == ActionType.classic || e.type == ActionType.simulator)
          .toList(),
    );
  }
}
