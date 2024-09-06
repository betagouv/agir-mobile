// ignore_for_file: prefer-correct-handler-name

import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/liste/pages/mieux_vous_connaitre_page.dart';
import 'package:app/features/profil/informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/presentation/pages/options_avancees_page.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/card.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const name = 'profil';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const ProfilPage(),
      );

  @override
  Widget build(final BuildContext context) => RootPage(
        body: ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: [
            const ProfilTitle(title: Localisation.votreProfil),
            FnvCard(
              child: Column(
                children: [
                  _MenuElement(
                    icon: DsfrIcons.userAccountCircleLine,
                    label: Localisation.vosInformations,
                    onTap: () async => GoRouter.of(context)
                        .pushNamed(MesInformationsPage.name),
                  ),
                  const DsfrDivider(),
                  _MenuElement(
                    icon: DsfrIcons.buildingsHome4Line,
                    label: Localisation.votreLogement,
                    onTap: () async =>
                        GoRouter.of(context).pushNamed(MonLogementPage.name),
                  ),
                  const DsfrDivider(),
                  _MenuElement(
                    icon: DsfrIcons.userUserSettingLine,
                    label: Localisation.mieuxVousConnaitre,
                    onTap: () async => GoRouter.of(context)
                        .pushNamed(MieuxVousConnaitrePage.name),
                  ),
                  const DsfrDivider(),
                  _MenuElement(
                    icon: DsfrIcons.documentArticleLine,
                    label: Localisation.lesCguMenu,
                    onTap: () async => launchUrlString(
                      Localisation.lesCguSite,
                    ),
                    iconRight: DsfrIcons.systemExternalLinkLine,
                  ),
                  const DsfrDivider(),
                  _MenuElement(
                    icon: DsfrIcons.systemSettings5Line,
                    label: Localisation.optionsAvancees,
                    onTap: () async => GoRouter.of(context)
                        .pushNamed(OptionsAvanceesPage.name),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _MenuElement extends StatelessWidget {
  const _MenuElement({
    required this.icon,
    required this.label,
    this.onTap,
    this.iconRight = DsfrIcons.systemArrowRightSLine,
  });

  final IconData icon;
  final String label;
  final GestureTapCallback? onTap;
  final IconData iconRight;

  @override
  Widget build(final BuildContext context) {
    const iconColor = DsfrColors.blueFranceSun113;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: DsfrSpacings.s1w),
            Expanded(
              child: Text(label, style: const DsfrTextStyle.bodyMdMedium()),
            ),
            const SizedBox(width: DsfrSpacings.s1w),
            Icon(iconRight, color: iconColor),
          ],
        ),
      ),
    );
  }
}
