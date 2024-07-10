import 'package:equatable/equatable.dart';

final class UtilisateurState extends Equatable {
  const UtilisateurState({
    required this.prenom,
    required this.aLesAides,
    required this.aLesRecommandations,
  });

  final String prenom;
  final bool aLesAides;
  final bool aLesRecommandations;

  @override
  List<Object> get props => [prenom, aLesAides, aLesRecommandations];
}
