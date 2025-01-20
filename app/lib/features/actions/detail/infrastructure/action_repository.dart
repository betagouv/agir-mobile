import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/domain/action.dart';
import 'package:app/features/actions/detail/infrastructure/action_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ActionRepository {
  const ActionRepository({
    required final DioHttpClient client,
    required final MessageBus messageBus,
  })  : _client = client,
        _messageBus = messageBus;

  final DioHttpClient _client;
  final MessageBus _messageBus;

  Future<Either<Exception, Action>> fetchAction(final ActionId id) async {
    final response = await _client.get(Endpoints.action(id.value));

    return isResponseSuccessful(response.statusCode)
        ? Right(ActionMapper.fromJson(response.data as Map<String, dynamic>))
        : Left(Exception('Erreur lors de la récupération des actions'));
  }

  Future<Either<Exception, Unit>> updateActionStatus({
    required final ActionId id,
    required final ActionStatus status,
    required final String? reason,
  }) async {
    String actionStatusToJson(final ActionStatus status) => switch (status) {
          ActionStatus.toDo => 'todo',
          ActionStatus.inProgress => 'en_cours',
          ActionStatus.refused => 'pas_envie',
          ActionStatus.alreadyDone => 'deja_fait',
          ActionStatus.abandonned => 'abondon',
          ActionStatus.done => 'fait',
        };

    final data = {'status': actionStatusToJson(status)};
    if (reason != null) {
      data['motif'] = reason;
    }
    final response =
        await _client.patch(Endpoints.action(id.value), data: data);

    if (isResponseSuccessful(response.statusCode)) {
      _messageBus.publish(actionCompletedTopic);

      return const Right(unit);
    }

    return Left(
      Exception("Erreur lors de la mise à jour du statut de l'action"),
    );
  }
}
