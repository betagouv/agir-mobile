import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  group('Accueil', () {
    testWidgets(
      "Iel n'a pas débloqué les recommandations alors iel ne les voit pas sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielNeVoitPasLeTexte(Localisation.accueilRecommandationsTitre);
      },
    );

    testWidgets(
      "Iel a débloqué les recommandations alors iel voit le titre sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites([Fonctionnalites.recommandations]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(Localisation.accueilRecommandationsTitre);
      },
    );

    testWidgets(
      "Iel a débloqué les recommandations alors iel voit les recommndations sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites([Fonctionnalites.recommandations]);
        const recommandation = Recommandation(
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: Thematique.climat,
        );
        ielALesRecommandationsSuivantes([recommandation]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(recommandation.titre);
      },
    );
  });
}
