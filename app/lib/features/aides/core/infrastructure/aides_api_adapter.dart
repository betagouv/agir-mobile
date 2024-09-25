import 'dart:async';
import 'dart:io';

import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:app/features/aides/core/infrastructure/aide_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class AidesApiAdapter implements AidesPort {
  const AidesApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<Aide>>> fetchAides() async {
    final utilisateurId = await _client.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _client.get<List<dynamic>>(
      '/utilisateurs/$utilisateurId/aides',
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération des aides'));
    }

    final json = response.data!;

    return Right(
      json
          .map((final e) => AideMapper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
