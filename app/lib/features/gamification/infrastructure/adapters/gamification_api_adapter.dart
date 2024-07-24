import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/domain/ports/gamification_port.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/subjects.dart';

class GamificationApiAdapter implements GamificationPort {
  GamificationApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, void>> mettreAJourLesPoints() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.get(
      Uri.parse('/utilisateurs/$utilisateurId/gamification'),
    );
    if (response.statusCode != HttpStatus.ok) {
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
    await _gamificationSubject.close();
  }
}
