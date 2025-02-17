import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class AidsDisclaimerState extends Equatable {
  const AidsDisclaimerState();

  @override
  List<Object> get props => [];
}

@immutable
final class AidsDisclaimerVisible extends AidsDisclaimerState {
  const AidsDisclaimerVisible();
}

@immutable
final class AidsDisclaimerNotVisible extends AidsDisclaimerState {
  const AidsDisclaimerNotVisible();
}
