// ignore_for_file: avoid-long-parameter-list

import 'dart:convert';
import 'dart:io';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo_par_type.dart';
import 'package:app/features/simulateur_velo/domain/velo_pour_simulateur.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_par_type_mapper.dart';
import 'package:fpdart/fpdart.dart';

class AideVeloRepository {
  const AideVeloRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, AideVeloParType>> simuler({
    required final int prix,
    required final VeloEtat etatVelo,
    required final String codePostal,
    required final String commune,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  }) async {
    final result = await _mettreAJourProfilEtLogement(
      nombreDePartsFiscales: nombreDePartsFiscales,
      revenuFiscal: revenuFiscal,
      codePostal: codePostal,
      commune: commune,
    );

    return result.fold(Left.new, (final r) async {
      final response = await _client.post(
        Endpoints.simulerAideVelo,
        data: jsonEncode({
          'prix_du_velo': prix,
          'etat_du_velo': _etatVeloToString(etatVelo),
        }),
      );

      if (response.statusCode! >= HttpStatus.badRequest) {
        return Left(Exception("Erreur lors de la simulation de l'aide vélo"));
      }

      final json = response.data as Map<String, dynamic>;

      return Right(AideVeloParTypeMapper.fromJson(json));
    });
  }

  String _etatVeloToString(final VeloEtat etatVelo) => switch (etatVelo) {
        VeloEtat.neuf => 'neuf',
        VeloEtat.occasion => 'occasion',
      };

  Future<Either<Exception, void>> _mettreAJourProfilEtLogement({
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
    required final String codePostal,
    required final String commune,
  }) async {
    final responses = await Future.wait([
      _client.patch(
        Endpoints.profile,
        data: jsonEncode({
          'nombre_de_parts_fiscales': nombreDePartsFiscales,
          'revenu_fiscal': revenuFiscal,
        }),
      ),
      _client.patch(
        Endpoints.logement,
        data: jsonEncode({'code_postal': codePostal, 'commune': commune}),
      ),
    ]);

    for (final response in responses) {
      if (isResponseUnsuccessful(response.statusCode)) {
        return Left(Exception('Erreur lors de la mise à jour du profil'));
      }
    }

    return const Right(null);
  }
}
