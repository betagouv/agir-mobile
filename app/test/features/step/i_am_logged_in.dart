import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I am logged in
Future<void> iAmLoggedIn(final WidgetTester tester) async {
  await FeatureContext.instance.secureStorage.write(
    key: 'token',
    value: 'header.${base64Encode(jsonEncode({'exp': 715341600, 'utilisateurId': 'user123'}).codeUnits)}.signature',
  );
  FeatureContext.instance.dioMock.getM(Endpoints.utilisateur, responseData: {'prenom': 'Joe', 'is_onboarding_done': true});
}
