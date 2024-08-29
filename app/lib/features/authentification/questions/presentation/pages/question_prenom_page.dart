import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_bloc.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_event.dart';
import 'package:app/features/authentification/questions/presentation/pages/question_code_postal_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class QuestionPrenomPage extends StatelessWidget {
  const QuestionPrenomPage({super.key});

  static const name = 'question-prenom';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const QuestionPrenomPage(),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) =>
            QuestionPrenomBloc(profilPort: context.read()),
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
        ),
        body: ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AssetsImages.illustration1,
                width: 208,
                height: 141,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            MarkdownBody(
              data: Localisation.questionCourantSurMax(1, 3),
              styleSheet: MarkdownStyleSheet(
                p: const DsfrTextStyle.bodyMd(
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              Localisation.bienvenueSurAgir,
              style: DsfrTextStyle.headline2(),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              Localisation.bienvenueSurAgirDetails,
              style: DsfrTextStyle.bodyLg(lineHeight: 28),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            DsfrInput(
              label: Localisation.votrePrenom,
              onChanged: (final value) =>
                  context.read<QuestionPrenomBloc>().add(
                        QuestionPrenomAChange(value),
                      ),
              keyboardType: TextInputType.name,
            ),
          ],
        ),
        bottomNavigationBar: const FnvBottomBar(child: _ButtonContinuer()),
      );
}

class _ButtonContinuer extends StatelessWidget {
  const _ButtonContinuer();

  @override
  Widget build(final BuildContext context) {
    final prenom = context.select<QuestionPrenomBloc, String>(
      (final bloc) => bloc.state.prenom,
    );

    return DsfrButton(
      label: Localisation.continuer,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: prenom.isNotEmpty
          ? () async {
              context.read<QuestionPrenomBloc>().add(
                    const QuestionPrenomMiseAJourDemandee(),
                  );
              await GoRouter.of(context).pushNamed(QuestionCodePostalPage.name);
            }
          : null,
    );
  }
}
