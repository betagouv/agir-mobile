import 'package:equatable/equatable.dart';

sealed class ActionListEvent extends Equatable {
  const ActionListEvent();

  @override
  List<Object> get props => [];
}

final class ActionListFetch extends ActionListEvent {
  const ActionListFetch();
}
