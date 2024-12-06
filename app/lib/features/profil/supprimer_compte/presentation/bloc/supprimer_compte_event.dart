import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class SupprimerCompteEvent extends Equatable {
  const SupprimerCompteEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class SupprimerCompteSuppressionDemandee extends SupprimerCompteEvent {
  const SupprimerCompteSuppressionDemandee();
}
