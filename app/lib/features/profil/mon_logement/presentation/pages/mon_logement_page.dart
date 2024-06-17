import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MonLogementPage extends StatelessWidget {
  const MonLogementPage({super.key});

  static const name = 'mon-logement';
  static const path = '/$name';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => BlocProvider(
          create: (final context) => MonLogementBloc(
            profilPort: context.read(),
            communesPort: context.read(),
          )..add(const MonLogementRecuperationDemandee()),
          child: const MonLogementPage(),
        ),
      );

  void _handleMettreAJour(final BuildContext context) {
    context.read<MonLogementBloc>().add(const MonLogementMiseAJourDemandee());
    GoRouter.of(context).pop();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: SafeArea(
          child: BlocBuilder<MonLogementBloc, MonLogementState>(
            builder: (final context, final state) {
              switch (state.statut) {
                case MonLogementStatut.initial:
                case MonLogementStatut.chargement:
                  return const Center(child: CircularProgressIndicator());

                case MonLogementStatut.succes:
                  return const MonLogementForm();
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
