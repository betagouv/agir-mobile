import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_bloc.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreerComptePage extends StatelessWidget {
  const CreerComptePage({super.key});

  static const name = 'creer-compte';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const CreerComptePage(),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            CreerCompteBloc(authentificationRepository: context.read()),
        child: const CreerCompteView(),
      );
}
