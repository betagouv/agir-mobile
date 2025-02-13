import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mission/mission/domain/mission_quiz.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/pages/quiz_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionQuizPage extends StatelessWidget {
  const MissionQuizPage({super.key, required this.value});

  final MissionQuiz value;

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            QuizBloc(quizRepository: context.read(), gamificationRepository: context.read())
              ..add(QuizRecuperationDemandee(value.contentId.value)),
    child: Builder(
      builder:
          (final context) => ListView(
            padding: const EdgeInsets.all(paddingVerticalPage),
            children: const [
              QuizContent(),
              SizedBox(height: DsfrSpacings.s3w),
              SafeArea(child: Align(alignment: Alignment.centerLeft, child: FittedBox(child: _BottomButton()))),
            ],
          ),
    ),
  );
}

class _BottomButton extends StatelessWidget {
  const _BottomButton();

  @override
  Widget build(final context) {
    final estValidee = context.select<QuizBloc, bool>((final bloc) => bloc.state.estExacte.isSome());

    return estValidee
        ? DsfrButton(
          label: Localisation.continuer,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () => context.read<MissionBloc>().add(const MissionNextRequested()),
        )
        : const _BoutonValider();
  }
}

class _BoutonValider extends StatelessWidget {
  const _BoutonValider();

  @override
  Widget build(final context) {
    final estSelectionnee = context.select<QuizBloc, bool>((final bloc) => bloc.state.estSelectionnee);

    return DsfrButton(
      label: Localisation.valider,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: estSelectionnee ? () => context.read<QuizBloc>().add(const QuizValidationDemandee()) : null,
    );
  }
}
