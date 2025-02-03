import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_repository.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MieuxVousConnaitreEditBloc
    extends Bloc<MieuxVousConnaitreEditEvent, MieuxVousConnaitreEditState> {
  MieuxVousConnaitreEditBloc({
    required final MieuxVousConnaitreRepository mieuxVousConnaitreRepository,
  }) : super(const MieuxVousConnaitreEditInitial()) {
    on<MieuxVousConnaitreEditRecuperationDemandee>(
      (final event, final emit) async {
        emit(const MieuxVousConnaitreEditInitial());
        final result =
            await mieuxVousConnaitreRepository.recupererQuestion(id: event.id);

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

          if (question is QuestionMultipleChoice &&
              newQuestion is QuestionMultipleChoice) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.changeResponses(event.value),
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

          if (question is QuestionSingleChoice &&
              newQuestion is QuestionSingleChoice) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.changeResponses([event.value]),
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

          if (question is QuestionOpen && newQuestion is QuestionOpen) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.changeResponse(event.value),
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
          if (question is QuestionInteger && newQuestion is QuestionInteger) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.changeResponse(event.value),
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

          if (question is QuestionMosaicBoolean &&
              newQuestion is QuestionMosaicBoolean) {
            emit(
              MieuxVousConnaitreEditLoaded(
                question: question,
                newQuestion: newQuestion.changeResponses(
                  event.value
                      .where((final e) => e.isSelected)
                      .map((final e) => e.label)
                      .toList(),
                ),
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
            final result =
                await mieuxVousConnaitreRepository.mettreAJour(newQuestion);
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
