import 'dart:async';
import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/subjects.dart';

class GamificationApiAdapter implements GamificationPort {
  GamificationApiAdapter({
    required final AuthentificationApiClient apiClient,
    required final MessageBus messageBus,
  }) : _apiClient = apiClient {
    _subscription =
        messageBus.subscribe(actionCompletedTopic).listen((final event) async {
      await mettreAJourLesPoints();
    });
  }

  final AuthentificationApiClient _apiClient;
  late final StreamSubscription<String> _subscription;

  @override
  Future<Either<Exception, void>> mettreAJourLesPoints() async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.get(
      Uri.parse('/utilisateurs/$utilisateurId/gamification'),
    );
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des points'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final gamification = Gamification(points: (json['points'] as num).toInt());

    _gamificationSubject.add(gamification);

    return const Right(null);
  }

  final _gamificationSubject = BehaviorSubject<Gamification>();

  @override
  Stream<Gamification> gamification() => _gamificationSubject.stream;

  Future<void> dispose() async {
    await _subscription.cancel();
    await _gamificationSubject.close();
    await _apiClient.close();
  }
}
