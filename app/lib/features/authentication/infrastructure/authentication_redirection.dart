// ignore_for_file: use_build_context_synchronously

import 'package:app/features/accueil/presentation/pages/home_page.dart';
import 'package:app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthenticationRedirection extends StatelessWidget {
  const AuthenticationRedirection({super.key, required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) =>
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (final context, final state) => switch (state) {
          AuthenticationUnauthenticated() =>
            GoRouter.of(context).goNamed(PreOnboardingPage.name),
          AuthenticationAuthenticated() =>
            GoRouter.of(context).goNamed(HomePage.name),
          AuthenticationInitial() => null,
        },
        bloc: context.read(),
        child: child,
      );
}
