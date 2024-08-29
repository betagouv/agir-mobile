import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_bloc.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/svgs.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AideSimulateurVeloDisponiblePage extends StatelessWidget {
  const AideSimulateurVeloDisponiblePage({super.key});

  static const name = 'aide-simulateur-velo-disponible';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            const AideSimulateurVeloDisponiblePage(),
      );

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<AideVeloBloc>().state;

    return Scaffold(
      appBar: const FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: paddingVerticalPage),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: Text(
              Localisation.vosAidesDisponibles,
              style: DsfrTextStyle.headline2(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          if (state.aideVeloStatut == AideVeloStatut.chargement)
            const Center(child: CircularProgressIndicator())
          else
            DsfrAccordionsGroup(
              values: state.aidesDisponibles
                  .map(
                    (final e) => DsfrAccordion(
                      headerBuilder: (final isExpanded) => _Header(
                        titre: e.titre,
                        montantMax: e.montantTotal,
                        isExpanded: isExpanded,
                      ),
                      body: _Body(aides: e.aides),
                      isEnable: e.aides.isNotEmpty,
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: DsfrSpacings.s3w),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: Localisation.propulsePar,
                    style: DsfrTextStyle.bodyXsBold(),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SvgPicture.asset(
                      AssetsSvgs.mesAidesVeloTexte,
                      height: 9,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1v)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SvgPicture.asset(
                      AssetsSvgs.mesAidesVeloLogo,
                      height: 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton(
          label: Localisation.revenirAuSimulateur,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.titre,
    required this.montantMax,
    required this.isExpanded,
  });

  final String titre;
  final int? montantMax;
  final bool isExpanded;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                titre,
                style: isExpanded
                    ? const DsfrTextStyle.bodyMdBold()
                    : const DsfrTextStyle.bodyMd(),
              ),
            ),
            const SizedBox(width: DsfrSpacings.s1w),
            Text.rich(
              TextSpan(
                children: montantMax == null
                    ? [
                        const TextSpan(
                          text: Localisation.aucuneAideDisponible,
                          style: DsfrTextStyle.bodyMdBold(),
                        ),
                      ]
                    : [
                        const TextSpan(text: Localisation.jusqua),
                        TextSpan(
                          text: Localisation.euro(montantMax!),
                          style: const DsfrTextStyle.bodyMdBold(),
                        ),
                      ],
              ),
              style: const DsfrTextStyle.bodyMd(),
            ),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({required this.aides});

  final List<AideVelo> aides;

  Future<bool> _handleVoirLesDemarches(final AideVelo e) =>
      launchUrlString(e.lien);

  @override
  Widget build(final BuildContext context) => Column(
        children: aides
            .map(
              (final e) => Padding(
                padding: const EdgeInsets.all(DsfrSpacings.s2w),
                child: Row(
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
                          Text(
                            e.libelle,
                            style: const DsfrTextStyle.bodyMdBold(),
                          ),
                          const SizedBox(height: DsfrSpacings.s1v),
                          Text(
                            e.description.replaceAll('\n', ''),
                            style: const DsfrTextStyle.bodyXs(),
                          ),
                          const SizedBox(height: DsfrSpacings.s1v),
                          DsfrLink.sm(
                            label: Localisation.voirLesDemarches,
                            icon: DsfrIcons.systemExternalLinkFill,
                            iconPosition: DsfrLinkIconPosition.end,
                            onTap: () async => _handleVoirLesDemarches(e),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: DsfrSpacings.s1w),
                    Text(
                      Localisation.euro(e.montant),
                      style: const DsfrTextStyle.bodyMdBold(),
                    ),
                  ],
                ),
              ),
            )
            .separator(const Divider())
            .toList(),
      );
}
