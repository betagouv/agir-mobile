import 'package:app/features/aides/presentation/pages/aides_page.dart';
import 'package:app/features/aides/presentation/widgets/mes_aides.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/profil/presentation/pages/profil_page.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_bloc.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_event.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/shared/widgets/fondamentaux/text_styles.dart';
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

  Future<void> _handleSeDeconnecter(final BuildContext context) async =>
      context.read<AuthentificationPort>().deconnectionDemandee();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<UtilisateurBloc>().state;

    return Scaffold(
      appBar: FnvAppBar(title: _AppBarTitle(firstName: state.prenom)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
          child: ListView(
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
                style: DsfrFonts.bodyMdBold,
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
                        label: Localisation.monProfil,
                        onTap: () async => context.pushNamed(ProfilPage.name),
                      ),
                      DsfrLink.md(
                        label: 'Se déconnecter',
                        onTap: () async => _handleSeDeconnecter(context),
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
