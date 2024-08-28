import 'package:app/features/authentification/questions/presentation/blocs/question_themes_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_themes_state.dart';
import 'package:app/features/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuestionThemesBloc
    extends Bloc<QuestionThemesEvent, QuestionThemesState> {
  QuestionThemesBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  })  : _mieuxVousConnaitrePort = mieuxVousConnaitrePort,
        super(
          const QuestionThemesState(question: Question.empty(), valeur: []),
        ) {
    on<QuestionThemesRecuperationDemandee>(_onRecuperationDemandee);
    on<QuestionThemesOntChange>(_onOntChange);
    on<QuestionThemesMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final MieuxVousConnaitrePort _mieuxVousConnaitrePort;
  final _id = 'KYC_preference';

  Future<void> _onRecuperationDemandee(
    final QuestionThemesRecuperationDemandee event,
    final Emitter<QuestionThemesState> emit,
  ) async {
    final result = await _mieuxVousConnaitrePort.recupererQuestion(id: _id);
    if (result.isRight()) {
      final question = result.getRight().getOrElse(() => throw Exception());
      emit(state.copyWith(question: question));
    }
  }

  void _onOntChange(
    final QuestionThemesOntChange event,
    final Emitter<QuestionThemesState> emit,
  ) {
    emit(state.copyWith(valeur: event.valeur));
  }

  Future<void> _onMiseAJourDemandee(
    final QuestionThemesMiseAJourDemandee event,
    final Emitter<QuestionThemesState> emit,
  ) async {
    await _mieuxVousConnaitrePort.mettreAJour(
      id: _id,
      reponses: state.valeur,
    );
  }
}
