import 'dart:async';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_mapper.dart';
import 'package:fpdart/fpdart.dart';

class BibliothequeApiAdapter implements BibliothequePort {
  const BibliothequeApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, Bibliotheque>> recuperer({
    required final List<String>? thematiques,
    required final String? titre,
    required final bool? isFavorite,
  }) async {
    final map = <String, String>{
      if (thematiques != null && thematiques.isNotEmpty)
        'filtre_thematiques': thematiques.join(','),
      if (titre != null && titre.isNotEmpty) 'titre': titre,
      if (isFavorite != null && isFavorite) 'favoris': '$isFavorite',
    };

    final uri = Uri(
      path: Endpoints.bibliotheque,
      queryParameters: map.isNotEmpty ? map : null,
    );

    final response = await _client.get(uri.toString());

    return isResponseUnsuccessful(response.statusCode)
        ? Left(
            Exception('Erreur lors de la récupération de la bibliothèque'),
          )
        : Right(
            BibliothequeMapper.fromJson(response.data as Map<String, dynamic>),
          );
  }
}
