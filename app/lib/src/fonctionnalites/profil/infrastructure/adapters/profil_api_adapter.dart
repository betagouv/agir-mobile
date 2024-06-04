import 'package:app/src/fonctionnalites/profil/domain/ports/profil_repository.dart';
import 'package:app/src/fonctionnalites/profil/domain/profil.dart';

class ProfilApiAdapter implements ProfilRepository {
  const ProfilApiAdapter();

  @override
  Future<Profil> recupereProfil() {
    throw UnimplementedError();
  }
}
