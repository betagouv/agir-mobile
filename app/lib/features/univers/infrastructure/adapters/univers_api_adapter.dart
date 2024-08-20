// ignore_for_file: no-equal-switch-expression-cases

import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
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
}
