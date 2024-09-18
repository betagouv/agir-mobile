import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo.dart';
import 'package:equatable/equatable.dart';

enum AideVeloStatut { initial, chargement, succes, erreur }

final class AideVeloState extends Equatable {
  const AideVeloState({
    required this.prix,
    required this.codePostal,
    required this.communes,
    required this.commune,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
    required this.aidesDisponibles,
    required this.veutModifierLesInformations,
    required this.aideVeloStatut,
  });

  const AideVeloState.empty()
      : this(
          prix: 1000,
          codePostal: '',
          communes: const [],
          commune: '',
          nombreDePartsFiscales: 1,
          revenuFiscal: null,
          aidesDisponibles: const [],
          veutModifierLesInformations: false,
          aideVeloStatut: AideVeloStatut.initial,
        );

  final int prix;
  final bool veutModifierLesInformations;
  final String codePostal;
  final List<String> communes;
  final String commune;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;
  final AideVeloStatut aideVeloStatut;

  bool get prixEstValide => prix > 0;
  bool get codePostalEstValide =>
      codePostal.isNotEmpty && codePostal.length == 5;
  bool get communeEstValide => commune.isNotEmpty;
  bool get nombreDePartsFiscalesEstValide => nombreDePartsFiscales > 0;
  bool get revenuFiscalEstValide => revenuFiscal != null && revenuFiscal! >= 0;
  bool get estValide =>
      prixEstValide &&
      codePostalEstValide &&
      communeEstValide &&
      nombreDePartsFiscalesEstValide &&
      revenuFiscalEstValide;

  final List<AideDisponiblesViewModel> aidesDisponibles;

  AideVeloState copyWith({
    final int? prix,
    final bool? veutModifierLesInformations,
    final String? codePostal,
    final List<String>? communes,
    final String? commune,
    final double? nombreDePartsFiscales,
    final int? revenuFiscal,
    final List<AideDisponiblesViewModel>? aidesDisponibles,
    final AideVeloStatut? aideVeloStatut,
  }) =>
      AideVeloState(
        prix: prix ?? this.prix,
        codePostal: codePostal ?? this.codePostal,
        communes: communes ?? this.communes,
        commune: commune ?? this.commune,
        nombreDePartsFiscales:
            nombreDePartsFiscales ?? this.nombreDePartsFiscales,
        revenuFiscal: revenuFiscal ?? this.revenuFiscal,
        aidesDisponibles: aidesDisponibles ?? this.aidesDisponibles,
        veutModifierLesInformations:
            veutModifierLesInformations ?? this.veutModifierLesInformations,
        aideVeloStatut: aideVeloStatut ?? this.aideVeloStatut,
      );

  @override
  List<Object?> get props => [
        prix,
        codePostal,
        communes,
        commune,
        nombreDePartsFiscales,
        revenuFiscal,
        aidesDisponibles,
        veutModifierLesInformations,
        aideVeloStatut,
      ];
}

class AideDisponiblesViewModel extends Equatable {
  const AideDisponiblesViewModel({
    required this.titre,
    required this.montantTotal,
    required this.aides,
  });

  final String titre;
  final int? montantTotal;
  final List<AideVelo> aides;

  @override
  List<Object?> get props => [titre, montantTotal, aides];
}
