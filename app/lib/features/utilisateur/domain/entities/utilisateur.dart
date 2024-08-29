import 'package:equatable/equatable.dart';

class Utilisateur extends Equatable {
  const Utilisateur({
    required this.prenom,
    required this.estIntegrationTerminee,
  });

  final String prenom;
  final bool estIntegrationTerminee;

  @override
  List<Object?> get props => [prenom, estIntegrationTerminee];
}
