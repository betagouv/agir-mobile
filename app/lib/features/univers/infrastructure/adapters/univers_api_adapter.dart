// ignore_for_file: no-equal-switch-expression-cases

import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/univers/domain/aggregates/mission.dart';
import 'package:app/features/univers/domain/entities/defi.dart';
import 'package:app/features/univers/domain/mission_liste.dart';
import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/domain/value_objects/content_id.dart';
import 'package:app/features/univers/domain/value_objects/defi_id.dart';
import 'package:app/features/univers/infrastructure/adapters/defi_mapper.dart';
import 'package:app/features/univers/infrastructure/adapters/mission_liste_mapper.dart';
import 'package:app/features/univers/infrastructure/adapters/mission_mapper.dart';
import 'package:app/features/univers/infrastructure/adapters/tuile_univers_mapper.dart';
import 'package:fpdart/fpdart.dart';

class UniversApiAdapter implements UniversPort {
  const UniversApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<TuileUnivers>>> recuperer() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response =
        await _apiClient.get(Uri.parse('/utilisateurs/$utilisateurId/univers'));

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération des univers'));
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return Right(
      json
          .map(
            (final e) => TuileUniversMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Exception, List<MissionListe>>> recupererThematiques({
    required final String universType,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.get(
      Uri.parse(
        '/utilisateurs/$utilisateurId/univers/$universType/thematiques',
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération des missions'));
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return Right(
      json
          .map(
            (final e) => MissionListeMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Exception, Mission>> recupererMission({
    required final String missionId,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.get(
      Uri.parse(
        '/utilisateurs/$utilisateurId/thematiques/$missionId/mission',
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération de la mission'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(MissionMapper.fromJson(json));
  }

  @override
  Future<Either<Exception, Defi>> recupererDefi({
    required final DefiId defiId,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/defis/${defiId.value}'));

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération du défi'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(DefiMapper.fromJson(json));
  }

  @override
  Future<Either<Exception, void>> accepterDefi({
    required final DefiId defiId,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final parse =
        Uri.parse('/utilisateurs/$utilisateurId/defis/${defiId.value}');

    final response = await _apiClient.patch(
      parse,
      body: jsonEncode({'status': 'en_cours'}),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception("Erreur lors de l'acceptation du défi"));
  }

  @override
  Future<Either<Exception, void>> refuserDefi({
    required final DefiId defiId,
    final String? motif,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.patch(
      Uri.parse('/utilisateurs/$utilisateurId/defis/${defiId.value}'),
      body: jsonEncode(
        {if (motif != null) 'motif': motif, 'status': 'pas_envie'},
      ),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors du refus du défi'));
  }

  @override
  Future<Either<Exception, void>> gagnerPoints({
    required final ObjectifId id,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.post(
      Uri.parse(
        '/utilisateurs/$utilisateurId/objectifs/${id.value}/gagner_points',
      ),
      body: jsonEncode({'element_id': id.value}),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors du gain de points'));
  }

  @override
  Future<Either<Exception, void>> terminer({
    required final String missionId,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.post(
      Uri.parse(
        '/utilisateurs/$utilisateurId/thematiques/$missionId/mission/terminer',
      ),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la fin de la mission'));
  }
}
