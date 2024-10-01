import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/checkbox_set.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/question_themes/presentation/bloc/question_themes_bloc.dart';
import 'package:app/features/authentification/question_themes/presentation/bloc/question_themes_event.dart';
import 'package:app/features/authentification/questions/presentation/pages/tout_est_pret_page.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class QuestionThemesPage extends StatelessWidget {
  const QuestionThemesPage({super.key});

  static const name = 'question-themes';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const QuestionThemesPage(),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) =>
            QuestionThemesBloc(mieuxVousConnaitrePort: context.read())
              ..add(const QuestionThemesRecuperationDemandee()),
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
                AssetsImages.illustration4,
                width: 208,
                height: 141,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            MarkdownBody(
              data: Localisation.questionCourantSurMax(3, 3),
              styleSheet: MarkdownStyleSheet(
                p: const DsfrTextStyle.bodyMd(
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              Localisation.cestPresqueTermine,
              style: DsfrTextStyle.headline2(),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            const _Question(),
          ],
        ),
        bottomNavigationBar: const FnvBottomBar(child: _ButtonContinuer()),
      );
}

class _Question extends StatelessWidget {
  const _Question();

  @override
  Widget build(final BuildContext context) {
    final question = context.select<QuestionThemesBloc, ChoixMultipleQuestion?>(
      (final bloc) => bloc.state.question,
    );

    return question == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Text(
                question.text.value,
                style: const DsfrTextStyle.bodyLg(lineHeight: 28),
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              FnvCheckboxSet(
                options: question.responsesPossibles.value,
                selectedOptions: question.responses.value,
                onChanged: (final value) => context
                    .read<QuestionThemesBloc>()
                    .add(QuestionThemesOntChange(value)),
              ),
            ],
          );
  }
}

class _ButtonContinuer extends StatelessWidget {
  const _ButtonContinuer();

  @override
  Widget build(final BuildContext context) {
    final estRempli = context.select<QuestionThemesBloc, bool>(
      (final bloc) => bloc.state.valeur.isNotEmpty,
    );

    return DsfrButton(
      label: Localisation.continuer,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: estRempli
          ? () async {
              context.read<QuestionThemesBloc>().add(
                    const QuestionThemesMiseAJourDemandee(),
                  );
              await GoRouter.of(context).pushNamed(ToutEstPretPage.name);
            }
          : null,
    );
  }
}
