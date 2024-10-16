import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/features/aides/list/presentation/pages/aides_page.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/profil/profil/presentation/pages/profil_page.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(final BuildContext context) => Drawer(
        shape: const RoundedRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                style: DsfrTextStyle.bodyMdBold(),
              ),
            ),
            const Expanded(
              child: ColoredBox(
                color: Colors.white,
                child: SafeArea(top: false, child: _MenuItems()),
              ),
            ),
          ],
        ),
      );
}

class _MenuItems extends StatelessWidget {
  const _MenuItems();

  Future<void> _redirigeSiLaPageCourantEstDifferente(
    final BuildContext context,
    final String name,
  ) async {
    Scaffold.of(context).closeDrawer();
    if (GoRouterState.of(context).name == name) {
      return;
    }
    await GoRouter.of(context).pushNamed(name);
  }

  @override
  Widget build(final BuildContext context) {
    final groupValue = GoRouterState.of(context).name ?? AccueilPage.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MenuItem(
          label: Localisation.accueil,
          value: AccueilPage.name,
          groupValue: groupValue,
          onTap: () async =>
              _redirigeSiLaPageCourantEstDifferente(context, AccueilPage.name),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        _MenuItem(
          label: Localisation.mesAides,
          value: AidesPage.name,
          groupValue: groupValue,
          onTap: () async =>
              _redirigeSiLaPageCourantEstDifferente(context, AidesPage.name),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        _MenuItem(
          label: Localisation.bibliotheque,
          value: BibliothequePage.name,
          groupValue: groupValue,
          onTap: () async => _redirigeSiLaPageCourantEstDifferente(
            context,
            BibliothequePage.name,
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        _MenuItem(
          label: Localisation.bilanEnvironnemental,
          value: EnvironmentalPerformanceSummaryPage.name,
          groupValue: groupValue,
          onTap: () async => _redirigeSiLaPageCourantEstDifferente(
            context,
            EnvironmentalPerformanceSummaryPage.name,
          ),
        ),
        const Spacer(),
        _MenuItem(
          label: Localisation.monProfil,
          value: ProfilPage.name,
          groupValue: groupValue,
          onTap: () async =>
              _redirigeSiLaPageCourantEstDifferente(context, ProfilPage.name),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: DsfrLink.md(
            label: Localisation.seDeconnecter,
            onTap: () async =>
                context.read<AuthentificationPort>().deconnexionDemandee(),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: VersionLabel(),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  final String label;
  final String value;
  final String groupValue;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    final isCurrentPage = groupValue == value;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 24),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (isCurrentPage)
              const DecoratedBox(
                decoration: ShapeDecoration(
                  color: DsfrColors.blueFranceSun113,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(DsfrSpacings.s0v5),
                    ),
                  ),
                ),
                child: SizedBox(width: 3, height: 24),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
              child: Text(
                label,
                style: isCurrentPage
                    ? const DsfrTextStyle.bodyLgBold(
                        color: DsfrColors.blueFranceSun113,
                      )
                    : const DsfrTextStyle.bodyLg(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
