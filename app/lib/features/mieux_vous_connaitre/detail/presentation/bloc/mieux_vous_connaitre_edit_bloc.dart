import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MieuxVousConnaitreEditBloc
    extends Bloc<MieuxVousConnaitreEditEvent, MieuxVousConnaitreEditState> {
  MieuxVousConnaitreEditBloc({
    required final MieuxVousConnaitrePort mieuxVousConnaitrePort,
  }) : super(const MieuxVousConnaitreEditInitial()) {
    on<MieuxVousConnaitreEditRecuperationDemandee>(
      (final event, final emit) async {
        emit(const MieuxVousConnaitreEditInitial());
        final result =
            await mieuxVousConnaitrePort.recupererQuestion(id: event.id);

        result.fold(
          (final l) => emit(
            MieuxVousConnaitreEditError(id: event.id, error: l.toString()),
          ),
          (final r) => emit(
            MieuxVousConnaitreEditLoaded(
              question: r,
              newQuestion: r,
              updated: false,
            ),
          ),
        );
      },
    );
    on<MieuxVousConnaitreEditChoixMultipleChangee>(
      (final event, final emit) async {
        final aState = state;
        if (aState is MieuxVousConnaitreEditLoaded) {
          final question = aState.question;
          final newQuestion = aState.newQuestion;

          if (question is ChoixMultipleQuestion &&
              newQuestion is ChoixMultipleQuestion) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.responsesChanged(
                  reponses: Responses(event.value),
                ),
                updated: false,
              ),
            );
          }
        }
      },
    );
    on<MieuxVousConnaitreEditChoixUniqueChangee>(
      (final event, final emit) async {
        final aState = state;
        if (aState is MieuxVousConnaitreEditLoaded) {
          final question = aState.question;
          final newQuestion = aState.newQuestion;

          if (question is ChoixUniqueQuestion &&
              newQuestion is ChoixUniqueQuestion) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.responsesChanged(
                  reponses: Responses([event.value]),
                ),
                updated: false,
              ),
            );
          }
        }
      },
    );
    on<MieuxVousConnaitreEditLibreChangee>(
      (final event, final emit) async {
        final aState = state;
        if (aState is MieuxVousConnaitreEditLoaded) {
          final question = aState.question;
          final newQuestion = aState.newQuestion;

          if (question is LibreQuestion && newQuestion is LibreQuestion) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.responsesChanged(
                  reponses: Responses([event.value]),
                ),
                updated: false,
              ),
            );
          }
        }
      },
    );
    on<MieuxVousConnaitreEditEntierChangee>(
      (final event, final emit) async {
        final aState = state;
        if (aState is MieuxVousConnaitreEditLoaded) {
          final question = aState.question;
          final newQuestion = aState.newQuestion;
          if (question is EntierQuestion && newQuestion is EntierQuestion) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.responsesChanged(
                  reponses: Responses([event.value]),
                ),
                updated: false,
              ),
            );
          }
        }
      },
    );
    on<MieuxVousConnaitreEditMosaicChangee>(
      (final event, final emit) async {
        final aState = state;
        if (aState is MieuxVousConnaitreEditLoaded) {
          final question = aState.question;
          final newQuestion = aState.newQuestion;

          if (question is MosaicQuestion && newQuestion is MosaicQuestion) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion:
                    newQuestion.responsesChanged(responses: event.value),
                updated: false,
              ),
            );
          }
        }
      },
    );
    on<MieuxVousConnaitreEditMisAJourDemandee>(
      (final event, final emit) async {
        final aState = state;
        switch (aState) {
          case MieuxVousConnaitreEditLoaded():
            final newQuestion = aState.newQuestion;
            if (newQuestion is! MosaicQuestion && !newQuestion.isAnswered()) {
              return;
            }

            final result =
                await mieuxVousConnaitrePort.mettreAJour(newQuestion);
            result.fold(
              (final l) => emit(
                MieuxVousConnaitreEditError(
                  id: aState.question.id.value,
                  error: l.toString(),
                ),
              ),
              (final r) {
                emit(
                  MieuxVousConnaitreEditLoaded(
                    question: newQuestion,
                    newQuestion: newQuestion,
                    updated: true,
                  ),
                );
                emit(
                  MieuxVousConnaitreEditLoaded(
                    question: newQuestion,
                    newQuestion: newQuestion,
                    updated: false,
                  ),
                );
              },
            );
          default:
            return;
        }
      },
    );
  }
}
