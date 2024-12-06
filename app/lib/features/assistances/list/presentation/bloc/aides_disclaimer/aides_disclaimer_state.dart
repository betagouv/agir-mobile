import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AidesDisclaimerState extends Equatable {
  const AidesDisclaimerState();

  @override
  List<Object> get props => [];
}

@immutable
final class AidesDisclaimerVisible extends AidesDisclaimerState {
  const AidesDisclaimerVisible();
}

@immutable
final class AidesDisclaimerNotVisible extends AidesDisclaimerState {
  const AidesDisclaimerNotVisible();
}
