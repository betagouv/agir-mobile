import 'dart:convert';

import 'package:app/src/fonctionnalites/aides/domain/aide_velo.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_collectivite.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_par_type.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aide_velo_repository.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';

class AideVeloApiAdapter implements AideVeloRepository {
  const AideVeloApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<AideVeloParType> simuler({
    required final int prix,
    required final String codePostal,
    required final String ville,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      throw Exception();
    }
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
        body: jsonEncode({'code_postal': codePostal, 'commune': ville}),
      ),
    ]);

    for (final response in responses) {
      if (response.statusCode != 200) {
        throw Exception();
      }
    }

    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/$utilisateurId/simulerAideVelo'),
      body: jsonEncode({'prix_du_velo': prix}),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return AideVeloParType(
      mecaniqueSimple:
          (json['mécanique simple'] as List<dynamic>).map(_toAideVelo).toList(),
      electrique:
          (json['électrique'] as List<dynamic>).map(_toAideVelo).toList(),
      cargo: (json['cargo'] as List<dynamic>).map(_toAideVelo).toList(),
      cargoElectrique:
          (json['cargo électrique'] as List<dynamic>).map(_toAideVelo).toList(),
      pliant: (json['pliant'] as List<dynamic>).map(_toAideVelo).toList(),
      motorisation:
          (json['motorisation'] as List<dynamic>).map(_toAideVelo).toList(),
    );
  }
}

AideVelo _toAideVelo(final dynamic e) {
  final f = e as Map<String, dynamic>;

  return AideVelo(
    libelle: f['libelle'] as String,
    description: f['description'] as String,
    lien: f['lien'] as String,
    collectivite: _toAideVeloCollectivite(f['collectivite']),
    montant: (f['montant'] as num).toInt(),
    plafond: (f['plafond'] as num).toInt(),
    logo: f['logo'] as String,
  );
}

AideVeloCollectivite _toAideVeloCollectivite(final dynamic e) {
  final f = e as Map<String, dynamic>;

  return AideVeloCollectivite(
    kind: f['kind'] as String,
    value: f['value'] as String,
  );
}
