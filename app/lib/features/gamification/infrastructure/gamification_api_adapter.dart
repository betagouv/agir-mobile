import 'dart:async';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/subjects.dart';

class GamificationApiAdapter implements GamificationPort {
  GamificationApiAdapter({
    required final DioHttpClient client,
    required final MessageBus messageBus,
  }) : _client = client {
    _subscription =
        messageBus.subscribe(actionCompletedTopic).listen((final event) async {
      await mettreAJourLesPoints();
    });
    _subscription2 = messageBus.subscribe(kycTopic).listen((final event) async {
      await mettreAJourLesPoints();
    });
  }

  final DioHttpClient _client;
  late final StreamSubscription<String> _subscription;
  late final StreamSubscription<String> _subscription2;

  @override
  Future<Either<Exception, void>> mettreAJourLesPoints() async {
    final response = await _client.get(
      '/utilisateurs/{userId}/gamification',
    );
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des points'));
    }

    final json = response.data as Map<String, dynamic>;

    final gamification = Gamification(points: (json['points'] as num).toInt());

    _gamificationSubject.add(gamification);

    return const Right(null);
  }

  final _gamificationSubject = BehaviorSubject<Gamification>();

  @override
  Stream<Gamification> gamification() => _gamificationSubject.stream;

  Future<void> dispose() async {
    await _subscription.cancel();
    await _subscription2.cancel();
    await _gamificationSubject.close();
  }
}
