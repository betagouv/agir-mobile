import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: The account deletion endpoint has not been called
Future<void> theAccountDeletionEndpointHasNotBeenCalled(final WidgetTester tester) async {
  verifyNever(() => FeatureContext.instance.dioMock.delete<dynamic>(Endpoints.utilisateur));
}
