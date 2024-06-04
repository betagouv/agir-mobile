import 'package:app/src/fonctionnalites/profil/domain/ports/profil_repository.dart';
import 'package:app/src/fonctionnalites/profil/domain/profil.dart';

class ProfilRepositoryMock implements ProfilRepository {
  ProfilRepositoryMock({
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
