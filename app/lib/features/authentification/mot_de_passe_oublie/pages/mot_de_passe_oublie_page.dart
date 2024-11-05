import 'package:app/features/authentification/mot_de_passe_oublie/bloc/mot_de_passe_oublie_bloc.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MotDePasseOubliePage extends StatelessWidget {
  const MotDePasseOubliePage({super.key});

  static const name = 'mot-de-passe-oublie';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const MotDePasseOubliePage(),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            MotDePasseOublieBloc(authentificationPort: context.read()),
        child: const MotDePasseOublieView(),
      );
}
