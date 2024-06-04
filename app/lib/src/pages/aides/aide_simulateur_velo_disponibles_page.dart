import 'package:app/src/design_system/composants/app_bar.dart';
import 'package:app/src/design_system/composants/bottom_bar.dart';
import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide_velo/aide_velo_bloc.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AideSimulateurVeloDisponiblePage extends StatelessWidget {
  const AideSimulateurVeloDisponiblePage({super.key});

  static const name = 'aide-simulateur-velo-disponible';
  static const path = name;

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) =>
            const AideSimulateurVeloDisponiblePage(),
      );

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<AideVeloBloc>().state;
    return Scaffold(
      appBar: const FnvAppBar(),
      backgroundColor: FnvColors.aidesFond,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: DsfrSpacings.s2w,
          vertical: DsfrSpacings.s3w,
        ),
        children: [
          const Text(
            Localisation.vosAidesDisponibles,
            style: DsfrFonts.headline2,
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          DsfrAccordionsGroup(
            values: state.aidesDisponibles
                .map(
                  (final e) => DsfrAccordion(
                    header: _Header(
                      titre: e.titre,
                      montantMax: e.montantTotal,
                    ),
                    body: _Body(aides: e.aides),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(
            Localisation.propulsePar,
            style: DsfrFonts.bodyXs,
          ),
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton.lg(
          label: Localisation.revenirAuSimulateur,
          onTap: () => GoRouter.of(context).pop(),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.titre,
    required this.montantMax,
  });

  final String titre;
  final int? montantMax;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: DsfrSpacings.s2w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                titre,
                style: DsfrFonts.bodyMd,
              ),
            ),
            Text(
              montantMax != null
                  ? Localisation.jusqua + Localisation.euro(montantMax!)
                  : Localisation.aucuneAideDisponible,
              style: DsfrFonts.bodyMd,
            ),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({
    required this.aides,
  });

  final List<AideVelo> aides;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Column(
          children: aides
              .map(
                (final e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      e.logo,
                      width: DsfrSpacings.s7w,
                      height: DsfrSpacings.s7w,
                    ),
                    const SizedBox(width: DsfrSpacings.s1w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.libelle, style: DsfrFonts.bodyMdBold),
                          const SizedBox(height: DsfrSpacings.s1v),
                          Text(e.description, style: DsfrFonts.bodyXs),
                          const SizedBox(height: DsfrSpacings.s1v),
                          DsfrLink.sm(
                            label: Localisation.voirLesDemarches,
                            icon: DsfrIcons.systemExternalLinkFill,
                            onTap: () async {
                              await launchUrlString(e.lien);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: DsfrSpacings.s1w),
                    Text(
                      Localisation.euro(e.montant),
                      style: DsfrFonts.bodyMdBold,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
}
