import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: The account deletion endpoint has been called
Future<void> theAccountDeletionEndpointHasBeenCalled(
  final WidgetTester tester,
) async {
  verify(
    () =>
        FeatureContext.instance.dioMock.delete<dynamic>(Endpoints.utilisateur),
  );
}