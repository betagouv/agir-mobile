import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_bloc.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_event.dart';
import 'package:app/features/authentification/questions/presentation/pages/app_est_encore_en_experimentation_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/helpers/text_scaler.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class QuestionCodePostalPage extends StatelessWidget {
  const QuestionCodePostalPage({super.key});

  static const name = 'question-code-postal';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const QuestionCodePostalPage(),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => QuestionCodePostalBloc(
          profilPort: context.read(),
          communesPort: context.read(),
        )..add(const QuestionCodePostalPrenomDemande()),
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
        ),
        body: ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AssetsImages.illustration2,
                width: 208,
                height: 141,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            MarkdownBody(
              data: Localisation.questionCourantSurMax(2, 3),
              styleSheet: MarkdownStyleSheet(
                p: const DsfrTextStyle.bodyMd(
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            const _Prenom(),
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              Localisation.enchanteDetails,
              style: DsfrTextStyle.bodyLg(lineHeight: 28),
            ),
            const SizedBox(height: DsfrSpacings.s4w),
            const _CodePostalEtCommune(),
          ],
        ),
        bottomNavigationBar: const FnvBottomBar(child: _ButtonContinuer()),
      );
}

class _Prenom extends StatelessWidget {
  const _Prenom();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<QuestionCodePostalBloc>().state;

    const dsfrTextStyle = DsfrTextStyle.headline2();

    return Text.rich(
      TextSpan(
        text: Localisation.enchante,
        children: [
          TextSpan(
            text: state.prenom,
            style: dsfrTextStyle.copyWith(color: DsfrColors.blueFranceSun113),
          ),
          const TextSpan(text: ' !'),
        ],
      ),
      style: dsfrTextStyle,
    );
  }
}

class _CodePostalEtCommune extends StatefulWidget {
  const _CodePostalEtCommune();

  @override
  State<_CodePostalEtCommune> createState() => _CodePostalEtCommuneState();
}

class _CodePostalEtCommuneState extends State<_CodePostalEtCommune> {
  late final _textEditingController = TextEditingController();

  void _handleCodePostal(final BuildContext context, final String value) {
    context
        .read<QuestionCodePostalBloc>()
        .add(QuestionCodePostalAChange(value));
    _textEditingController.clear();
  }

  void _handleCommune(final BuildContext context, final String? value) {
    if (value == null) {
      return;
    }
    context.read<QuestionCodePostalBloc>().add(QuestionCommuneAChange(value));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<QuestionCodePostalBloc>().state;

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
          width: adjustTextSize(context, 97),
          child: DsfrInput(
            label: Localisation.codePostal,
            initialValue: state.codePostal,
            onChanged: (final value) => _handleCodePostal(context, value),
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

class _ButtonContinuer extends StatelessWidget {
  const _ButtonContinuer();

  @override
  Widget build(final BuildContext context) {
    final estRempli = context.select<QuestionCodePostalBloc, bool>(
      (final bloc) => bloc.state.estRempli,
    );

    return DsfrButton(
      label: Localisation.continuer,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: estRempli
          ? () async {
              final bloc = context.read<QuestionCodePostalBloc>()
                ..add(const QuestionCodePostalMiseAJourDemandee());

              await GoRouter.of(context).pushNamed(
                AppEstEncoreEnExperimentationPage.name,
                pathParameters: {'commune': bloc.state.commune},
              );
            }
          : null,
    );
  }
}
