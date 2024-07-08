import 'package:app/features/aides/simulateur_velo/domain/value_objects/velo_pour_simulateur.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_bloc.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_event.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/alert.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/text_styles.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

const _inputWidth = 97.0;

class AideSimulateurVeloPage extends StatelessWidget {
  const AideSimulateurVeloPage({super.key});

  static const name = 'aide-simulateur-velo';
  static const path = name;

  static GoRoute route({required final List<RouteBase> routes}) => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AideSimulateurVeloPage(),
        routes: routes,
      );

  @override
  Widget build(final BuildContext context) {
    context.read<AideVeloBloc>().add(const AideVeloInformationsDemandee());

    return const _AideSimulateurVeloView();
  }
}

class _AideSimulateurVeloView extends StatelessWidget {
  const _AideSimulateurVeloView();

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: DsfrSpacings.s3w,
            horizontal: DsfrSpacings.s2w,
          ),
          children: const [
            Text(Localisation.simulerMonAide, style: DsfrTextStyle.headline2()),
            Text(Localisation.acheterUnVelo, style: DsfrTextStyle.bodyXl()),
            SizedBox(height: DsfrSpacings.s2w),
            _Prix(),
            SizedBox(height: DsfrSpacings.s4w),
            Divider(color: FnvColors.dividerColor),
            SizedBox(height: DsfrSpacings.s3w),
            _ElementsNecessaireAuCalcul(),
          ],
        ),
        bottomNavigationBar: const FnvBottomBar(child: _EstimerMesAides()),
        backgroundColor: FnvColors.aidesFond,
      );
}

class _Prix extends StatefulWidget {
  const _Prix();

  @override
  State<_Prix> createState() => _PrixState();
}

class _PrixState extends State<_Prix> {
  final _prixVeloControlleur = TextEditingController();

  void _handlePrix(final BuildContext context, final String value) {
    final parse = int.tryParse(value);
    if (parse == null) {
      return;
    }
    context.read<AideVeloBloc>().add(AideVeloPrixChange(parse));
  }

  void _handleTagPrix(final BuildContext context, final int prix) {
    context.read<AideVeloBloc>().add(AideVeloPrixChange(prix));
    _prixVeloControlleur.text = '$prix';
  }

  @override
  void dispose() {
    _prixVeloControlleur.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    _prixVeloControlleur.text =
        context.read<AideVeloBloc>().state.prix.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 114,
            child: DsfrInput(
              label: Localisation.prixDuVelo,
              onChanged: (final value) => _handlePrix(context, value),
              suffixText: '€',
              controller: _prixVeloControlleur,
              validator: (final value) => value == null || value.isEmpty
                  ? Localisation.prixDuVeloObligatoire
                  : null,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            child: DsfrTag.sm(
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
              onTap: () => _handleTagPrix(context, e.prix),
            ),
          );
        }).separator(const SizedBox(height: 10)),
      ],
    );
  }
}

class _ElementsNecessaireAuCalcul extends StatelessWidget {
  const _ElementsNecessaireAuCalcul();

  void _handleModification(final BuildContext context) =>
      context.read<AideVeloBloc>().add(const AideVeloModificationDemandee());

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<AideVeloBloc>().state;
    const bodySmMediumBlue =
        DsfrTextStyle.bodySmMedium(color: DsfrColors.blueFranceSun113);

    return state.veutModifierLesInformations
        ? const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avertissement(),
              _CodePostalEtCommune(),
              SizedBox(height: DsfrSpacings.s3w),
              Text(
                Localisation.revenuQuestion,
                style: DsfrTextStyle.headline6(),
              ),
              SizedBox(height: DsfrSpacings.s1v),
              _NombreDePartsFiscales(),
              SizedBox(height: DsfrSpacings.s3w),
              _RevenuFiscal(),
              SizedBox(height: DsfrSpacings.s3w),
              _Questions(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(DsfrIcons.systemErrorWarningLine, size: 16),
                    ),
                    WidgetSpan(child: SizedBox(width: DsfrSpacings.s1v)),
                    TextSpan(text: Localisation.elementsNecessaireAuCalcul),
                  ],
                ),
                style: DsfrTextStyle.bodySmBold(),
              ),
              const SizedBox(height: DsfrSpacings.s1v),
              Text.rich(
                TextSpan(
                  text: Localisation.donneesUtiliseesPart1,
                  children: [
                    TextSpan(
                      text: Localisation.donneesUtiliseesCodePostalEtCommune(
                        codePostal: state.codePostal,
                        commune: state.commune,
                      ),
                      style: bodySmMediumBlue,
                    ),
                    const TextSpan(text: Localisation.donneesUtiliseesPart2),
                    TextSpan(
                      text: Localisation.donneesUtiliseesRevenuFiscal(
                        state.revenuFiscal,
                      ),
                      style: bodySmMediumBlue,
                    ),
                    const TextSpan(text: Localisation.donneesUtiliseesPart3),
                    TextSpan(
                      text: Localisation.donneesUtiliseesNombreDeParts(
                        state.nombreDePartsFiscales,
                      ),
                      style: bodySmMediumBlue,
                    ),
                    const TextSpan(text: Localisation.point),
                  ],
                ),
                style: const DsfrTextStyle.bodySm(),
              ),
              const SizedBox(height: DsfrSpacings.s3v),
              Align(
                alignment: Alignment.centerRight,
                child: DsfrLink.md(
                  label: Localisation.modifier,
                  icon: DsfrIcons.designPencilFill,
                  onTap: () => _handleModification(context),
                ),
              ),
            ],
          );
  }
}

