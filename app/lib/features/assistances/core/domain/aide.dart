import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class AssistanceList extends Equatable {
  const AssistanceList({required this.isCovered, required this.assistances});

  final bool isCovered;
  final List<Assistance> assistances;

  @override
  List<Object?> get props => [isCovered, assistances];
}

class Assistance extends Equatable {
  const Assistance({
    required this.titre,
    required this.themeType,
    required this.contenu,
    this.montantMax,
    this.urlSimulateur,
  });

  final String titre;
  final ThemeType themeType;
  final String contenu;
  final int? montantMax;
  final String? urlSimulateur;
  bool get aUnSimulateur => urlSimulateur != null && urlSimulateur!.isNotEmpty;
  bool get estSimulateurVelo => urlSimulateur == '/aides/velo';

  @override
  List<Object?> get props => [
        titre,
        themeType,
        contenu,
        montantMax,
        urlSimulateur,
      ];
}
