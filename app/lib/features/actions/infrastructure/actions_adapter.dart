import 'dart:async';
import 'dart:io';

import 'package:app/features/actions/domain/action_item.dart';
import 'package:app/features/actions/domain/actions_port.dart';
import 'package:app/features/actions/infrastructure/action_item_mapper.dart';
import 'package:app/features/authentification/infrastructure/adapters/dio_http_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class ActionsAdapter implements ActionsPort {
  const ActionsAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<ActionItem>>> fetchActions() async {
    final utilisateurId = await _client.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _client.get<List<dynamic>>(
      '/utilisateurs/$utilisateurId/defis',
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération des actions'));
    }

    final json = response.data!;

    return Right(
      json
          .map(
            (final e) => ActionItemMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
