import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:equatable/equatable.dart';

sealed class ActionDetailEvent extends Equatable {
  const ActionDetailEvent();

  @override
  List<Object> get props => [];
}

final class ActionDetailLoadRequested extends ActionDetailEvent {
  const ActionDetailLoadRequested(this.id);

  final ActionId id;

  @override
  List<Object> get props => [id];
}

final class ActionDetailResponseSubmitted extends ActionDetailEvent {
  const ActionDetailResponseSubmitted(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

final class ActionDetailReasonChanged extends ActionDetailEvent {
  const ActionDetailReasonChanged(this.reason);

  final String reason;

  @override
  List<Object> get props => [reason];
}

final class ActionDetailValidatePressed extends ActionDetailEvent {
  const ActionDetailValidatePressed();
}
