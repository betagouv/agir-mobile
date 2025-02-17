// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/i_have_action_detail_in_my_library.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';
import './step/i_have_lvao_services_in_my_library.dart';
import './step/i_have_recipe_services_in_my_library.dart';

void main() {
  group('''Actions''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iHaveActionsInMyLibrary(
          tester,
          const bdd.DataTable([
            [
              'type',
              'code',
              'title',
              'nb_actions_completed',
              'nb_aids_available'
            ],
            [
              'classique',
              '1',
              'Faire réparer une **paire de chaussures**',
              2,
              2
            ],
            [
              'classique',
              '2',
              'Contribuer à la **bonne santé de son sol**',
              0,
              0
            ],
            [
              'classique',
              '3',
              'Tester une **nouvelle recette végétarienne**',
              1,
              1
            ]
          ]));
      await iHaveActionDetailInMyLibrary(
          tester,
          const bdd.DataTable([
            [
              'id',
              'title',
              'subTitle',
              'how',
              'why',
              'service_id',
              'service_category'
            ],
            [
              '1',
              'Faire réparer une **paire de chaussures**',
              'Faites des économies en donnant une seconde vie à vos paires de chaussures',
              '# Nos astuces\n\n- **Choisissez un cordonnier agréé** : pour profiter de l’aide d’État sur vos réparations\n\n- **Bottes, chaussures de ski, baskets** : toutes les chaussures sont éligibles\n\n- **Si vos chaussures sont trop abimées** : Déposez-les dans un point de collecte pour que valoriser les matériaux utilisés',
              '# En quelques mots\n\n- Pour chaque paire de chaussure réparée, vous économisez **entre 20 et 60€**\n\n- Les paires de chaussures jetées représentent plusieurs **milliers de tonnes** de déchets généralement non recyclables. \n\n- Chaque année, un Français achète en moyenne 4 paires de chaussures.',
              'longue_vie_objets',
              'reparer'
            ],
            [
              '3',
              'Tester une **nouvelle recette végétarienne**',
              'Faites des économies et le plein de vitamines ! Cette semaine, on cuisine une recette saine et délicieuse !',
              '# Nos astuces\n\n- **Revisitez vos classiques** : Lasagnes au légumes, chili sin carne, re-découvrez vos plats favoris en version végétariennes \n\n- **Protéines végétales** : Associez légumineuses (lentilles, pois chiches) et céréales (riz, quinoa) pour un plat complet.\n\n- **Variez les textures** : Alternez croquant (graines, noix) et fondant (avocats, patates douces)\n\n- **Épices et herbes** : Boostez les saveurs avec du curry, paprika fumé, curcuma, cumin ou herbes fraîches.',
              '# En quelques mots\n\n- Les repas à base de légumes sont en moyenne **30% moins chers** que ceux à base de viande.\n\n- Les nutriments contenus dans les légumes de saison sont une grande aide pour passer l’hiver !\n\n![test alt](https://agir-cms-prod.osc-secnum-fr1.scalingo.io/admin/70674f63fc3904c20de0.svg)',
              'recettes',
              'vegan'
            ]
          ]));
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
    }

    testWidgets('''See all actions''', (tester) async {
      await bddSetUp(tester);
      await iTapOn(tester, 'Actions');
      await iSee(tester, 'Contribuer à la bonne santé de son sol');
      await iSee(tester, 'Tester une nouvelle recette végétarienne');
      await iSee(tester, 'Faire réparer une paire de chaussures');
      await iDontSee(tester, '0 action');
      await iSee(tester, '1 action');
      await iSee(tester, '2 actions');
      await iDontSee(tester, '0 aide');
      await iSee(tester, '1 aide');
      await iSee(tester, '2 aides');
    });
    testWidgets('''See details classic action''', (tester) async {
      await bddSetUp(tester);
      await iHaveLvaoServicesInMyLibrary(tester);
      await iTapOn(tester, 'Actions');
      await iTapOn(tester, 'Faire réparer une paire de chaussures');
      await iSee(tester,
          'Faites des économies en donnant une seconde vie à vos paires de chaussures');
    });
    testWidgets('''See Longues vies aux objets service''', (tester) async {
      await bddSetUp(tester);
      await iHaveLvaoServicesInMyLibrary(tester);
      await iTapOn(tester, 'Actions');
      await iTapOn(tester, 'Faire réparer une paire de chaussures');
      await iSee(tester, 'Octavent');
    });
    testWidgets('''See recipe service''', (tester) async {
      await bddSetUp(tester);
      await iHaveRecipeServicesInMyLibrary(tester);
      await iTapOn(tester, 'Actions');
      await iTapOn(tester, 'Tester une nouvelle recette végétarienne');
      await iSee(tester, 'Salade de pâtes complètes et lentilles');
    });
  });
}
