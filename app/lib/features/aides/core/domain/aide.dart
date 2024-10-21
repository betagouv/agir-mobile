import 'package:equatable/equatable.dart';

class Aids extends Equatable {
  const Aids({required this.isCovered, required this.aids});

  final bool isCovered;
  final List<Aid> aids;

  @override
  List<Object?> get props => [isCovered, aids];
}

class Aid extends Equatable {
  const Aid({
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
