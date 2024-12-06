import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ActionListEvent extends Equatable {
  const ActionListEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionListFetch extends ActionListEvent {
  const ActionListFetch();
}
