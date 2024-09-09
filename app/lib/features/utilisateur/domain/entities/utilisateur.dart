import 'package:equatable/equatable.dart';

class Utilisateur extends Equatable {
  const Utilisateur({
    required this.prenom,
    required this.estIntegrationTerminee,
    required this.aMaVilleCouverte,
  });

  final String prenom;
  final bool estIntegrationTerminee;
  final bool aMaVilleCouverte;

  @override
  List<Object?> get props => [prenom, estIntegrationTerminee, aMaVilleCouverte];
}
