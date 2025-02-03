import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/quiz/domain/quiz.dart';

import '../scenario_context.dart';

/// Iel a le quiz suivant.
void ielALeQuizSuivant(final Quiz valeur) {
  ScenarioContext().dioMock!.getM(
    Endpoints.quiz(valeur.id),
    responseData: {
      'content_id': valeur.id,
      'thematique_principale': valeur.thematique,
      'points': valeur.points,
      'questions': [
        {
          'libelle': valeur.question,
          'reponses': valeur.reponses
              .map((final e) => {'reponse': e.reponse, 'exact': e.exact})
              .toList(),
          'explicationOk': valeur.explicationOk,
          'explicationKO': valeur.explicationKo,
        },
      ],
      'article_contenu': valeur.article,
    },
  );
}
