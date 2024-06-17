import 'package:app/features/profil/mes_informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/mes_informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/features/profil/mes_informations/presentation/blocs/mes_informations_state.dart';
import 'package:app/features/profil/mes_informations/presentation/widgets/mes_informations_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MesInformationsPage extends StatelessWidget {
  const MesInformationsPage({super.key});

  static const name = 'mes-informations';
  static const path = '/$name';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => BlocProvider(
          create: (final context) =>
              MesInformationsBloc(profilPort: context.read())
                ..add(const MesInformationsRecuperationDemandee()),
          child: const MesInformationsPage(),
        ),
      );

  void _handleMettreAJour(final BuildContext context) {
    context
        .read<MesInformationsBloc>()
        .add(const MesInformationsMiseAJourDemandee());
    GoRouter.of(context).pop();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: SafeArea(
          child: BlocBuilder<MesInformationsBloc, MesInformationsState>(
            builder: (final context, final state) {
              switch (state.statut) {
                case MesInformationsStatut.initial:
                case MesInformationsStatut.chargement:
                  return const Center(child: CircularProgressIndicator());

                case MesInformationsStatut.succes:
                  return const MesInformationsForm();
              }
            },
          ),
        ),
        bottomNavigationBar: FnvBottomBar(
          child: DsfrButton.lg(
            label: Localisation.mettreAJourVosInformations,
            onTap: () => _handleMettreAJour(context),
          ),
        ),
      );
}
