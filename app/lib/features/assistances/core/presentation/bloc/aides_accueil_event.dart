import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AidesAccueilEvent extends Equatable {
  const AidesAccueilEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AidesAccueilRecuperationDemandee extends AidesAccueilEvent {
  const AidesAccueilRecuperationDemandee();
}
