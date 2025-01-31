import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_bloc.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SeConnecterPage extends StatelessWidget {
  const SeConnecterPage({super.key});

  static const name = 'se-connecter';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const SeConnecterPage(),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            SeConnecterBloc(authentificationRepository: context.read()),
        child: const SeConnecterView(),
      );
}
