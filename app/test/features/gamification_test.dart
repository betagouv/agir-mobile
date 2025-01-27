// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_see_points.dart';

void main() {
  group('''Gamification''', () {
    testWidgets('''View points at application startup''', (tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iSeePoints(tester, '650');
    });
  });
}
