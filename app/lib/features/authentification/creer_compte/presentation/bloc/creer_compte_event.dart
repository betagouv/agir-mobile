import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CreerCompteEvent extends Equatable {
  const CreerCompteEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class CreerCompteAdresseMailAChangee extends CreerCompteEvent {
  const CreerCompteAdresseMailAChangee(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class CreerCompteMotDePasseAChange extends CreerCompteEvent {
  const CreerCompteMotDePasseAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class CreerCompteCguAChange extends CreerCompteEvent {
  const CreerCompteCguAChange(this.valeur);

  final bool valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class CreerCompteCreationDemandee extends CreerCompteEvent {
  const CreerCompteCreationDemandee();
}
