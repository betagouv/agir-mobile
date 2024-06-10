import 'package:app/src/fonctionnalites/aides/domain/aide_velo_informations.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_par_type.dart';

abstract interface class AideVeloRepository {
  Future<AideVeloInformations> recupererProfil();

  Future<AideVeloParType> simuler({
    required final int prix,
    required final String codePostal,
    required final String ville,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  });
}
