import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';

abstract interface class AideVeloPort {
  Future<AideVeloParType> simuler({
    required final int prix,
    required final String codePostal,
    required final String commune,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  });
}
