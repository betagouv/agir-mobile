import 'package:equatable/equatable.dart';

class Utilisateur extends Equatable {
  const Utilisateur({
    required this.prenom,
    required this.fonctionnalitesDebloquees,
    required this.estIntegrationTerminee,
  });

  final String prenom;
  final List<Fonctionnalites> fonctionnalitesDebloquees;
  final bool estIntegrationTerminee;

  @override
  List<Object?> get props =>
      [prenom, fonctionnalitesDebloquees, estIntegrationTerminee];
}

enum Fonctionnalites {
  aides,
  bibliotheque,
  recommandations,
  univers,
}
