// ignore_for_file: no-equal-switch-expression-cases

import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/univers/core/domain/content_id.dart';
import 'package:app/features/univers/core/domain/mission.dart';
import 'package:app/features/univers/core/domain/mission_liste.dart';
import 'package:app/features/univers/core/domain/service_item.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:app/features/univers/core/infrastructure/mission_liste_mapper.dart';
import 'package:app/features/univers/core/infrastructure/mission_mapper.dart';
import 'package:app/features/univers/core/infrastructure/service_item_mapper.dart';
import 'package:app/features/univers/core/infrastructure/tuile_univers_mapper.dart';
import 'package:fpdart/fpdart.dart';

class UniversApiAdapter implements UniversPort {
  const UniversApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<TuileUnivers>>> recuperer() async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
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
  Future<Either<Exception, List<MissionListe>>> recupererThematiques(
    final String universType,
  ) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
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
    final utilisateurId = _apiClient.recupererUtilisateurId;
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
  Future<Either<Exception, void>> gagnerPoints({
    required final ObjectifId id,
  }) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
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
    final utilisateurId = _apiClient.recupererUtilisateurId;
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

  @override
  Future<Either<Exception, List<ServiceItem>>> getServices(
    final String universType,
  ) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.get(
      Uri.parse(
        '/utilisateurs/$utilisateurId/recherche_services/$universType',
      ),
    );

    return response.statusCode == HttpStatus.ok
        ? Right(
            (jsonDecode(response.body) as List<dynamic>)
                .map((final e) => e as Map<String, dynamic>)
                .map(ServiceItemMapper.fromJson)
                .toList(),
          )
        : Left(Exception('Erreur lors de la récupération des services'));
  }
}
