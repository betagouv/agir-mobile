import 'package:app/features/actions/domain/action_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionEvent extends Equatable {
  const ActionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionLoadRequested extends ActionEvent {
  const ActionLoadRequested(this.id, this.type);

  final ActionType type;
  final String id;

  @override
  List<Object> get props => [id, type];
}
