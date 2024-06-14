import 'package:app/features/profil/domain/entities/mes_informations.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';

class ProfilPortMock implements ProfilPort {
  ProfilPortMock({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.codePostal,
    required this.ville,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  String prenom;
  String nom;
  String email;
  String codePostal;
  String ville;
  double nombreDePartsFiscales;
  int? revenuFiscal;

  @override
  Future<MesInformations> recupererProfil() async => MesInformations(
        prenom: prenom,
        nom: nom,
        email: email,
        codePostal: codePostal,
        ville: ville,
        nombreDePartsFiscales: nombreDePartsFiscales,
        revenuFiscal: revenuFiscal,
      );

  @override
  Future<void> mettreAJour({
    required final String prenom,
    required final String nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    this.prenom = prenom;
    this.nom = nom;
    this.email = email;
    this.nombreDePartsFiscales = nombreDePartsFiscales;
    this.revenuFiscal = revenuFiscal;
  }
}
