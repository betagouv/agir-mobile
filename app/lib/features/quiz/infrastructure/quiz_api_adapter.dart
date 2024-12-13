import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:app/features/quiz/infrastructure/quiz_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuizApiAdapter implements QuizPort {
  const QuizApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, Quiz>> recupererQuiz(final String id) async {
    final response = await _client.get(Endpoints.quiz(id));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du quiz'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(QuizMapper.fromJson(json: json));
  }

  @override
  Future<Either<Exception, void>> terminerQuiz({
    required final String id,
    required final bool estExacte,
  }) async {
    final response = await _client.post(
      Endpoints.events,
      data: jsonEncode({
        'content_id': id,
        'number_value': estExacte ? 100 : 0,
        'type': 'quizz_score',
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
