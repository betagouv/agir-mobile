import 'package:equatable/equatable.dart';

class Utilisateur extends Equatable {
  const Utilisateur({required this.prenom});

  final String prenom;

  @override
  List<Object?> get props => [prenom];
}
