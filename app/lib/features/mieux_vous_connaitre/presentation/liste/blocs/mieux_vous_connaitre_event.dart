import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class MieuxVousConnaitreEvent extends Equatable {
  const MieuxVousConnaitreEvent();

  @override
  List<Object?> get props => [];
}

class MieuxVousConnaitreRecuperationDemandee extends MieuxVousConnaitreEvent {
  const MieuxVousConnaitreRecuperationDemandee();
}

class MieuxVousConnaitreThematiqueSelectionnee extends MieuxVousConnaitreEvent {
  const MieuxVousConnaitreThematiqueSelectionnee(this.valeur);

  final Thematique? valeur;

  @override
  List<Object?> get props => [valeur];
}
