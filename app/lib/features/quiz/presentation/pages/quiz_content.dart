import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuizContent extends StatelessWidget {
  const QuizContent({super.key});

  @override
  Widget build(final context) {
    final state = context.watch<QuizBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        Text(state.quiz.question, style: const DsfrTextStyle.headline2()),
        const SizedBox(height: DsfrSpacings.s2w),
        _Choices(state: state),
        if (state.estExacte.isSome()) ...[
          const Text(Localisation.pourquoi, style: DsfrTextStyle.headline2()),
          FnvHtmlWidget(state.explication),
        ],
      ],
    );
  }
}

class _Choices extends StatelessWidget {
  const _Choices({required this.state});

  final QuizState state;

  Color? _getColor(final QuizState state, final String reponse) {
    if (state.estExacte.isNone()) {
      return null;
    }

    final reponseExacte = state.quiz.reponses.firstWhereOrNull((final r) => r.exact)?.reponse;
    if (reponse == reponseExacte) {
      return DsfrColors.success950;
    }

    final reponseUtilisateur = state.reponse.getOrElse(() => '');

    return reponse == reponseUtilisateur
        ? state.estExacte.fold(() => null, (final t) => t ? DsfrColors.success950 : DsfrColors.error950)
        : null;
  }

  @override
  Widget build(final context) => DsfrRadioButtonSetHeadless(
    values: Map.fromEntries(
      state.quiz.reponses
          .map((final e) => e.reponse)
          .map((final e) => MapEntry(e, DsfrRadioButtonItem(e, backgroundColor: _getColor(state, e)))),
    ),
    onCallback: (final value) => context.read<QuizBloc>().add(QuizReponseSelectionnee(value ?? '')),
    mode: DsfrRadioButtonSetMode.column,
    isEnabled: state.estExacte.isNone(),
  );
}
