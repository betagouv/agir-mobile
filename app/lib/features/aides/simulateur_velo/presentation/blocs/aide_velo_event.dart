import 'package:equatable/equatable.dart';

sealed class AideVeloEvent extends Equatable {
  const AideVeloEvent();

  @override
  List<Object> get props => [];
}

final class AideVeloInformationsDemandee extends AideVeloEvent {
  const AideVeloInformationsDemandee();
}

final class AideVeloPrixChange extends AideVeloEvent {
  const AideVeloPrixChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

final class AideVeloModificationDemandee extends AideVeloEvent {
  const AideVeloModificationDemandee();
}

final class AideVeloCodePostalChange extends AideVeloEvent {
  const AideVeloCodePostalChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class AideVeloCommuneChange extends AideVeloEvent {
  const AideVeloCommuneChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class AideVeloNombreDePartsFiscalesChange extends AideVeloEvent {
  const AideVeloNombreDePartsFiscalesChange(this.valeur);

  final double valeur;

  @override
  List<Object> get props => [valeur];
}

final class AideVeloRevenuFiscalChange extends AideVeloEvent {
  const AideVeloRevenuFiscalChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

final class AideVeloEstimationDemandee extends AideVeloEvent {
  const AideVeloEstimationDemandee();
}
