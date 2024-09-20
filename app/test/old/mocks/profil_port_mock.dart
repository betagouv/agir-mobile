import 'package:app/features/first_name/domain/ports/first_name_port.dart';
import 'package:app/features/first_name/domain/value_objects/first_name.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';
import 'package:fpdart/fpdart.dart';

class ProfilPortMock implements ProfilPort, FirstNamePort {
  ProfilPortMock({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.codePostal,
    required this.commune,
    required this.nombreAdultes,
    required this.nombreEnfants,
    required this.typeDeLogement,
    required this.estProprietaire,
    required this.superficie,
    required this.chauffage,
    required this.plusDe15Ans,
    required this.dpe,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  String? prenom;
  String? nom;
  String email;
  String? codePostal;
  String? commune;
  int? nombreAdultes;
  int? nombreEnfants;
  TypeDeLogement? typeDeLogement;
  bool? estProprietaire;
  Superficie? superficie;
  Chauffage? chauffage;
  bool? plusDe15Ans;
  Dpe? dpe;
  double nombreDePartsFiscales;
  int? revenuFiscal;
  bool supprimerLeCompteAppele = false;
  bool changerLeMotDePasseAppele = false;

  @override
  Future<Either<Exception, Informations>> recupererProfil() async => Right(
        Informations(
          prenom: prenom,
          nom: nom,
          email: email,
          codePostal: codePostal,
          commune: commune,
          nombreDePartsFiscales: nombreDePartsFiscales,
          revenuFiscal: revenuFiscal,
        ),
      );

  @override
  Future<Either<Exception, void>> mettreAJour({
    required final String? prenom,
    required final String? nom,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    this.prenom = prenom;
    this.nom = nom;
    this.nombreDePartsFiscales = nombreDePartsFiscales;
    this.revenuFiscal = revenuFiscal;

    return const Right(null);
  }

  @override
  Future<Either<Exception, Logement>> recupererLogement() async => Right(
        Logement(
          codePostal: codePostal,
          commune: commune,
          nombreAdultes: nombreAdultes,
          nombreEnfants: nombreEnfants,
          typeDeLogement: typeDeLogement,
          estProprietaire: estProprietaire,
          superficie: superficie,
          chauffage: chauffage,
          plusDe15Ans: plusDe15Ans,
          dpe: dpe,
        ),
      );

  @override
  Future<Either<Exception, void>> mettreAJourLogement({
    required final Logement logement,
  }) async {
    codePostal = logement.codePostal;
    commune = logement.commune;
    nombreAdultes = logement.nombreAdultes;
    nombreEnfants = logement.nombreEnfants;
    typeDeLogement = logement.typeDeLogement;
    estProprietaire = logement.estProprietaire;
    superficie = logement.superficie;
    chauffage = logement.chauffage;
    plusDe15Ans = logement.plusDe15Ans;
    dpe = logement.dpe;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> supprimerLeCompte() async {
    supprimerLeCompteAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> changerMotDePasse({
    required final String motDePasse,
  }) async {
    changerLeMotDePasseAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, Unit>> addFirstName(
    final FirstName firstName,
  ) async {
    prenom = firstName.value;

    return const Right(unit);
  }

  @override
  Future<Either<Exception, void>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) async {
    this.codePostal = codePostal;
    this.commune = commune;

    return const Right(null);
  }
}
