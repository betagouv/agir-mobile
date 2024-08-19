import 'package:app/features/authentification/presentation/blocs/se_connecter_bloc.dart';
import 'package:app/features/authentification/presentation/pages/se_connecter_view.dart';
import 'package:dsfr/dsfr.dart';
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
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s2w,
              right: DsfrSpacings.s2w,
              bottom: DsfrSpacings.s2w,
            ),
            child: BlocProvider(
              create: (final context) =>
                  SeConnecterBloc(authentificationPort: context.read()),
              child: const SeConnecterView(),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
}
