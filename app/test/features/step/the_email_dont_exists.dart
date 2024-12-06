import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: the email don't exists
Future<void> theEmailDontExists(final WidgetTester tester) async {
  FeatureContext.instance.dioMock.postM(Endpoints.creationCompte);
}
