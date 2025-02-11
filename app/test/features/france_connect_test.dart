// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on.dart';
import './step/im_redirect_to_franceconnect_callback.dart';
import './step/i_see.dart';

void main() {
  group('''France Connect''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
    }

    testWidgets('''Login with FranceConnect is successful''', (tester) async {
      await bddSetUp(tester);
      await theApplicationIsLaunched(tester);
      await iTapOn(tester, "J’ai déjà un compte");
      await iTapOn(tester, "FranceConnect");
      await imRedirectToFranceconnectCallback(tester);
      await iSee(tester, 'Bienvenue sur J’agis ! Faisons connaissance...');
    });
  });
}
