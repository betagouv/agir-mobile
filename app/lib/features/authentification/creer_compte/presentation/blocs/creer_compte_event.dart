import 'package:equatable/equatable.dart';

sealed class CreerCompteEvent extends Equatable {
  const CreerCompteEvent();

  @override
  List<Object> get props => [];
}

final class CreerCompteAdresseMailAChangee extends CreerCompteEvent {
  const CreerCompteAdresseMailAChangee(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class CreerCompteMotDePasseAChange extends CreerCompteEvent {
  const CreerCompteMotDePasseAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class CreerCompteCreationDemandee extends CreerCompteEvent {
  const CreerCompteCreationDemandee();
}
