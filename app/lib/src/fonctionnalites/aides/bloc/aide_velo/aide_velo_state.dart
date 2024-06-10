import 'package:app/src/fonctionnalites/aides/domain/aide_velo.dart';
import 'package:equatable/equatable.dart';

final class AideVeloState extends Equatable {
  const AideVeloState({
    required this.prix,
    required this.codePostal,
    required this.communes,
    required this.ville,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
    required this.aidesDisponibles,
  });

  const AideVeloState.empty()
      : this(
          prix: 1000,
          codePostal: '',
          communes: const [],
          ville: '',
          nombreDePartsFiscales: 1,
          revenuFiscal: 0,
          aidesDisponibles: const [],
        );

  final int prix;
  final String codePostal;
  final List<String> communes;
  final String ville;
  final double nombreDePartsFiscales;
  final int revenuFiscal;
  final List<AideDisponiblesViewModel> aidesDisponibles;

  AideVeloState copyWith({
    final int? prix,
    final String? codePostal,
    final List<String>? communes,
    final String? ville,
    final double? nombreDePartsFiscales,
    final int? revenuFiscal,
    final List<AideDisponiblesViewModel>? aidesDisponibles,
  }) =>
      AideVeloState(
        prix: prix ?? this.prix,
        codePostal: codePostal ?? this.codePostal,
        communes: communes ?? this.communes,
        ville: ville ?? this.ville,
        nombreDePartsFiscales:
            nombreDePartsFiscales ?? this.nombreDePartsFiscales,
        revenuFiscal: revenuFiscal ?? this.revenuFiscal,
        aidesDisponibles: aidesDisponibles ?? this.aidesDisponibles,
      );

  @override
  List<Object> get props => [
        prix,
        codePostal,
        communes,
        ville,
        nombreDePartsFiscales,
        revenuFiscal,
        aidesDisponibles,
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