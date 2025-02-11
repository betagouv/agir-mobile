import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/detail/domain/challenge.dart';
import 'package:app/features/challenges/detail/infrastructure/challenge_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ChallengeRepository {
  const ChallengeRepository({
    required final DioHttpClient client,
    required final MessageBus messageBus,
  })  : _client = client,
        _messageBus = messageBus;

  final DioHttpClient _client;
  final MessageBus _messageBus;

  Future<Either<Exception, Challenge>> fetchChallenge(
    final ChallengeId id,
  ) async {
    final response = await _client.get(Endpoints.challenge(id.value));

    return isResponseSuccessful(response.statusCode)
        ? Right(ChallengeMapper.fromJson(response.data as Map<String, dynamic>))
        : Left(Exception('Erreur lors de la récupération des défis'));
  }

  Future<Either<Exception, Unit>> updateChallengeStatus({
    required final ChallengeId id,
    required final ChallengeStatus status,
    required final String? reason,
  }) async {
    String challengeStatusToJson(final ChallengeStatus status) =>
        switch (status) {
          ChallengeStatus.toDo => 'todo',
          ChallengeStatus.inProgress => 'en_cours',
          ChallengeStatus.refused => 'pas_envie',
          ChallengeStatus.alreadyDone => 'deja_fait',
          ChallengeStatus.abandonned => 'abondon',
          ChallengeStatus.done => 'fait',
        };

    final data = {'status': challengeStatusToJson(status)};
    if (reason != null) {
      data['motif'] = reason;
    }
    final response =
        await _client.patch(Endpoints.challenge(id.value), data: data);

    if (isResponseSuccessful(response.statusCode)) {
      _messageBus.publish(challengeCompletedTopic);

      return const Right(unit);
    }

    return Left(
      Exception('Erreur lors de la mise à jour du statut du défi'),
    );
  }
}
