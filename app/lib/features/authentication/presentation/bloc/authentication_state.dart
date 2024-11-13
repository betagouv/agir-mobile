import 'package:equatable/equatable.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated();
}

final class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated();
}
