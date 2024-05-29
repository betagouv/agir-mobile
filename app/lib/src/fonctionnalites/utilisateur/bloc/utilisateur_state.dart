import 'package:equatable/equatable.dart';

final class UtilisateurState extends Equatable {
  const UtilisateurState({required this.prenom});

  final String prenom;

  @override
  List<Object> get props => [prenom];
}
