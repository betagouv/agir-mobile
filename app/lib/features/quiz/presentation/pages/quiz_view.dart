import 'package:app/features/quiz/presentation/blocs/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(final BuildContext context) => const Scaffold(
        appBar: FnvAppBar(),
        body: _Body(),
        bottomNavigationBar: FnvBottomBar(child: _BoutonValider()),
        backgroundColor: FnvColors.aidesFond,
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<QuizBloc>().state;

    return ListView(
      padding: const EdgeInsets.all(DsfrSpacings.s3w),
      children: [
        Text(state.quiz.question, style: const DsfrTextStyle.headline2()),
        const SizedBox(height: DsfrSpacings.s2w),
        DsfrRadioButtonSetHeadless(
          values: Map.fromEntries(
            state.quiz.reponses
                .map((final e) => e.reponse)
                .map((final e) => MapEntry(e, e)),
          ),
          onCallback: (final value) => context
              .read<QuizBloc>()
              .add(QuizReponseSelectionnee(value ?? '')),
          mode: DsfrRadioButtonSetMode.column,
        ),
      ],
    );
  }
}

class _BoutonValider extends StatelessWidget {
  const _BoutonValider();

  @override
  Widget build(final BuildContext context) {
    final estSelectionnee = context
        .select<QuizBloc, bool>((final bloc) => bloc.state.estSelectionnee);

    return DsfrButton(
      label: Localisation.valider,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: estSelectionnee
          ? () => context.read<QuizBloc>().add(const QuizValidationDemandee())
          : null,
    );
  }
}
