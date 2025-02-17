import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionsEvent extends Equatable {
  const ActionsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionsLoadRequested extends ActionsEvent {
  const ActionsLoadRequested();
}
