import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_bloc.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AideSimulateurVeloDisponiblePage extends StatelessWidget {
  const AideSimulateurVeloDisponiblePage({super.key});

  static const name = 'aide-simulateur-velo-disponible';
  static const path = name;

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const AideSimulateurVeloDisponiblePage());

  @override
  Widget build(final context) {
    final state = context.watch<AideVeloBloc>().state;

    return FnvScaffold(
      appBar: FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: paddingVerticalPage),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: Text(Localisation.mesAidesDisponibles, style: DsfrTextStyle.headline2()),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          if (state.aideVeloStatut == AideVeloStatut.chargement)
            const Center(child: CircularProgressIndicator())
          else
            DsfrAccordionsGroup(
              values:
                  state.aidesDisponibles
                      .map(
                        (final e) => DsfrAccordion(
                          headerBuilder:
                              (final isExpanded) => _Header(titre: e.titre, montantMax: e.montantTotal, isExpanded: isExpanded),
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
                  const TextSpan(text: Localisation.propulsePar, style: DsfrTextStyle.bodyXsBold()),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: FnvSvg.asset(AssetImages.mesAidesVeloTexte, height: 9),
                  ),
                  const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1v)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: FnvSvg.asset(AssetImages.mesAidesVeloLogo, height: 9),
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
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.titre, required this.montantMax, required this.isExpanded});

  final String titre;
  final int? montantMax;
  final bool isExpanded;

  @override
  Widget build(final context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Row(
      spacing: DsfrSpacings.s1w,
      children: [
        Expanded(child: Text(titre, style: isExpanded ? const DsfrTextStyle.bodyMdBold() : const DsfrTextStyle.bodyMd())),
        Text.rich(
          TextSpan(
            children:
                montantMax == null
                    ? [const TextSpan(text: Localisation.aucuneAideDisponible, style: DsfrTextStyle.bodyMdBold())]
                    : [
                      const TextSpan(text: Localisation.jusqua),
                      TextSpan(text: Localisation.euro(montantMax!), style: const DsfrTextStyle.bodyMdBold()),
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

  @override
  Widget build(final context) => Column(
    children:
        aides
            .map(
              (final e) => Padding(
                padding: const EdgeInsets.all(DsfrSpacings.s2w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: DsfrSpacings.s1w,
                  children: [
                    FnvImage.network(e.logo, width: DsfrSpacings.s7w, height: DsfrSpacings.s7w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: DsfrSpacings.s1v,
                        children: [
                          Text(e.libelle, style: const DsfrTextStyle.bodyMdBold()),
                          Text(e.description.trim(), style: const DsfrTextStyle.bodyXs()),
                          DsfrLink.sm(
                            label: Localisation.voirLesDemarches,
                            icon: DsfrIcons.systemExternalLinkFill,
                            iconPosition: DsfrLinkIconPosition.end,
                            onTap: () async => FnvUrlLauncher.launch(e.lien),
                          ),
                        ],
                      ),
                    ),
                    Text(Localisation.euro(e.montant), style: const DsfrTextStyle.bodyMdBold()),
                  ],
                ),
              ),
            )
            .separator(const Divider())
            .toList(),
  );
}
