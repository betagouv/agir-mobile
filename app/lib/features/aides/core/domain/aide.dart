import 'package:equatable/equatable.dart';

class Aide extends Equatable {
  const Aide({
    required this.titre,
    required this.thematique,
    required this.contenu,
    this.montantMax,
    this.urlSimulateur,
  });

  final String titre;
  final String thematique;
  final String contenu;
  final int? montantMax;
  final String? urlSimulateur;
  bool get aUnSimulateur => urlSimulateur != null && urlSimulateur!.isNotEmpty;
  bool get estSimulateurVelo => urlSimulateur == '/aides/velo';

  @override
  List<Object?> get props => [
        titre,
        thematique,
        contenu,
        montantMax,
        urlSimulateur,
      ];
}
