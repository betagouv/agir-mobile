import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';

void main() {
  testWidgets(
    'Aller sur la page de la question libre',
    (final tester) async {
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = 'J’ai un emploi';
      leServeurRetourneCesQuestions([
        const Question(
          id: 'KYC005',
          question: question,
          reponses: [reponse],
          categorie: 'recommandation',
          points: 5,
          type: ReponseType.libre,
          reponsesPossibles: [],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
      ]);
      await _allerSurMesInformations(tester);
      await ielAppuieSur(tester, question);
      ielVoitLeTexte('🌍 ${Localisation.lesCategoriesClimat}');
      ielVoitLeTexte(question);
      ielVoitLeTexte(Localisation.maReponse);
      ielVoitLeTexte(reponse);
    },
  );

  testWidgets(
    'Modifier la réponse à une question libre',
    (final tester) async {
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = 'J’ai un emploi';
      leServeurRetourneCesQuestions([
        const Question(
          id: 'KYC005',
          question: question,
          reponses: [reponse],
          categorie: 'recommandation',
          points: 5,
          type: ReponseType.libre,
          reponsesPossibles: [],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
      ]);
      await _allerSurMesInformations(tester);
      await ielAppuieSur(tester, question);
      const nouvelleReponse = "Je n'ai pas d'emploi";
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.maReponse,
        enterText: nouvelleReponse,
      );
      await ielAppuieSur(tester, Localisation.mettreAJour);
      ielVoitLeTexte(Localisation.mieuxVousConnaitre);
      ielVoitLeTexte(nouvelleReponse);
    },
  );

  testWidgets(
    'Modifier la réponse à une question choix unique',
    (final tester) async {
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = 'J’ai un emploi';
      const nouvelleReponse = "Je n'ai pas d'emploi";
      leServeurRetourneCesQuestions([
        const Question(
          id: 'KYC005',
          question: question,
          reponses: [reponse],
          categorie: 'recommandation',
          points: 5,
          type: ReponseType.choixUnique,
          reponsesPossibles: [reponse, nouvelleReponse],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
      ]);
      await _allerSurMesInformations(tester);
      await ielAppuieSur(tester, question);
      await ielAppuieSur(tester, nouvelleReponse);
      await ielAppuieSur(tester, Localisation.mettreAJour);
      ielVoitLeTexte(Localisation.mieuxVousConnaitre);
      ielVoitLeTexte(nouvelleReponse);
    },
  );

  testWidgets(
    'Modifier la réponse à une question choix multiple',
    (final tester) async {
      const question =
          'Qu’est-ce qui vous motive le plus pour adopter des habitudes écologiques ?';
      const reponses = [
        'Famille ou génération future',
        'Conscience écologique',
      ];
      const reponseEnPlus = 'Économies financières';

      leServeurRetourneCesQuestions([
        const Question(
          id: 'KYC005',
          question: question,
          reponses: reponses,
          categorie: 'recommandation',
          points: 5,
          type: ReponseType.choixMultiple,
          reponsesPossibles: [
            ...reponses,
            reponseEnPlus,
            'Conscience écologique',
            'Autre raison',
          ],
          deNosGestesClimat: false,
          thematique: Thematique.climat,
        ),
      ]);
      await _allerSurMesInformations(tester);
      await ielAppuieSur(tester, question);
      await ielAppuieSur(tester, reponseEnPlus);
      await ielAppuieSur(tester, Localisation.mettreAJour);
      ielVoitLeTexte(Localisation.mieuxVousConnaitre);
      ielVoitLeTexte([...reponses, reponseEnPlus].join(' - '));
    },
  );
}

Future<void> _allerSurMesInformations(final WidgetTester tester) async {
  ielEstConnecte();

  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
  await ielAppuieSur(tester, Localisation.mieuxVousConnaitre);
}
