import 'package:equatable/equatable.dart';

final class UtilisateurState extends Equatable {
  const UtilisateurState({
    required this.prenom,
    required this.estIntegrationTerminee,
  });

  final String? prenom;
  final bool estIntegrationTerminee;

  @override
  List<Object?> get props => [prenom, estIntegrationTerminee];
}
