import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/profil/mieux_vous_connaitre/infrastructure/adapters/question_mapper.dart';

class MieuxVousConnaitreApiAdapter implements MieuxVousConnaitrePort {
  const MieuxVousConnaitreApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<List<Question>> recupererLesQuestionsDejaRepondue() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/questionsKYC'));

    if (response.statusCode != 200) {
      throw Exception();
    }
    final json = jsonDecode(response.body) as List<dynamic>;

    return json
        .map((final e) => QuestionMapper.fromJson(e as Map<String, dynamic>))
        .where((final e) => e.reponse.isNotEmpty)
        .toList();
  }
}
