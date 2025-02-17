import 'package:app/features/know_your_customer/core/domain/response_mosaic.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MieuxVousConnaitreEditEvent extends Equatable {
  const MieuxVousConnaitreEditEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MieuxVousConnaitreEditRecuperationDemandee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

@immutable
final class MieuxVousConnaitreEditChoixMultipleChangee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditChoixMultipleChangee(this.value);

  final List<String> value;

  @override
  List<Object> get props => [value];
}

@immutable
final class MieuxVousConnaitreEditChoixUniqueChangee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditChoixUniqueChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class MieuxVousConnaitreEditLibreChangee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditLibreChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class MieuxVousConnaitreEditMosaicChangee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditMosaicChangee(this.value);

  final List<ResponseMosaic> value;

  @override
  List<Object> get props => [value];
}

@immutable
final class MieuxVousConnaitreEditEntierChangee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditEntierChangee(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class MieuxVousConnaitreEditMisAJourDemandee extends MieuxVousConnaitreEditEvent {
  const MieuxVousConnaitreEditMisAJourDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
