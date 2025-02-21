import 'package:app/app/app.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:clock/clock.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';
import '../helper/notification_service_fake.dart';

class _TrackerMock extends Mock implements Tracker {}

/// Usage: The application is launched
Future<void> theApplicationIsLaunched(final WidgetTester tester) async {
  final clock = Clock.fixed(DateTime(1992, 9));
  final authenticationStorage = AuthenticationStorage(FeatureContext.instance.secureStorage);
  await authenticationStorage.init();
  final authenticationService = AuthenticationService(authenticationStorage: authenticationStorage, clock: clock);
  await authenticationService.checkAuthenticationStatus();
  final dioHttpClient = DioHttpClient(dio: FeatureContext.instance.dioMock, authenticationService: authenticationService);
  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver).thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  final messageBus = MessageBus();

  await tester.pumpFrames(
    App(
      clock: clock,
      tracker: tracker,
      messageBus: messageBus,
      dioHttpClient: dioHttpClient,
      packageInfo: FeatureContext.instance.packageInfo,
      notificationService: const NotificationServiceFake(AuthorizationStatus.authorized),
      authenticationService: authenticationService,
    ),
    Durations.short1,
  );
}
