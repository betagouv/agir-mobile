import 'package:app/features/simulateur_velo/domain/aide_velo.dart';
import 'package:equatable/equatable.dart';

class AideVeloParType extends Equatable {
  const AideVeloParType({
    required this.mecaniqueSimple,
    required this.electrique,
    required this.cargo,
    required this.cargoElectrique,
    required this.pliant,
    required this.pliantElectrique,
    required this.motorisation,
    required this.adapte,
  });

  final List<AideVelo> mecaniqueSimple;
  final List<AideVelo> electrique;
  final List<AideVelo> cargo;
  final List<AideVelo> cargoElectrique;
  final List<AideVelo> pliant;
  final List<AideVelo> pliantElectrique;
  final List<AideVelo> motorisation;
  final List<AideVelo> adapte;

  @override
  List<Object?> get props => [
        mecaniqueSimple,
        electrique,
        cargo,
        cargoElectrique,
        pliant,
        pliantElectrique,
        motorisation,
        adapte,
      ];
}
