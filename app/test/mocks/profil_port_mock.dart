import 'package:app/features/profil/domain/entities/profil.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';

class ProfilPortMock implements ProfilPort {
  ProfilPortMock({
    required this.prenom,
    required this.nom,
    required this.adresseElectronique,
  });

  String prenom;
  String nom;
  String adresseElectronique;

  @override
  Future<Profil> recupereProfil() async => Profil(
        prenom: prenom,
        nom: nom,
        adresseElectronique: adresseElectronique,
      );
}
