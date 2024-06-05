import 'package:app/src/design_system/composants/alert.dart';
import 'package:app/src/design_system/composants/app_bar.dart';
import 'package:app/src/design_system/composants/bottom_bar.dart';
import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/design_system/fondamentaux/text_styles.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide_velo/aide_velo_bloc.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide_velo/aide_velo_event.dart';
import 'package:app/src/fonctionnalites/aides/domain/velo_pour_simulateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:app/src/pages/aides/aide_simulateur_velo_disponibles_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AideSimulateurVeloPage extends StatefulWidget {
  const AideSimulateurVeloPage({super.key});

  static const name = 'aide-simulateur-velo';
  static const path = '/$name';

  static GoRoute route({required final List<RouteBase> routes}) => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AideSimulateurVeloPage(),
        routes: routes,
      );

  @override
  State<AideSimulateurVeloPage> createState() => _AideSimulateurVeloPageState();
}

class _AideSimulateurVeloPageState extends State<AideSimulateurVeloPage> {
  final _prixVeloControlleur = TextEditingController();

  @override
  void dispose() {
    _prixVeloControlleur.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const inputWidth = 97.0;
    _prixVeloControlleur.text =
        context.read<AideVeloBloc>().state.prix.toString();

    return Scaffold(
      appBar: const FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: DsfrSpacings.s3w,
          horizontal: DsfrSpacings.s2w,
        ),
        children: [
          const Text(
            Localisation.simulerMonAide,
            style: DsfrFonts.headline2,
          ),
          const Text(Localisation.acheterUnVelo, style: DsfrFonts.bodyXl),
          const SizedBox(height: DsfrSpacings.s2w),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 114,
              child: DsfrInput(
                label: Localisation.prixDuVelo,
                onChanged: (final value) {
                  final parse = int.tryParse(value);
                  if (parse == null) {
                    return;
                  }
                  context.read<AideVeloBloc>().add(AideVeloPrixChange(parse));
                },
                controller: _prixVeloControlleur,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          const Text(
            Localisation.prixDuVeloExplications,
            style: FnvTextStyles.prixExplicationsStyle,
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          ...VeloPourSimulateur.values.map((final e) {
            const foregroundColor = DsfrColors.grey50;

            return Align(
              alignment: Alignment.centerLeft,
              child: DsfrTag.md(
                label: TextSpan(
                  text: Localisation.veloLabel(e.label),
                  children: [
                    TextSpan(
                      text: Localisation.euro(e.prix),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: foregroundColor,
                      ),
                    ),
                  ],
                ),
                backgroundColor: DsfrColors.info950,
                foregroundColor: foregroundColor,
                onTap: () {
                  context.read<AideVeloBloc>().add(AideVeloPrixChange(e.prix));
                  _prixVeloControlleur.text = '${e.prix}';
                },
              ),
            );
          }).separator(const SizedBox(height: DsfrSpacings.s1w)),
          const SizedBox(height: DsfrSpacings.s4w),
          const Divider(color: FnvColors.dividerColor),
          const SizedBox(height: DsfrSpacings.s3w),
          const FnvAlert.warning(label: Localisation.aideVeloAvertissement),
          const SizedBox(height: DsfrSpacings.s2w),
          Row(
            children: [
              SizedBox(
                width: inputWidth,
                child: DsfrInput(
                  label: Localisation.codePostal,
                  onChanged: (final value) => context
                      .read<AideVeloBloc>()
                      .add(AideVeloCodePostalChange(value)),
                ),
              ),
              const SizedBox(width: DsfrSpacings.s2w),
              Expanded(
                child: DsfrSelect<String>(
                  label: Localisation.ville,
                  dropdownMenuEntries: context
                      .watch<AideVeloBloc>()
                      .state
                      .communes
                      .map((final e) => DropdownMenuEntry(value: e, label: e))
                      .toList(),
                  onSelected: (final value) {
                    if (value == null) {
                      return;
                    }
                    context
                        .read<AideVeloBloc>()
                        .add(AideVeloVilleChange(value));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          Text(
            Localisation.revenuQuestion,
            style: DsfrFonts.headline6.copyWith(color: DsfrColors.grey50),
          ),
          const SizedBox(height: DsfrSpacings.s1v),
          DsfrInput(
            label: Localisation.nombrePartsFiscales,
            onChanged: (final value) {
              final parse = double.tryParse(value);
              if (parse == null) {
                return;
              }

              context
                  .read<AideVeloBloc>()
                  .add(AideVeloNombreDePartsFiscalesChange(parse));
            },
            hint: Localisation.nombrePartsFiscalesDescription,
            width: inputWidth,
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrRadioButtonSet(
            title: Localisation.revenuFiscal,
            values: const {
              0: Localisation.tranche0,
              16000: Localisation.tranche1,
              35000: Localisation.tranche2,
            },
            onCallback: (final value) {
              if (value == null) {
                return;
              }
              context
                  .read<AideVeloBloc>()
                  .add(AideVeloRevenuFiscalChange(value));
            },
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrAccordionsGroup(
            values: [
              DsfrAccordion(
                header: const _AccordionHeader(
                  text: Localisation.ouTrouverCesInformations,
                ),
                body: _AccordionBody(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MarkdownBody(
                        data: Localisation.ouTrouverCesInformationsReponse,
                      ),
                      const SizedBox(height: DsfrSpacings.s3w),
                      DsfrLink.sm(
                        label: Localisation.plusDaide,
                        icon: DsfrIcons.systemExternalLinkFill,
                        onTap: () async {
                          await launchUrlString('https://example.com');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const DsfrAccordion(
                header:
                    _AccordionHeader(text: Localisation.pourquoiCesQuestions),
                body: _AccordionBody(
                  child: MarkdownBody(
                    data: Localisation.pourquoiCesQuestionsReponse,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton.lg(
          label: Localisation.estimerMesAides,
          onTap: () async {
            context
                .read<AideVeloBloc>()
                .add(const AideVeloEstimationDemandee());
            await GoRouter.of(context)
                .pushNamed(AideSimulateurVeloDisponiblePage.name);
          },
        ),
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}

class _AccordionBody extends StatelessWidget {
  const _AccordionBody({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: child,
      );
}

class _AccordionHeader extends StatelessWidget {
  const _AccordionHeader({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
        child: Row(
          children: [
            const Icon(
              DsfrIcons.systemQuestionFill,
              color: DsfrColors.blueFranceSun113,
            ),
            const SizedBox(width: DsfrSpacings.s1w),
            Expanded(child: Text(text, style: DsfrFonts.bodySmMedium)),
          ],
        ),
      );
}
