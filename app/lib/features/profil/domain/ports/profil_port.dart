import 'package:app/features/profil/domain/entities/profil.dart';

abstract interface class ProfilPort {
  Future<Profil> recupereProfil();
}
