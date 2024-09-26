import 'package:app/features/authentication/domain/user_id.dart';
import 'package:equatable/equatable.dart';

sealed class AuthenticationStatus extends Equatable {
  const AuthenticationStatus();

  const factory AuthenticationStatus.authenticated(final UserId userId) =
      Authenticated;

  const factory AuthenticationStatus.unauthenticated() = Unauthenticated;

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthenticationStatus {
  const Authenticated(this.userId);

  final UserId userId;

  @override
  List<Object> get props => [userId];
}

final class Unauthenticated extends AuthenticationStatus {
  const Unauthenticated();
}
