import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';

void main() {
  testWidgets(
    "Iel appuie sur une recommandation de type kyc et l'ouvre",
    (final tester) async {
      setUpWidgets(tester);
      ielADebloqueCesFonctionnalites([Fonctionnalites.recommandations]);
      const question = 'Quelle est votre situation professionnelle ?';
      const recommandation = Recommandation(
        id: 'KYC005',
        type: TypeDuContenu.kyc,
        titre: question,
        sousTitre: null,
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
        points: 20,
        thematique: Thematique.climat,
        thematiqueLabel: '☀️ Environnement',
      );
      ielALesRecommandationsSuivantes([recommandation]);
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
      ]);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, recommandation.titre);
      ielVoitLeTexte(Localisation.maReponse);
    },
  );
  testWidgets(
    'Aller sur la page de la question libre',
    (final tester) async {
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
      setUpWidgets(tester);
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
      setUpWidgets(tester);
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

  testWidgets('Modifier plusieurs questions', (final tester) async {
    setUpWidgets(tester);
    const question = 'Quelle est votre situation professionnelle ?';
    const reponse = 'J’ai un emploi';

    const question2 = 'Qui joue en première base ?';
    const reponse2 = 'Personne ne joue en première base';
    const nouvelleReponse2 = "C'est qui qui qui joue en première base";
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
      const Question(
        id: 'KYC006',
        question: question2,
        reponses: [reponse2],
        categorie: 'recommandation',
        points: 5,
        type: ReponseType.choixUnique,
        reponsesPossibles: [reponse2, nouvelleReponse2],
        deNosGestesClimat: false,
        thematique: Thematique.loisir,
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
    await ielAppuieSur(tester, question2);
    await ielAppuieSur(tester, nouvelleReponse2);
    await ielAppuieSur(tester, Localisation.mettreAJour);
    ielVoitLeTexte(Localisation.mieuxVousConnaitre);
    ielVoitLeTexte(nouvelleReponse2);
  });
}

Future<void> _allerSurMesInformations(final WidgetTester tester) async {
  ielEstConnecte();

  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.votreProfil);
  await ielAppuieSur(tester, Localisation.mieuxVousConnaitre);
}
