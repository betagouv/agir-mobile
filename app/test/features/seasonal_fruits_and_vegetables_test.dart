// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/i_scroll_down.dart';
import './step/i_see.dart';
import './step/i_dont_see.dart';

void main() {
  group('''Seasonal fruits and vegetables service''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, 'Me nourrir');
      await iScrollDown(tester);
      await iTapOn(tester, 'Fruits et légumes de saison');
    }

    testWidgets('''See seasonal fruits and vegetables''', (tester) async {
      await bddSetUp(tester);
      await iSee(tester, 'Les fruits et légumes pour le mois de');
      await iSee(tester, 'janvier');
      await iSee(tester, 'Poire');
      await iDontSee(tester, 'Fraise');
    });
    testWidgets(
        '''Change the month to view different seasonal fruits and vegetables''',
        (tester) async {
      await bddSetUp(tester);
      await iTapOn(tester, 'janvier');
      await iTapOn(tester, 'juin');
      await iSee(tester, 'Fraise');
      await iDontSee(tester, 'Poire');
    });
  });
}
