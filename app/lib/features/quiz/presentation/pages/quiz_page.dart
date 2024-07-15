import 'package:app/features/quiz/presentation/blocs/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_event.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_state.dart';
import 'package:app/features/quiz/presentation/pages/quiz_explication_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({required this.id, super.key});

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

  Future<void> _handleQuizValider(
    final QuizState state,
    final BuildContext context,
  ) async {
    final goRouter = GoRouter.of(context);

    if (state.estExacte.getOrElse(() => false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Bien joué ! Vous récoltez ${state.quiz.points} points.'),
        ),
      );
      await goRouter.pushReplacementNamed(
        QuizExplicationPage.name,
        extra: state.quiz.explicationOk ?? state.quiz.article?.contenu,
      );
    } else {
      await goRouter.pushReplacementNamed(
        QuizExplicationPage.name,
        extra: state.quiz.explicationKo ?? state.quiz.article?.contenu,
      );
    }
  }

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => QuizBloc(quizPort: context.read())
          ..add(QuizRecuperationDemandee(id)),
        child: Builder(
          builder: (final context) => BlocListener<QuizBloc, QuizState>(
            listener: (final context, final state) async =>
                _handleQuizValider(state, context),
            listenWhen: (final previous, final current) =>
                previous.estExacte != current.estExacte,
            child: const QuizView(),
          ),
        ),
      );
}
