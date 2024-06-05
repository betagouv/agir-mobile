import 'package:app/src/design_system/composants/app_bar.dart';
import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/design_system/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/src/design_system/fondamentaux/text_styles.dart';
import 'package:app/src/fonctionnalites/aides/widgets/mes_aides.dart';
import 'package:app/src/fonctionnalites/authentification/domain/ports/authentification_repository.dart';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_bloc.dart';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_event.dart';
import 'package:app/src/fonctionnalites/version/widgets/version_label.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:app/src/pages/aides/aides_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  static const name = 'accueil';
  static const path = '/$name';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
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
      appBar: FnvAppBar(title: _AppBarTitle(firstName: state.prenom)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.aLesAides) ...[
                const MesAides(),
                const SizedBox(height: DsfrSpacings.s5w),
              ],
            ],
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: [
            FnvAppBar(
              leading: IconButton(
                iconSize: 24,
                padding: const EdgeInsets.all(DsfrSpacings.s1w),
                onPressed: () => GoRouter.of(context).pop(),
                style: const ButtonStyle(
                  shape: WidgetStatePropertyAll(roundedRectangleBorder),
                ),
                icon: const Icon(
                  DsfrIcons.systemCloseLine,
                  color: DsfrColors.blueFranceSun113,
                  semanticLabel: Localisation.fermer,
                ),
              ),
              title: const Text(
                Localisation.menu,
                style: DsfrTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsfrSpacings.s3w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.aLesAides)
                        DsfrLink.md(
                          label: Localisation.menuAides,
                          onTap: () async => context.pushNamed(AidesPage.name),
                        ),
                      const Spacer(),
                      DsfrLink.md(
                        label: 'Se déconnecter',
                        onTap: () async {
                          await context
                              .read<AuthentificationRepository>()
                              .deconnectionDemandee();
                        },
                      ),
                      const SizedBox(height: DsfrSpacings.s3w),
                      const Align(child: VersionLabel()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: FnvColors.accueilFond,
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({required this.firstName});

  final String firstName;

  @override
  Widget build(final BuildContext context) {
    const font = FnvTextStyles.appBarTitleStyle;

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
