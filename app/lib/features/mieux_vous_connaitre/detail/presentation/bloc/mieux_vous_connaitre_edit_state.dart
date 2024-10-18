import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class MieuxVousConnaitreEditState extends Equatable {
  const MieuxVousConnaitreEditState();

  @override
  List<Object> get props => [];
}

final class MieuxVousConnaitreEditInitial extends MieuxVousConnaitreEditState {
  const MieuxVousConnaitreEditInitial();
}

final class MieuxVousConnaitreEditLoaded extends MieuxVousConnaitreEditState {
  const MieuxVousConnaitreEditLoaded({
    required this.question,
    required this.newQuestion,
    required this.updated,
  });

  final Question question;
  final Question newQuestion;
  final bool updated;

  @override
  List<Object> get props => [question, newQuestion, updated];
}

final class MieuxVousConnaitreEditError extends MieuxVousConnaitreEditState {
  const MieuxVousConnaitreEditError({required this.id, required this.error});

  final String id;
  final String error;

  @override
  List<Object> get props => [id, error];
}
