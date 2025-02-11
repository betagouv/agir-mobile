import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
