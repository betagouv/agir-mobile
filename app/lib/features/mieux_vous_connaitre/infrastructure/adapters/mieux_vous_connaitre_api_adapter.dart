import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/infrastructure/adapters/question_mapper.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitreApiAdapter implements MieuxVousConnaitrePort {
  const MieuxVousConnaitreApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<Question>>>
      recupererLesQuestionsDejaRepondue() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/questionsKYC'));

    if (response.statusCode != 200) {
      return Left(Exception('Erreur lors de la récupération des questions'));
    }
    final json = jsonDecode(response.body) as List<dynamic>;

    return Right(
      json
          .map((final e) => QuestionMapper.fromJson(e as Map<String, dynamic>))
          .where((final e) => e.reponses.isNotEmpty)
          .toList(),
    );
  }

  @override
  Future<Either<Exception, void>> mettreAJour({
    required final String id,
    required final List<String> reponses,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final body = jsonEncode({'reponse': reponses});
    final response = await _apiClient.put(
      Uri.parse('/utilisateurs/$utilisateurId/questionsKYC/$id'),
      body: body,
    );

    return response.statusCode == 200
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour des réponses'));
  }

  @override
  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/questionsKYC/$id'));

    if (response.statusCode != 200) {
      return Left(Exception('Erreur lors de la récupération de la question'));
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(QuestionMapper.fromJson(json));
  }
}
