import 'package:equatable/equatable.dart';

class Aide extends Equatable {
  const Aide({
    required this.titre,
    required this.thematique,
    required this.contenu,
    this.montantMax,
  });

  final String titre;
  final String thematique;
  final String contenu;
  final int? montantMax;

  @override
  List<Object?> get props => [
        titre,
        thematique,
        contenu,
        montantMax,
      ];
}
