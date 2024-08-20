import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/domain/ports/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/infrastructure/adapters/bibliotheque_mapper.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class BibliothequeApiAdapter implements BibliothequePort {
  const BibliothequeApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, Bibliotheque>> recuperer({
    final List<String>? thematiques,
    final String? titre,
    final bool? estFavoris,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final map = {
      if (thematiques != null) 'filtre_thematiques': thematiques.join(','),
      if (titre != null) 'titre': titre,
    };

    final uri = Uri.parse('/utilisateurs/$utilisateurId/bibliotheque').replace(
      queryParameters: map.isNotEmpty ? map : null,
    );

    final response = await _apiClient.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      return Left(
        Exception('Erreur lors de la récupération de la bibliothèque'),
      );
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(BibliothequeMapper.fromJson(json));
  }
}
