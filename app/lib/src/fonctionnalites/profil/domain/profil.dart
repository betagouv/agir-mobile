import 'package:equatable/equatable.dart';

class Profil extends Equatable {
  const Profil({
    required this.prenom,
    required this.nom,
    required this.adresseElectronique,
  });

  final String prenom;
  final String nom;
  final String adresseElectronique;

  @override
  List<Object?> get props => [prenom, nom, adresseElectronique];
}
