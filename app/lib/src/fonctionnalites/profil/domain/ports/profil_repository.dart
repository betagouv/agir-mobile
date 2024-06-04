import 'package:app/src/fonctionnalites/profil/domain/profil.dart';

abstract interface class ProfilRepository {
  Future<Profil> recupereProfil();
}
