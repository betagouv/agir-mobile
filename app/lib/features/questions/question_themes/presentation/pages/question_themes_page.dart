import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/checkbox_set.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/questions/core/presentation/widgets/onboarding_illustration.dart';
import 'package:app/features/questions/presentation/pages/tout_est_pret_page.dart';
import 'package:app/features/questions/question_themes/presentation/bloc/question_themes_bloc.dart';
import 'package:app/features/questions/question_themes/presentation/bloc/question_themes_event.dart';
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

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const QuestionThemesPage());

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            QuestionThemesBloc(mieuxVousConnaitreRepository: context.read())..add(const QuestionThemesRecuperationDemandee()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => FnvScaffold(
    appBar: AppBar(backgroundColor: FnvColors.homeBackground, iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113)),
    body: ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: [
        MarkdownBody(
          data: Localisation.questionCourantSurMax(3, 3),
          styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113)),
        ),
        const SizedBox(height: DsfrSpacings.s3v),
        const Align(alignment: Alignment.centerLeft, child: OnboardingIllustration(assetName: AssetImages.illustration4)),
        const Text(Localisation.cestPresqueTermine, style: DsfrTextStyle.headline2()),
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
  Widget build(final context) {
    final question = context.select<QuestionThemesBloc, QuestionMultipleChoice?>((final bloc) => bloc.state.question);

    return question == null
        ? const SizedBox.shrink()
        : Column(
          spacing: DsfrSpacings.s3w,
          children: [
            Text(question.label, style: const DsfrTextStyle.bodyLg()),
            FnvCheckboxSet(
              options: question.responses.map((final e) => e.label).toList(),
              selectedOptions: question.responses.where((final e) => e.isSelected).map((final e) => e.label).toList(),
              onChanged: (final value) => context.read<QuestionThemesBloc>().add(QuestionThemesOntChange(value)),
            ),
          ],
        );
  }
}

class _ButtonContinuer extends StatelessWidget {
  const _ButtonContinuer();

  @override
  Widget build(final context) {
    final estRempli = context.select<QuestionThemesBloc, bool>((final bloc) => bloc.state.valeur.isNotEmpty);

    return DsfrButton(
      label: Localisation.continuer,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed:
          estRempli
              ? () async {
                context.read<QuestionThemesBloc>().add(const QuestionThemesMiseAJourDemandee());
                await GoRouter.of(context).pushNamed(ToutEstPretPage.name);
              }
              : null,
    );
  }
}
