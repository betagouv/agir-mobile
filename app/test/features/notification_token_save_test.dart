// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/the_notification_token_save_endpoint_has_been_called.dart';

void main() {
  group('''Save notification token''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
    }

    testWidgets(
        '''Login to my account is successful and notification token is saved''',
        (tester) async {
      await bddSetUp(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await theNotificationTokenSaveEndpointHasBeenCalled(tester);
    });
  });
}
