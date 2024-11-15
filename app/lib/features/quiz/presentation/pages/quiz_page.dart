import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:app/features/quiz/presentation/pages/quiz_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.id});

  static const name = 'quiz';
  static const path = '$name/:id';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => QuizPage(
          id: state.pathParameters['id']!,
        ),
      );

  final String id;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => QuizBloc(
          quizPort: context.read(),
          gamificationPort: context.read(),
          articlesPort: context.read(),
        )..add(QuizRecuperationDemandee(id)),
        child: Builder(
          builder: (final context) => BlocListener<QuizBloc, QuizState>(
            listener: (final context, final state) {
              if (state.estExacte.getOrElse(() => false)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Bien joué ! Vous récoltez ${state.quiz.points} points.',
                    ),
                  ),
                );
              }
            },
            listenWhen: (final previous, final current) =>
                previous.estExacte != current.estExacte,
            child: FnvScaffold(
              appBar: FnvAppBar(),
              body: const SingleChildScrollView(child: QuizContent()),
              bottomNavigationBar: const _BottomButton(),
            ),
          ),
        ),
      );
}

class _BottomButton extends StatelessWidget {
  const _BottomButton();

  @override
  Widget build(final context) {
    final estValidee = context
        .select<QuizBloc, bool>((final bloc) => bloc.state.estExacte.isSome());

    return FnvBottomBar(
      child: estValidee
          ? DsfrButton(
              label: Localisation.revenirEnArriere,
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
  Widget build(final context) {
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
