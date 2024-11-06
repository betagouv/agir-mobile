// ignore_for_file: map-keys-ordering

import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/accueil/presentation/pages/home_page.dart';
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
  Widget build(final context) => Drawer(
        backgroundColor: Colors.white,
        shadowColor: DsfrColors.blueFranceSun113,
        surfaceTintColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: DsfrSpacings.s1w,
                  right: DsfrSpacings.s3w,
                ),
                child: Row(
                  children: [
                    IconButton(
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
                    const SizedBox(width: DsfrSpacings.s1w),
                    const Expanded(
                      child: Text(
                        Localisation.menu,
                        style: DsfrTextStyle.bodyMdBold(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              const Expanded(
                child: SafeArea(top: false, child: _MenuItems()),
              ),
            ],
          ),
        ),
      );
}

class _MenuItems extends StatelessWidget {
  const _MenuItems();

  @override
  Widget build(final context) {
    final groupValue = GoRouterState.of(context).name ?? HomePage.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...{
          HomePage.name: Localisation.accueil,
          AidesPage.name: Localisation.mesAides,
          BibliothequePage.name: Localisation.bibliotheque,
          EnvironmentalPerformanceSummaryPage.name:
              Localisation.bilanEnvironnemental,
        }.entries.map(
              (final e) => _MenuItem(
                label: e.value,
                value: e.key,
                groupValue: groupValue,
              ),
            ),
        const Spacer(),
        _MenuItem(
          label: Localisation.monProfil,
          value: ProfilPage.name,
          groupValue: groupValue,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: DsfrLink.md(
              label: Localisation.seDeconnecter,
              onTap: () async =>
                  context.read<AuthentificationPort>().deconnexionDemandee(),
            ),
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
  });

  final String label;
  final String value;
  final String groupValue;

  @override
  Widget build(final context) {
    final isCurrentPage = groupValue == value;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isCurrentPage
              ? null
              : () async => GoRouter.of(context).pushReplacementNamed(value),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
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
      ),
    );
  }
}
