import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';
import 'steps/set_up_widgets.dart';

void main() {
  testWidgets('Aller sur la page de la question libre', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      {
        'code': 'KYC005',
        'type': 'libre',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    ielVoitLeTexte(question);
    ielVoitLeTexte(reponse);
  });

  testWidgets('Modifier la réponse à une question libre', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    const nouvelleReponse = "Je n'ai pas d'emploi";
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.maReponse,
      enterText: nouvelleReponse,
    );
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
    ]);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(nouvelleReponse);
  });

  testWidgets('Modifier la réponse à une question entier', (
    final tester,
  ) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = '10000';
    leServeurRetourneCesQuestions([
      {
        'type': 'entier',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    const nouvelleReponse = '1000';
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.maReponse,
      enterText: nouvelleReponse,
    );
    leServeurRetourneCesQuestions([
      {
        'type': 'entier',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
    ]);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(nouvelleReponse);
  });

  testWidgets('Ne pas modifier la réponse à une question entier', (
    final tester,
  ) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = '10000';
    leServeurRetourneCesQuestions([
      {
        'type': 'entier',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
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
  });

  testWidgets('Valider sans mettre à jour', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(reponse);
  });

  testWidgets('Modifier la réponse à une question choix unique', (
    final tester,
  ) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';
    const nouvelleReponse = "Je n'ai pas d'emploi";
    leServeurRetourneCesQuestions([
      {
        'type': 'choix_unique',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse, 'selected': true},
          {'code': '', 'label': nouvelleReponse, 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    await ielAppuieSur(tester, nouvelleReponse);
    leServeurRetourneCesQuestions([
      {
        'type': 'choix_unique',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse, 'selected': false},
          {'code': '', 'label': nouvelleReponse, 'selected': true},
        ],
        'points': 5,
      },
    ]);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(nouvelleReponse);
  });

  testWidgets('Modifier la réponse à une question choix multiple', (
    final tester,
  ) async {
    setUpWidgets(tester);
    const question =
        'Qu’est-ce qui vous motive le plus pour adopter des habitudes écologiques ?';
    const reponses = ['Famille ou génération future', 'Conscience écologique'];
    const reponseEnPlus = 'Économies financières';

    leServeurRetourneCesQuestions([
      {
        'type': 'choix_multiple',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponses.first, 'selected': true},
          {'code': '', 'label': reponses[1], 'selected': true},
          {'code': '', 'label': reponseEnPlus, 'selected': false},
          {'code': '', 'label': 'Autre raison', 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    await ielAppuieSur(tester, reponseEnPlus);
    leServeurRetourneCesQuestions([
      {
        'type': 'choix_multiple',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponses.first, 'selected': true},
          {'code': '', 'label': reponses[1], 'selected': true},
          {'code': '', 'label': reponseEnPlus, 'selected': true},
          {'code': '', 'label': 'Autre raison', 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte([...reponses, reponseEnPlus].join(' - '));
  });

  testWidgets('Modifier plusieurs questions', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';

    const question2 = 'Qui joue en première base ?';
    const reponse2 = 'Personne ne joue en première base';
    const nouvelleReponse2 = "C'est qui qui qui joue en première base";
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': reponse},
        'points': 5,
      },
      {
        'type': 'choix_unique',
        'code': 'KYC006',
        'thematique': 'decouverte',
        'question': question2,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse2, 'selected': true},
          {'code': '', 'label': nouvelleReponse2, 'selected': false},
        ],
        'points': 5,
      },
    ]);

    await _allerSurMieuxVousConnaitre(tester);
    await ielAppuieSur(tester, question);
    const nouvelleReponse = "Je n'ai pas d'emploi";
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.maReponse,
      enterText: nouvelleReponse,
    );
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
      {
        'type': 'choix_unique',
        'code': 'KYC006',
        'thematique': 'decouverte',
        'question': question2,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse2, 'selected': true},
          {'code': '', 'label': nouvelleReponse2, 'selected': false},
        ],
        'points': 5,
      },
    ]);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(nouvelleReponse);
    await ielAppuieSur(tester, question2);
    await ielAppuieSur(tester, nouvelleReponse2);
    leServeurRetourneCesQuestions([
      {
        'type': 'libre',
        'code': 'KYC005',
        'thematique': 'decouverte',
        'question': question,
        'is_answered': true,
        'reponse_unique': {'value': nouvelleReponse},
        'points': 5,
      },
      {
        'type': 'choix_unique',
        'code': 'KYC006',
        'thematique': 'decouverte',
        'question': question2,
        'is_answered': true,
        'reponse_multiple': [
          {'code': '', 'label': reponse2, 'selected': false},
          {'code': '', 'label': nouvelleReponse2, 'selected': true},
        ],
        'points': 5,
      },
    ]);
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
