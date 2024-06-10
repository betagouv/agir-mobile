import 'package:app/src/fonctionnalites/aides/domain/aide_velo_informations.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_par_type.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aide_velo_repository.dart';

class AideVeloRepositoryMock implements AideVeloRepository {
  AideVeloRepositoryMock({
    required final AideVeloParType aideVeloParType,
    required final AideVeloInformations profil,
  })  : _aideVeloParType = aideVeloParType,
        _profil = profil;

  int prix = 0;
  String codePostal = '';
  String ville = '';
  double nombreDePartsFiscales = 0;
  int revenuFiscal = 0;

  final AideVeloParType _aideVeloParType;
  final AideVeloInformations _profil;

  @override
  Future<AideVeloInformations> recupererProfil() async => _profil;

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
