import 'package:equatable/equatable.dart';

class AideVelo extends Equatable {
  const AideVelo({
    required this.libelle,
    required this.description,
    required this.lien,
    required this.montant,
    required this.logo,
  });

  final String libelle;
  final String description;
  final String lien;
  final int montant;
  final String logo;

  @override
  List<Object?> get props => [libelle, description, lien, montant, logo];
}
