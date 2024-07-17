import 'package:app/features/quiz/presentation/blocs/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_event.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_state.dart';
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

  void _handleQuizValider(final BuildContext context, final QuizState state) {
    if (state.estExacte.getOrElse(() => false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Bien joué ! Vous récoltez ${state.quiz.points} points.'),
        ),
      );
    }
  }

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) =>
            QuizBloc(quizPort: context.read(), gamificationPort: context.read())
              ..add(QuizRecuperationDemandee(id)),
        child: Builder(
          builder: (final context) => BlocListener<QuizBloc, QuizState>(
            listener: _handleQuizValider,
            listenWhen: (final previous, final current) =>
                previous.estExacte != current.estExacte,
            child: const QuizView(),
          ),
        ),
      );
}
