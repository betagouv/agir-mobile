import 'package:equatable/equatable.dart';

sealed class SupprimerCompteEvent extends Equatable {
  const SupprimerCompteEvent();

  @override
  List<Object> get props => [];
}

final class SupprimerCompteSuppressionDemandee extends SupprimerCompteEvent {
  const SupprimerCompteSuppressionDemandee();
}
