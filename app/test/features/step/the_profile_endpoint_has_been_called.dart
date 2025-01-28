import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: The profile endpoint has been called
Future<void> theProfileEndpointHasBeenCalled(final WidgetTester tester) async {
  verify(
    () => FeatureContext.instance.dioMock.patch<dynamic>(
      Endpoints.profile,
      data:
          jsonEncode({'nombre_de_parts_fiscales': 2.5, 'revenu_fiscal': 16000}),
    ),
  );
}
