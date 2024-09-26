import 'dart:async';

import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/authentification/core/domain/authentification_statut_manager.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_token_storage.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/infrastructure/gamification_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  test('gamification', () async {
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/gamification',
        response: CustomResponse(
          '''
{
  "points": 650,
  "niveau": 6,
  "current_points_in_niveau": 150,
  "point_target_in_niveau": 300,
  "celebrations": [
    {
      "id": "d907cc3b-5b3c-4db4-9660-c651f7e9c789",
      "type": "fin_mission",
      "titre": "Toutes les missions sont terminées !!"
    }
  ]
}''',
        ),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);

    final adapter = GamificationApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
      messageBus: MessageBus(),
    );

    unawaited(
      expectLater(
        adapter.gamification(),
        emitsInOrder([const Gamification(points: 650), emitsDone]),
      ),
    );

    await adapter.mettreAJourLesPoints();

    await adapter.dispose();
  });
}
