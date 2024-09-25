import 'package:app/features/univers/core/domain/content_id.dart';
import 'package:app/features/univers/core/domain/defi.dart';
import 'package:app/features/univers/core/domain/defi_id.dart';
import 'package:app/features/univers/core/domain/mission.dart';
import 'package:app/features/univers/core/domain/mission_defi.dart';
import 'package:app/features/univers/core/domain/mission_kyc.dart';
import 'package:app/features/univers/core/domain/mission_liste.dart';
import 'package:app/features/univers/core/domain/mission_quiz.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_la_mission_suivante.dart';
import 'steps/iel_a_le_defi_suivant.dart';
import 'steps/iel_a_les_univers_thematiques_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_univers.dart';

void main() {
  const univers = TuileUnivers(
    type: 'alimentation',
    titre: 'En cuisine',
    imageUrl: 'https://example.com/image.jpg',
    estTerminee: false,
  );
  const missionListe = MissionListe(
    id: 'manger_saison_1',
    titre: 'Pourquoi manger de saison ?',
    progression: 2,
    progressionCible: 8,
    estNouvelle: false,
    imageUrl:
        'https://res.cloudinary.com/dq023imd8/image/upload/v1718631224/fruits_1_dec0e90839.png',
    niveau: 1,
  );
  const defiTitre =
      'Aider la communauté en partageant un lieu où faire ses courses de saison à Dole ou une astuce pour remplacer un fruit ou légume hors saison';
  const mission = Mission(
    titre: 'Comment bien choisir ses aliments ?',
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
        titre: defiTitre,
        contentId: ContentId('39'),
        estFait: false,
        estVerrouille: false,
        points: 10,
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
        status: MissionDefiStatus.inProgress,
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
        status: MissionDefiStatus.done,
        isRecommended: false,
      ),
    ],
    peutEtreTermine: false,
    estTermine: false,
  );
  const defi = Defi(
    id: DefiId('38'),
    thematique: '🥦 Alimentation',
    titre: defiTitre,
    status: 'todo',
    astuces:
        '<p><strong>Par exemple :</strong></p><ul><li><p>Pour manger des fraises en hiver, vous pouvez utiliser des fraises surgelées ou choisir des oranges, qui sont de saison.</p></li><li><p>Pour consommer des tomates hors saison, vous pouvez utiliser des conserves de tomates pelées ou tomates séchées</p></li></ul>',
    pourquoi:
        "<p>Manger de saison permet de profiter de produits plus savoureux et nutritifs tout en réduisant l'empreinte carbone et les coûts associés au transport et à la culture sous serre. Cela soutient également l'économie locale et encourage une alimentation diversifiée tout au long de l'année.</p>",
  );

  testWidgets('Iel voit le défi', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      leServeurRetourneCesUnivers([univers]);
      ielALesMissionsSuivantes([missionListe]);
      ielALaMissionSuivante(mission);
      ielALeDefiSuivant(defi);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      await ielAppuieSur(tester, missionListe.titre);
      await ielScrolle(tester, defiTitre);
      await ielAppuieSur(tester, Localisation.allerALAction);
      ielVoitLeTexte(Localisation.jeReleveLeDefi);
    });
  });

  testWidgets('Iel relève le défi', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      leServeurRetourneCesUnivers([univers]);
      ielALesMissionsSuivantes([missionListe]);
      ielALaMissionSuivante(mission);
      ielALeDefiSuivant(defi);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      await ielAppuieSur(tester, missionListe.titre);
      await ielScrolle(tester, defiTitre);
      await ielAppuieSur(tester, Localisation.allerALAction);
      await ielAppuieSur(tester, Localisation.jeReleveLeDefi);
      await ielAppuieSur(tester, Localisation.valider);
      final universPort = ScenarioContext().universPortMock!;
      expect(universPort.accepterDefiAppele, isTrue);
    });
  });

  testWidgets('Iel refuse le défi', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      leServeurRetourneCesUnivers([univers]);
      ielALesMissionsSuivantes([missionListe]);
      ielALaMissionSuivante(mission);
      ielALeDefiSuivant(defi);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      await ielAppuieSur(tester, missionListe.titre);
      await ielScrolle(tester, defiTitre);
      await ielAppuieSur(tester, Localisation.allerALAction);
      await ielAppuieSur(tester, Localisation.pasPourMoi);
      await ielAppuieSur(tester, Localisation.valider);
      final universPort = ScenarioContext().universPortMock!;
      expect(universPort.refuserDefiAppele, isTrue);
    });
  });

  testWidgets('Défi réalisé', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      leServeurRetourneCesUnivers([univers]);
      ielALesMissionsSuivantes([missionListe]);
      ielALaMissionSuivante(mission);
      ielALeDefiSuivant(
        const Defi(
          id: DefiId('38'),
          thematique: '🥦 Alimentation',
          titre: defiTitre,
          status: 'en_cours',
          astuces:
              '<p><strong>Par exemple :</strong></p><ul><li><p>Pour manger des fraises en hiver, vous pouvez utiliser des fraises surgelées ou choisir des oranges, qui sont de saison.</p></li><li><p>Pour consommer des tomates hors saison, vous pouvez utiliser des conserves de tomates pelées ou tomates séchées</p></li></ul>',
          pourquoi:
              "<p>Manger de saison permet de profiter de produits plus savoureux et nutritifs tout en réduisant l'empreinte carbone et les coûts associés au transport et à la culture sous serre. Cela soutient également l'économie locale et encourage une alimentation diversifiée tout au long de l'année.</p>",
        ),
      );
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      await ielAppuieSur(tester, missionListe.titre);
      await ielScrolle(
        tester,
        "Remplacer un fruit ou un légume qui n'est pas de saison par la conserve, surgelé ou un autre produit frais",
      );
      await ielAppuieSur(tester, Localisation.reprendreLaction);
      await ielAppuieSur(tester, Localisation.defiRealise);
      await ielAppuieSur(tester, Localisation.valider);
      final universPort = ScenarioContext().universPortMock!;
      expect(universPort.realiserDefiAppele, isTrue);
    });
  });

  testWidgets('Finalement, pas pour moi', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      leServeurRetourneCesUnivers([univers]);
      ielALesMissionsSuivantes([missionListe]);
      ielALaMissionSuivante(mission);
      ielALeDefiSuivant(
        const Defi(
          id: DefiId('38'),
          thematique: '🥦 Alimentation',
          titre: defiTitre,
          status: 'en_cours',
          astuces:
              '<p><strong>Par exemple :</strong></p><ul><li><p>Pour manger des fraises en hiver, vous pouvez utiliser des fraises surgelées ou choisir des oranges, qui sont de saison.</p></li><li><p>Pour consommer des tomates hors saison, vous pouvez utiliser des conserves de tomates pelées ou tomates séchées</p></li></ul>',
          pourquoi:
              "<p>Manger de saison permet de profiter de produits plus savoureux et nutritifs tout en réduisant l'empreinte carbone et les coûts associés au transport et à la culture sous serre. Cela soutient également l'économie locale et encourage une alimentation diversifiée tout au long de l'année.</p>",
        ),
      );
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      await ielAppuieSur(tester, missionListe.titre);
      await ielScrolle(
        tester,
        "Remplacer un fruit ou un légume qui n'est pas de saison par la conserve, surgelé ou un autre produit frais",
      );
      await ielAppuieSur(tester, Localisation.reprendreLaction);
      await ielAppuieSur(tester, Localisation.finalementPasPourMoi);
      await ielAppuieSur(tester, Localisation.valider);
      final universPort = ScenarioContext().universPortMock!;
      expect(universPort.abondonnerDefiAppele, isTrue);
    });
  });
}
