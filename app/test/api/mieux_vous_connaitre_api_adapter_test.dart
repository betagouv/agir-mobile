import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/profil/mieux_vous_connaitre/infrastructure/adapters/mieux_vous_connaitre_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';
import 'request_mathcher.dart';

void main() {
  test('recupererLesQuestions', () async {
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/questionsKYC',
        response: CustomResponse('''
[
  {
    "id": "KYC_saison_savoir",
    "question": "Connaissez-vous les fruits et légumes du mois ?",
    "reponse": [],
    "categorie": "mission",
    "points": 5,
    "type": "choix_unique",
    "reponses_possibles": [
      "Oui",
      "Certains",
      "Non"
    ],
    "is_NGC": false,
    "thematique": "climat"
  },
  {
    "id": "KYC005",
    "question": "Quelle est votre situation professionnelle ?",
    "reponse": [
      "J’ai un emploi"
    ],
    "categorie": "recommandation",
    "points": 5,
    "type": "choix_unique",
    "reponses_possibles": [
      "J’ai un emploi",
      "Je suis sans emploi",
      "Je suis étudiant",
      "Je suis à la retraite",
      "Je ne souhaite pas répondre"
    ],
    "is_NGC": false,
    "thematique": "climat"
  },
  {
    "id": "KYC_motivation",
    "question": "Qu’est-ce qui vous motive le plus pour adopter des habitudes écologiques ?",
    "reponse": [
      "Famille ou génération future",
      "Conscience écologique"
    ],
    "categorie": "mission",
    "points": 5,
    "type": "choix_multiple",
    "reponses_possibles": [
      "Santé et bien être",
      "Famille ou génération future",
      "Économies financières",
      "Conscience écologique",
      "Autre raison"
    ],
    "is_NGC": false,
    "thematique": "climat"
  },
  {
    "id": "KYC_compost_idee",
    "question": "Quelles sont vos idées reçues ou freins concernant le compost ?",
    "reponse": ["Blabla"],
    "categorie": "mission",
    "points": 5,
    "type": "libre",
    "reponses_possibles": [],
    "is_NGC": false,
    "thematique": "climat"
  }
]'''),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManager: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
      token,
      utilisateurId,
    );

    final adapter = MieuxVousConnaitreApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
    );

    final result = await adapter.recupererLesQuestionsDejaRepondue();
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      equals([
        const Question(
          id: 'KYC005',
          question: 'Quelle est votre situation professionnelle ?',
          reponses: ['J’ai un emploi'],
          categorie: 'recommandation',
          points: 5,
          type: ReponseType.choixUnique,
          reponsesPossibles: [
            'J’ai un emploi',
            'Je suis sans emploi',
            'Je suis étudiant',
            'Je suis à la retraite',
            'Je ne souhaite pas répondre',
          ],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
        const Question(
          id: 'KYC_motivation',
          question:
              'Qu’est-ce qui vous motive le plus pour adopter des habitudes écologiques ?',
          reponses: ['Famille ou génération future', 'Conscience écologique'],
          categorie: 'mission',
          points: 5,
          type: ReponseType.choixMultiple,
          reponsesPossibles: [
            'Santé et bien être',
            'Famille ou génération future',
            'Économies financières',
            'Conscience écologique',
            'Autre raison',
          ],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
        const Question(
          id: 'KYC_compost_idee',
          question:
              'Quelles sont vos idées reçues ou freins concernant le compost ?',
          reponses: ['Blabla'],
          categorie: 'mission',
          points: 5,
          type: ReponseType.libre,
          reponsesPossibles: [],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
      ]),
    );
  });

  test('recupererQuestion', () async {
    const id = 'KYC005';
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/questionsKYC/$id',
        response: CustomResponse('''
{
  "id": "$id",
  "question": "Quelle est votre situation professionnelle ?",
  "reponse": [
    "J’ai un emploi"
  ],
  "categorie": "recommandation",
  "points": 5,
  "type": "choix_unique",
  "reponses_possibles": [
    "J’ai un emploi",
    "Je suis sans emploi",
    "Je suis étudiant",
    "Je suis à la retraite",
    "Je ne souhaite pas répondre"
  ],
  "is_NGC": false,
  "thematique": "climat"
}'''),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManager: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
      token,
      utilisateurId,
    );

    final adapter = MieuxVousConnaitreApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
    );

    final result = await adapter.recupererQuestion(id: id);
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      equals(
        const Question(
          id: id,
          question: 'Quelle est votre situation professionnelle ?',
          reponses: ['J’ai un emploi'],
          categorie: 'recommandation',
          points: 5,
          type: ReponseType.choixUnique,
          reponsesPossibles: [
            'J’ai un emploi',
            'Je suis sans emploi',
            'Je suis étudiant',
            'Je suis à la retraite',
            'Je ne souhaite pas répondre',
          ],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
      ),
    );
  });

  test('mettreAJour', () async {
    const id = 'KYC005';
    final client = ClientMock()
      ..putSuccess(
        path: '/utilisateurs/$utilisateurId/questionsKYC/$id',
        response: CustomResponse(''),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManager: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
      token,
      utilisateurId,
    );

    final adapter = MieuxVousConnaitreApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
    );

    await adapter.mettreAJour(id: id, reponses: ['J’ai un emploi']);

    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/$utilisateurId/questionsKYC/$id',
            body: '{"reponse":["J’ai un emploi"]}',
          ),
        ),
      ),
    );
  });
}
