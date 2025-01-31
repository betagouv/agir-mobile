import 'package:app/core/infrastructure/endpoints.dart';

import '../scenario_context.dart';

/// Iel a les recommandations suivantes.
void ielALesRecommandationsSuivantes(final String titre) {
  ScenarioContext().dioMock!.getM(
    Endpoints.recommandationsParThematique('alimentation'),
    responseData: [
      {
        'content_id': '42',
        'type': 'quizz',
        'titre': titre,
        'soustitre': null,
        'image_url':
            'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
        'points': 20,
        'thematique_principale': 'alimentation',
      },
    ],
  );
}
