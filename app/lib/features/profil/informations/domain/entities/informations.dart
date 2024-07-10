import 'package:equatable/equatable.dart';

class Informations extends Equatable {
  const Informations({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.codePostal,
    required this.commune,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  final String prenom;
  final String nom;
  final String email;
  final String? codePostal;
  final String? commune;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;

  @override
  List<Object?> get props => [
        prenom,
        nom,
        email,
        codePostal,
        commune,
        nombreDePartsFiscales,
        revenuFiscal,
      ];
}
