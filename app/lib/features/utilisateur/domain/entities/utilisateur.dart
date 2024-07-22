import 'package:equatable/equatable.dart';

class Utilisateur extends Equatable {
  const Utilisateur({
    required this.prenom,
    required this.fonctionnalitesDebloquees,
  });

  final String prenom;
  final List<Fonctionnalites> fonctionnalitesDebloquees;

  @override
  List<Object?> get props => [prenom, fonctionnalitesDebloquees];
}

enum Fonctionnalites {
  aides,
  bibliotheque,
  recommandations,
  univers,
}
