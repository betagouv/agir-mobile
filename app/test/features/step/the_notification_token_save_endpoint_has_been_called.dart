import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';

/// Usage: The notification token save endpoint has been called
Future<void> theNotificationTokenSaveEndpointHasBeenCalled(
  final WidgetTester tester,
) async {
  verify(
    () => FeatureContext.instance.dioMock.put<dynamic>(
      Endpoints.notificationToken,
      data: {'token': 'token'},
    ),
  );
}
