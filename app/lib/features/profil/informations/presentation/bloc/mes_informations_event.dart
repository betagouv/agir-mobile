import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class MesInformationsEvent extends Equatable {
  const MesInformationsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MesInformationsRecuperationDemandee extends MesInformationsEvent {
  const MesInformationsRecuperationDemandee();
}

@immutable
final class MesInformationsPrenomChange extends MesInformationsEvent {
  const MesInformationsPrenomChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MesInformationsNomChange extends MesInformationsEvent {
  const MesInformationsNomChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MesInformationsAnneeChange extends MesInformationsEvent {
  const MesInformationsAnneeChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MesInformationsNombreDePartsFiscalesChange extends MesInformationsEvent {
  const MesInformationsNombreDePartsFiscalesChange(this.valeur);

  final double valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MesInformationsRevenuFiscalChange extends MesInformationsEvent {
  const MesInformationsRevenuFiscalChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MesInformationsMiseAJourDemandee extends MesInformationsEvent {
  const MesInformationsMiseAJourDemandee();
}
