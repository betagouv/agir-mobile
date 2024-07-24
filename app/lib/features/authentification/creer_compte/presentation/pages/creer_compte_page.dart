import 'package:app/features/authentification/creer_compte/presentation/blocs/creer_compte_bloc.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_view.dart';
import 'package:dsfr/dsfr.dart';
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
                  CreerCompteBloc(authentificationPort: context.read()),
              child: const CreerCompteView(),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
}
