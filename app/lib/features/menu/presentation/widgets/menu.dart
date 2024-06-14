import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/features/aides/presentation/pages/aides_page.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/profil/presentation/pages/profil_page.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_bloc.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> _redirigeSiLaPageCourantEstDifferente(
  final BuildContext context,
  final String name,
) async {
  final router = GoRouter.of(context);
  if (GoRouterState.of(context).name == name) {
    Scaffold.of(context).closeDrawer();

    return;
  }
  await router.pushReplacementNamed(name);
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  Future<void> _handleTapOnAccueil(final BuildContext context) async =>
      _redirigeSiLaPageCourantEstDifferente(context, AccueilPage.name);

  Future<void> _handleTapOnProfile(final BuildContext context) async =>
      _redirigeSiLaPageCourantEstDifferente(context, ProfilPage.name);

  @override
  Widget build(final BuildContext context) => Drawer(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: DsfrSpacings.s3w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DsfrLink.md(
                        label: Localisation.menuAccueil,
                        onTap: () async => _handleTapOnAccueil(context),
                      ),
                      const _MenuAides(),
                      const Spacer(),
                      DsfrLink.md(
                        label: Localisation.monProfil,
                        onTap: () async => _handleTapOnProfile(context),
                      ),
                      DsfrLink.md(
                        label: 'Se déconnecter',
                        onTap: () async => context
                            .read<AuthentificationPort>()
                            .deconnectionDemandee(),
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
      );
}

class _MenuAides extends StatelessWidget {
  const _MenuAides();

  Future<void> _handleTapOnAides(final BuildContext context) async =>
      _redirigeSiLaPageCourantEstDifferente(context, AidesPage.name);

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<UtilisateurBloc>().state;

    return state.aLesAides
        ? DsfrLink.md(
            label: Localisation.menuAides,
            onTap: () async => _handleTapOnAides(context),
          )
        : const SizedBox.shrink();
  }
}
