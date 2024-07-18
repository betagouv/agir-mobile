import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_le_contenu_de_la_bibliotheque.dart';

void main() {
  testWidgets('Allez sur la page Base de connaissances', (final tester) async {
    setUpWidgets(tester);
    await _allerLeMenu(tester);

    await ielAppuieSur(tester, Localisation.bibliotheque);
    ielVoitLeTexte(Localisation.baseDeConnaissances);
  });

  testWidgets('Voir un article', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);

      const titre = 'Quelle est votre situation professionnelle ?';
      leServeurRetourneLeContenuDeLaBibliotheque(
        const Bibliotheque(
          contenus: [
            Recommandation(
              id: 'KYC005',
              type: TypeDuContenu.kyc,
              titre: titre,
              sousTitre: null,
              imageUrl:
                  'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
              points: 20,
              thematique: Thematique.climat,
              thematiqueLabel: '☀️ Environnement',
            ),
          ],
          filtres: [],
        ),
      );
      await _allerLeMenu(tester);
      await ielAppuieSur(tester, Localisation.bibliotheque);
      ielVoitLeTexte(titre);
    });
  });
}

Future<void> _allerLeMenu(final WidgetTester tester) async {
  ielEstConnecte();
  ielADebloqueCesFonctionnalites([Fonctionnalites.bibliotheque]);

  await mockNetworkImages(() async => ielLanceLapplication(tester));
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
}
