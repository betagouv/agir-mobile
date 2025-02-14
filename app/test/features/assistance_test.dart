// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';

void main() {
  group('''Assistance''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
    }

    testWidgets('''Show 2 first assistances on the home page''',
        (tester) async {
      await bddSetUp(tester);
      await iSee(tester, 'Rénover son logement');
      await iSee(tester, 'Acheter un vélo');
      await iDontSee(tester, 'Composter ses déchets');
    });
    testWidgets('''Show assistances on the assistance page''', (tester) async {
      await bddSetUp(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mes aides');
      await iSee(tester, 'Simulateur');
      await iSee(tester, 'Rénover son logement');
      await iSee(tester, 'Acheter un vélo');
      await iSee(tester, 'Composter ses déchets');
    });
    testWidgets('''Filter assistances by theme''', (tester) async {
      await bddSetUp(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mes aides');
      await iTapOn(tester, 'Me déplacer');
      await iSee(tester, 'Acheter un vélo');
      await iDontSee(tester, 'Rénover son logement');
      await iDontSee(tester, 'Composter ses déchets');
    });
    testWidgets('''Go on the assistance detail page''', (tester) async {
      await bddSetUp(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mes aides');
      await iTapOn(tester, 'Composter ses déchets');
      await iSee(tester, 'Composter ses déchets');
      await iDontSee(tester, 'Acheter un vélo');
      await iDontSee(tester, 'Rénover son logement');
    });
  });
}
