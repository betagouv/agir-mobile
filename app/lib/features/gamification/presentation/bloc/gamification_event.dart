import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class GamificationEvent extends Equatable {
  const GamificationEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class GamificationAuthentificationAChange extends GamificationEvent {
  const GamificationAuthentificationAChange(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

@immutable
final class GamificationAbonnementDemande extends GamificationEvent {
  const GamificationAbonnementDemande();
}
