import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ActionDetailEvent extends Equatable {
  const ActionDetailEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionDetailLoadRequested extends ActionDetailEvent {
  const ActionDetailLoadRequested(this.id);

  final ActionId id;

  @override
  List<Object> get props => [id];
}

@immutable
final class ActionDetailResponseSubmitted extends ActionDetailEvent {
  const ActionDetailResponseSubmitted(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

@immutable
final class ActionDetailReasonChanged extends ActionDetailEvent {
  const ActionDetailReasonChanged(this.reason);

  final String reason;

  @override
  List<Object> get props => [reason];
}

@immutable
final class ActionDetailValidatePressed extends ActionDetailEvent {
  const ActionDetailValidatePressed();
}
