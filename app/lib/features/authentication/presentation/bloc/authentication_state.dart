import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

@immutable
final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

@immutable
final class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated();
}

@immutable
final class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated();
}
