import 'package:app/features/quiz/presentation/blocs/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_event.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/composants/html_widget.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:collection/collection.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(final BuildContext context) => const Scaffold(
        appBar: FnvAppBar(),
        body: _Body(),
        bottomNavigationBar: _BottomButton(),
        backgroundColor: FnvColors.aidesFond,
      );
}

class _Body extends StatelessWidget {
  const _Body();

  Color? _getColor(final QuizState state, final String reponse) {
    if (state.estExacte.isNone()) {
      return null;
    }

    final reponseExacte =
        state.quiz.reponses.firstWhereOrNull((final r) => r.exact)?.reponse;
    if (reponse == reponseExacte) {
      return DsfrColors.success950;
    }

    final reponseUtilisateur = state.reponse.getOrElse(() => '');

    return reponse == reponseUtilisateur
        ? state.estExacte.fold(
            () => null,
            (final t) => t ? DsfrColors.success950 : DsfrColors.error950,
          )
        : null;
  }

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
            state.quiz.reponses.map((final e) => e.reponse).map(
                  (final e) => MapEntry(
                    e,
                    DsfrRadioButtonItem(
                      e,
                      backgroundColor: _getColor(state, e),
                    ),
                  ),
                ),
          ),
          onCallback: (final value) => context
              .read<QuizBloc>()
              .add(QuizReponseSelectionnee(value ?? '')),
          mode: DsfrRadioButtonSetMode.column,
        ),
        if (state.estExacte.isSome()) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          const Text(Localisation.pourquoi, style: DsfrTextStyle.headline2()),
          const SizedBox(height: DsfrSpacings.s2w),
          FnvHtmlWidget(state.explication),
        ],
      ],
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton();

  @override
  Widget build(final BuildContext context) {
    final estValidee = context
        .select<QuizBloc, bool>((final bloc) => bloc.state.estExacte.isSome());

    return FnvBottomBar(
      child: estValidee
          ? DsfrButton(
              label: Localisation.revenirAccueil,
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
              onPressed: () => GoRouter.of(context).pop(),
            )
          : const _BoutonValider(),
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
