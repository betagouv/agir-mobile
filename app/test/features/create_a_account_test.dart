// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/the_email_dont_exists.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_field.dart';
import './step/i_accept_the_terms_of_use.dart';
import './step/i_tap_on_create_my_account_button.dart';
import './step/i_enter_in_the_pin_field.dart';
import './step/the_email_already_exists.dart';

void main() {
  group('''Create a account''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, 'Je crée mon compte');
    }

    testWidgets('''Successful account creation''', (tester) async {
      await bddSetUp(tester);
      await theEmailDontExists(tester);
      await iSee(tester, 'Créez votre compte J’agis');
      await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
      await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
      await iAcceptTheTermsOfUse(tester);
      await iTapOnCreateMyAccountButton(tester);
      await iSee(tester, 'Entrez le code reçu par e-mail !');
      await iEnterInThePinField(tester, '999999');
      await iSee(tester, 'Bienvenue sur J’agis ! Faisons connaissance...');
    });
    testWidgets('''See the error message when the email already exists''',
        (tester) async {
      await bddSetUp(tester);
      await theEmailAlreadyExists(tester);
      await iEnterInTheField(tester, 'joe@doe.fr', 'Mon adresse email');
      await iEnterInTheField(tester, 'Azertyuiop1&', 'Mot de passe');
      await iAcceptTheTermsOfUse(tester);
      await iTapOnCreateMyAccountButton(tester);
      await iSee(tester, 'Adresse électronique joe@doe.fr déjà existante');
    });
  });
}
