import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AuthenticationCheckRequested extends AuthenticationEvent {
  const AuthenticationCheckRequested();
}
