import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_bloc.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_state.dart';
import 'package:app/features/authentification/questions/presentation/pages/question_code_postal_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
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

  Future<void> _handlePrenom(
    final BuildContext context,
    final QuestionPrenomState state,
  ) async {
    if (state.aEteChange) {
      await GoRouter.of(context).pushNamed(QuestionCodePostalPage.name);
    }
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<QuestionPrenomBloc, QuestionPrenomState>(
        listener: (final context, final state) async =>
            _handlePrenom(context, state),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
          ),
          body: ListView(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            children: [
              MarkdownBody(
                data: Localisation.questionCourantSurMax(1, 2),
                styleSheet: MarkdownStyleSheet(
                  p: const DsfrTextStyle.bodyMd(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(
                Localisation.bienvenuSurAgir,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(
                Localisation.bienvenuSurAgirDetails,
                style: DsfrTextStyle.bodyLg(),
              ),
              const SizedBox(height: DsfrSpacings.s4w),
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
        ),
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
          ? () => context.read<QuestionPrenomBloc>().add(
                const QuestionPrenomMiseAJourDemandee(),
              )
          : null,
    );
  }
}
