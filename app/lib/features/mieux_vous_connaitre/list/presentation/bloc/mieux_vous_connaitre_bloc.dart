import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_event.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitreBloc
    extends Bloc<MieuxVousConnaitreEvent, MieuxVousConnaitreState> {
  MieuxVousConnaitreBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  }) : super(const MieuxVousConnaitreState.empty()) {
    on<MieuxVousConnaitreRecuperationDemandee>((final event, final emit) async {
      emit(state.copyWith(statut: MieuxVousConnaitreStatut.chargement));
      final result =
          await mieuxVousConnaitrePort.recupererLesQuestionsDejaRepondue();
      if (result.isRight()) {
        final questions = result.getRight().getOrElse(() => throw Exception());

        emit(
          state.copyWith(
            questions: questions,
            questionsParCategorie: questions,
            statut: MieuxVousConnaitreStatut.succes,
          ),
        );
      }
    });
    on<MieuxVousConnaitreThematiqueSelectionnee>((final event, final emit) {
      emit(
        state.copyWith(
          questionsParCategorie: state.questions
              .where(
                (final e) =>
                    event.valeur == null || e.thematique == event.valeur,
              )
              .toList(),
          thematiqueSelectionnee: Some(event.valeur),
        ),
      );
    });
  }
}
