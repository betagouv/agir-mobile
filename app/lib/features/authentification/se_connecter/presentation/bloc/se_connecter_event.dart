import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class SeConnecterEvent extends Equatable {
  const SeConnecterEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class SeConnecterAdresseMailAChange extends SeConnecterEvent {
  const SeConnecterAdresseMailAChange(this.valeur);

  final String valeur;

  @override
  List<Object?> get props => [valeur];
}

@immutable
final class SeConnecterMotDePasseAChange extends SeConnecterEvent {
  const SeConnecterMotDePasseAChange(this.valeur);

  final String valeur;

  @override
  List<Object?> get props => [valeur];
}

@immutable
final class SeConnecterConnexionDemandee extends SeConnecterEvent {
  const SeConnecterConnexionDemandee();
}
