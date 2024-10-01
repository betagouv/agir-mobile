import 'package:app/features/univers/core/domain/content_id.dart';
import 'package:app/features/univers/core/domain/mission.dart';
import 'package:app/features/univers/core/domain/mission_defi.dart';
import 'package:app/features/univers/core/domain/mission_kyc.dart';
import 'package:app/features/univers/core/domain/mission_liste.dart';
import 'package:app/features/univers/core/domain/mission_quiz.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_la_mission_suivante.dart';
import 'steps/iel_a_les_univers_thematiques_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_univers.dart';

void main() {
  testWidgets('On voit la mission', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      const univers = TuileUnivers(
        type: 'alimentation',
        titre: 'En cuisine',
        imageUrl: 'https://example.com/image.jpg',
        estTerminee: false,
      );
      leServeurRetourneCesUnivers([univers]);
      const universThematique = MissionListe(
        id: 'manger_saison_1',
        titre: 'Pourquoi manger de saison ?',
        progression: 2,
        progressionCible: 8,
        estNouvelle: false,
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/v1718631224/fruits_1_dec0e90839.png',
        niveau: 1,
      );
      ielALesMissionsSuivantes([universThematique]);
      const mission = Mission(
        titre: 'Comment bien choisir ses aliments ?',
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/v1718701364/fruits_2_cfbf4b47b9.png',
        kycListe: [
          MissionKyc(
            id: ObjectifId('1'),
            titre: 'Mieux vous connaître 1',
            contentId: ContentId('KYC_saison_alternative'),
            estFait: true,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
        ],
        quizListe: [
          MissionQuiz(
            id: ObjectifId('1'),
            titre:
                "Comment repérer si les produits sont de saison ou pas lors de l'achat ?",
            contentId: ContentId('88'),
            estFait: true,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
          MissionQuiz(
            id: ObjectifId('1'),
            titre: "Comment remplacer un produit qui n'est pas de saison ?",
            contentId: ContentId('89'),
            estFait: false,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
          MissionQuiz(
            id: ObjectifId('1'),
            titre:
                "La saisonnalité des produits : il n'y en a pas que pour les fruits et légumes !",
            contentId: ContentId('90'),
            estFait: false,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
        ],
        articles: [],
        defis: [
          MissionDefi(
            id: ObjectifId('1'),
            titre:
                'Aider la communauté en partageant un lieu où faire ses courses de saison à Dole ou une astuce pour remplacer un fruit ou légume hors saison',
            contentId: ContentId('39'),
            estFait: false,
            estVerrouille: false,
            points: 50,
            aEteRecolte: false,
            status: MissionDefiStatus.toDo,
            isRecommended: true,
          ),
          MissionDefi(
            id: ObjectifId('1'),
            titre:
                "Remplacer un fruit ou un légume qui n'est pas de saison par la conserve, surgelé ou un autre produit frais",
            contentId: ContentId('38'),
            estFait: false,
            estVerrouille: false,
            points: 50,
            aEteRecolte: false,
            status: MissionDefiStatus.toDo,
            isRecommended: false,
          ),
          MissionDefi(
            id: ObjectifId('1'),
            titre:
                "Faire ses propres conserves ou confitures d'un fruit ou légume de saison",
            contentId: ContentId('89'),
            estFait: false,
            estVerrouille: false,
            points: 50,
            aEteRecolte: false,
            status: MissionDefiStatus.toDo,
            isRecommended: false,
          ),
        ],
        peutEtreTermine: false,
        estTermine: false,
      );
      ielALaMissionSuivante(mission);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      ielVoitLeTexte(universThematique.titre);
      await ielAppuieSur(tester, universThematique.titre);
      ielVoitLeTexte(mission.titre, n: 2);
      ielVoitLeTexte(
        "Faire ses propres conserves ou confitures d'un fruit ou légume de saison",
      );
    });
  });
}
