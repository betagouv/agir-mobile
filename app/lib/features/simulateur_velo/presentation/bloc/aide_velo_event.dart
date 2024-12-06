import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AideVeloEvent extends Equatable {
  const AideVeloEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AideVeloInformationsDemandee extends AideVeloEvent {
  const AideVeloInformationsDemandee();
}

@immutable
final class AideVeloPrixChange extends AideVeloEvent {
  const AideVeloPrixChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class AideVeloModificationDemandee extends AideVeloEvent {
  const AideVeloModificationDemandee();
}

@immutable
final class AideVeloCodePostalChange extends AideVeloEvent {
  const AideVeloCodePostalChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class AideVeloCommuneChange extends AideVeloEvent {
  const AideVeloCommuneChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class AideVeloNombreDePartsFiscalesChange extends AideVeloEvent {
  const AideVeloNombreDePartsFiscalesChange(this.valeur);

  final double valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class AideVeloRevenuFiscalChange extends AideVeloEvent {
  const AideVeloRevenuFiscalChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class AideVeloEstimationDemandee extends AideVeloEvent {
  const AideVeloEstimationDemandee();
}
