import 'package:equatable/equatable.dart';

sealed class SeConnecterEvent extends Equatable {
  const SeConnecterEvent();

  @override
  List<Object?> get props => [];
}

final class SeConnecterAdresseMailAChange extends SeConnecterEvent {
  const SeConnecterAdresseMailAChange(this.valeur);

  final String valeur;

  @override
  List<Object?> get props => [valeur];
}

final class SeConnecterMotDePasseAChange extends SeConnecterEvent {
  const SeConnecterMotDePasseAChange(this.valeur);

  final String valeur;

  @override
  List<Object?> get props => [valeur];
}

final class SeConnecterConnexionDemandee extends SeConnecterEvent {
  const SeConnecterConnexionDemandee();
}
