import 'dart:convert';
import 'dart:io';

import 'package:app/features/aides/simulateur_velo/domain/ports/aide_velo_port.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class AideVeloApiAdapter implements AideVeloPort {
  const AideVeloApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, AideVeloParType>> simuler({
    required final int prix,
    required final String codePostal,
    required final String commune,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final result = await _mettreAJourProfilEtLogement(
      utilisateurId: utilisateurId,
      nombreDePartsFiscales: nombreDePartsFiscales,
      revenuFiscal: revenuFiscal,
      codePostal: codePostal,
      commune: commune,
    );

    if (result.isLeft()) {
      return Left(result.getLeft().getOrElse(() => throw Exception()));
    }

    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/$utilisateurId/simulerAideVelo'),
      body: jsonEncode({'prix_du_velo': prix}),
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception("Erreur lors de la simulation de l'aide vélo"));
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(
      AideVeloParType(
        mecaniqueSimple: (json['mécanique simple'] as List<dynamic>)
            .map(_toAideVelo)
            .toList(),
        electrique:
            (json['électrique'] as List<dynamic>).map(_toAideVelo).toList(),
        cargo: (json['cargo'] as List<dynamic>).map(_toAideVelo).toList(),
        cargoElectrique: (json['cargo électrique'] as List<dynamic>)
            .map(_toAideVelo)
            .toList(),
        pliant: (json['pliant'] as List<dynamic>).map(_toAideVelo).toList(),
        motorisation:
            (json['motorisation'] as List<dynamic>).map(_toAideVelo).toList(),
      ),
    );
  }

  Future<Either<Exception, void>> _mettreAJourProfilEtLogement({
    required final String utilisateurId,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
    required final String codePostal,
    required final String commune,
  }) async {
    final responses = await Future.wait([
      _apiClient.patch(
        Uri.parse('/utilisateurs/$utilisateurId/profile'),
        body: jsonEncode({
          'nombre_de_parts_fiscales': nombreDePartsFiscales,
          'revenu_fiscal': revenuFiscal,
        }),
      ),
      _apiClient.patch(
        Uri.parse('/utilisateurs/$utilisateurId/logement'),
        body: jsonEncode({'code_postal': codePostal, 'commune': commune}),
      ),
    ]);

    for (final response in responses) {
      if (response.statusCode != HttpStatus.ok) {
        return Left(Exception('Erreur lors de la mise à jour du profil'));
      }
    }

    return const Right(null);
  }
}

AideVelo _toAideVelo(final dynamic e) {
  final f = e as Map<String, dynamic>;

  return AideVelo(
    libelle: f['libelle'] as String,
    description: f['description'] as String,
    lien: f['lien'] as String,
    montant: (f['montant'] as num).toInt(),
    plafond: (f['plafond'] as num).toInt(),
    logo: f['logo'] as String,
  );
}
