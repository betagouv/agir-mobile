import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';

void main() {
  testWidgets(
    'Aller sur la page de la question libre',
    (final tester) async {
      setUpWidgets(tester);
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = 'J’ai un emploi';
      leServeurRetourneCesQuestions([
        const LibreQuestion(
          id: QuestionId('KYC005'),
          text: QuestionText(question),
          responses: Responses([reponse]),
          points: Points(5),
          theme: QuestionTheme.climat,
        ),
      ]);
      await _allerSurMieuxVousConnaitre(tester);
      await ielAppuieSur(tester, question);
      ielVoitLeTexte(question);
      ielVoitLeTexte(reponse);
    },
  );

  testWidgets(
    'Modifier la réponse à une question libre',
    (final tester) async {
      setUpWidgets(tester);
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = 'J’ai un emploi';
      leServeurRetourneCesQuestions([
        const LibreQuestion(
          id: QuestionId('KYC005'),
          text: QuestionText(question),
          responses: Responses([reponse]),
          points: Points(5),
          theme: QuestionTheme.climat,
        ),
      ]);
      await _allerSurMieuxVousConnaitre(tester);
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
    'Modifier la réponse à une question entier',
    (final tester) async {
      setUpWidgets(tester);
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = '10000';
      leServeurRetourneCesQuestions([
        const EntierQuestion(
          id: QuestionId('KYC005'),
          text: QuestionText(question),
          responses: Responses([reponse]),
          points: Points(5),
          theme: QuestionTheme.climat,
        ),
      ]);
      await _allerSurMieuxVousConnaitre(tester);
      await ielAppuieSur(tester, question);
      const nouvelleReponse = '1000';
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
    'Ne pas modifier la réponse à une question entier',
    (final tester) async {
      setUpWidgets(tester);
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = '10000';
      leServeurRetourneCesQuestions([
        const EntierQuestion(
          id: QuestionId('KYC005'),
          text: QuestionText(question),
          responses: Responses([reponse]),
          points: Points(5),
          theme: QuestionTheme.climat,
        ),
      ]);
      await _allerSurMieuxVousConnaitre(tester);
      await ielAppuieSur(tester, question);
      const nouvelleReponse = 'Michel';
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.maReponse,
        enterText: nouvelleReponse,
      );
      await ielAppuieSur(tester, Localisation.mettreAJour);
      ielVoitLeTexte(Localisation.mieuxVousConnaitre);
      ielVoitLeTexte(reponse);
      ielNeVoitPasLeTexte(nouvelleReponse);
    },
  );

  testWidgets('Valider sans mettre à jour', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      const LibreQuestion(
        id: QuestionId('KYC005'),
        text: QuestionText(question),
        responses: Responses([reponse]),
        points: Points(5),
        theme: QuestionTheme.climat,
      ),
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(reponse);
  });

  testWidgets(
    'Modifier la réponse à une question choix unique',
    (final tester) async {
      setUpWidgets(tester);
      const question = 'Quelle est votre situation professionnelle ?';
      const reponse = 'J’ai un emploi';
      const nouvelleReponse = "Je n'ai pas d'emploi";
      leServeurRetourneCesQuestions([
        const ChoixUniqueQuestion(
          id: QuestionId('KYC005'),
          text: QuestionText(question),
          responses: Responses([reponse]),
          points: Points(5),
          responsesPossibles: ResponsesPossibles([reponse, nouvelleReponse]),
          theme: QuestionTheme.climat,
        ),
      ]);
      await _allerSurMieuxVousConnaitre(tester);
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
      setUpWidgets(tester);
      const question =
          'Qu’est-ce qui vous motive le plus pour adopter des habitudes écologiques ?';
      const reponses = [
        'Famille ou génération future',
        'Conscience écologique',
      ];
      const reponseEnPlus = 'Économies financières';

      leServeurRetourneCesQuestions([
        const ChoixMultipleQuestion(
          id: QuestionId('KYC005'),
          text: QuestionText(question),
          responses: Responses(reponses),
          points: Points(5),
          responsesPossibles: ResponsesPossibles([
            ...reponses,
            reponseEnPlus,
            'Conscience écologique',
            'Autre raison',
          ]),
          theme: QuestionTheme.climat,
        ),
      ]);
      await _allerSurMieuxVousConnaitre(tester);
      await ielAppuieSur(tester, question);
      await ielAppuieSur(tester, reponseEnPlus);
      await ielAppuieSur(tester, Localisation.mettreAJour);
      ielVoitLeTexte(Localisation.mieuxVousConnaitre);
      ielVoitLeTexte([...reponses, reponseEnPlus].join(' - '));
    },
  );

  testWidgets('Modifier plusieurs questions', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';

    const question2 = 'Qui joue en première base ?';
    const reponse2 = 'Personne ne joue en première base';
    const nouvelleReponse2 = "C'est qui qui qui joue en première base";
    leServeurRetourneCesQuestions([
      const LibreQuestion(
        id: QuestionId('KYC005'),
        text: QuestionText(question),
        responses: Responses([reponse]),
        points: Points(5),
        theme: QuestionTheme.climat,
      ),
      const ChoixUniqueQuestion(
        id: QuestionId('KYC006'),
        text: QuestionText(question2),
        responses: Responses([reponse2]),
        points: Points(5),
        responsesPossibles: ResponsesPossibles([reponse2, nouvelleReponse2]),
        theme: QuestionTheme.loisir,
      ),
    ]);

    await _allerSurMieuxVousConnaitre(tester);
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
    await ielAppuieSur(tester, question2);
    await ielAppuieSur(tester, nouvelleReponse2);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(nouvelleReponse2);
  });
}

Future<void> _allerSurMieuxVousConnaitre(final WidgetTester tester) async {
  ielEstConnecte();

  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
  await ielAppuieSur(tester, Localisation.mieuxVousConnaitre);
}
