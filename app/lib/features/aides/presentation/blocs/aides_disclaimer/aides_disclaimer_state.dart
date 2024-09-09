import 'package:equatable/equatable.dart';

sealed class AidesDisclaimerState extends Equatable {
  const AidesDisclaimerState();

  @override
  List<Object> get props => [];
}

final class AidesDisclaimerVisible extends AidesDisclaimerState {
  const AidesDisclaimerVisible();
}

final class AidesDisclaimerNotVisible extends AidesDisclaimerState {
  const AidesDisclaimerNotVisible();
}
