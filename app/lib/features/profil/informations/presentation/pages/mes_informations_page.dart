import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_state.dart';
import 'package:app/features/profil/informations/presentation/widgets/mes_informations_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MesInformationsPage extends StatelessWidget {
  const MesInformationsPage({super.key});

  static const name = 'mes-informations';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const MesInformationsPage(),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) =>
            MesInformationsBloc(profilPort: context.read())
              ..add(const MesInformationsRecuperationDemandee()),
        child: const _MesInformationsView(),
      );
}

class _MesInformationsView extends StatelessWidget {
  const _MesInformationsView();

  void _handleMettreAJour(final BuildContext context) {
    context
        .read<MesInformationsBloc>()
        .add(const MesInformationsMiseAJourDemandee());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(Localisation.miseAJourEffectuee)),
    );
    GoRouter.of(context).pop();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: BlocBuilder<MesInformationsBloc, MesInformationsState>(
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
        bottomNavigationBar: FnvBottomBar(
          child: DsfrButton(
            label: Localisation.mettreAJourVosInformations,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
            onPressed: () => _handleMettreAJour(context),
          ),
        ),
        backgroundColor: FnvColors.aidesFond,
      );
}
