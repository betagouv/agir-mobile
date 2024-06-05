import 'package:equatable/equatable.dart';

final class UtilisateurState extends Equatable {
  const UtilisateurState({required this.prenom, required this.aLesAides});

  final String prenom;
  final bool aLesAides;

  @override
  List<Object> get props => [prenom, aLesAides];
}
