import 'package:app/src/fonctionnalites/aides/domain/aide_velo_collectivite.dart';
import 'package:equatable/equatable.dart';

class AideVelo extends Equatable {
  const AideVelo({
    required this.libelle,
    required this.description,
    required this.lien,
    required this.collectivite,
    required this.montant,
    required this.plafond,
    required this.logo,
  });

  final String libelle;
  final String description;
  final String lien;
  final AideVeloCollectivite collectivite;
  final int montant;
  final int plafond;
  final String logo;

  @override
  List<Object?> get props => [
        libelle,
        description,
        lien,
        collectivite,
        montant,
        plafond,
        logo,
      ];
}
