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
import './step/i_have_recipe_services_in_my_library.dart';
import './step/i_have_recipe_detail_in_my_library.dart';
import './step/i_scroll_down.dart';
import './step/i_see.dart';

void main() {
  group('''Recipe''', () {
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

    testWidgets('''See recipe detail''', (tester) async {
      await bddSetUp(tester);
      await iTapOn(tester, 'Actions');
      await iHaveRecipeServicesInMyLibrary(tester);
      await iHaveRecipeDetailInMyLibrary(
          tester,
          const bdd.DataTable([
            ['id', 'title', 'preparation_time'],
            ['1', 'Salade de pâtes complètes et lentilles', 5]
          ]));
      await iTapOn(tester, 'Tester une nouvelle recette végétarienne');
      await iScrollDown(tester);
      await iTapOn(tester, 'Salade de pâtes complètes et lentilles');
      await iSee(tester, 'Temps de préparation : 5 min');
    });
  });
}
