import 'package:equatable/equatable.dart';

class Informations extends Equatable {
  const Informations({
    required this.email,
    required this.prenom,
    required this.nom,
    required this.anneeDeNaissance,
    required this.codePostal,
    required this.commune,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  final String email;
  final String? prenom;
  final String? nom;
  final int? anneeDeNaissance;
  final String? codePostal;
  final String? commune;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;

  @override
  List<Object?> get props => [
        email,
        prenom,
        nom,
        anneeDeNaissance,
        codePostal,
        commune,
        nombreDePartsFiscales,
        revenuFiscal,
      ];
}
