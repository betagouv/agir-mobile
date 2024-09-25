import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo_par_type.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo_port.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_par_type_mapper.dart';
import 'package:fpdart/fpdart.dart';

class AideVeloApiAdapter implements AideVeloPort {
  const AideVeloApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, AideVeloParType>> simuler({
    required final int prix,
    required final String codePostal,
    required final String commune,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  }) async {
    final utilisateurId = await _client.recupererUtilisateurId;
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

    return result.fold(Left.new, (final r) async {
      final response = await _client.post<dynamic>(
        '/utilisateurs/$utilisateurId/simulerAideVelo',
        data: jsonEncode({'prix_du_velo': prix}),
      );

      if (response.statusCode! >= HttpStatus.badRequest) {
        return Left(Exception("Erreur lors de la simulation de l'aide vélo"));
      }

      final json = response.data as Map<String, dynamic>;

      return Right(AideVeloParTypeMapper.fromJson(json));
    });
  }

  Future<Either<Exception, void>> _mettreAJourProfilEtLogement({
    required final String utilisateurId,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
    required final String codePostal,
    required final String commune,
  }) async {
    final responses = await Future.wait([
      _client.patch<void>(
        '/utilisateurs/$utilisateurId/profile',
        data: jsonEncode({
          'nombre_de_parts_fiscales': nombreDePartsFiscales,
          'revenu_fiscal': revenuFiscal,
        }),
      ),
      _client.patch<void>(
        '/utilisateurs/$utilisateurId/logement',
        data: jsonEncode({'code_postal': codePostal, 'commune': commune}),
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
