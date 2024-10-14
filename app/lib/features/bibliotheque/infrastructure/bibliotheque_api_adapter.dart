import 'dart:async';
import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_mapper.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class BibliothequeApiAdapter implements BibliothequePort {
  const BibliothequeApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, Bibliotheque>> recuperer({
    required final List<String>? thematiques,
    required final String? titre,
    required final bool? isFavorite,
  }) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final map = <String, String>{
      if (thematiques != null && thematiques.isNotEmpty)
        'filtre_thematiques': thematiques.join(','),
      if (titre != null && titre.isNotEmpty) 'titre': titre,
      if (isFavorite != null && isFavorite) 'favoris': '$isFavorite',
    };

    final uri = Uri.parse('/utilisateurs/$utilisateurId/bibliotheque').replace(
      queryParameters: map.isNotEmpty ? map : null,
    );

    final response = await _apiClient.get(uri);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception('Erreur lors de la récupération de la bibliothèque'),
      );
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(BibliothequeMapper.fromJson(json));
  }
}
