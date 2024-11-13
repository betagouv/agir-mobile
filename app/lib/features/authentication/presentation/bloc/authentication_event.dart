import 'package:equatable/equatable.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationCheckRequested extends AuthenticationEvent {
  const AuthenticationCheckRequested();
}
