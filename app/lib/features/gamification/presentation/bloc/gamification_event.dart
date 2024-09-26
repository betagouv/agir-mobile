import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:equatable/equatable.dart';

sealed class GamificationEvent extends Equatable {
  const GamificationEvent();

  @override
  List<Object> get props => [];
}

final class GamificationAuthentificationAChange extends GamificationEvent {
  const GamificationAuthentificationAChange(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

final class GamificationAbonnementDemande extends GamificationEvent {
  const GamificationAbonnementDemande();
}
