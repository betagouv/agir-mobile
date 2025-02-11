// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_have_actions_in_my_library.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';

void main() {
  group('''Actions''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
    }

    testWidgets('''See all actions''', (tester) async {
      await bddSetUp(tester);
      await iHaveActionsInMyLibrary(
          tester,
          const bdd.DataTable([
            ['title', 'nb_actions_completed', 'nb_aids_available'],
            ['Contribuer à la **bonne santé de son sol**', 0, 0],
            ['Tester une **nouvelle recette végétarienne**', 1, 1],
            ['Faire réparer une **paire de chaussures**', 2, 2]
          ]));
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
  });
}
