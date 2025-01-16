import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class HomeDisclaimerState extends Equatable {
  const HomeDisclaimerState();

  @override
  List<Object> get props => [];
}

@immutable
final class HomeDisclaimerVisible extends HomeDisclaimerState {
  const HomeDisclaimerVisible();
}

@immutable
final class HomeDisclaimerNotVisible extends HomeDisclaimerState {
  const HomeDisclaimerNotVisible();
}
