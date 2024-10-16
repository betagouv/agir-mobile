import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class MieuxVousConnaitreEditEvent extends Equatable {
  const MieuxVousConnaitreEditEvent();

  @override
  List<Object> get props => [];
}

final class MieuxVousConnaitreEditRecuperationDemandee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class MieuxVousConnaitreEditChoixMultipleChangee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditChoixMultipleChangee(this.value);

  final List<String> value;

  @override
  List<Object> get props => [value];
}

final class MieuxVousConnaitreEditChoixUniqueChangee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditChoixUniqueChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class MieuxVousConnaitreEditLibreChangee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditLibreChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class MieuxVousConnaitreEditMosaicChangee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditMosaicChangee(this.value);

  final List<MosaicResponse> value;

  @override
  List<Object> get props => [value];
}

final class MieuxVousConnaitreEditEntierChangee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditEntierChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class MieuxVousConnaitreEditMisAJourDemandee
    extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditMisAJourDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
