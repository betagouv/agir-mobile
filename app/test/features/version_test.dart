// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/the_application_is_launched.dart';
import './step/i_see.dart';
import './step/i_am_logged_in.dart';
import './step/i_tap_on_the_menu_button.dart';

void main() {
  group('''Version''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
    }

    testWidgets('''User launches app and sees version number''', (
      tester,
    ) async {
      await bddSetUp(tester);
      await theApplicationIsLaunched(tester);
      await iSee(tester, '1.2.3+4');
    });
    testWidgets('''User views version number through menu''', (tester) async {
      await bddSetUp(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iSee(tester, '1.2.3+4');
    });
  });
}
