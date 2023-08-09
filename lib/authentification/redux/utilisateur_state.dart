import 'package:equatable/equatable.dart';

class UtilisateurState extends Equatable {
  final String id;
  final String nom;

  const UtilisateurState(this.id, this.nom);

  @override
  List<Object?> get props => [id, nom];
}
