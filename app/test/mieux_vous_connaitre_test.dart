import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';

void main() {
  testWidgets('Voir tous les textes', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      const Question(
        id: 'KYC005',
        question: question,
        reponses: [reponse],
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
    ]);
    await _allerSurMesInformations(tester);
    ielVoitLeTexte(Localisation.lesCategories);
    ielVoitLeTexte(question);
    ielVoitLeTexte(reponse);
  });

  testWidgets('Filtrer avec les catégories', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const question2 = 'Que consommez-vous ?';
    leServeurRetourneCesQuestions([
      const Question(
        id: 'KYC005',
        question: question,
        reponses: ['J’ai un emploi'],
        categorie: 'recommandation',
        points: 5,
        type: ReponseType.libre,
        reponsesPossibles: [],
        deNosGestesClimat: false,
        thematique: Thematique.climat,
      ),
      const Question(
        id: 'KYC006',
        question: question2,
        reponses: ['Je consomme des produits locaux'],
        categorie: 'recommandation',
        points: 5,
        type: ReponseType.libre,
        reponsesPossibles: [],
        deNosGestesClimat: false,
        thematique: Thematique.consommation,
      ),
    ]);
    await _allerSurMesInformations(tester);
    await ielAppuieSur(tester, Localisation.lesCategoriesConsommation);
    ielNeVoitPasLeTexte(question);
    ielVoitLeTexte(question2);
    await ielAppuieSur(tester, Localisation.lesCategoriesTout);
    ielVoitLeTexte(question);
    ielVoitLeTexte(question2);
  });
}

Future<void> _allerSurMesInformations(final WidgetTester tester) async {
  ielEstConnecte();

  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.votreProfil);
  await ielAppuieSur(tester, Localisation.mieuxVousConnaitre);
}
