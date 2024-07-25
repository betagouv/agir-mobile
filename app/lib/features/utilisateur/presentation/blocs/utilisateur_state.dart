import 'package:equatable/equatable.dart';

final class UtilisateurState extends Equatable {
  const UtilisateurState({
    required this.prenom,
    required this.aLesAides,
    required this.aLaBibliotheque,
    required this.aLesRecommandations,
    required this.aLesUnivers,
  });

  final String? prenom;
  final bool aLesAides;
  final bool aLaBibliotheque;
  final bool aLesRecommandations;
  final bool aLesUnivers;

  @override
  List<Object?> get props =>
      [prenom, aLesAides, aLaBibliotheque, aLesRecommandations, aLesUnivers];
}
