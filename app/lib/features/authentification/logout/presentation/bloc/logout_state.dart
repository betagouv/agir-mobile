import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object?> get props => [];
}

@immutable
final class LogoutInitial extends LogoutState {
  const LogoutInitial();
}

@immutable
final class LogoutLoadInProgress extends LogoutState {
  const LogoutLoadInProgress();
}

@immutable
final class LogoutLoadSuccess extends LogoutState {
  const LogoutLoadSuccess({this.callbackUrl});

  final String? callbackUrl;

  @override
  List<Object?> get props => [callbackUrl];
}
