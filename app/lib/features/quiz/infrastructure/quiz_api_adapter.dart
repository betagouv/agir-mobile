import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:app/features/quiz/infrastructure/quiz_mapper.dart';
import 'package:fpdart/fpdart.dart';

class QuizApiAdapter implements QuizPort {
  const QuizApiAdapter({
    required final AuthentificationApiClient apiClient,
    required final CmsApiClient cmsApiClient,
  })  : _apiClient = apiClient,
        _cmsApiClient = cmsApiClient;

  final AuthentificationApiClient _apiClient;
  final CmsApiClient _cmsApiClient;

  @override
  Future<Either<Exception, Quiz>> recupererQuiz(final String id) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final cmsResponse = await _cmsApiClient.get(
      Uri.parse(
        '/api/quizzes/$id?populate[0]=questions.reponses,thematique_gamification,articles.partenaire.logo',
      ),
    );

    if (cmsResponse.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération du quiz'));
    }

    final quizData = jsonDecode(cmsResponse.body) as Map<String, dynamic>;
    Map<String, dynamic>? articleData;
    // ignore: avoid_dynamic_calls
    if ((quizData['data']['attributes']['articles']['data'] as List<dynamic>)
        .isNotEmpty) {
      final articleResponse = await _apiClient.get(
        Uri.parse('utilisateurs/$utilisateurId/bibliotheque/articles/$id'),
      );
      if (articleResponse.statusCode != HttpStatus.ok) {
        return Left(Exception("Erreur lors de la récupération de l'article"));
      }
      articleData = jsonDecode(articleResponse.body) as Map<String, dynamic>;
    }

    return Right(QuizMapper.fromJson(cms: quizData, api: articleData));
  }

  @override
  Future<Either<Exception, void>> terminerQuiz({
    required final int id,
    required final bool estExacte,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/$utilisateurId/events'),
      body: jsonEncode({
        'content_id': '$id',
        'number_value': estExacte ? 100 : 0,
        'type': 'quizz_score',
      }),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
