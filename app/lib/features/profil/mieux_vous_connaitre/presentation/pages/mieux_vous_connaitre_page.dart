import 'package:app/features/profil/mieux_vous_connaitre/presentation/blocs/mieux_vous_connaitre_bloc.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/blocs/mieux_vous_connaitre_event.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/blocs/mieux_vous_connaitre_state.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/widgets/mieux_vous_connaitre_view.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
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
        builder: (final context, final state) {
          context.read<MieuxVousConnaitreBloc>().add(
                const MieuxVousConnaitreRecuperationDemandee(),
              );

          return const MieuxVousConnaitrePage();
        },
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: BlocBuilder<MieuxVousConnaitreBloc, MieuxVousConnaitreState>(
          builder: (final context, final state) {
            switch (state.statut) {
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
