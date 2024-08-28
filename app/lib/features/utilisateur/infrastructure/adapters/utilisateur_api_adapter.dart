import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';
import 'package:fpdart/fpdart.dart';

class UtilisateurApiAdapter implements UtilisateurPort {
  const UtilisateurApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, Utilisateur>> recupereUtilisateur() async {
    final id = await _apiClient.recupererUtilisateurId;
    if (id == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }
    final response = await _apiClient.get(Uri.parse('/utilisateurs/$id'));
    if (response.statusCode != HttpStatus.ok) {
      return Left(
        Exception("Erreur lors de la récupération de l'utilisateur"),
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(
      Utilisateur(
        prenom: json['prenom'] as String? ?? '',
        fonctionnalitesDebloquees:
            (json['fonctionnalites_debloquees'] as List<dynamic>)
                .where(
                  (final e) =>
                      e == Fonctionnalites.aides.name ||
                      e == Fonctionnalites.recommandations.name ||
                      e == Fonctionnalites.bibliotheque.name ||
                      e == Fonctionnalites.univers.name,
                )
                .map((final e) => Fonctionnalites.values.byName(e as String))
                .toList(),
        estIntegrationTerminee: json['is_onboarding_done'] as bool,
      ),
    );
  }
}
