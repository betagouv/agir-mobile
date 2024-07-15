import 'package:equatable/equatable.dart';

sealed class MieuxVousConnaitreEditEvent extends Equatable {
  const MieuxVousConnaitreEditEvent();

  @override
  List<Object?> get props => [];
}

class MieuxVousConnaitreEditRecuperationDemandee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class MieuxVousConnaitreEditReponsesChangee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditReponsesChangee(this.valeur);

  final List<String> valeur;

  @override
  List<Object?> get props => [valeur];
}

class MieuxVousConnaitreEditMisAJourDemandee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditMisAJourDemandee(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
