import 'package:app/features/profil/domain/entities/profil.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';

class ProfilApiAdapter implements ProfilPort {
  const ProfilApiAdapter();

  @override
  Future<Profil> recupereProfil() {
    throw UnimplementedError();
  }
}
