import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: The change password endpoint has not been called
Future<void> theChangePasswordEndpointHasNotBeenCalled(final WidgetTester tester) async {
  verifyNever(
    () => FeatureContext.instance.dioMock.patch<dynamic>(Endpoints.profile, data: jsonEncode({'mot_de_passe': 'pasvalide'})),
  );
}
