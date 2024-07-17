import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:equatable/equatable.dart';

sealed class GamificationEvent extends Equatable {
  const GamificationEvent();

  @override
  List<Object> get props => [];
}

final class GamificationAuthentificationAChange extends GamificationEvent {
  const GamificationAuthentificationAChange(this.statut);

  final AuthentificationStatut statut;

  @override
  List<Object> get props => [statut];
}

final class GamificationAbonnementDemande extends GamificationEvent {
  const GamificationAbonnementDemande();
}
