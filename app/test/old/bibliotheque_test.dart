import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_l_article_suivant.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_le_contenu_de_la_bibliotheque.dart';

void main() {
  testWidgets('Allez sur la page Base de connaissances', (final tester) async {
    setUpWidgets(tester);
    await _allerSurBibliotheque(tester);
    ielVoitLeTexte(Localisation.baseDeConnaissances);
  });

  testWidgets('Voir un article', (final tester) async {
    setUpWidgets(tester);
    await mockNetworkImages(() async {
      const titre = "L'agriculture biologique en France";
      leServeurRetourneLeContenuDeLaBibliotheque(
        const Bibliotheque(
          contenus: [
            Recommandation(
              id: '1',
              type: TypeDuContenu.article,
              titre: titre,
              sousTitre: null,
              imageUrl: 'https://example.com/image.jpg',
              points: 20,
              thematique: 'alimentation',
              thematiqueLabel: '🥦 Alimentation',
            ),
          ],
          filtres: [],
        ),
      );

      await _allerSurBibliotheque(tester);
      ielVoitLeTexte(titre);
    });
  });

  testWidgets("Iel appuie sur l'article", (final tester) async {
    setUpWidgets(tester);
    await mockNetworkImages(() async {
      const titre = "L'agriculture biologique en France";
      leServeurRetourneLeContenuDeLaBibliotheque(
        const Bibliotheque(
          contenus: [
            Recommandation(
              id: '1',
              type: TypeDuContenu.article,
              titre: titre,
              sousTitre: null,
              imageUrl: 'https://example.com/image.jpg',
              points: 20,
              thematique: 'alimentation',
              thematiqueLabel: '🥦 Alimentation',
            ),
          ],
          filtres: [],
        ),
      );
      ielALArticleSuivant(
        const Article(
          titre: titre,
          sousTitre: null,
          contenu: '<h2>Ingrédients</h2>',
          partenaire: null,
          sources: [],
        ),
      );
      await _allerSurBibliotheque(tester);
      await ielAppuieSur(tester, Localisation.continuerLaLecture);
      ielVoitLeTexte(titre);
    });
  });

  testWidgets('Iel filtre via le titre', (final tester) async {
    setUpWidgets(tester);
    await mockNetworkImages(() async {
      leServeurRetourneLeContenuDeLaBibliotheque(
        const Bibliotheque(
          contenus: [
            Recommandation(
              id: '1',
              type: TypeDuContenu.article,
              titre: "L'agriculture biologique en France",
              sousTitre: null,
              imageUrl: 'https://example.com/image.jpg',
              points: 20,
              thematique: 'alimentation',
              thematiqueLabel: '🥦 Alimentation',
            ),
            Recommandation(
              id: '2',
              type: TypeDuContenu.article,
              titre: 'La collecte de vos déchets',
              sousTitre: null,
              imageUrl: 'https://example.com/image.jpg',
              points: 20,
              thematique: 'dechet',
              thematiqueLabel: '🗑️ Déchets',
            ),
          ],
          filtres: [],
        ),
      );

      await _allerSurBibliotheque(tester);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.rechercherParTitre,
        enterText: 'biologique',
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      ielVoitLeTexte("L'agriculture biologique en France");
      ielNeVoitPasLeTexte('La collecte de vos déchets');
    });
  });

  testWidgets('Iel filtre via les thematiques', (final tester) async {
    setUpWidgets(tester);

    await mockNetworkImages(() async {
      leServeurRetourneLeContenuDeLaBibliotheque(
        const Bibliotheque(
          contenus: [
            Recommandation(
              id: '1',
              type: TypeDuContenu.article,
              titre: "L'agriculture biologique en France",
              sousTitre: null,
              imageUrl: 'https://example.com/image.jpg',
              points: 20,
              thematique: 'alimentation',
              thematiqueLabel: '🥦 Alimentation',
            ),
            Recommandation(
              id: '2',
              type: TypeDuContenu.article,
              titre: 'La collecte de vos déchets',
              sousTitre: null,
              imageUrl: 'https://example.com/image.jpg',
              points: 20,
              thematique: 'dechet',
              thematiqueLabel: '🗑️ Déchets',
            ),
          ],
          filtres: [
            BibliothequeFiltre(
              code: 'alimentation',
              titre: '🥦 Alimentation',
              choisi: false,
            ),
            BibliothequeFiltre(
              code: 'dechets',
              titre: '🗑️ Déchets',
              choisi: false,
            ),
          ],
        ),
      );

      await _allerSurBibliotheque(tester);
      await ielAppuieSur(tester, '🥦 Alimentation');
      ielVoitLeTexte("L'agriculture biologique en France");
      ielNeVoitPasLeTexte('La collecte de vos déchets');
    });
  });
}

Future<void> _allerSurBibliotheque(final WidgetTester tester) async {
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.bibliotheque);
}
