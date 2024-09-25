import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitreEditBloc
    extends Bloc<MieuxVousConnaitreEditEvent, MieuxVousConnaitreEditState> {
  MieuxVousConnaitreEditBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
    required final GamificationPort gamificationPort,
  }) : super(const MieuxVousConnaitreEditState.empty()) {
    on<MieuxVousConnaitreEditRecuperationDemandee>(
      (final event, final emit) async {
        final result =
            await mieuxVousConnaitrePort.recupererQuestion(id: event.id);
        if (result.isRight()) {
          final question = result.getRight().getOrElse(() => throw Exception());
          emit(state.copyWith(question: question, valeur: question.reponses));
        }
      },
    );
    on<MieuxVousConnaitreEditReponsesChangee>(
      (final event, final emit) => emit(state.copyWith(valeur: event.valeur)),
    );
    on<MieuxVousConnaitreEditMisAJourDemandee>((final event, final emit) async {
      await mieuxVousConnaitrePort.mettreAJour(
        id: event.id,
        reponses: state.valeur,
      );
      await gamificationPort.mettreAJourLesPoints();
      emit(state.copyWith(estMiseAJour: true));
    });
  }
}
