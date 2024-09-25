import 'package:equatable/equatable.dart';

sealed class MesInformationsEvent extends Equatable {
  const MesInformationsEvent();

  @override
  List<Object> get props => [];
}

final class MesInformationsRecuperationDemandee extends MesInformationsEvent {
  const MesInformationsRecuperationDemandee();
}

final class MesInformationsPrenomChange extends MesInformationsEvent {
  const MesInformationsPrenomChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MesInformationsNomChange extends MesInformationsEvent {
  const MesInformationsNomChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MesInformationsAnneeChange extends MesInformationsEvent {
  const MesInformationsAnneeChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

final class MesInformationsNombreDePartsFiscalesChange
    extends MesInformationsEvent {
  const MesInformationsNombreDePartsFiscalesChange(this.valeur);

  final double valeur;

  @override
  List<Object> get props => [valeur];
}

final class MesInformationsRevenuFiscalChange extends MesInformationsEvent {
  const MesInformationsRevenuFiscalChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

final class MesInformationsMiseAJourDemandee extends MesInformationsEvent {
  const MesInformationsMiseAJourDemandee();
}