class _Avertissement extends StatelessWidget {
  const _Avertissement();

  @override
  Widget build(final BuildContext context) =>
      context.watch<AideVeloBloc>().state.estValide
          ? const SizedBox.shrink()
          : const Column(
              children: [
                FnvAlert.error(label: Localisation.aideVeloAvertissement),
                SizedBox(height: DsfrSpacings.s2w),
              ],
            );
}

class _CodePostalEtCommune extends StatefulWidget {
  const _CodePostalEtCommune();

  @override
  State<_CodePostalEtCommune> createState() => _CodePostalEtCommuneState();
}

class _CodePostalEtCommuneState extends State<_CodePostalEtCommune> {
  late final _textEditingController = TextEditingController();

  void _handleCodePostal(final BuildContext context, final String value) {
    context.read<AideVeloBloc>().add(AideVeloCodePostalChange(value));
    _textEditingController.clear();
  }

  void _handleCommune(final BuildContext context, final String? value) {
    if (value == null) {
      return;
    }
    context.read<AideVeloBloc>().add(AideVeloCommuneChange(value));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<AideVeloBloc>().state;
    if (state.communes.length == 1) {
      final commune = state.communes.firstOrNull!;
      _textEditingController.text = commune;
      _handleCommune(context, commune);
    } else {
      _textEditingController.text = state.commune;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.textScalerOf(context).scale(_inputWidth),
          child: DsfrInput(
            label: Localisation.codePostal,
            onChanged: (final value) => _handleCodePostal(context, value),
            initialValue: state.codePostal,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(5),
            ],
          ),
        ),
        const SizedBox(width: DsfrSpacings.s2w),
        Expanded(
          child: DsfrSelect<String>(
            label: Localisation.commune,
            dropdownMenuEntries: state.communes
                .map((final e) => DropdownMenuEntry(value: e, label: e))
                .toList(),
            onSelected: (final value) => _handleCommune(context, value),
            controller: _textEditingController,
          ),
        ),
      ],
    );
  }
}

class _NombreDePartsFiscales extends StatelessWidget {
  const _NombreDePartsFiscales();

  void _handleNombreDePartsFiscales(
    final BuildContext context,
    final String value,
  ) {
    final parse = double.tryParse(value.replaceFirst(',', '.'));
    if (parse == null) {
      context
          .read<AideVeloBloc>()
          .add(const AideVeloNombreDePartsFiscalesChange(0));

      return;
    }
    context
        .read<AideVeloBloc>()
        .add(AideVeloNombreDePartsFiscalesChange(parse));
  }

  @override
  Widget build(final BuildContext context) {
    final nombreDePartsFiscales =
        context.read<AideVeloBloc>().state.nombreDePartsFiscales;

    return DsfrInput(
      label: Localisation.nombreDePartsFiscales,
      hint: Localisation.nombreDePartsFiscalesDescription,
      onChanged: (final value) => _handleNombreDePartsFiscales(context, value),
      initialValue: '$nombreDePartsFiscales',
      width: MediaQuery.textScalerOf(context).scale(_inputWidth),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9,.]'))],
    );
  }
}

class _RevenuFiscal extends StatelessWidget {
  const _RevenuFiscal();

  void _handleRevenuFiscal(final BuildContext context, final String value) {
    final parse = int.tryParse(value);
    if (parse == null) {
      return;
    }
    context.read<AideVeloBloc>().add(AideVeloRevenuFiscalChange(parse));
  }

  @override
  Widget build(final BuildContext context) => DsfrInput(
        label: Localisation.revenuFiscal,
        onChanged: (final value) => _handleRevenuFiscal(context, value),
        suffixText: '€',
        initialValue:
            context.read<AideVeloBloc>().state.revenuFiscal?.toString(),
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );
}

class _EstimerMesAides extends StatelessWidget {
  const _EstimerMesAides();

  @override
  Widget build(final BuildContext context) => DsfrButton(
        label: Localisation.estimerMesAides,
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: context.watch<AideVeloBloc>().state.estValide
            ? () async {
                context
                    .read<AideVeloBloc>()
                    .add(const AideVeloEstimationDemandee());
                await GoRouter.of(context)
                    .pushNamed(AideSimulateurVeloDisponiblePage.name);
              }
            : null,
      );
}

class _Questions extends StatelessWidget {
  const _Questions();

  @override
  Widget build(final BuildContext context) => DsfrAccordionsGroup(
        values: [
          DsfrAccordion(
            headerBuilder: (final isExpanded) => const _AccordionHeader(
              text: Localisation.ouTrouverCesInformations,
            ),
            body: _AccordionBody(
              child: MarkdownBody(
                data: Localisation.ouTrouverCesInformationsReponse,
                styleSheet: MarkdownStyleSheet(
                  p: const DsfrTextStyle(fontSize: 15, lineHeight: 24),
                ),
              ),
            ),
          ),
          DsfrAccordion(
            headerBuilder: (final isExpanded) =>
                const _AccordionHeader(text: Localisation.pourquoiCesQuestions),
            body: _AccordionBody(
              child: MarkdownBody(
                data: Localisation.pourquoiCesQuestionsReponse,
                styleSheet: MarkdownStyleSheet(
                  p: const DsfrTextStyle(fontSize: 15, lineHeight: 24),
                ),
              ),
            ),
          ),
        ],
      );
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
        child: Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  DsfrIcons.systemQuestionFill,
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
              TextSpan(text: text),
            ],
          ),
          style: const DsfrTextStyle.bodySmMedium(),
        ),
      );
}
