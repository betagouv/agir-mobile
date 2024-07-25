import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_bloc.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
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
        create: (final context) =>
            QuestionCodePostalBloc(profilPort: context.read()),
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View();

  Future<void> _handleCodePostal(
    final BuildContext context,
    final QuestionCodePostalState state,
  ) async {
    if (state.aEteChange) {
      await GoRouter.of(context).pushReplacementNamed(AccueilPage.name);
    }
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<QuestionCodePostalBloc, QuestionCodePostalState>(
        listener: (final context, final state) async =>
            _handleCodePostal(context, state),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
          ),
          body: ListView(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            children: [
              MarkdownBody(
                data: Localisation.questionCourantSurMax(2, 2),
                styleSheet: MarkdownStyleSheet(
                  p: const DsfrTextStyle.bodyMd(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(
                Localisation.enchante,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(
                Localisation.enchanteDetails,
                style: DsfrTextStyle.bodyLg(),
              ),
              const SizedBox(height: DsfrSpacings.s4w),
              DsfrInput(
                label: Localisation.votreCodePostal,
                onChanged: (final value) =>
                    context.read<QuestionCodePostalBloc>().add(
                          QuestionCodePostalAChange(value),
                        ),
                keyboardType: TextInputType.name,
              ),
            ],
          ),
          bottomNavigationBar: FnvBottomBar(
            child: Row(
              children: [
                const Expanded(child: _ButtonContinuer()),
                const SizedBox(width: DsfrSpacings.s2w),
                DsfrLink.md(
                  label: Localisation.retour,
                  onPressed: () => GoRouter.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      );
}

class _ButtonContinuer extends StatelessWidget {
  const _ButtonContinuer();

  @override
  Widget build(final BuildContext context) {
    final codePostal = context.select<QuestionCodePostalBloc, String>(
      (final bloc) => bloc.state.codePostal,
    );

    return DsfrButton(
      label: Localisation.continuer,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: codePostal.isNotEmpty
          ? () => context.read<QuestionCodePostalBloc>().add(
                const QuestionCodePostalMiseAJourDemandee(),
              )
          : null,
    );
  }
}
