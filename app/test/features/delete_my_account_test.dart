// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/i_scroll_down.dart';
import './step/the_account_deletion_endpoint_has_been_called.dart';
import './step/i_see.dart';
import './step/the_account_deletion_endpoint_has_not_been_called.dart';

void main() {
  group('''Delete my account''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Mon profil');
      await iScrollDown(tester);
      await iTapOn(tester, 'Options avancées');
      await iScrollDown(tester);
      await iTapOn(tester, 'Supprimer mon compte');
    }

    testWidgets('''Confirm account deletion''', (tester) async {
      await bddSetUp(tester);
      await iTapOn(tester, 'Confirmer');
      await theAccountDeletionEndpointHasBeenCalled(tester);
      await iSee(tester, 'Ensemble,\naméliorons\nnos habitudes\nau jour le jour');
    });
    testWidgets('''Cancel account deletion''', (tester) async {
      await bddSetUp(tester);
      await iTapOn(tester, 'Annuler');
      await theAccountDeletionEndpointHasNotBeenCalled(tester);
      await iSee(tester, 'Options avancées');
    });
  });
}
