import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class FranceConnectState extends Equatable {
  const FranceConnectState();

  @override
  List<Object> get props => [];
}

@immutable
final class FranceConnectInitial extends FranceConnectState {
  const FranceConnectInitial();
}

@immutable
final class FranceConnectLoadInProgress extends FranceConnectState {
  const FranceConnectLoadInProgress();
}

@immutable
final class FranceConnectLoadSuccess extends FranceConnectState {
  const FranceConnectLoadSuccess();
}

@immutable
final class FranceConnectLoadFailure extends FranceConnectState {
  const FranceConnectLoadFailure();
}
