import 'package:app/src/app.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../authentification_repository_mock.dart';
import '../scenario_context.dart';

/// Iel lance l'application
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final authentificationStatusManager = AuthentificationStatutManager()
    ..gererAuthentificationStatut(ScenarioContext().authentificationStatut);
  final authentificationRepositoryMock =
      AuthentificationRepositoryMock(authentificationStatusManager);
  await tester.pumpFrames(
    App(
      authentificationRepository: authentificationRepositoryMock,
      authentificationStatusManager: authentificationStatusManager,
    ),
    Durations.short1,
  );
}
