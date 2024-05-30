import 'package:app/src/design_system/composants/app_bar.dart';
import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/fonctionnalites/authentification/domain/ports/authentification_repository.dart';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_bloc.dart';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_event.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  static const name = 'accueil';
  static const path = '/$name';

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) {
          context
              .read<UtilisateurBloc>()
              .add(const UtilsateurRecuperationDemandee());
          return const AccueilPage();
        },
      );

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<UtilisateurBloc>().state;
    return Scaffold(
      appBar: FnvAppBar(
        title: _AppBarTitle(firstName: state.prenom),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        child: ListView(
          children: [
            DsfrButton.lg(
              label: 'Se déconnecter',
              onTap: () async {
                await context
                    .read<AuthentificationRepository>()
                    .deconnectionDemandee();
              },
            ),
          ],
        ),
      ),
      body: ColoredBox(
        color: FnvColors.accueilFond,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
            child: Column(
              children: [
                if (state.aLesAides) ...[
                  const MesAides(),
                  const SizedBox(height: DsfrSpacings.s5w),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({required this.firstName});

  final String firstName;

  @override
  Widget build(final BuildContext context) {
    const font = DsfrTextStyle(
      fontSize: 16,
      height: 20,
    );
    return Text.rich(
      TextSpan(
        text: Localisation.bonjour,
        children: [
          TextSpan(
            text: Localisation.prenomExclamation(firstName),
            style: font,
          ),
        ],
      ),
      style: font.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
