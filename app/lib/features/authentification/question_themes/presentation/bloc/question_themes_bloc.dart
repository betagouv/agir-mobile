import 'package:app/features/authentification/question_themes/presentation/bloc/question_themes_event.dart';
import 'package:app/features/authentification/question_themes/presentation/bloc/question_themes_state.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuestionThemesBloc
    extends Bloc<QuestionThemesEvent, QuestionThemesState> {
  QuestionThemesBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  }) : super(
          const QuestionThemesState(question: Question.empty(), valeur: []),
        ) {
    on<QuestionThemesRecuperationDemandee>((final event, final emit) async {
      final result = await mieuxVousConnaitrePort.recupererQuestion(id: _id);
      if (result.isRight()) {
        final question = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(question: question));
      }
    });
    on<QuestionThemesOntChange>(
      (final event, final emit) => emit(state.copyWith(valeur: event.valeur)),
    );
    on<QuestionThemesMiseAJourDemandee>((final event, final emit) async {
      await mieuxVousConnaitrePort.mettreAJour(
        id: _id,
        reponses: state.valeur,
      );
    });
  }

  final _id = 'KYC_preference';
}
