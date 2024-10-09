import 'dart:io';

import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class KnowYourCustomersRepository {
  const KnowYourCustomersRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<Question>>> fetchQuestions() async {
    final response = await _client.get('/utilisateurs/{userId}/questionsKYC');
    if (response.statusCode == HttpStatus.ok) {
      final data = response.data! as List<dynamic>;

      return Right(
        data
            .map((final e) => e as Map<String, dynamic>)
            .map(QuestionMapper.fromJson)
            .whereType<Question>()
            .where(
              (final e) => switch (e) {
                LibreQuestion() => e.responses.value.isNotEmpty,
                ChoixUniqueQuestion() => e.responses.value.isNotEmpty,
                ChoixMultipleQuestion() => e.responses.value.isNotEmpty,
                MosaicQuestion() => e.answered,
              },
            )
            .toList(),
      );
    }

    return Left(Exception('Erreur lors de la récupération des questions'));
  }
}
