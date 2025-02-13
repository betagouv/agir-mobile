// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/the_application_is_launched.dart';
import './step/the_email_dont_exists.dart';
import './step/i_tap_on.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_accept_the_terms_of_use.dart';
import './step/i_tap_on_create_my_account_button.dart';
import './step/i_enter_in_the_pin_field.dart';
import './step/i_see.dart';
import './step/i_select_in_the_field.dart';
import './step/i_see_the_home_page.dart';

void main() {
  group('''First questions''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await theApplicationIsLaunched(tester);
      await theEmailDontExists(tester);
      await iTapOn(tester, 'Je crée mon compte');
      await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
      await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
      await iAcceptTheTermsOfUse(tester);
      await iTapOnCreateMyAccountButton(tester);
      await iEnterInThePinField(tester, '999999');
    }

    testWidgets('''Answer the first questions.''', (tester) async {
      await bddSetUp(tester);
      await iEnterInTheField(tester, 'Joe', 'Mon prénom');
      await iSee(
        tester,
        'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.',
      );
      await iEnterInTheField(tester, '39100', 'Code postal');
      await iSelectInTheField(tester, 'DOLE', 'Commune');
      await iTapOn(tester, 'Continuer');
      await iSee(tester, 'J’agis est encore en expérimentation !');
      await iTapOn(tester, 'J’ai compris');
      await iSee(tester, 'C’est presque terminé !');
      await iTapOn(tester, 'La cuisine et l’alimentation');
      await iTapOn(tester, 'Continuer');
      await iSee(tester, 'Tout est prêt !');
      await iTapOn(tester, 'C’est parti !');
      await iSeeTheHomePage(tester);
    });
  });
}
