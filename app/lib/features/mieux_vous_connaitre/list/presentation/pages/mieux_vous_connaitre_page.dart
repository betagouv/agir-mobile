import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_event.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_state.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/widgets/mieux_vous_connaitre_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MieuxVousConnaitrePage extends StatelessWidget {
  const MieuxVousConnaitrePage({super.key});

  static const name = 'mieux-vous-connaitre';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const MieuxVousConnaitrePage(),
      );

  @override
  Widget build(final BuildContext context) {
    context.read<MieuxVousConnaitreBloc>().add(
          const MieuxVousConnaitreRecuperationDemandee(),
        );

    return Scaffold(
      appBar: const FnvAppBar(),
      body: BlocSelector<MieuxVousConnaitreBloc, MieuxVousConnaitreState,
          MieuxVousConnaitreStatut>(
        selector: (final state) => state.statut,
        builder: (final context, final state) {
          switch (state) {
            case MieuxVousConnaitreStatut.initial:
            case MieuxVousConnaitreStatut.chargement:
              return const Center(child: CircularProgressIndicator());
            case MieuxVousConnaitreStatut.succes:
              return const MieuxVousConnaitreView();
          }
        },
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}
