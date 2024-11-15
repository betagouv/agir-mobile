// ignore_for_file: no-equal-switch-expression-cases

import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/theme/core/domain/content_id.dart';
import 'package:app/features/theme/core/domain/mission.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/core/infrastructure/mission_liste_mapper.dart';
import 'package:app/features/theme/core/infrastructure/mission_mapper.dart';
import 'package:app/features/theme/core/infrastructure/service_item_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ThemeApiAdapter implements ThemePort {
  const ThemeApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<MissionListe>>> recupererMissions(
    final String themeType,
  ) async {
    final response = await _client.get(
      '/utilisateurs/{userId}/thematiques/$themeType/tuiles_missions',
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des missions'));
    }
    final json = response.data as List<dynamic>;

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
    final response = await _client.get(
      '/utilisateurs/{userId}/missions/$missionId',
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération de la mission'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(MissionMapper.fromJson(json));
  }

  @override
  Future<Either<Exception, void>> gagnerPoints({
    required final ObjectifId id,
  }) async {
    final response = await _client.post(
      '/utilisateurs/{userId}/objectifs/${id.value}/gagner_points',
      data: jsonEncode({'element_id': id.value}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors du gain de points'));
  }

  @override
  Future<Either<Exception, void>> terminer({
    required final String missionId,
  }) async {
    final response = await _client.post(
      '/utilisateurs/{userId}/missions/$missionId/terminer',
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la fin de la mission'));
  }

  @override
  Future<Either<Exception, List<ServiceItem>>> getServices(
    final String themeType,
  ) async {
    final response = await _client.get(
      '/utilisateurs/{userId}/thematiques/$themeType/recherche_services',
    );

    return isResponseSuccessful(response.statusCode)
        ? Right(
            (response.data as List<dynamic>)
                .map((final e) => e as Map<String, dynamic>)
                .map(ServiceItemMapper.fromJson)
                .toList(),
          )
        : Left(Exception('Erreur lors de la récupération des services'));
  }
}
