import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:app/features/quiz/infrastructure/quiz_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuizApiAdapter implements QuizPort {
  const QuizApiAdapter({
    required final DioHttpClient client,
    required final CmsApiClient cmsApiClient,
  })  : _client = client,
        _cmsApiClient = cmsApiClient;

  final DioHttpClient _client;
  final CmsApiClient _cmsApiClient;

  @override
  Future<Either<Exception, Quiz>> recupererQuiz(final String id) async {
    final cmsResponse = await _cmsApiClient.get(
      Uri.parse(
        '/api/quizzes/$id?populate[0]=questions.reponses,thematique_gamification,articles.partenaire.logo',
      ),
    );

    if (isResponseUnsuccessful(cmsResponse.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du quiz'));
    }

    final quizData = jsonDecode(cmsResponse.body) as Map<String, dynamic>;
    Map<String, dynamic>? articleData;
    final articles =
        // ignore: avoid_dynamic_calls
        quizData['data']['attributes']['articles']['data'] as List<dynamic>;
    if (articles.isNotEmpty) {
      final firstArticle = articles.first as Map<String, dynamic>;
      final id = (firstArticle['id'] as num).toString();
      final articleResponse = await _client.get(Endpoints.article(id));
      if (isResponseUnsuccessful(articleResponse.statusCode)) {
        return Left(Exception("Erreur lors de la récupération de l'article"));
      }
      articleData = articleResponse.data as Map<String, dynamic>;
    }

    return Right(QuizMapper.fromJson(cms: quizData, api: articleData));
  }

  @override
  Future<Either<Exception, void>> terminerQuiz({
    required final int id,
    required final bool estExacte,
  }) async {
    final response = await _client.post(
      Endpoints.events,
      data: jsonEncode({
        'content_id': '$id',
        'number_value': estExacte ? 100 : 0,
        'type': 'quizz_score',
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
