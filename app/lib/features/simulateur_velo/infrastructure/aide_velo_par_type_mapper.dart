import 'package:app/features/simulateur_velo/domain/aide_velo.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo_par_type.dart';

abstract final class AideVeloParTypeMapper {
  static AideVeloParType fromJson(final Map<String, dynamic> json) =>
      AideVeloParType(
        mecaniqueSimple:
            _mapAideVeloList(json['mécanique simple'] as List<dynamic>),
        electrique: _mapAideVeloList(json['électrique'] as List<dynamic>),
        cargo: _mapAideVeloList(json['cargo'] as List<dynamic>),
        cargoElectrique:
            _mapAideVeloList(json['cargo électrique'] as List<dynamic>),
        pliant: _mapAideVeloList(json['pliant'] as List<dynamic>),
        motorisation: _mapAideVeloList(json['motorisation'] as List<dynamic>),
      );

  static List<AideVelo> _mapAideVeloList(final List<dynamic> jsonList) =>
      jsonList
          .map((final e) => e as Map<String, dynamic>)
          .map(AideVeloMapper.fromJson)
          .toList();
}

abstract final class AideVeloMapper {
  static AideVelo fromJson(final Map<String, dynamic> json) => AideVelo(
        libelle: json['libelle'] as String,
        description: json['description'] as String,
        lien: json['lien'] as String,
        montant: (json['montant'] as num).toInt(),
        plafond: (json['plafond'] as num).toInt(),
        logo: json['logo'] as String,
      );
}
