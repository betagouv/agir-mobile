import 'package:app/src/fonctionnalites/aides/domain/aide_velo.dart';
import 'package:equatable/equatable.dart';

class AideVeloParType extends Equatable {
  const AideVeloParType({
    required this.mecaniqueSimple,
    required this.electrique,
    required this.cargo,
    required this.cargoElectrique,
    required this.pliant,
    required this.motorisation,
  });

  final List<AideVelo> mecaniqueSimple;
  final List<AideVelo> electrique;
  final List<AideVelo> cargo;
  final List<AideVelo> cargoElectrique;
  final List<AideVelo> pliant;
  final List<AideVelo> motorisation;

  @override
  List<Object?> get props => [
        mecaniqueSimple,
        electrique,
        cargo,
        cargoElectrique,
        pliant,
        motorisation,
      ];
}
