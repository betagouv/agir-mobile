import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/helpers/text_scaler.dart';
import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/text_styles.dart';
import 'package:app/features/profil/informations/presentation/widgets/revenu_fiscal_input.dart';
import 'package:app/features/simulateur_velo/domain/velo_pour_simulateur.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_bloc.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_event.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/l10n/l10n.dart';
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

  static GoRoute route({required final List<RouteBase> routes}) =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const AideSimulateurVeloPage(), routes: routes);

  @override
  Widget build(final context) {
    context.read<AideVeloBloc>().add(const AideVeloInformationsDemandee());

    return const _AideSimulateurVeloView();
  }
}

class _AideSimulateurVeloView extends StatelessWidget {
  const _AideSimulateurVeloView();

  @override
  Widget build(final context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: const [
        Text(Localisation.simulerMonAide, style: DsfrTextStyle.headline2()),
        Text(Localisation.acheterUnVelo, style: DsfrTextStyle.bodyXl()),
        SizedBox(height: DsfrSpacings.s2w),
        _BikeState(),
        SizedBox(height: DsfrSpacings.s2w),
        _Price(),
        SizedBox(height: DsfrSpacings.s4w),
        Divider(color: FnvColors.dividerColor),
        SizedBox(height: DsfrSpacings.s3w),
        _ElementsNecessaireAuCalcul(),
      ],
    ),
    bottomNavigationBar: const FnvBottomBar(child: _EstimerMesAides()),
  );
}

class _Price extends StatefulWidget {
  const _Price();

  @override
  State<_Price> createState() => _PriceState();
}

class _PriceState extends State<_Price> {
  final _prixVeloController = TextEditingController();

  @override
  void dispose() {
    _prixVeloController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) {
    _prixVeloController.text = context.read<AideVeloBloc>().state.prix.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 114,
            child: DsfrInput(
              label: Localisation.prixDuVelo,
              suffixText: '€',
              controller: _prixVeloController,
              onChanged: (final value) {
                final parse = int.tryParse(value);
                if (parse == null) {
                  return;
                }
                context.read<AideVeloBloc>().add(AideVeloPrixChange(parse));
              },
              validator: (final value) => value == null || value.isEmpty ? Localisation.prixDuVeloObligatoire : null,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        const Text(Localisation.prixDuVeloExplications, style: FnvTextStyles.prixExplicationsStyle),
        const SizedBox(height: DsfrSpacings.s1w),
        ...VeloPourSimulateur.values
            .map((final e) {
              const foregroundColor = DsfrColors.grey50;

              return Align(
                alignment: Alignment.centerLeft,
                child: DsfrTag.sm(
                  label: TextSpan(
                    text: Localisation.veloLabel(e.label),
                    children: [
                      TextSpan(
                        text: Localisation.euro(e.prix),
                        style: const TextStyle(decoration: TextDecoration.underline, decorationColor: foregroundColor),
                      ),
                    ],
                  ),
                  backgroundColor: DsfrColors.info950,
                  foregroundColor: foregroundColor,
                  textStyle: const DsfrTextStyle.bodySm(),
                  onTap: () {
                    final prix = e.prix;
                    context.read<AideVeloBloc>().add(AideVeloPrixChange(prix));
                    _prixVeloController.text = '$prix';
                  },
                ),
              );
            })
            .separator(const SizedBox(height: DsfrSpacings.s2w)),
      ],
    );
  }
}

class _BikeState extends StatelessWidget {
  const _BikeState();

  @override
  Widget build(final context) => DsfrRadioButtonSet(
    title: Localisation.etatDuVelo,
    values: {VeloEtat.neuf: VeloEtat.neuf.label, VeloEtat.occasion: VeloEtat.occasion.label},
    onCallback: (final value) {
      if (value == null) {
        return;
      }
      context.read<AideVeloBloc>().add(AideVeloEtatChange(value));
    },
    initialValue: VeloEtat.neuf,
  );
}

class _ElementsNecessaireAuCalcul extends StatelessWidget {
  const _ElementsNecessaireAuCalcul();

  @override
  Widget build(final context) {
    final state = context.watch<AideVeloBloc>().state;
    const bodySmMediumBlue = DsfrTextStyle.bodySmMedium(color: DsfrColors.blueFranceSun113);

    return state.veutModifierLesInformations
        ? const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avertissement(),
            _CodePostalEtCommune(),
            SizedBox(height: DsfrSpacings.s3w),
            Text(Localisation.revenuQuestion, style: DsfrTextStyle.headline6()),
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
                  WidgetSpan(alignment: PlaceholderAlignment.middle, child: Icon(DsfrIcons.systemErrorWarningLine, size: 16)),
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
                    text: Localisation.donneesUtiliseesCodePostalEtCommune(codePostal: state.codePostal, commune: state.commune),
                    style: bodySmMediumBlue,
                  ),
                  const TextSpan(text: Localisation.donneesUtiliseesPart2),
                  TextSpan(text: Localisation.donneesUtiliseesRevenuFiscal(state.revenuFiscal), style: bodySmMediumBlue),
                  const TextSpan(text: Localisation.donneesUtiliseesPart3),
                  TextSpan(
                    text: Localisation.donneesUtiliseesNombreDeParts(state.nombreDePartsFiscales),
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
                onTap: () => context.read<AideVeloBloc>().add(const AideVeloModificationDemandee()),
              ),
            ),
          ],
        );
  }
}

