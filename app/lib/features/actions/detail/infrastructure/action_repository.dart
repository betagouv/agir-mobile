import 'dart:io';

import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/domain/action.dart';
import 'package:app/features/actions/detail/infrastructure/action_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
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
    final utilisateurId = await _client.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _client.get<dynamic>(
      '/utilisateurs/$utilisateurId/defis/${id.value}',
    );

    return response.statusCode == HttpStatus.ok
        ? Right(ActionMapper.fromJson(response.data as Map<String, dynamic>))
        : Left(Exception('Erreur lors de la récupération des actions'));
  }

  Future<Either<Exception, Unit>> updateActionStatus({
    required final ActionId id,
    required final ActionStatus status,
    required final String? reason,
  }) async {
    final utilisateurId = await _client.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    String actionStatusToJson(final ActionStatus status) => switch (status) {
          ActionStatus.toDo => 'todo',
          ActionStatus.inProgress => 'en_cours',
          ActionStatus.refused => 'pas_envie',
          ActionStatus.alreadyDone => 'deja_fait',
          ActionStatus.abandonned => 'abondon',
          ActionStatus.done => 'fait',
        };

    final path = '/utilisateurs/$utilisateurId/defis/${id.value}';
    final data = {'status': actionStatusToJson(status)};
    if (reason != null) {
      data['motif'] = reason;
    }
    final response = await _client.patch<void>(path, data: data);

    if (response.statusCode == HttpStatus.ok) {
      _messageBus.publish(actionCompletedTopic);

      return const Right(unit);
    }

    return Left(
      Exception("Erreur lors de la mise à jour du statut de l'action"),
    );
  }
}
