import 'package:equatable/equatable.dart';

sealed class AidesAccueilEvent extends Equatable {
  const AidesAccueilEvent();

  @override
  List<Object> get props => [];
}

final class AidesAccueilRecuperationDemandee extends AidesAccueilEvent {
  const AidesAccueilRecuperationDemandee();
}
