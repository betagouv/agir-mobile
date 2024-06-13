import 'package:equatable/equatable.dart';

sealed class AidesEvent extends Equatable {
  const AidesEvent();

  @override
  List<Object> get props => [];
}

final class AidesRecuperationDemandee extends AidesEvent {
  const AidesRecuperationDemandee();
}
