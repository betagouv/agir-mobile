// ignore_for_file: no-equal-switch-expression-cases

import 'dart:convert';

import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/ports/recommandations_port.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsApiAdapter implements RecommandationsPort {
  const RecommandationsApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, List<Recommandation>>> recuperer() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/recommandations_v2'));

    if (response.statusCode != 200) {
      return Left(
        Exception('Erreur lors de la récupération des recommandations'),
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return Right(
      json.map((final e) {
        final f = e as Map<String, dynamic>;

        return Recommandation(
          titre: f['titre'] as String,
          imageUrl: f['image_url'] as String,
          points: (f['points'] as num).toInt(),
          thematique:
              _mapThematiqueFromJson(f['thematique_principale'] as String),
        );
      }).toList(),
    );
  }

  static Thematique _mapThematiqueFromJson(final String? type) =>
      switch (type) {
        'alimentation' => Thematique.alimentation,
        'transport' => Thematique.transport,
        'logement' => Thematique.logement,
        'consommation' => Thematique.consommation,
        'climat' => Thematique.climat,
        'dechet' => Thematique.dechet,
        'loisir' => Thematique.loisir,
        _ => Thematique.loisir,
      };
}