class _Avertissement extends StatelessWidget {
  const _Avertissement();

  @override
  Widget build(final context) =>
      context.watch<AideVeloBloc>().state.estValide
          ? const SizedBox.shrink()
          : const Column(
            children: [FnvAlert.error(label: Localisation.aideVeloAvertissement), SizedBox(height: DsfrSpacings.s2w)],
          );
}

class _CodePostalEtCommune extends StatefulWidget {
  const _CodePostalEtCommune();

  @override
  State<_CodePostalEtCommune> createState() => _CodePostalEtCommuneState();
}

class _CodePostalEtCommuneState extends State<_CodePostalEtCommune> {
  late final _textEditingController = TextEditingController();

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
  Widget build(final context) {
    final state = context.watch<AideVeloBloc>().state;
    if (state.communes.length == 1) {
      final commune = state.communes.first;
      _textEditingController.text = commune;
      _handleCommune(context, commune);
    } else {
      _textEditingController.text = state.commune;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: adjustTextSize(context, _inputWidth),
          child: DsfrInput(
            label: Localisation.codePostal,
            initialValue: state.codePostal,
            onChanged: (final value) {
              context.read<AideVeloBloc>().add(AideVeloCodePostalChange(value));
              _textEditingController.clear();
            },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
            autofillHints: const [AutofillHints.postalCode],
          ),
        ),
        const SizedBox(width: DsfrSpacings.s2w),
        Expanded(
          child: DsfrSelect<String>(
            label: Localisation.commune,
            dropdownMenuEntries: state.communes.map((final e) => DropdownMenuEntry(value: e, label: e)).toList(),
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

  @override
  Widget build(final context) {
    final nombreDePartsFiscales = context.read<AideVeloBloc>().state.nombreDePartsFiscales;

    return DsfrInput(
      label: Localisation.nombreDePartsFiscales,
      hintText: Localisation.nombreDePartsFiscalesDescription,
      initialValue: FnvNumberFormat.formatNumber(nombreDePartsFiscales),
      onChanged: (final value) {
        final parse = double.tryParse(value.replaceFirst(',', '.'));
        if (parse == null) {
          context.read<AideVeloBloc>().add(const AideVeloNombreDePartsFiscalesChange(0));

          return;
        }
        context.read<AideVeloBloc>().add(AideVeloNombreDePartsFiscalesChange(parse));
      },
      width: adjustTextSize(context, _inputWidth),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9,.]'))],
    );
  }
}

class _RevenuFiscal extends StatelessWidget {
  const _RevenuFiscal();

  @override
  Widget build(final context) {
    final revenuFiscal = context.read<AideVeloBloc>().state.revenuFiscal;

    return RevenuFiscalInput(
      initialValue: revenuFiscal,
      onChanged: (final value) {
        context.read<AideVeloBloc>().add(AideVeloRevenuFiscalChange(value));
      },
    );
  }
}

class _EstimerMesAides extends StatelessWidget {
  const _EstimerMesAides();

  @override
  Widget build(final context) => DsfrButton(
    label: Localisation.estimerMesAides,
    variant: DsfrButtonVariant.primary,
    size: DsfrButtonSize.lg,
    onPressed:
        context.watch<AideVeloBloc>().state.estValide
            ? () async {
              context.read<AideVeloBloc>().add(const AideVeloEstimationDemandee());
              await GoRouter.of(context).pushNamed(AideSimulateurVeloDisponiblePage.name);
            }
            : null,
  );
}

class _Questions extends StatelessWidget {
  const _Questions();

  @override
  Widget build(final context) => DsfrAccordionsGroup(
    values: [
      DsfrAccordion(
        headerBuilder: (final isExpanded) => const _AccordionHeader(text: Localisation.ouTrouverCesInformations),
        body: _AccordionBody(
          child: MarkdownBody(
            data: Localisation.ouTrouverCesInformationsReponse,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle(fontSize: 15)),
          ),
        ),
      ),
      DsfrAccordion(
        headerBuilder: (final isExpanded) => const _AccordionHeader(text: Localisation.pourquoiCesQuestions),
        body: _AccordionBody(
          child: MarkdownBody(
            data: Localisation.pourquoiCesQuestionsReponse,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle(fontSize: 15)),
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
  Widget build(final context) => Padding(padding: const EdgeInsets.all(DsfrSpacings.s2w), child: child);
}

class _AccordionHeader extends StatelessWidget {
  const _AccordionHeader({required this.text});

  final String text;

  @override
  Widget build(final context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
    child: Text.rich(
      TextSpan(
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(DsfrIcons.systemQuestionFill, color: DsfrColors.blueFranceSun113),
          ),
          const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
          TextSpan(text: text),
        ],
      ),
      style: const DsfrTextStyle.bodySmMedium(),
    ),
  );
}
