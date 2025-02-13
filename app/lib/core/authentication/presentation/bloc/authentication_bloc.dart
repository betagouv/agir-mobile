import 'dart:async';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/presentation/bloc/authentication_event.dart';
import 'package:app/core/authentication/presentation/bloc/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required final AuthenticationService authenticationService,
  }) : super(const AuthenticationInitial()) {
    _subscription = authenticationService.authenticationStatus.listen((
      final status,
    ) {
      add(const AuthenticationCheckRequested());
    });
    on<AuthenticationCheckRequested>((final event, final emit) {
      final status = authenticationService.status;
      emit(
        status == const Unauthenticated()
            ? const AuthenticationUnauthenticated()
            : const AuthenticationAuthenticated(),
      );
    });
  }

  late final StreamSubscription<AuthenticationStatus> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();

    return super.close();
  }
}
