import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/cms_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/quiz/domain/ports/quiz_port.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/infrastructure/adapters/quiz_mapper.dart';
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
    final response = await _cmsApiClient.get(
      Uri.parse(
        '/api/quizzes/$id?populate[0]=questions.reponses,thematique_gamification,articles.partenaire.logo',
      ),
    );
    if (response.statusCode != 200) {
      return Left(Exception("Erreur lors de la récupération de l'article"));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(QuizMapper.fromJson(json));
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

    return response.statusCode == 200
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
