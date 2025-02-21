import 'dart:convert';

import 'package:app/app/router/app_router.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../helper/feature_context.dart';

/// Usage: I'm redirect to FranceConnect callback
Future<void> imRedirectToFranceconnectCallback(final WidgetTester tester) async {
  const user = 'user123';
  const code = 'aCode';
  const state = 'aState';
  final uri = Uri(path: Endpoints.franceConnectStep2, queryParameters: {'oidc_code': code, 'oidc_state': state});
  FeatureContext.instance.dioMock
    ..getM(
      uri.toString(),
      responseData: jsonDecode('''
{
  "token": "${"header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': user}).codeUnits)}.signature"}",
  "utilisateur": {
    "id": "$user"
  }
}'''),
    )
    ..getM(Endpoints.utilisateur, responseData: {'is_onboarding_done': false});
  GoRouter.of(navigatorKey.currentContext!).go('https://www.jagis.gouv.fr/fc-login-callback?code=$code&state=$state');
  await tester.pumpAndSettle();
}
