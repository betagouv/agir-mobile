import 'package:equatable/equatable.dart';

sealed class HomeDisclaimerState extends Equatable {
  const HomeDisclaimerState();

  @override
  List<Object> get props => [];
}

final class HomeDisclaimerVisible extends HomeDisclaimerState {
  const HomeDisclaimerVisible();
}

final class HomeDisclaimerNotVisible extends HomeDisclaimerState {
  const HomeDisclaimerNotVisible();
}
