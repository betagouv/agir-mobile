import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class MieuxVousConnaitreEditState extends Equatable {
  const MieuxVousConnaitreEditState();

  @override
  List<Object> get props => [];
}

@immutable
final class MieuxVousConnaitreEditInitial extends MieuxVousConnaitreEditState {
  const MieuxVousConnaitreEditInitial();
}

@immutable
final class MieuxVousConnaitreEditLoaded extends MieuxVousConnaitreEditState {
  const MieuxVousConnaitreEditLoaded({required this.question, required this.newQuestion, required this.updated});

  final Question question;
  final Question newQuestion;
  final bool updated;

  @override
  List<Object> get props => [question, newQuestion, updated];
}

@immutable
final class MieuxVousConnaitreEditError extends MieuxVousConnaitreEditState {
  const MieuxVousConnaitreEditError({required this.id, required this.error});

  final String id;
  final String error;

  @override
  List<Object> get props => [id, error];
}
