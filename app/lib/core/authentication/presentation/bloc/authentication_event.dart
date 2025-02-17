import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
