import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitreApiAdapter implements MieuxVousConnaitrePort {
  const MieuxVousConnaitreApiAdapter({
    required final DioHttpClient client,
    required final MessageBus messageBus,
  })  : _client = client,
        _messageBus = messageBus;

  final DioHttpClient _client;
  final MessageBus _messageBus;

  @override
  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  }) async {
    final response = await _client.get(
      '/utilisateurs/{userId}/questionsKYC/$id',
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération de la question'));
    }

    final fromJson = QuestionMapper.fromJson(
      response.data as Map<String, dynamic>,
    );

    return fromJson == null
        ? Left(Exception('Erreur lors de la récupération de la question'))
        : Right(fromJson);
  }

  @override
  Future<Either<Exception, Unit>> mettreAJour(final Question question) async {
    final object = switch (question) {
      ChoixMultipleQuestion() => {'reponse': question.responses.value},
      ChoixUniqueQuestion() => {'reponse': question.responses.value},
      LibreQuestion() => {'reponse': question.responses.value},
      MosaicQuestion() => {
          'reponse_mosaic': question.responses
              .map(
                (final e) =>
                    {'boolean_value': e.isSelected, 'code': e.id.value},
              )
              .toList(),
        },
      EntierQuestion() => {'reponse': question.responses.value},
    };

    final response = await _client.put(
      '/utilisateurs/{userId}/questionsKYC/${question.id.value}',
      data: jsonEncode(object),
    );

    if (isResponseSuccessful(response.statusCode)) {
      _messageBus.publish(kycTopic);

      return const Right(unit);
    }

    return Left(Exception('Erreur lors de la mise à jour des réponses'));
  }
}
