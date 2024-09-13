import 'package:equatable/equatable.dart';

class Partenaire extends Equatable {
  const Partenaire({required this.nom, required this.logo});

  final String nom;
  final String logo;

  @override
  List<Object?> get props => [nom, logo];
}
