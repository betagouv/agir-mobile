// ignore_for_file: no-equal-switch-expression-cases

import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/recommandations/domain/ports/recommandations_port.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/infrastructure/adapters/recommandation_mapper.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsApiAdapter implements RecommandationsPort {
  const RecommandationsApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final String? thematique,
  ) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final map = {if (thematique != null) 'univers': thematique};

    final uri =
        Uri.parse('/utilisateurs/$utilisateurId/recommandations_v2').replace(
      queryParameters: map.isNotEmpty ? map : null,
    );

    final response = await _apiClient.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      return Left(
        Exception('Erreur lors de la récupération des recommandations'),
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return Right(
      json
          .map(
            (final e) =>
                RecommandationMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
