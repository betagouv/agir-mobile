import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_repository.dart';
import 'package:app/features/questions/question_themes/presentation/bloc/question_themes_event.dart';
import 'package:app/features/questions/question_themes/presentation/bloc/question_themes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuestionThemesBloc
    extends Bloc<QuestionThemesEvent, QuestionThemesState> {
  QuestionThemesBloc({
    required final MieuxVousConnaitreRepository mieuxVousConnaitreRepository,
  }) : super(const QuestionThemesState(valeur: [])) {
    on<QuestionThemesRecuperationDemandee>((final event, final emit) async {
      final result =
          await mieuxVousConnaitreRepository.recupererQuestion(id: _id);
      if (result.isRight()) {
        final question = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(question: question as QuestionMultipleChoice));
      }
    });
    on<QuestionThemesOntChange>(
      (final event, final emit) => emit(state.copyWith(valeur: event.valeur)),
    );
    on<QuestionThemesMiseAJourDemandee>((final event, final emit) async {
      await mieuxVousConnaitreRepository.mettreAJour(state.question!);
    });
  }

  final _id = 'KYC_preference';
}
