// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_tap_on.dart';
import './step/the_notification_token_delete_endpoint_has_been_called.dart';

void main() {
  group('''Delete notification token''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
    }

    testWidgets('''L'utilisateur se déconnecte de l'application alors le token de notification est supprimé''', (tester) async {
      await bddSetUp(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
      await iTapOn(tester, 'Se déconnecter');
      await theNotificationTokenDeleteEndpointHasBeenCalled(tester);
    });
  });
}
