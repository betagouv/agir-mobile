import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationInjection extends StatelessWidget {
  const AuthenticationInjection({
    super.key,
    required this.authenticationService,
    required this.child,
  });

  final AuthenticationService authenticationService;
  final Widget child;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            AuthenticationBloc(authenticationService: authenticationService),
        child: child,
      );
}
