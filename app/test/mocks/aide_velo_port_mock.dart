import 'package:app/features/aides/simulateur_velo/domain/ports/aide_velo_port.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';

class AideVeloPortMock implements AideVeloPort {
  AideVeloPortMock({required final AideVeloParType aideVeloParType})
      : _aideVeloParType = aideVeloParType;

  int prix = 0;
  String codePostal = '';
  String ville = '';
  double nombreDePartsFiscales = 0;
  int revenuFiscal = 0;

  final AideVeloParType _aideVeloParType;

  @override
  Future<AideVeloParType> simuler({
    required final int prix,
    required final String codePostal,
    required final String ville,
    required final double nombreDePartsFiscales,
    required final int revenuFiscal,
  }) async {
    this.prix = prix;
    this.codePostal = codePostal;
    this.ville = ville;
    this.nombreDePartsFiscales = nombreDePartsFiscales;
    this.revenuFiscal = revenuFiscal;

    return _aideVeloParType;
  }
}
